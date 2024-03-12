module Face = TextureFace

type region = (int, int, int, int)
type face = (string, region)
type tab = (string, region, int)
type fold = (string, region, int)

module Tab = {
  let drawTab = ((dx, dy, dw, dh), rotate, tabType, ()) => {
    let destination = switch rotate {
    | 0 => (dx, dy, dw, dh)
    | 1 => (dx, dy, dw, dh)
    | 2 => (dx, dy, dw, dh)
    | 3 => (dx, dy, dw, dh)
    | _ => (dx, dy, dw, dh)
    }
    let orientation = switch rotate {
    | 0 => #North
    | 1 => #East
    | 2 => #South
    | 3 => #West
    | _ => #North
    }

    Generator.drawTab(destination, orientation, ~tabType, ~showFoldLine=false, ())
  }

  let draw = (destination, rotate, tabType) => {
    drawTab(destination, rotate, tabType)
  }
}

module Fold = {
  let drawFoldLine = ((dx, dy, dw, dh), rotate) => {
    let destination = switch rotate {
    | 0 => (dx, dy + dh - 1, dx + dw, dy + dh - 1)
    | 1 => (dx, dy, dx, dy + dh)
    | 2 => (dx, dy, dx + dw, dy)
    | 3 => (dx + dw - 1, dy, dx + dw - 1, dy + dh)
    | _ => (dx, dy, dw, dh)
    }
    let (x1, y1, x2, y2) = destination
    Generator.drawLine(
      (x1, y1),
      (x2, y2),
      ~color="#a1a1a1",
      ~width=1,
      ~pattern=[2, 2],
      ~offset=3,
      (),
    )
  }

  let draw = (destination, rotate) => {
    drawFoldLine(destination, rotate)
  }
}

module Block = {
  module Regions = {
    let make = (ox, oy, size, cols, rows, cw: array<int>, rh: array<int>): array<face> => {
      let percentOf = (value, percent) => {
        let p = Belt.Int.toFloat(percent) == 0.0 ? 100.0 : Belt.Int.toFloat(percent)
        let result = Belt.Int.toFloat(value) *. p /. 100.0
        Belt.Float.toInt(result)
      }
      let tw = Belt.Array.map(cw, x => percentOf(size, x))
      let th = Belt.Array.map(rh, x => percentOf(size, x))

      let tx = Belt.Array.mapWithIndex(tw, (i, x) =>
        Belt.Array.reduce(Belt.Array.slice(tw, ~offset=0, ~len=i), 0, (total, x) => total + x)
      )
      let ty = Belt.Array.mapWithIndex(th, (i, y) =>
        Belt.Array.reduce(Belt.Array.slice(th, ~offset=0, ~len=i), 0, (total, y) => total + y)
      )
      let regions = ref([])
      for c in 0 to cols - 1 {
        for r in 0 to rows - 1 {
          let face = (
            "BlockFace" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
            (
              ox + Belt.Option.getWithDefault(tx[c], 128),
              oy + Belt.Option.getWithDefault(ty[r], 128),
              Belt.Option.getWithDefault(tw[c], 128),
              Belt.Option.getWithDefault(th[r], 128),
            ),
          )
          regions := Belt.Array.concat(regions.contents, [face])
        }
      }
      regions.contents
    }
  }

  let draw = options => {
    let (
      ox: int,
      oy: int,
      size: int,
      cols: int,
      rows: int,
      cw,
      rh,
      editMode: string,
    ) = options.contents
    let regions = Regions.make(ox, oy, size, cols, rows, cw, rh)

    let initialTexture = `{"textureDefId":"minecraft-1.20.4-blocks","frame":{"id":"debug2-0","name":"debug2","rectangle":[128,144,16,16],"frameIndex":0,"frameCount":1},"rotation":0,"flip":"None","blend":"None"}`
    Js.Console.log(("Block: ", options))

    Belt.Array.forEach(regions, face => {
      let (faceName, faceRegion) = face
      if editMode == "Blocks" {
        Face.defineInputRegion(faceName, faceRegion)
        Face.addTexture(faceName, initialTexture)
      }
      Face.draw(faceName, (0, 0, 16, 16), faceRegion, ())
    })
  }
}

