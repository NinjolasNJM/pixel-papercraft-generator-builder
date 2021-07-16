// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var React = require("react");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Generator = require("../../builder/modules/Generator.bs.js");
var Belt_Option = require("rescript/lib/js/belt_Option.js");
var MinecraftBlock_Face = require("./MinecraftBlock_Face.bs.js");
var MinecraftBlock_Textures = require("./MinecraftBlock_Textures.bs.js");
var MinecraftBlock_Components = require("./MinecraftBlock_Components.bs.js");

var id = "minecraft-block";

var name = "Minecraft Block";

var thumbnail = {
  url: require("./thumbnail.jpg")
};

function make(ox, oy) {
  return {
          top: [
            ox + 128 | 0,
            oy + 0 | 0,
            128,
            128
          ],
          bottom: [
            ox + 128 | 0,
            oy + 256 | 0,
            128,
            128
          ],
          right: [
            ox,
            oy + 128 | 0,
            128,
            128
          ],
          front: [
            ox + 128 | 0,
            oy + 128 | 0,
            128,
            128
          ],
          left: [
            ox + 256 | 0,
            oy + 128 | 0,
            128,
            128
          ],
          back: [
            ox + 384 | 0,
            oy + 128 | 0,
            128,
            128
          ]
        };
}

var Regions = {
  size: 128,
  make: make
};

