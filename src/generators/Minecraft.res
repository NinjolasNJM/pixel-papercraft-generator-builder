module Builder = Generator.Builder

module CuboidLegacy = {
  type t = {
    top: Builder.rectangleLegacy,
    bottom: Builder.rectangleLegacy,
    front: Builder.rectangleLegacy,
    right: Builder.rectangleLegacy,
    left: Builder.rectangleLegacy,
    back: Builder.rectangleLegacy,
  }

  // W = Width
  // H = Height
  // D = Depth
  //
  // (0,0)
  //   .         +----W----+
  //             |         |
  //             D   Top   D
  //             |         |
  //   +----D----+----W----+----D----+----W----+
  //   |         |         |         |         |
  //   H  Right  H  Front  H  Left   H  Back   H
  //   |         |         |         |         |
  //   +----D----+----W----+----D----+----W----+
  //             |         |
  //             D Bottom  D
  //             |         |
  //             +----W----+
  //
  let make = (width, height, depth): t => {
    top: {x: depth, y: 0, w: width, h: depth},
    bottom: {x: depth + width, y: 0, w: width, h: depth},
    front: {x: depth, y: depth, w: width, h: height},
    right: {x: 0, y: depth, w: depth, h: height},
    left: {x: depth + width, y: depth, w: depth, h: height},
    back: {x: depth * 2 + width, y: depth, w: width, h: height},
  }

  let translateRectangle = (
    rectangle: Builder.rectangleLegacy,
    xTranslate: int,
    yTranslate: int,
  ): Builder.rectangleLegacy => {
    let {x, y, w, h} = rectangle
    {
      x: x + xTranslate,
      y: y + yTranslate,
      w,
      h,
    }
  }

  let translate = (cuboid: t, xTranslate: int, yTranslate: int): t => {
    let {top, bottom, left, right, front, back} = cuboid
    {
      top: translateRectangle(top, xTranslate, yTranslate),
      bottom: translateRectangle(bottom, xTranslate, yTranslate),
      left: translateRectangle(left, xTranslate, yTranslate),
      right: translateRectangle(right, xTranslate, yTranslate),
      front: translateRectangle(front, xTranslate, yTranslate),
      back: translateRectangle(back, xTranslate, yTranslate),
    }
  }
}

let translateRectangle = (
  rectangle: Builder.rectangle,
  (xTranslate, yTranslate): Builder.position,
): Builder.rectangle => {
  let (x, y, w, h) = rectangle
  (x + xTranslate, y + yTranslate, w, h)
}

let toFloat = (i: int) => Belt.Int.toFloat(i)
let round = (f: float) => Js.Math.round(f)
let toInt = (f: float) => Belt.Float.toInt(round(f))

type rectangleF = (float, float, float, float)

let toRectangleF = ((x, y, w, h): Builder.rectangle): rectangleF => {
  (toFloat(x), toFloat(y), toFloat(w), toFloat(h))
}

let toRectangle = ((x, y, w, h): rectangleF): Builder.rectangle => {
  (toInt(x), toInt(y), toInt(w), toInt(h))
}

let translateRectangleF = (
  rectangle: rectangleF,
  (xTranslate, yTranslate): Builder.position,
): rectangleF => {
  let (x, y, w, h) = rectangle
  (x +. toFloat(xTranslate), y +. toFloat(yTranslate), w, h)
}

let addAngle = (r1: float, r2: float): float => mod_float(r1 +. r2 +. 360.0, 360.0)

type scale = (int, int, int)

module Cuboid = {
  module Source = {
    type t = {
      front: Builder.rectangle,
      back: Builder.rectangle,
      top: Builder.rectangle,
      bottom: Builder.rectangle,
      right: Builder.rectangle,
      left: Builder.rectangle,
    }

    let make = ((w, h, d): scale): t => {
      top: (d, 0, w, d),
      bottom: (d + w, 0, w, d),
      front: (d, d, w, h),
      right: (0, d, d, h),
      left: (d + w, d, d, h),
      back: (d * 2 + w, d, w, h),
    }

    let translate = (source: t, position: Builder.position) => {
      front: translateRectangle(source.front, position),
      back: translateRectangle(source.back, position),
      top: translateRectangle(source.top, position),
      bottom: translateRectangle(source.bottom, position),
      right: translateRectangle(source.right, position),
      left: translateRectangle(source.left, position),
    }
  }

  module Face = {
    type t = {
      rectangle: rectangleF,
      flip: Generator_Texture.flip,
      rotate: float,
    }