module Tabs = {
  module Regions = {
    let make = (ox, oy, size, cols, rows, cw, rh): array<tab> => {
      let (width, height) = (size, size)
      let regions = ref([])
      let makeNorth = (c, r) => {
        (
          "TabsNorth" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * c, oy + height * r, width, height / 4),
          2,
        )
      }
      let makeSouth = (c, r) => {
        (
          "TabsSouth" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * c, oy + height * 3 / 4 + height * r, width, height / 4),
          0,
        )
      }
      let makeEast = (c, r) => {
        (
          "TabsEast" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * c, oy + height * r, width / 4, height),
          1,
        )
      }
      let makeWest = (c, r) => {
        (
          "TabsWest" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * 3 / 4 + width * c, oy + height * r, width / 4, height),
          3,
        )
      }
      let makeTabs = (c, r) => {
        let north = makeNorth(c, r)
        let south = makeSouth(c, r)
        let east = makeEast(c, r)
        let west = makeWest(c, r)
        [north, south, east, west]
      }
      // tabs on the grid
      for c in 0 to cols - 1 {
        for r in 0 to rows - 1 {
          let tabs = makeTabs(c, r)
          regions := Belt.Array.concat(regions.contents, tabs)
        }
      }
      // tabs on the edge
      for c in 0 to cols - 1 {
        let tabs = [makeSouth(c, -1)]
        regions := Belt.Array.concat(regions.contents, tabs)
      }
      for r in 0 to rows - 1 {
        let tabs = [makeWest(-1, r)]
        regions := Belt.Array.concat(regions.contents, tabs)
      }
      for r in 0 to rows - 1 {
        let tabs = [makeEast(cols, r)]
        regions := Belt.Array.concat(regions.contents, tabs)
      }
      regions.contents
    }
  }

  let cycleTabValue = t => {
    let t = if t === 4 {
      0
    } else {
      t + 1
    }
    Belt.Int.toString(t)
  }

  let draw = options => {
    let (
      ox: int,
      oy: int,
      size: int,
      cols: int,
      rows: int,
      cw,
      rh,
      editMode: string,
    ) = options.contents
    let regions = Regions.make(ox, oy, size, cols, rows, cw, rh)

    Belt.Array.forEach(regions, tab => {
      let (tabName, tabRegion, tabRot) = tab
      let tabValue =
        Generator.getSelectInputValue(tabName)->Belt.Int.fromString->Belt.Option.getWithDefault(0)
      if editMode == "Tabs" {
        Generator.defineRegionInput(tabRegion, () => {
          Generator.setSelectInputValue(tabName, cycleTabValue(tabValue))
        })
      }
      Tab.draw(tabRegion, tabRot, tabValue, ())
    })
  }
}
module Folds = {
  module Regions = {
    let make = (ox, oy, size, cols, rows, cw, rh): array<fold> => {
      let (width, height) = (size, size)
      let regions = ref([])
      let makeNorth = (c, r) => {
        (
          "FoldsNorth" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * c, oy + height * r, width, height / 4),
          2,
        )
      }
      let makeSouth = (c, r) => {
        (
          "FoldsSouth" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * c, oy + height * 3 / 4 + height * r, width, height / 4),
          0,
        )
      }
      let makeEast = (c, r) => {
        (
          "FoldsEast" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * c, oy + height * r, width / 4, height),
          1,
        )
      }
      let makeWest = (c, r) => {
        (
          "FoldsWest" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (ox + width * 3 / 4 + width * c, oy + height * r, width / 4, height),
          3,
        )
      }
      let makeFolds = (c, r) => {
        let north = makeNorth(c, r)
        let south = makeSouth(c, r)
        let east = makeEast(c, r)
        let west = makeWest(c, r)
        [north, south, east, west]
      }
      // folds on the grid
      for c in 0 to cols - 1 {
        for r in 0 to rows - 1 {
          let folds = makeFolds(c, r)
          regions := Belt.Array.concat(regions.contents, folds)
        }
      }
      // folds on the edge
      for c in 0 to cols - 1 {
        let folds = [makeNorth(c, rows)]
        regions := Belt.Array.concat(regions.contents, folds)
      }
      for c in 0 to cols - 1 {
        let folds = [makeSouth(c, -1)]
        regions := Belt.Array.concat(regions.contents, folds)
      }
      for r in 0 to rows - 1 {
        let folds = [makeWest(-1, r)]
        regions := Belt.Array.concat(regions.contents, folds)
      }
      for r in 0 to rows - 1 {
        let folds = [makeEast(cols, r)]
        regions := Belt.Array.concat(regions.contents, folds)
      }
      regions.contents
    }
  }

  let draw = options => {
    let (
      ox: int,
      oy: int,
      size: int,
      cols: int,
      rows: int,
      cw,
      rh,
      editMode: string,
    ) = options.contents
    let regions = Regions.make(ox, oy, size, cols, rows, cw, rh)

    Belt.Array.forEach(regions, fold => {
      let (foldName, foldRegion, foldRot) = fold
      let foldValue = Generator.getBooleanInputValue(foldName)
      if editMode == "Folds" {
        Generator.defineRegionInput(foldRegion, () => {
          Generator.setBooleanInputValue(foldName, !foldValue)
        })
      }
      if foldValue {
        Fold.draw(foldRegion, foldRot)
      }
    })
  }
}

