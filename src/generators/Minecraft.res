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
  xTranslate: int,
  yTranslate: int,
): Builder.rectangle => {
  let (x, y, w, h) = rectangle
  (x + xTranslate, y + yTranslate, w, h)
}

module Cuboid = {
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

    let translate = ({rectangle, flip, rotate}: t, (dx, dy): Builder.position) => {
      rectangle: rectangle->translateRectangle(dx, dy),
      flip: flip,
      rotate: rotate,
    }

    let draw = (textureId: string, source: t, dest: t) => {
      Generator.drawTexture(
        textureId,
        source.rectangle,
        dest.rectangle,
        ~flip=dest.flip,
        ~rotate=dest.rotate,
        (),
      )
    }
  }
  type t = {
    front: Face.t,
    back: Face.t,
    top: Face.t,
    bottom: Face.t,
    right: Face.t,
    left: Face.t,
  }

  let translate = (cuboid: t, position: Builder.position) => {
    front: Face.translate(cuboid.front, position),
    back: Face.translate(cuboid.back, position),
    top: Face.translate(cuboid.top, position),
    bottom: Face.translate(cuboid.bottom, position),
    right: Face.translate(cuboid.right, position),
    left: Face.translate(cuboid.left, position),
  }

  type direction = [#East | #West | #North | #South]
  type scale = (int, int, int)
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
  let makeSource = ((w, h, d): scale): t => {
    {
      top: Face.make((d, 0, w, d)),
      bottom: Face.make((d + w, 0, w, d)),
      front: Face.make((d, d, w, h)),
      right: Face.make((0, d, d, h)),
      left: Face.make((d + w, d, d, h)),
      back: Face.make((d * 2 + w, d, w, h)),
    }
  }

  let makeDest = ((w, h, d): scale, direction: direction): t => {
    switch direction {
    | #East => {
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
        top: Face.make((d, 0, w, d)),
        right: Face.make((0, d, d, h)),
        front: Face.make((d, d, w, h)),
        left: Face.make((d + w, d, d, h)),
        back: Face.make((d + w + d, d, w, h)),
        bottom: Face.make((d, d + h, w, d)),
      }
    | #West => {
        // (0,0)
        //   .                   +----W----+
        //                       |         |
        //                       D   Top   D
        //                       |         |
        //   +----W----+----D----+----W----+----D----+
        //   |         |         |         |         |
        //   H  Back   H  Right  H  Front  H  Left   H
        //   |         |         |         |         |
        //   +----W----+----D----+----W----+----D----+
        //                       |         |
        //                       D Bottom  D
        //                       |         |
        //                       +----W----+
        //
        top: Face.make((w + d, 0, w, d)),
        back: Face.make((0, d, w, h)),
        right: Face.make((w, d, d, h)),
        front: Face.make((w + d, d, w, h)),
        left: Face.make((w + d + w, d, d, h)),
        bottom: Face.make((w + d, d + h, w, d)),
      }
    | #North => {
        // (0,0)
        //   .         +----W----+
        //             |         |
        //             D   Top   D
        //             |         |
        //   +----D----+----W----+----D----+
        //   |         |         |         |
        //   H  Right  H  Front  H  Left   H
        //   |         |         |         |
        //   +----D----+----W----+----D----+
        //             |         |
        //             D Bottom  D
        //             |         |
        //             +----W----+
        //             |         |
        //             H  Back   H
        //             |         |
        //             +----W----+
        //
        top: Face.make((d, 0, w, d)),
        right: Face.make((0, d, d, h)),
        front: Face.make((d, d, w, h)),
        left: Face.make((d + w, d, d, h)),
        bottom: Face.make((d, d + h, w, d)),
        back: Face.make((d, d + h + d, w, h)),
      }
    | #South => {
        // (0,0)
        //   .         +----W----+
        //             |         |
        //             H  Back   H
        //             |         |
        //             +----W----+
        //             |         |
        //             D   Top   D
        //             |         |
        //   +----D----+----W----+----D----+
        //   |         |         |         |
        //   H  Right  H  Front  H  Left   H
        //   |         |         |         |
        //   +----D----+----W----+----D----+
        //             |         |
        //             D Bottom  D
        //             |         |
        //             +----W----+
        //
        back: Face.make((d, 0, w, h)),
        top: Face.make((d, h, w, d)),
        right: Face.make((0, h + d, d, h)),
        front: Face.make((d, h + d, w, h)),
        left: Face.make((d + w, h + d, d, h)),
        bottom: Face.make((d, h + d + w, w, d)),
      }
    }
  }

  let getLayout = (scale, direction): t => {
    let cuboid = makeDest(scale, direction)
    switch direction {
    | #East => {
        top: cuboid.top,
        right: cuboid.right,
        front: cuboid.front,
        left: cuboid.left,
        back: cuboid.back,
        bottom: {rectangle: cuboid.bottom.rectangle, flip: #Vertical, rotate: 0.0},
      }
    | #West => {
        top: cuboid.top,
        right: cuboid.right,
        front: cuboid.front,
        left: cuboid.left,
        back: cuboid.back,
        bottom: {rectangle: cuboid.bottom.rectangle, flip: #Vertical, rotate: 0.0},
      }
    | #North => {
        top: cuboid.top,
        right: cuboid.right,
        front: cuboid.front,
        left: cuboid.left,
        back: {rectangle: cuboid.back.rectangle, flip: #None, rotate: 180.0},
        bottom: {rectangle: cuboid.bottom.rectangle, flip: #Vertical, rotate: 0.0},
      }
    | #South => {
        top: cuboid.top,
        right: cuboid.right,
        front: cuboid.front,
        left: cuboid.left,
        back: {rectangle: cuboid.back.rectangle, flip: #None, rotate: 180.0},
        bottom: {rectangle: cuboid.bottom.rectangle, flip: #Vertical, rotate: 0.0},
      }
    }
  }

  let draw = (
    textureId: string,
    source: t,
    position: Builder.position,
    scale: scale,
    ~direction: direction=#East,
    (),
  ) => {
    let dest = getLayout(scale, direction)->translate(position)
    Face.draw(textureId, source.front, dest.front)
    Face.draw(textureId, source.back, dest.back)
    Face.draw(textureId, source.top, dest.top)
    Face.draw(textureId, source.bottom, dest.bottom)
    Face.draw(textureId, source.left, dest.left)
    Face.draw(textureId, source.right, dest.right)
  }
}

/* module Cuboid = {
  module Face = {
    type t = {rectangle, flip, rotate, (etc)}
    let translate = rectangle->translateRectangle
  }
  
  type t = {top: Face.t, ... } // Faces.t
  let translate
  let translateRectangle

  let makeSource = scale: t // make
  let makeDest = (scale, direction): t // make2
  let getLayout = (scale, direction): t // getFaces

  let drawFace, or Face.draw
  let drawCuboid, or Cuboid.draw, = (textureId, source: makeSource, position, scale, ~direction) => {
    let dest = getLayout??-> translate(position)
    draw each of dest's faces
  }


 */

let drawCuboid = (
  textureId: string,
  source: Cuboid.t,
  position: Builder.position,
  scale: Cuboid.scale,
  ~direction: Cuboid.direction=#East,
  (),
) => Cuboid.draw(textureId, source, position, scale, ~direction, ())

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
      head: Cuboid.t,
      rightArm: Cuboid.t,
      leftArm: Cuboid.t,
      body: Cuboid.t,
      rightLeg: Cuboid.t,
      leftLeg: Cuboid.t,
    }
  }

  type t = {
    base: Layer.t,
    overlay: Layer.t,
  }

  let {makeSource, translate} = module(Cuboid)

  let steve: t = {
    base: {
      head: makeSource((8, 8, 8))->translate((0, 0)),
      rightArm: makeSource((4, 12, 4))->translate((40, 16)),
      leftArm: makeSource((4, 12, 4))->translate((32, 48)),
      body: makeSource((8, 12, 4))->translate((16, 16)),
      rightLeg: makeSource((4, 12, 4))->translate((0, 16)),
      leftLeg: makeSource((4, 12, 4))->translate((16, 48)),
    },
    overlay: {
      head: makeSource((8, 8, 8))->translate((32, 0)),
      rightArm: makeSource((4, 12, 4))->translate((40, 32)),
      leftArm: makeSource((4, 12, 4))->translate((48, 48)),
      body: makeSource((8, 12, 4))->translate((16, 32)),
      rightLeg: makeSource((4, 12, 4))->translate((0, 32)),
      leftLeg: makeSource((4, 12, 4))->translate((0, 48)),
    },
  }

  let alex: t = {
    base: {
      head: steve.base.head,
      rightArm: makeSource((3, 12, 4))->translate((40, 16)),
      leftArm: makeSource((3, 12, 4))->translate((32, 48)),
      body: steve.base.body,
      rightLeg: steve.base.rightLeg,
      leftLeg: steve.base.leftLeg,
    },
    overlay: {
      head: steve.overlay.head,
      rightArm: makeSource((3, 12, 4))->translate((40, 32)),
      leftArm: makeSource((3, 12, 4))->translate((48, 48)),
      body: steve.overlay.body,
      rightLeg: steve.overlay.rightLeg,
      leftLeg: steve.overlay.leftLeg,
    },
  }
}
