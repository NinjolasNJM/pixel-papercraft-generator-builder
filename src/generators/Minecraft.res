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
      w: w,
      h: h,
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
      rectangle: Builder.rectangle,
      flip: Generator_Texture.flip,
      rotate: float,
    }

    let make = (rect: Builder.rectangle): t => {
      rectangle: rect,
      flip: #None,
      rotate: 0.0,
    }

    let rotateOnAxis = ({rectangle, flip, rotate}: t, axis: (float, float), r: float) => {
      let rad = r *. Js.Math._PI /. 180.0
      let (cos, sin) = (Js.Math.cos(rad), Js.Math.sin(rad))
      let (x, y, w, h) = rectangle
      let (x0, y0) = axis
      let (x1, y1) = (toFloat(x) -. x0, toFloat(y) -. y0)
      let (x2, y2) = (x1 *. cos -. y1 *. sin, x1 *. sin +. y1 *. cos)
      let (x3, y3) = (toInt(x2 +. x0), toInt(y2 +. y0))

      {
        rectangle: (x3, y3, w, h),
        flip: flip,
        rotate: addAngle(rotate, r),
      }
    }

    let rotate = ({rectangle, flip, rotate}: t, r: float) => {
      let (x, y, w, h) = rectangle
      let r = addAngle(r, 0.0)

      let f =
        rotate +. r >= 360.0
          ? rotateOnAxis(
              {rectangle: rectangle, flip: flip, rotate: rotate},
              (toFloat(x) -. toFloat(w) /. 2.0, toFloat(y) -. toFloat(h) /. 2.0),
              r,
            )
          : rotateOnAxis(
              {rectangle: rectangle, flip: flip, rotate: rotate},
              (toFloat(x) +. toFloat(w) /. 2.0, toFloat(y) +. toFloat(h) /. 2.0),
              r,
            )
      let {rectangle, flip, rotate} = f
      let (x, y, w, h) = rectangle

      {
        rectangle: switch addAngle(rotate, 0.0) {
        | 90.0 => (
            toInt(toFloat(x) +. (toFloat(w) -. toFloat(h)) /. 2.0),
            toInt(toFloat(y) +. (toFloat(w) -. toFloat(h)) /. 2.0),
            h,
            w,
          )
        | 270.0 => (
            toInt(toFloat(x) -. (toFloat(w) -. toFloat(h)) /. 2.0),
            toInt(toFloat(y) -. (toFloat(w) -. toFloat(h)) /. 2.0),
            h,
            w,
          )
        | _ => (x, y, w, h)
        },
        flip: flip,
        rotate: rotate,
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
      rectangle: rectangle->translateRectangle(position),
      flip: flip,
      rotate: rotate,
    }

    let draw = (textureId: string, source: Builder.rectangle, dest: t) => {
      Generator.drawTexture(
        textureId,
        source,
        dest.rectangle,
        ~flip=dest.flip,
        ~rotateLegacy=dest.rotate,
        (),
      )
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

    type orientation = Generator.Orientation.t

    type center = [#Right | #Front | #Left | #Back | #Top | #Bottom]

    let translate = (dest: t, position: Builder.position) => {
      front: Face.translate(dest.front, position),
      back: Face.translate(dest.back, position),
      top: Face.translate(dest.top, position),
      bottom: Face.translate(dest.bottom, position),
      right: Face.translate(dest.right, position),
      left: Face.translate(dest.left, position),
    }

    let make = ((w, h, d): scale, orientation: orientation): t => {
      switch orientation {
      | #West => {
          top: Face.make((d, 0, w, d)),
          right: Face.make((0, d, d, h)),
          front: Face.make((d, d, w, h)),
          left: Face.make((d + w, d, d, h)),
          back: Face.make((d + w + d, d, w, h)),
          bottom: Face.make((d, d + h, w, d)),
        }
      | #East => {
          top: Face.make((w + d, 0, w, d)),
          back: Face.make((0, d, w, h)),
          right: Face.make((w, d, d, h)),
          front: Face.make((w + d, d, w, h)),
          left: Face.make((w + d + w, d, d, h)),
          bottom: Face.make((w + d, d + h, w, d)),
        }
      | #South => {
          back: Face.make((d, 0, w, h))->Face.rotate(180.0),
          top: Face.make((d, h, w, d)),
          right: Face.make((0, h + d, d, h)),
          front: Face.make((d, h + d, w, h)),
          left: Face.make((d + w, h + d, d, h)),
          bottom: Face.make((d, h * 2 + d, w, d)),
        }
      | #North => {
          top: Face.make((d, 0, w, d)),
          right: Face.make((0, d, d, h)),
          front: Face.make((d, d, w, h)),
          left: Face.make((d + w, d, d, h)),
          bottom: Face.make((d, d + h, w, d)),
          back: Face.make((d, d + h + d, w, h))->Face.rotate(180.0),
        }
      }
    }

    let getAxis = ((w, h, d): scale, orientation: orientation): (float, float) => {
      switch orientation {
      | #East => (toFloat(d) +. toFloat(w) *. 1.5, toFloat(d) +. toFloat(h) /. 2.0)
      | #South => (toFloat(d) +. toFloat(w) /. 2.0, toFloat(d) +. toFloat(h) *. 1.5)
      | _ => (toFloat(d) +. toFloat(w) /. 2.0, toFloat(d) +. toFloat(h) /. 2.0)
      }
    }

    let rotate = (dest: t, axis: (float, float), rotate: float): t => {
      {
        right: dest.right->Face.rotateOnAxis(axis, rotate),
        front: dest.front->Face.rotateOnAxis(axis, rotate),
        left: dest.left->Face.rotateOnAxis(axis, rotate),
        back: dest.back->Face.rotateOnAxis(axis, rotate),
        top: dest.top->Face.rotateOnAxis(axis, rotate),
        bottom: dest.bottom->Face.rotateOnAxis(axis, rotate),
      }
    }

    let setLayout = (scale, orientation, center, r): t => {
      let (w, h, d) = scale
      let scale = switch center {
      | #Right => (d, h, w)
      | #Left => (d, h, w)
      | #Top => (w, d, h)
      | #Bottom => (w, d, h)
      | _ => (w, h, d)
      }

      let dest = make(scale, orientation)
      let dest = switch center {
      | #Right => {
          right: dest.front,
          front: dest.left,
          left: dest.back,
          back: dest.right,
          top: dest.top->Face.rotate(-90.0),
          bottom: dest.bottom->Face.flip(#Vertical)->Face.rotate(90.0),
        }
      | #Front => {
          right: dest.right,
          front: dest.front,
          left: dest.left,
          back: dest.back,
          top: dest.top,
          bottom: dest.bottom->Face.flip(#Vertical),
        }
      | #Left => {
          right: dest.back,
          front: dest.right,
          left: dest.front,
          back: dest.left,
          top: dest.top->Face.rotate(90.0),
          bottom: dest.bottom->Face.flip(#Vertical)->Face.rotate(-90.0),
        }
      | #Back => {
          right: dest.left,
          front: dest.back,
          left: dest.right,
          back: dest.front,
          top: dest.top->Face.rotate(180.0),
          bottom: dest.bottom->Face.flip(#Horizontal),
        }
      | #Top => {
          right: dest.right->Face.rotate(90.0),
          front: dest.bottom,
          left: dest.left->Face.rotate(-90.0),
          back: dest.top->Face.rotate(180.0),
          top: dest.front,
          bottom: dest.back->Face.flip(#Horizontal),
        }
      | #Bottom => {
          right: dest.right->Face.rotate(-90.0),
          front: dest.top,
          left: dest.left->Face.rotate(90.0),
          back: dest.bottom->Face.rotate(180.0),
          top: dest.back->Face.rotate(180.0),
          bottom: dest.front->Face.flip(#Vertical),
        }
      }
      let axis = getAxis(scale, orientation)
      rotate(dest, axis, r)
    }
  }

  let draw = (
    textureId: string,
    source: Source.t,
    position: Builder.position,
    scale: scale,
    ~orientation: Dest.orientation=#West,
    ~center: Dest.center=#Front,
    ~rotate: float=0.0,
    (),
  ) => {
    let dest = Dest.setLayout(scale, orientation, center, rotate)->Dest.translate(position)
    Face.draw(textureId, source.front, dest.front)
    Face.draw(textureId, source.back, dest.back)
    Face.draw(textureId, source.top, dest.top)
    Face.draw(textureId, source.bottom, dest.bottom)
    Face.draw(textureId, source.left, dest.left)
    Face.draw(textureId, source.right, dest.right)
  }
}