function draw(blockId, ox, oy) {
  var regions = make(ox, oy);
  MinecraftBlock_Face.defineInputRegion("BlockFaceTop" + blockId, regions.top);
  MinecraftBlock_Face.defineInputRegion("BlockFaceBottom" + blockId, regions.bottom);
  MinecraftBlock_Face.defineInputRegion("BlockFaceRight" + blockId, regions.right);
  MinecraftBlock_Face.defineInputRegion("BlockFaceFront" + blockId, regions.front);
  MinecraftBlock_Face.defineInputRegion("BlockFaceLeft" + blockId, regions.left);
  MinecraftBlock_Face.defineInputRegion("BlockFaceBack" + blockId, regions.back);
  MinecraftBlock_Face.draw("BlockFaceTop" + blockId, [
        0,
        0,
        16,
        16
      ], regions.top, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("BlockFaceBottom" + blockId, [
        0,
        0,
        16,
        16
      ], regions.bottom, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("BlockFaceRight" + blockId, [
        0,
        0,
        16,
        16
      ], regions.right, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("BlockFaceFront" + blockId, [
        0,
        0,
        16,
        16
      ], regions.front, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("BlockFaceLeft" + blockId, [
        0,
        0,
        16,
        16
      ], regions.left, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("BlockFaceBack" + blockId, [
        0,
        0,
        16,
        16
      ], regions.back, undefined, undefined, undefined);
  Generator.drawImage("Tabs-Block", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  if (showFolds) {
    return Generator.drawImage("Folds-Block", [
                ox - 32 | 0,
                oy - 1 | 0
              ]);
  }
  
}

var Block = {
  Regions: Regions,
  draw: draw
};

function make$1(ox, oy) {
  return {
          top: [
            ox + 128 | 0,
            oy + 64 | 0,
            128,
            128
          ],
          bottom: [
            ox + 128 | 0,
            oy + 256 | 0,
            128,
            128
          ],
          right: [
            ox,
            oy + 192 | 0,
            128,
            64
          ],
          front: [
            ox + 128 | 0,
            oy + 192 | 0,
            128,
            64
          ],
          left: [
            ox + 256 | 0,
            oy + 192 | 0,
            128,
            64
          ],
          back: [
            ox + 384 | 0,
            oy + 192 | 0,
            128,
            64
          ]
        };
}

var Regions$1 = {
  size: 128,
  make: make$1
};

function draw$1(blockId, ox, oy) {
  var regions = make$1(ox, oy);
  MinecraftBlock_Face.defineInputRegion("SlabFaceTop" + blockId, regions.top);
  MinecraftBlock_Face.defineInputRegion("SlabFaceBottom" + blockId, regions.bottom);
  MinecraftBlock_Face.defineInputRegion("SlabFaceRight" + blockId, regions.right);
  MinecraftBlock_Face.defineInputRegion("SlabFaceFront" + blockId, regions.front);
  MinecraftBlock_Face.defineInputRegion("SlabFaceLeft" + blockId, regions.left);
  MinecraftBlock_Face.defineInputRegion("SlabFaceBack" + blockId, regions.back);
  MinecraftBlock_Face.draw("SlabFaceTop" + blockId, [
        0,
        0,
        16,
        16
      ], regions.top, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SlabFaceBottom" + blockId, [
        0,
        0,
        16,
        16
      ], regions.bottom, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SlabFaceRight" + blockId, [
        0,
        8,
        16,
        8
      ], regions.right, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SlabFaceFront" + blockId, [
        0,
        8,
        16,
        8
      ], regions.front, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SlabFaceLeft" + blockId, [
        0,
        8,
        16,
        8
      ], regions.left, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SlabFaceBack" + blockId, [
        0,
        8,
        16,
        8
      ], regions.back, undefined, undefined, undefined);
  Generator.drawImage("Tabs-Slab", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  if (showFolds) {
    return Generator.drawImage("Folds-Slab", [
                ox - 32 | 0,
                oy - 1 | 0
              ]);
  }
  
}

var Slab = {
  Regions: Regions$1,
  draw: draw$1
};

function make$2(ox, oy) {
  return {
          top: [
            ox + 128 | 0,
            oy + 64 | 0,
            128,
            64
          ],
          top2: [
            ox + 384 | 0,
            oy + 128 | 0,
            128,
            64
          ],
          bottom: [
            ox + 128 | 0,
            oy + 256 | 0,
            128,
            128
          ],
          right: [
            ox,
            oy + 128 | 0,
            128,
            128
          ],
          front: [
            ox + 128 | 0,
            oy + 128 | 0,
            128,
            128
          ],
          left: [
            ox + 256 | 0,
            oy + 128 | 0,
            128,
            128
          ],
          back: [
            ox + 384 | 0,
            oy + 192 | 0,
            128,
            64
          ],
          back2: [
            ox + 128 | 0,
            oy + 0 | 0,
            128,
            64
          ]
        };
}

var Regions$2 = {
  size: 128,
  make: make$2
};

function draw$2(blockId, ox, oy) {
  var regions = make$2(ox, oy);
  MinecraftBlock_Face.defineInputRegion("StairFaceTop" + blockId, regions.top);
  MinecraftBlock_Face.defineInputRegion("StairFaceBottom" + blockId, regions.bottom);
  MinecraftBlock_Face.defineInputRegion("StairFaceRight" + blockId, regions.right);
  MinecraftBlock_Face.defineInputRegion("StairFaceFront" + blockId, regions.front);
  MinecraftBlock_Face.defineInputRegion("StairFaceLeft" + blockId, regions.left);
  MinecraftBlock_Face.defineInputRegion("StairFaceBack" + blockId, regions.back);
  MinecraftBlock_Face.draw("StairFaceTop" + blockId, [
        0,
        8,
        16,
        8
      ], regions.top, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("StairFaceBack" + blockId, [
        0,
        0,
        16,
        8
      ], regions.back2, undefined, 180.0, undefined);
  MinecraftBlock_Face.draw("StairFaceBottom" + blockId, [
        0,
        0,
        16,
        16
      ], regions.bottom, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("StairFaceRight" + blockId, [
        0,
        0,
        16,
        16
      ], regions.right, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("StairFaceFront" + blockId, [
        0,
        0,
        16,
        16
      ], regions.front, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("StairFaceLeft" + blockId, [
        0,
        0,
        16,
        16
      ], regions.left, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("StairFaceBack" + blockId, [
        0,
        8,
        16,
        8
      ], regions.back, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("StairFaceTop" + blockId, [
        0,
        0,
        16,
        8
      ], regions.top2, undefined, 180.0, undefined);
  Generator.drawImage("Tabs-Stair", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  if (showFolds) {
    return Generator.drawImage("Folds-Stair", [
                ox - 32 | 0,
                oy - 1 | 0
              ]);
  }
  
}

var Stair = {
  Regions: Regions$2,
  draw: draw$2
};

function make$3(ox, oy) {
  return {
          top: [
            (ox + 128 | 0) + 32 | 0,
            oy + 96 | 0,
            32,
            32
          ],
          bottom: [
            (ox + 128 | 0) + 32 | 0,
            oy + 256 | 0,
            32,
            32
          ],
          right: [
            (ox + 128 | 0) + 64 | 0,
            oy + 128 | 0,
            32,
            128
          ],
          front: [
            (ox + 128 | 0) + 32 | 0,
            oy + 128 | 0,
            32,
            128
          ],
          left: [
            ox + 128 | 0,
            oy + 128 | 0,
            32,
            128
          ],
          back: [
            (ox + 128 | 0) + 96 | 0,
            oy + 128 | 0,
            32,
            128
          ],
          stop1: [
            (ox - 1 | 0) + 16 | 0,
            oy + 96 | 0,
            48,
            16
          ],
          sbottom1: [
            (ox - 1 | 0) + 16 | 0,
            ((oy + 96 | 0) + 16 | 0) + 24 | 0,
            48,
            16
          ],
          sright1: [
            ((ox - 1 | 0) + 16 | 0) + 48 | 0,
            (oy + 96 | 0) + 16 | 0,
            16,
            24
          ],
          sfront1: [
            (ox - 1 | 0) + 16 | 0,
            (oy + 96 | 0) + 16 | 0,
            48,
            24
          ],
          sleft1: [
            ox - 1 | 0,
            (oy + 96 | 0) + 16 | 0,
            16,
            24
          ],
          sback1: [
            (ox - 1 | 0) + 16 | 0,
            ((oy + 96 | 0) + 32 | 0) + 24 | 0,
            48,
            24
          ],
          stop2: [
            (ox - 1 | 0) + 16 | 0,
            oy + 208 | 0,
            48,
            16
          ],
          sbottom2: [
            (ox - 1 | 0) + 16 | 0,
            ((oy + 208 | 0) + 16 | 0) + 24 | 0,
            48,
            16
          ],
          sright2: [
            ((ox - 1 | 0) + 16 | 0) + 48 | 0,
            (oy + 208 | 0) + 16 | 0,
            16,
            24
          ],
          sfront2: [
            (ox - 1 | 0) + 16 | 0,
            (oy + 208 | 0) + 16 | 0,
            48,
            24
          ],
          sleft2: [
            ox - 1 | 0,
            (oy + 208 | 0) + 16 | 0,
            16,
            24
          ],
          sback2: [
            (ox - 1 | 0) + 16 | 0,
            ((oy + 208 | 0) + 32 | 0) + 24 | 0,
            48,
            24
          ],
          ltop1: [
            (ox + 320 | 0) + 16 | 0,
            oy + 96 | 0,
            48,
            16
          ],
          lbottom1: [
            (ox + 320 | 0) + 16 | 0,
            ((oy + 96 | 0) + 16 | 0) + 24 | 0,
            48,
            16
          ],
          lright1: [
            ((ox + 320 | 0) + 16 | 0) + 96 | 0,
            (oy + 96 | 0) + 16 | 0,
            16,
            24
          ],
          lfront1: [
            (ox + 320 | 0) + 16 | 0,
            (oy + 96 | 0) + 16 | 0,
            48,
            24
          ],
          lleft1: [
            ox + 320 | 0,
            (oy + 96 | 0) + 16 | 0,
            16,
            24
          ],
          lback1: [
            (ox + 320 | 0) + 16 | 0,
            ((oy + 96 | 0) + 32 | 0) + 24 | 0,
            48,
            24
          ],
          l2top1: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            oy + 96 | 0,
            48,
            16
          ],
          l2bottom1: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            ((oy + 96 | 0) + 16 | 0) + 24 | 0,
            48,
            16
          ],
          l2front1: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            (oy + 96 | 0) + 16 | 0,
            48,
            24
          ],
          l2back1: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            ((oy + 96 | 0) + 32 | 0) + 24 | 0,
            48,
            24
          ],
          ltop2: [
            (ox + 320 | 0) + 16 | 0,
            oy + 208 | 0,
            48,
            16
          ],
          lbottom2: [
            (ox + 320 | 0) + 16 | 0,
            ((oy + 208 | 0) + 16 | 0) + 24 | 0,
            48,
            16
          ],
          lright2: [
            ((ox + 320 | 0) + 16 | 0) + 96 | 0,
            (oy + 208 | 0) + 16 | 0,
            16,
            24
          ],
          lfront2: [
            (ox + 320 | 0) + 16 | 0,
            (oy + 208 | 0) + 16 | 0,
            48,
            24
          ],
          lleft2: [
            ox + 320 | 0,
            (oy + 208 | 0) + 16 | 0,
            16,
            24
          ],
          lback2: [
            (ox + 320 | 0) + 16 | 0,
            ((oy + 208 | 0) + 32 | 0) + 24 | 0,
            48,
            24
          ],
          l2top2: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            oy + 208 | 0,
            48,
            16
          ],
          l2bottom2: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            ((oy + 208 | 0) + 16 | 0) + 24 | 0,
            48,
            16
          ],
          l2front2: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            (oy + 208 | 0) + 16 | 0,
            48,
            24
          ],
          l2back2: [
            ((ox + 320 | 0) + 16 | 0) + 48 | 0,
            ((oy + 208 | 0) + 32 | 0) + 24 | 0,
            48,
            24
          ]
        };
}

var Regions$3 = {
  size: 128,
  size2: 16,
  size3: 24,
  sizel: 96,
  x1: -1,
  x2: 320,
  y1: 96,
  y2: 208,
  make: make$3
};

function draw$3(blockId, ox, oy) {
  var regions = make$3(ox, oy);
  MinecraftBlock_Face.defineInputRegion("FenceFaceTop" + blockId, regions.top);
  MinecraftBlock_Face.defineInputRegion("FenceFaceBottom" + blockId, regions.bottom);
  MinecraftBlock_Face.defineInputRegion("FenceFaceRight" + blockId, regions.right);
  MinecraftBlock_Face.defineInputRegion("FenceFaceFront" + blockId, regions.front);
  MinecraftBlock_Face.defineInputRegion("FenceFaceLeft" + blockId, regions.left);
  MinecraftBlock_Face.defineInputRegion("FenceFaceBack" + blockId, regions.back);
  MinecraftBlock_Face.draw("FenceFaceTop" + blockId, [
        6,
        6,
        4,
        4
      ], regions.top, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBottom" + blockId, [
        6,
        6,
        4,
        4
      ], regions.bottom, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceRight" + blockId, [
        6,
        0,
        4,
        16
      ], regions.right, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceFront" + blockId, [
        6,
        0,
        4,
        16
      ], regions.front, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceLeft" + blockId, [
        6,
        0,
        4,
        16
      ], regions.left, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBack" + blockId, [
        6,
        0,
        4,
        16
      ], regions.back, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceTop" + blockId, [
        10,
        7,
        6,
        2
      ], regions.stop1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBottom" + blockId, [
        10,
        7,
        6,
        2
      ], regions.sbottom1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceRight" + blockId, [
        7,
        1,
        2,
        3
      ], regions.sright1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceFront" + blockId, [
        10,
        1,
        6,
        3
      ], regions.sfront1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceLeft" + blockId, [
        7,
        1,
        2,
        3
      ], regions.sleft1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBack" + blockId, [
        0,
        1,
        6,
        3
      ], regions.sback1, undefined, 180.0, undefined);
  MinecraftBlock_Face.draw("FenceFaceTop" + blockId, [
        10,
        7,
        6,
        2
      ], regions.stop2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBottom" + blockId, [
        10,
        7,
        6,
        2
      ], regions.sbottom2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceRight" + blockId, [
        7,
        7,
        2,
        3
      ], regions.sright2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceFront" + blockId, [
        10,
        7,
        6,
        3
      ], regions.sfront2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceLeft" + blockId, [
        7,
        7,
        2,
        3
      ], regions.sleft2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBack" + blockId, [
        0,
        7,
        6,
        3
      ], regions.sback2, undefined, 180.0, undefined);
  MinecraftBlock_Face.draw("FenceFaceTop" + blockId, [
        10,
        7,
        6,
        2
      ], regions.ltop1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBottom" + blockId, [
        10,
        7,
        6,
        2
      ], regions.lbottom1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceRight" + blockId, [
        7,
        1,
        2,
        3
      ], regions.lright1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceFront" + blockId, [
        10,
        1,
        6,
        3
      ], regions.lfront1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceLeft" + blockId, [
        7,
        1,
        2,
        3
      ], regions.lleft1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBack" + blockId, [
        0,
        1,
        6,
        3
      ], regions.lback1, undefined, 180.0, undefined);
  MinecraftBlock_Face.draw("FenceFaceTop" + blockId, [
        0,
        7,
        6,
        2
      ], regions.l2top1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBottom" + blockId, [
        0,
        7,
        6,
        2
      ], regions.l2bottom1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceFront" + blockId, [
        0,
        1,
        6,
        3
      ], regions.l2front1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBack" + blockId, [
        7,
        1,
        6,
        3
      ], regions.l2back1, undefined, 180.0, undefined);
  MinecraftBlock_Face.draw("FenceFaceTop" + blockId, [
        10,
        7,
        6,
        2
      ], regions.ltop2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBottom" + blockId, [
        10,
        7,
        6,
        2
      ], regions.lbottom2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceRight" + blockId, [
        7,
        7,
        2,
        3
      ], regions.lright2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceFront" + blockId, [
        10,
        7,
        6,
        3
      ], regions.lfront2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceLeft" + blockId, [
        7,
        7,
        2,
        3
      ], regions.lleft2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBack" + blockId, [
        0,
        7,
        6,
        3
      ], regions.lback2, undefined, 180.0, undefined);
  MinecraftBlock_Face.draw("FenceFaceTop" + blockId, [
        0,
        7,
        6,
        2
      ], regions.l2top2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBottom" + blockId, [
        0,
        7,
        6,
        2
      ], regions.l2bottom2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceFront" + blockId, [
        0,
        7,
        6,
        3
      ], regions.l2front2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("FenceFaceBack" + blockId, [
        7,
        7,
        6,
        3
      ], regions.l2back2, undefined, 180.0, undefined);
  Generator.drawImage("Tabs-Fence", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  if (showFolds) {
    return Generator.drawImage("Folds-Fence", [
                ox - 32 | 0,
                oy - 1 | 0
              ]);
  }
  
}

