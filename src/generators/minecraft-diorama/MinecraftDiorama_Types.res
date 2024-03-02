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

module Region = {
  let make = (ox, oy, size, cols, rows, cw: array<int>, rh: array<int>): array<face> => {
    /*
cw, rh have percentages of the base size
for each in the number of columns and rows:
Find the width or height of the tile.
Add together or find the x and y it should be at.
Define region to be at said x, y, w, h.


 */
    let percentOf = (value, percent) => {
      let p = Belt.Int.toFloat(percent) == 0.0 ? 100.0 : Belt.Int.toFloat(percent)
      let result = Belt.Int.toFloat(value) *. p /. 100.0
      Belt.Float.toInt(result)
    }

    //Js.Console.log(rh)
    /* cw, rh need to: 
          detect zeroes and missings and set them to 100
     have percentOf done so that there is the actual width or height of each 
     have a tx and ty so that there is easy calculation of the x and y of each.
 */
    let tw = Belt.Array.map(cw, x => percentOf(size, x))
    let th = Belt.Array.map(rh, x => percentOf(size, x))

    //Js.Console.log(th)

    let tx = Belt.Array.mapWithIndex(tw, (i, x) =>
      Belt.Array.reduce(Belt.Array.slice(tw, ~offset=0, ~len=i), 0, (total, x) => total + x)
    )
    let ty = Belt.Array.mapWithIndex(th, (i, y) =>
      Belt.Array.reduce(Belt.Array.slice(th, ~offset=0, ~len=i), 0, (total, y) => total + y)
    )
    //Js.Console.log(ty)

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

module Block = {
  module Regions = {
    let make = (ox, oy, size, cols, rows): array<face> => {
      let (width, height) = (size, size)
      let regions = ref([])
      for c in 0 to cols - 1 {
        for r in 0 to rows - 1 {
          let face = (
            "BlockFace" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
            (ox + width * c, oy + height * r, width, height),
          )
          regions := Belt.Array.concat(regions.contents, [face])
        }
      }
      regions.contents
    }
  }

  let draw = ((ox: int, oy: int, size: int, cols: int, rows: int, editMode: string)) => {
    let regions = Regions.make(ox, oy, size, cols, rows)

    let initialTexture = `{"textureDefId":"minecraft-1.20.4-blocks","frame":{"id":"debug2-0","name":"debug2","rectangle":[128,144,16,16],"frameIndex":0,"frameCount":1},"rotation":0,"flip":"None","blend":"None"}`

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
    let make = (ox, oy, size, cols, rows): array<tab> => {
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

  let draw = ((ox: int, oy: int, size: int, cols: int, rows: int, editMode: string)) => {
    let regions = Regions.make(ox, oy, size, cols, rows)

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
    let make = (ox, oy, size, cols, rows): array<fold> => {
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

  let draw = ((ox: int, oy: int, size: int, cols: int, rows: int, editMode: string)) => {
    let regions = Regions.make(ox, oy, size, cols, rows)

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
    let make = (ox, oy, size, cols, rows): array<face> => {
      let (width, height) = (size, size)
      let regions = ref([])
      for c in 0 to cols - 1 {
        for r in 0 to rows - 1 {
          let face = (
            "ScaleFace" ++ Belt.Int.toString(c) ++ " " ++ Belt.Int.toString(r),
            (ox + width * c, oy + height * r, width, height),
          )
          regions := Belt.Array.concat(regions.contents, [face])
        }
      }
      regions.contents
    }
  }

  let draw = ((ox: int, oy: int, size: int, cols: int, rows: int, editMode: string)) => {
    let columnWidth = {
      Generator.defineAndGetRangeInput("Column Width", {min: 100, max: 1600, value: 800, step: 50})
    }
    let rowHeight = {
      Generator.defineAndGetRangeInput("Row Height", {min: 100, max: 1600, value: 800, step: 50})
    }

    let cw = Belt.Array.make(cols, 100)
    let rh = Belt.Array.make(rows, 100)

    // test stuff
    //let cw = [250, 100, 200, 100, 100]
    //let rh = [100, 50, 100, 150, 100]
    let _ = Belt.Array.set(rh, 3, 50)

    let regions = Region.make(ox, oy, size, cols, rows, cw, rh)

    Belt.Array.forEach(regions, face => {
      let (faceName, faceRegion) = face
      if editMode == "Scale" {
        Face.defineInputRegion(faceName, faceRegion)
      }
      Face.draw(faceName, (0, 0, 16, 16), faceRegion, ())
    })
  }
}