module Scale = {
  module Regions = {
    let make = (options): array<face> => {
      let (ox, oy, size, cols, rows, cw, rh, _) = options.contents

      /* Currently:
       Get the true width and height at each tile, or more accurately each row or column from the precents in the cw and rh arrays.
       get the total/true x and y of each tile/ at each row and column from adding up the widths and heights.

       To use strings, it would need to get them from the strings inputs and put them into arrays. This is easiest if only the rows and columns are ever used to define a tile's width or height.

       let everything else be defined

 */

      let percentOf = (value, percent) => {
        let p = Belt.Int.toFloat(percent) == 0.0 ? 100.0 : Belt.Int.toFloat(percent)
        let result = Belt.Int.toFloat(value) *. p /. 100.0
        Belt.Float.toInt(result)
      }

      let tw = Belt.Array.map(cw, x => percentOf(size, x))
      let th = Belt.Array.map(rh, x => percentOf(size, x))

      let tx = Belt.Array.mapWithIndex(tw, (i, x) =>
        Belt.Array.reduce(Belt.Array.slice(tw, ~offset=0, ~len=i), 0, (total, x) => total + x)
      )
      let ty = Belt.Array.mapWithIndex(th, (i, y) =>
        Belt.Array.reduce(Belt.Array.slice(th, ~offset=0, ~len=i), 0, (total, y) => total + y)
      )

      let makeScale = (c, r) => {
        (
          "BlockScale " ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
          (
            ox + Belt.Option.getWithDefault(tx[c], 128),
            oy + Belt.Option.getWithDefault(ty[r], 128),
            Belt.Option.getWithDefault(tw[c], 128),
            Belt.Option.getWithDefault(th[r], 128),
          ),
        )
      }
      let regions = ref([])

      for c in 0 to cols - 1 {
        for r in 0 to rows - 1 {
          let scale = [makeScale(c, r)]
          regions := Belt.Array.concat(regions.contents, scale)
        }
      }

      for c in 0 to cols - 1 {
        let scale = [makeScale(c, -1)]
        regions := Belt.Array.concat(regions.contents, scale)
      }
      for r in 0 to rows - 1 {
        let scale = [makeScale(-1, r)]
        regions := Belt.Array.concat(regions.contents, scale)
      }
      regions.contents
    }
  }