var Fence = {
  Regions: Regions$3,
  draw: draw$3
};

function make$4(ox, oy) {
  return {
          top: [
            (ox + 192 | 0) - 12 | 0,
            oy - 12 | 0,
            24,
            128
          ],
          bottom: [
            (ox + 192 | 0) - 12 | 0,
            (oy + 256 | 0) + 12 | 0,
            24,
            128
          ],
          right1: [
            (ox + 128 | 0) - 24 | 0,
            oy + 64 | 0,
            24,
            128
          ],
          front1: [
            ox + 128 | 0,
            oy + 64 | 0,
            128,
            128
          ],
          left1: [
            ox + 256 | 0,
            oy + 64 | 0,
            24,
            128
          ],
          back1: [
            (ox + 256 | 0) + 24 | 0,
            oy + 64 | 0,
            128,
            128
          ],
          right2: [
            (ox + 128 | 0) - 24 | 0,
            oy + 192 | 0,
            24,
            128
          ],
          front2: [
            ox + 128 | 0,
            oy + 192 | 0,
            128,
            128
          ],
          left2: [
            ox + 256 | 0,
            oy + 192 | 0,
            24,
            128
          ],
          back2: [
            (ox + 256 | 0) + 24 | 0,
            oy + 192 | 0,
            128,
            128
          ]
        };
}