let drawCuboid = (
  textureId: string,
  source: Cuboid.Source.t,
  position: Builder.position,
  scale: scale,
  ~orientation: Cuboid.Dest.orientation=#West,
  ~center: Cuboid.Dest.center=#Front,
  ~rotate: float=0.0,
  (),
) => Cuboid.draw(textureId, source, position, scale, ~orientation, ~center, ~rotate, ())

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

module Horse = {
  type t = {
    head: Cuboid.Source.t,
    mouth: Cuboid.Source.t,
    neck: Cuboid.Source.t,
    mane: Cuboid.Source.t,
    tail: Cuboid.Source.t,
    horseEar: Cuboid.Source.t,
    muleEar: Cuboid.Source.t,
    body: Cuboid.Source.t,
    leg: Cuboid.Source.t,
  }

  let {make, translate} = module(Cuboid.Source)
  let horse: t = {
    head: make((6, 5, 7))->translate((0, 13)),
    mouth: make((4, 5, 5))->translate((0, 25)),
    neck: make((4, 12, 7))->translate((0, 35)),
    mane: make((2, 16, 2))->translate((56, 36)),
    tail: make((3, 14, 4))->translate((42, 36)),
    horseEar: make((2, 2, 1))->translate((19, 16)),
    muleEar: make((2, 7, 1))->translate((0, 12)),
    body: make((10, 10, 22))->translate((0, 32)),
    leg: make((4, 11, 4))->translate((48, 21)),
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