  let draw = (dioramaWidth, pageFormat, editMode): (
    int,
    int,
    int,
    int,
    int,
    array<int>,
    array<int>,
    string,
  ) => {
    // things from the other page
    let ox = pageFormat ? 37 : 42
    let oy = 41
    let (bx, by) = pageFormat ? (768, 512) : (512, 768)
    let size = 16 * dioramaWidth / 100 //Belt.Float.toInt(16.0 *. Belt.Int.toFloat(dioramaWidth) /. 100.0)
    //let height = 16 * dioramaHeight / 100
    let (cols, rows) = (bx / size, by / size)

    // cw and rh will be string inputs like faces, and referred to when creating the]
    let (cw, rh) = (Belt.Array.make(cols, 100), Belt.Array.make(rows, 100))

    // change cw and rh to have the values of the strings, if they exist
    for c in 0 to cols - 1 {
      cw[c] = switch Belt.Int.fromString(
        Generator.getStringInputValue(
          "BlockScale " ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(-1),
        ),
      ) {
      | None => 100
      | Some(v) => v
      }
    }
    for r in 0 to rows - 1 {
      rh[r] = switch Belt.Int.fromString(
        Generator.getStringInputValue(
          "BlockScale " ++ Belt.Int.toString(-1) ++ " " ++ Belt.Int.toString(r),
        ),
      ) {
      | None => 100
      | Some(v) => v
      }
    }

    let options = ref((ox, oy, size, cols, rows, cw, rh, editMode))
    // things from the draw function
    let (columnWidth, rowHeight) =
      editMode == "Scale"
        ? (
            Generator.defineAndGetRangeInput(
              "Column Width",
              {min: 100, max: 1600, value: 800, step: 50},
            ),
            Generator.defineAndGetRangeInput(
              "Row Height",
              {min: 100, max: 1600, value: 800, step: 50},
            ),
          )
        : (100, 100)

    let setScaleAtTile = (scaleName, columnWidth, rowHeight) => {
      let scaleCoords = Js.String.split(scaleName, " ")
      /* Generator.setStringInputValue(
        "BlockScale" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
        Belt.Int.toString(columnWidth) ++ Belt.Int.toString(rowHeight),
      ) // would set the actual tile to have the coords */
      Generator.setStringInputValue(
        "BlockScale " ++
        Belt.Option.getWithDefault(scaleCoords[1], "-1") ++
        " " ++
        Belt.Int.toString(-1),
        Belt.Int.toString(columnWidth),
      )
      Generator.setStringInputValue(
        "BlockScale " ++
        Belt.Int.toString(-1) ++
        " " ++
        Belt.Option.getWithDefault(scaleCoords[2], "-1"),
        Belt.Int.toString(rowHeight),
      )
    }
    /* let scaleName = "Title 42 24";
scaleName = String.concat(" ", [
  String.split(scaleName, " ")[0],
  "-1",
  String.split(scaleName, " ")[2]
])
- set actual tile to be like it
- set the tile for the row and column to be like it
 */

    // test stuff
    //let cw = [250, 100, 200, 100, 100]
    //let rh = [100, 50, 100, 150, 100]
    //let _ = Belt.Array.set(rh, 3, 50)

    let regions = Regions.make(options)

    Belt.Array.forEach(regions, scale => {
      let (scaleName, scaleRegion) = scale
      if editMode == "Scale" {
        Generator.defineRegionInput(scaleRegion, () => {
          setScaleAtTile(scaleName, columnWidth, rowHeight)
          Js.Console.log(Generator.getStringInputValue(scaleName))
        })
      }
      /* Set cw, rh depending on said thing */
      //Face.draw(faceName, (0, 0, 16, 16), faceRegion, ())
      //Js.Console.log(("in loop:", newScales))
    })
    //Js.Console.log(("out of loop:", newScales))
    let (ox, oy, size, cols, rows, cw, rh, editMode) = options.contents
    options := (ox, oy, size, cols, rows, cw, rh, editMode)
    Js.Console.log(("End of draw:", options))
    options.contents
  }
}