var Regions$4 = {
  size: 128,
  size2: 24,
  make: make$4
};

function draw$4(blockId, ox, oy) {
  var regions = make$4(ox, oy);
  MinecraftBlock_Face.defineInputRegion("DoorFace1" + blockId, regions.front1);
  MinecraftBlock_Face.defineInputRegion("DoorFace2" + blockId, regions.front2);
  MinecraftBlock_Face.draw("DoorFace2" + blockId, [
        13,
        0,
        3,
        16
      ], regions.top, undefined, -90.0, undefined);
  MinecraftBlock_Face.draw("DoorFace2" + blockId, [
        13,
        0,
        3,
        16
      ], regions.bottom, undefined, 90.0, undefined);
  MinecraftBlock_Face.draw("DoorFace1" + blockId, [
        0,
        0,
        3,
        16
      ], regions.right1, "Horizontal", undefined, undefined);
  MinecraftBlock_Face.draw("DoorFace1" + blockId, [
        0,
        0,
        16,
        16
      ], regions.front1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("DoorFace1" + blockId, [
        0,
        0,
        3,
        16
      ], regions.left1, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("DoorFace1" + blockId, [
        0,
        0,
        16,
        16
      ], regions.back1, "Horizontal", undefined, undefined);
  MinecraftBlock_Face.draw("DoorFace2" + blockId, [
        0,
        0,
        3,
        16
      ], regions.right2, "Horizontal", undefined, undefined);
  MinecraftBlock_Face.draw("DoorFace2" + blockId, [
        0,
        0,
        16,
        16
      ], regions.front2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("DoorFace2" + blockId, [
        0,
        0,
        3,
        16
      ], regions.left2, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("DoorFace2" + blockId, [
        0,
        0,
        16,
        16
      ], regions.back2, "Horizontal", undefined, undefined);
  Generator.drawImage("Tabs-Door", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  if (showFolds) {
    return Generator.drawImage("Folds-Door", [
                ox - 32 | 0,
                oy - 1 | 0
              ]);
  }
  
}

var Door = {
  Regions: Regions$4,
  draw: draw$4
};

function make$5(ox, oy) {
  return {
          top: [
            ox + 128 | 0,
            (oy + 128 | 0) - 24 | 0,
            128,
            24
          ],
          bottom: [
            ox + 128 | 0,
            oy + 256 | 0,
            128,
            24
          ],
          right: [
            (ox + 64 | 0) - 12 | 0,
            (oy + 192 | 0) - 12 | 0,
            128,
            24
          ],
          front: [
            ox + 128 | 0,
            oy + 128 | 0,
            128,
            128
          ],
          left: [
            (ox + 192 | 0) + 12 | 0,
            (oy + 192 | 0) - 12 | 0,
            128,
            24
          ],
          back: [
            (ox + 256 | 0) + 24 | 0,
            oy + 128 | 0,
            128,
            128
          ]
        };
}

var Regions$5 = {
  size: 128,
  size2: 24,
  make: make$5
};

function draw$5(blockId, ox, oy) {
  var regions = make$5(ox, oy);
  MinecraftBlock_Face.defineInputRegion("TrapdoorFace" + blockId, regions.front);
  MinecraftBlock_Face.draw("TrapdoorFace" + blockId, [
        0,
        0,
        16,
        3
      ], regions.top, undefined, 180.0, undefined);
  MinecraftBlock_Face.draw("TrapdoorFace" + blockId, [
        0,
        0,
        16,
        3
      ], regions.bottom, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("TrapdoorFace" + blockId, [
        0,
        0,
        16,
        3
      ], regions.right, undefined, 90.0, undefined);
  MinecraftBlock_Face.draw("TrapdoorFace" + blockId, [
        0,
        0,
        16,
        16
      ], regions.front, "Horizontal", undefined, undefined);
  MinecraftBlock_Face.draw("TrapdoorFace" + blockId, [
        0,
        0,
        16,
        3
      ], regions.left, undefined, -90.0, undefined);
  MinecraftBlock_Face.draw("TrapdoorFace" + blockId, [
        0,
        0,
        16,
        16
      ], regions.back, undefined, undefined, undefined);
  Generator.drawImage("Tabs-Trapdoor", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  if (showFolds) {
    return Generator.drawImage("Folds-Trapdoor", [
                ox - 32 | 0,
                oy - 1 | 0
              ]);
  }
  
}

var Trapdoor = {
  Regions: Regions$5,
  draw: draw$5
};

function make$6(ox, oy, levels, offset) {
  return {
          top: [
            ox + 128 | 0,
            ((oy + 128 | 0) - (levels << 4) | 0) + (offset << 3) | 0,
            128,
            128
          ],
          bottom: [
            ox + 128 | 0,
            oy + 256 | 0,
            128,
            128
          ],
          right: [
            ox,
            ((oy + 256 | 0) - (levels << 4) | 0) + (offset << 3) | 0,
            128,
            (levels << 4) - (offset << 3) | 0
          ],
          front: [
            ox + 128 | 0,
            ((oy + 256 | 0) - (levels << 4) | 0) + (offset << 3) | 0,
            128,
            (levels << 4) - (offset << 3) | 0
          ],
          left: [
            ox + 256 | 0,
            ((oy + 256 | 0) - (levels << 4) | 0) + (offset << 3) | 0,
            128,
            (levels << 4) - (offset << 3) | 0
          ],
          back: [
            ox + 384 | 0,
            ((oy + 256 | 0) - (levels << 4) | 0) + (offset << 3) | 0,
            128,
            (levels << 4) - (offset << 3) | 0
          ]
        };
}

var Regions$6 = {
  size: 128,
  make: make$6
};

function draw$6(blockId, ox, oy) {
  Generator.defineSelectInput("Block " + blockId + " Level", [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8"
      ]);
  Generator.defineBooleanInput("Block " + blockId + " Offset for Intermediate Levels", false);
  var levels = Belt_Option.getWithDefault(Belt_Int.fromString(Generator.getSelectInputValue("Block " + blockId + " Level")), 1);
  var offset = Generator.getBooleanInputValue("Block " + blockId + " Offset for Intermediate Levels") ? 1 : 0;
  var regions = make$6(ox, oy, levels, offset);
  MinecraftBlock_Face.defineInputRegion("SnowFaceTop" + blockId, regions.top);
  MinecraftBlock_Face.defineInputRegion("SnowFaceBottom" + blockId, regions.bottom);
  MinecraftBlock_Face.defineInputRegion("SnowFaceRight" + blockId, regions.right);
  MinecraftBlock_Face.defineInputRegion("SnowFaceFront" + blockId, regions.front);
  MinecraftBlock_Face.defineInputRegion("SnowFaceLeft" + blockId, regions.left);
  MinecraftBlock_Face.defineInputRegion("SnowFaceBack" + blockId, regions.back);
  MinecraftBlock_Face.draw("SnowFaceTop" + blockId, [
        0,
        0,
        16,
        16
      ], regions.top, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SnowFaceBottom" + blockId, [
        0,
        0,
        16,
        16
      ], regions.bottom, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SnowFaceRight" + blockId, [
        0,
        (16 - (levels << 1) | 0) + offset | 0,
        16,
        (levels << 1) - offset | 0
      ], regions.right, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SnowFaceFront" + blockId, [
        0,
        (16 - (levels << 1) | 0) + offset | 0,
        16,
        (levels << 1) - offset | 0
      ], regions.front, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SnowFaceLeft" + blockId, [
        0,
        (16 - (levels << 1) | 0) + offset | 0,
        16,
        (levels << 1) - offset | 0
      ], regions.left, undefined, undefined, undefined);
  MinecraftBlock_Face.draw("SnowFaceBack" + blockId, [
        0,
        (16 - (levels << 1) | 0) + offset | 0,
        16,
        (levels << 1) - offset | 0
      ], regions.back, undefined, undefined, undefined);
  Generator.drawImage("Tabs-Snow-Bottom", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  if (showFolds) {
    Generator.drawImage("Folds-Snow-Bottom", [
          ox - 32 | 0,
          oy - 1 | 0
        ]);
  }
  Generator.drawImage("Tabs-Snow-Top", [
        ox - 32 | 0,
        (((oy - 1 | 0) + 128 | 0) - (levels << 4) | 0) + (offset << 3) | 0
      ]);
  Generator.drawImage("Tabs-Snow-Middle", [
        ox - 32 | 0,
        oy - 1 | 0
      ]);
  if (showFolds) {
    return Generator.drawImage("Folds-Snow-Top", [
                ox - 32 | 0,
                (((oy - 1 | 0) + 128 | 0) - (levels << 4) | 0) + (offset << 3) | 0
              ]);
  }
  
}

var Snow = {
  Regions: Regions$6,
  draw: draw$6
};

var images = [
  {
    id: "Background",
    url: require("./images/Background.png")
  },
  {
    id: "Title",
    url: require("./images/Title.png")
  },
  {
    id: "Folds-Block",
    url: require("./images/Folds-Block.png")
  },
  {
    id: "Tabs-Block",
    url: require("./images/Tabs-Block.png")
  },
  {
    id: "Folds-Slab",
    url: require("./images/Folds-Slab.png")
  },
  {
    id: "Tabs-Slab",
    url: require("./images/Tabs-Slab.png")
  },
  {
    id: "Folds-Stair",
    url: require("./images/Folds-Stair.png")
  },
  {
    id: "Tabs-Stair",
    url: require("./images/Tabs-Stair.png")
  },
  {
    id: "Folds-Fence",
    url: require("./images/Folds-Fence.png")
  },
  {
    id: "Tabs-Fence",
    url: require("./images/Tabs-Fence.png")
  },
  {
    id: "Folds-Door",
    url: require("./images/Folds-Door.png")
  },
  {
    id: "Tabs-Door",
    url: require("./images/Tabs-Door.png")
  },
  {
    id: "Folds-Trapdoor",
    url: require("./images/Folds-Trapdoor.png")
  },
  {
    id: "Tabs-Trapdoor",
    url: require("./images/Tabs-Trapdoor.png")
  },
  {
    id: "Folds-Snow-Top",
    url: require("./images/Folds-Snow-Top.png")
  },
  {
    id: "Folds-Snow-Bottom",
    url: require("./images/Folds-Snow-Bottom.png")
  },
  {
    id: "Tabs-Snow-Top",
    url: require("./images/Tabs-Snow-Top.png")
  },
  {
    id: "Tabs-Snow-Middle",
    url: require("./images/Tabs-Snow-Middle.png")
  },
  {
    id: "Tabs-Snow-Bottom",
    url: require("./images/Tabs-Snow-Bottom.png")
  }
];

function script(param) {
  Generator.defineSelectInput("Version", MinecraftBlock_Textures.versionIds);
  var versionId = Generator.getSelectInputValue("Version");
  Generator.defineCustomStringInput("BlockTexture", (function (onChange) {
          return React.createElement(MinecraftBlock_Components.TexturePicker.make, {
                      versionId: versionId,
                      onChange: onChange
                    });
        }));
  Generator.defineSelectInput("Number of Blocks", [
        "1",
        "2"
      ]);
  var numberOfBlocks = Belt_Option.getWithDefault(Belt_Int.fromString(Generator.getSelectInputValue("Number of Blocks")), 1);
  Generator.defineBooleanInput("Show Folds", true);
  Generator.drawImage("Background", [
        0,
        0
      ]);
  for(var i = 1; i <= numberOfBlocks; ++i){
    var blockId = i.toString();
    var typeName = "Block " + blockId + " Type";
    Generator.defineSelectInput(typeName, [
          "Block",
          "Slab",
          "Stair",
          "Fence",
          "Door",
          "Trapdoor",
          "Snow Layers"
        ]);
    var blockType = Generator.getSelectInputValue(typeName);
    switch (blockType) {
      case "Block" :
          var oy = 16 + Math.imul(400, i - 1 | 0) | 0;
          draw(blockId, 57, oy);
          break;
      case "Door" :
          var oy$1 = 16 + Math.imul(400, i - 1 | 0) | 0;
          draw$4(blockId, 57, oy$1);
          break;
      case "Fence" :
          var oy$2 = 16 + Math.imul(400, i - 1 | 0) | 0;
          draw$3(blockId, 57, oy$2);
          break;
      case "Slab" :
          var oy$3 = 16 + Math.imul(400, i - 1 | 0) | 0;
          draw$1(blockId, 57, oy$3);
          break;
      case "Snow Layers" :
          var oy$4 = 16 + Math.imul(400, i - 1 | 0) | 0;
          draw$6(blockId, 57, oy$4);
          break;
      case "Stair" :
          var oy$5 = 16 + Math.imul(400, i - 1 | 0) | 0;
          draw$2(blockId, 57, oy$5);
          break;
      case "Trapdoor" :
          var oy$6 = 16 + Math.imul(400, i - 1 | 0) | 0;
          draw$5(blockId, 57, oy$6);
          break;
      default:
        
    }
  }
  return Generator.drawImage("Title", [
              0,
              0
            ]);
}

var generator_thumbnail = thumbnail;

var generator = {
  id: id,
  name: name,
  thumbnail: generator_thumbnail,
  video: undefined,
  instructions: undefined,
  images: images,
  textures: MinecraftBlock_Textures.textures,
  script: script
};

var Components;

var Textures;

var Face;

var textures = MinecraftBlock_Textures.textures;

exports.Components = Components;
exports.Textures = Textures;
exports.Face = Face;
exports.id = id;
exports.name = name;
exports.thumbnail = thumbnail;
exports.Block = Block;
exports.Slab = Slab;
exports.Stair = Stair;
exports.Fence = Fence;
exports.Door = Door;
exports.Trapdoor = Trapdoor;
exports.Snow = Snow;
exports.images = images;
exports.textures = textures;
exports.script = script;
exports.generator = generator;
/* thumbnail Not a pure module */