    let make = (rect: Builder.rectangle): t => {
      rectangle: toRectangleF(rect),
      flip: #None,
      rotate: 0.0,
    }

    let rotateOnAxis = ({rectangle, flip, rotate}: t, axis: (float, float), r: float) => {
      let rad = r *. Js.Math._PI /. 180.0
      let (cos, sin) = (Js.Math.cos(rad), Js.Math.sin(rad))
      let (x, y, w, h) = rectangle
      let (x0, y0) = axis
      let (x1, y1) = (x -. x0, y -. y0)
      let (x2, y2) = (x1 *. cos -. y1 *. sin, x1 *. sin +. y1 *. cos)
      let (x3, y3) = (x2 +. x0, y2 +. y0)

      {
        rectangle: (x3, y3, w, h),
        flip,
        rotate: addAngle(rotate, r),
      }
    }

    let rotate = ({rectangle, flip, rotate}: t, r: float) => {
      let (x, y, w, h) = rectangle
      let r = addAngle(r, 0.0)

      // When the new angle is 360 or more, then the original angle's displacement needs to be accounted for, but translating it back to where it was.
      let f =
        rotate +. r >= 360.0
          ? rotateOnAxis({rectangle, flip, rotate}, (x -. w /. 2.0, y -. h /. 2.0), r)
          : rotateOnAxis({rectangle, flip, rotate}, (x +. w /. 2.0, y +. h /. 2.0), r)
      let {rectangle, flip, rotate} = f
      let (x, y, w, h) = rectangle

      {
        rectangle: switch addAngle(rotate, 0.0) {
        | 90.0 => (x +. (w -. h) /. 2.0, y +. (w -. h) /. 2.0, h, w)
        | 270.0 => (x -. (w -. h) /. 2.0, y -. (w -. h) /. 2.0, h, w)
        | _ => (x, y, w, h)
        },
        flip,
        rotate,
      }
    }

    // When a face is flipped both vertically and horizontally, this is the same as rotating 180 degrees.
    let flip = (face: t, flip: Generator_Texture.flip) => {
      let (newFlip, newRotate) = switch (face.flip, flip) {
      | (#None, #None) => (#None, 0.0)
      | (#None, #Vertical) => (#Vertical, 0.0)
      | (#None, #Horizontal) => (#Horizontal, 0.0)
      | (#Vertical, #None) => (#Vertical, 0.0)
      | (#Vertical, #Vertical) => (#None, 0.0)
      | (#Vertical, #Horizontal) => (#None, 180.0)
      | (#Horizontal, #None) => (#Horizontal, 0.0)
      | (#Horizontal, #Vertical) => (#None, 180.0)
      | (#Horizontal, #Horizontal) => (#None, 0.0)
      }
      rotate(
        {
          rectangle: face.rectangle,
          flip: newFlip,
          rotate: face.rotate,
        },
        newRotate,
      )
    }

    let translate = ({rectangle, flip, rotate}: t, position: Builder.position) => {
      rectangle: rectangle->translateRectangleF(position),
      flip,
      rotate,
    }

    let draw = (textureId: string, source: Builder.rectangle, dest: t) => {
      Generator.drawTexture(
        textureId,
        source,
        toRectangle(dest.rectangle),
        ~flip=dest.flip,
        ~rotateLegacy=dest.rotate,
        (),
      )
    }

    let isAligned = ({rectangle, _}: t) => {
      let (x, y, _, _) = toRectangle(rectangle)
      mod(x, 2) == 0 && mod(y, 2) == 0
    }

    let debug = (dest: t) => {
      let rectString = (rectangle: rectangleF): string => {
        let (x, y, _, _) = rectangle
        "(" ++
        Belt.Float.toString(x) ++
        ", " ++
        Belt.Float.toString(y) ++
        "), or (" ++
        Belt.Int.toString(toInt(x)) ++
        ", " ++
        Belt.Int.toString(toInt(y)) ++ ")"
      }
      let flipString = (flip: Generator_Texture.flip): string =>
        switch flip {
        | #Horizontal => " f H"
        | #Vertical => " f V"
        | #None => " f N"
        }
      if !isAligned(dest) {
        Generator.fillRect(toRectangle(dest.rectangle), "#ff800080")
      }
      let output = isAligned(dest)
        ? "OK; "
        : " @ " ++
          rectString(dest.rectangle) ++
          flipString(dest.flip) ++
          " r " ++
          Belt.Float.toString(dest.rotate) ++ ";" // (face) face is drawn (source) at (dest) flipped (flip) and rotated (rotate)

      output
    }
  }

  module Dest = {
    type t = {
      front: Face.t,
      back: Face.t,
      top: Face.t,
      bottom: Face.t,
      right: Face.t,
      left: Face.t,
    }

    type direction = [#East | #West | #North | #South]

    type center = [#Right | #Front | #Left | #Back | #Top | #Bottom]

    let translate = (dest: t, position: Builder.position) => {
      front: Face.translate(dest.front, position),
      back: Face.translate(dest.back, position),
      top: Face.translate(dest.top, position),
      bottom: Face.translate(dest.bottom, position),
      right: Face.translate(dest.right, position),
      left: Face.translate(dest.left, position),
    }

    let make = ((w, h, d): scale, direction: direction): t => {
      switch direction {
      | #East => {
          top: Face.make((d, 0, w, d)),
          right: Face.make((0, d, d, h)),
          front: Face.make((d, d, w, h)),
          left: Face.make((d + w, d, d, h)),
          back: Face.make((d + w + d, d, w, h)),
          bottom: Face.make((d, d + h, w, d)),
        }
      | #West => {
          top: Face.make((w + d, 0, w, d)),
          back: Face.make((0, d, w, h)),
          right: Face.make((w, d, d, h)),
          front: Face.make((w + d, d, w, h)),
          left: Face.make((w + d + w, d, d, h)),
          bottom: Face.make((w + d, d + h, w, d)),
        }
      | #North => {
          back: Face.make((d, 0, w, h))->Face.rotate(180.0),
          top: Face.make((d, h, w, d)),
          right: Face.make((0, h + d, d, h)),
          front: Face.make((d, h + d, w, h)),
          left: Face.make((d + w, h + d, d, h)),
          bottom: Face.make((d, h * 2 + d, w, d)),
        }
      | #South => {
          top: Face.make((d, 0, w, d)),
          right: Face.make((0, d, d, h)),
          front: Face.make((d, d, w, h)),
          left: Face.make((d + w, d, d, h)),
          bottom: Face.make((d, d + h, w, d)),
          back: Face.make((d, d + h + d, w, h))->Face.rotate(180.0),
        }
      }
    }

    let rotate = (dest: t, scale: scale, rotate: float): t => {
      let (w, h, d) = scale
      let axis = (toFloat(d) +. toFloat(w) /. 2.0, toFloat(d) +. toFloat(h) /. 2.0)
      {
        right: dest.right->Face.rotateOnAxis(axis, rotate),
        front: dest.front->Face.rotateOnAxis(axis, rotate),
        left: dest.left->Face.rotateOnAxis(axis, rotate),
        back: dest.back->Face.rotateOnAxis(axis, rotate),
        top: dest.top->Face.rotateOnAxis(axis, rotate),
        bottom: dest.bottom->Face.rotateOnAxis(axis, rotate),
      }
    }

    let setLayout = (scale, direction, center, r): t => {
      let (w, h, d) = scale
      let scale = switch center {
      | #Right => (d, h, w)
      | #Left => (d, h, w)
      | #Top => (w, d, h)
      | #Bottom => (w, d, h)
      | _ => (w, h, d)
      }

      let dest = make(scale, direction)
      let dest = switch center {
      | #Right => {
          right: dest.front, // 270
          front: dest.left, // 180
          left: dest.back,
          back: dest.right, // 90, 180
          top: dest.top->Face.rotate(-90.0), // 270
          bottom: dest.bottom->Face.flip(#Vertical)->Face.rotate(90.0), // 180, 270
        }
      | #Front => {
          right: dest.right, // 90, 180
          front: dest.front, // 180
          left: dest.left, // 180, 270
          back: dest.back,
          top: dest.top,
          bottom: dest.bottom->Face.flip(#Vertical), // 180, 270
        }
      | #Left => {
          right: dest.back,
          front: dest.right, // 90, 180
          left: dest.front, // 270
          back: dest.left, // 180
          top: dest.top->Face.rotate(90.0),
          bottom: dest.bottom->Face.flip(#Vertical)->Face.rotate(-90.0), // 180, 270
        }
      | #Back => {
          right: dest.left, // 180, 270
          front: dest.back,
          left: dest.right, // 90, 180
          back: dest.front, // 180
          top: dest.top->Face.rotate(180.0), // 180, 270
          bottom: dest.bottom->Face.flip(#Horizontal), // 180, 270
        }
      | #Top => {
          right: dest.right->Face.rotate(90.0),
          front: dest.bottom, // 180
          left: dest.left->Face.rotate(-90.0),
          back: dest.top->Face.rotate(180.0),
          top: dest.front,
          bottom: dest.back->Face.flip(#Horizontal), // 0, 90, 180, 270, 360
        }
      | #Bottom => {
          right: dest.right->Face.rotate(-90.0), // 180
          front: dest.top, // 360
          left: dest.left->Face.rotate(90.0), // 270, 360
          back: dest.bottom->Face.rotate(180.0), // 180, 270
          top: dest.back->Face.rotate(180.0), // 360
          bottom: dest.front->Face.flip(#Vertical),
        }
      }
      rotate(dest, scale, r)
    }
  }

  let draw = (
    textureId: string,
    source: Source.t,
    position: Builder.position,
    scale: scale,
    ~direction: Dest.direction=#East,
    ~center: Dest.center=#Front,
    ~rotate: float=0.0,
    (),
  ) => {
    let dest = Dest.setLayout(scale, direction, center, rotate)->Dest.translate(position)
    Face.draw(textureId, source.front, dest.front)
    Face.draw(textureId, source.back, dest.back)
    Face.draw(textureId, source.top, dest.top)
    Face.draw(textureId, source.bottom, dest.bottom)
    Face.draw(textureId, source.left, dest.left)
    Face.draw(textureId, source.right, dest.right)
  }

  let debug = (
    position: Builder.position,
    scale: scale,
    ~face: Dest.center=#Front,
    ~direction: Dest.direction=#East,
    ~center: Dest.center=#Front,
    ~rotate: float=0.0,
    (),
  ): string => {
    let dest = Dest.setLayout(scale, direction, center, rotate)->Dest.translate(position)

    let faceString = (face: Dest.center): string =>
      switch face {
      | #Right => "R"
      | #Front => "F"
      | #Left => "L"
      | #Back => "B"
      | #Top => "T"
      | #Bottom => "O"
      }

    let destFace = (face: Dest.center, dest: Dest.t): Face.t =>
      switch face {
      | #Right => dest.right
      | #Front => dest.front
      | #Left => dest.left
      | #Back => dest.back
      | #Top => dest.top
      | #Bottom => dest.bottom
      }

    let output = faceString(face) ++ ": " ++ Face.debug(destFace(face, dest))
    output
  }
}

let drawCuboid = (
  textureId: string,
  source: Cuboid.Source.t,
  position: Builder.position,
  scale: scale,
  ~direction: Cuboid.Dest.direction=#East,
  ~center: Cuboid.Dest.center=#Front,
  ~rotate: float=0.0,
  (),
) => Cuboid.draw(textureId, source, position, scale, ~direction, ~center, ~rotate, ())

let drawAndDebugCuboid = (
  textureId: string,
  source: Cuboid.Source.t,
  position: Builder.position,
  scale: scale,
  ~direction: Cuboid.Dest.direction=#East,
  ~center: Cuboid.Dest.center=#Front,
  ~rotate: float=0.0,
  (),
): string => {
  Cuboid.draw(textureId, source, position, scale, ~direction, ~center, ~rotate, ())
  let output =
    "(" ++
    Belt.Float.toString(rotate) ++
    ")- " ++
    Cuboid.debug(position, scale, ~face=#Right, ~direction, ~center, ~rotate, ()) ++
    "\n" ++
    Cuboid.debug(position, scale, ~face=#Front, ~direction, ~center, ~rotate, ()) ++
    "\n" ++
    Cuboid.debug(position, scale, ~face=#Left, ~direction, ~center, ~rotate, ()) ++
    "\n" ++
    Cuboid.debug(position, scale, ~face=#Back, ~direction, ~center, ~rotate, ()) ++
    "\n" ++
    Cuboid.debug(position, scale, ~face=#Top, ~direction, ~center, ~rotate, ()) ++
    "\n" ++
    Cuboid.debug(position, scale, ~face=#Bottom, ~direction, ~center, ~rotate, ())

  output
}

module CharacterLegacy = {
  module Layer = {
    type t = {
      head: CuboidLegacy.t,
      rightArm: CuboidLegacy.t,
      leftArm: CuboidLegacy.t,
      body: CuboidLegacy.t,
      rightLeg: CuboidLegacy.t,
      leftLeg: CuboidLegacy.t,
    }
  }

  type t = {
    base: Layer.t,
    overlay: Layer.t,
  }

  let {make, translate} = module(CuboidLegacy)

  let steve: t = {
    base: {
      head: make(8, 8, 8)->translate(0, 0),
      rightArm: make(4, 12, 4)->translate(40, 16),
      leftArm: make(4, 12, 4)->translate(32, 48),
      body: make(8, 12, 4)->translate(16, 16),
      rightLeg: make(4, 12, 4)->translate(0, 16),
      leftLeg: make(4, 12, 4)->translate(16, 48),
    },
    overlay: {
      head: make(8, 8, 8)->translate(32, 0),
      rightArm: make(4, 12, 4)->translate(40, 32),
      leftArm: make(4, 12, 4)->translate(48, 48),
      body: make(8, 12, 4)->translate(16, 32),
      rightLeg: make(4, 12, 4)->translate(0, 32),
      leftLeg: make(4, 12, 4)->translate(0, 48),
    },
  }

  let alex: t = {
    base: {
      head: steve.base.head,
      rightArm: make(3, 12, 4)->translate(40, 16),
      leftArm: make(3, 12, 4)->translate(32, 48),
      body: steve.base.body,
      rightLeg: steve.base.rightLeg,
      leftLeg: steve.base.leftLeg,
    },
    overlay: {
      head: steve.overlay.head,
      rightArm: make(3, 12, 4)->translate(40, 32),
      leftArm: make(3, 12, 4)->translate(48, 48),
      body: steve.overlay.body,
      rightLeg: steve.overlay.rightLeg,
      leftLeg: steve.overlay.leftLeg,
    },
  }
}

module Character = {
  module Layer = {
    type t = {
      head: Cuboid.Source.t,
      rightArm: Cuboid.Source.t,
      leftArm: Cuboid.Source.t,
      body: Cuboid.Source.t,
      rightLeg: Cuboid.Source.t,
      leftLeg: Cuboid.Source.t,
    }
  }

  type t = {
    base: Layer.t,
    overlay: Layer.t,
  }

  let {make, translate} = module(Cuboid.Source)

  let steve: t = {
    base: {
      head: make((8, 8, 8))->translate((0, 0)),
      rightArm: make((4, 12, 4))->translate((40, 16)),
      leftArm: make((4, 12, 4))->translate((32, 48)),
      body: make((8, 12, 4))->translate((16, 16)),
      rightLeg: make((4, 12, 4))->translate((0, 16)),
      leftLeg: make((4, 12, 4))->translate((16, 48)),
    },
    overlay: {
      head: make((8, 8, 8))->translate((32, 0)),
      rightArm: make((4, 12, 4))->translate((40, 32)),
      leftArm: make((4, 12, 4))->translate((48, 48)),
      body: make((8, 12, 4))->translate((16, 32)),
      rightLeg: make((4, 12, 4))->translate((0, 32)),
      leftLeg: make((4, 12, 4))->translate((0, 48)),
    },
  }

  let alex: t = {
    base: {
      head: steve.base.head,
      rightArm: make((3, 12, 4))->translate((40, 16)),
      leftArm: make((3, 12, 4))->translate((32, 48)),
      body: steve.base.body,
      rightLeg: steve.base.rightLeg,
      leftLeg: steve.base.leftLeg,
    },
    overlay: {
      head: steve.overlay.head,
      rightArm: make((3, 12, 4))->translate((40, 32)),
      leftArm: make((3, 12, 4))->translate((48, 48)),
      body: steve.overlay.body,
      rightLeg: steve.overlay.rightLeg,
      leftLeg: steve.overlay.leftLeg,
    },
  }
}

let setTabSize = (tabSize: int) => {
  Generator.setIntegerVariable("tabSize", tabSize)
}

let defaultTabSize = 24

let getTabSize = () => {
  switch Generator.getIntegerVariable("tabSize") {
  | None => defaultTabSize
  | Some(value) => value
  }
}

let drawFaceTab = (
  face: Builder.rectangle,
  side: Generator.Orientation.t,
  ~showFoldLine: bool=true,
  ~tabAngle: float=45.0,
  ~size: option<int>=?,
  (),
) => {
  let size = switch size {
  | Some(size) => size
  | None => getTabSize()
  }
  let (x, y, w, h) = face
  let tabRect = switch side {
  | #North => (x, y - size, w, size)
  | #East => (x + w, y, size, h)
  | #South => (x, y + h, w, size)
  | #West => (x - size, y, size, h)
  }
  Generator.drawTab(tabRect, side, ~showFoldLine, ~tabAngle, ())
}

let drawFaceTabs = (
  face: Builder.rectangle,
  sides: array<Generator.Orientation.t>,
  ~showFoldLine: bool=true,
  ~tabAngle: float=45.0,
  ~size: option<int>=?,
  (),
) => {
  let size = switch size {
  | Some(size) => size
  | None => getTabSize()
  }
  sides->Belt.Array.forEach(side => {
    drawFaceTab(face, side, ~showFoldLine, ~tabAngle, ~size, ())
  })
}
