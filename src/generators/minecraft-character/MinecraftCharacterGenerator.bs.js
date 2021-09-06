// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var React = require("react");
var Generator = require("../../builder/modules/Generator.bs.js");
var TextureMap = require("../TextureMap.bs.js");
var Caml_option = require("rescript/lib/js/caml_option.js");

function requireImage(id) {
  return require("./images/" + id + ".png");
}

function requireTexture(id) {
  return require("./textures/" + id + ".png");
}

var id = "minecraft-character";

var name = "Minecraft Character";

var thumbnail = {
  url: require("./thumbnail/thumbnail.jpeg")
};

var instructions = React.createElement("div", undefined, React.createElement(Generator.Markup.H2.make, {
          children: "How to use the Minecraft Character Generator?"
        }), React.createElement(Generator.Markup.OL.make, {
          children: null
        }, React.createElement(Generator.Markup.LI.make, {
              children: "Choose the your texture file model type"
            }), React.createElement(Generator.Markup.LI.make, {
              children: "Select your Minecraft skin file"
            }), React.createElement(Generator.Markup.LI.make, {
              children: "Download and print your character papercraft"
            })));

var imageIds = [
  "Background-Alex",
  "Background-Steve",
  "Folds-Alex",
  "Folds-Steve",
  "Labels"
];

function toImageDef(id) {
  return {
          id: id,
          url: requireImage(id)
        };
}

var images = imageIds.map(toImageDef);

var textures = [{
    id: "Skin",
    url: requireTexture("Skin64x64Steve"),
    standardWidth: 64,
    standardHeight: 64
  }];

var steve = TextureMap.MinecraftCharacterLegacy.steve;

var alex = TextureMap.MinecraftCharacterLegacy.alex;

function script(param) {
  Generator.defineSelectInput("Skin Model Type", [
        "Steve",
        "Alex"
      ]);
  Generator.defineTextureInput("Skin", {
        standardWidth: 64,
        standardHeight: 64,
        choices: []
      });
  Generator.defineBooleanInput("Show Folds", true);
  Generator.defineBooleanInput("Show Labels", true);
  Generator.defineText("Click in the papercraft template to turn on and off the overlay for each part.");
  var alexModel = Generator.getSelectInputValue("Skin Model Type") === "Alex";
  var showFolds = Generator.getBooleanInputValue("Show Folds");
  var showLabels = Generator.getBooleanInputValue("Show Labels");
  var hideHelmet = Generator.getBooleanInputValue("Hide Helmet");
  var hideJacket = Generator.getBooleanInputValue("Hide Jacket");
  var hideLeftSleeve = Generator.getBooleanInputValue("Hide Left Sleeve");
  var hideRightSleeve = Generator.getBooleanInputValue("Hide Right Sleeve");
  var hideLeftPant = Generator.getBooleanInputValue("Hide Left Pant");
  var hideRightPant = Generator.getBooleanInputValue("Hide Right Pant");
  Generator.defineRegionInput([
        74,
        25,
        256,
        192
      ], (function (param) {
          return Generator.setBooleanInputValue("Hide Helmet", !hideHelmet);
        }));
  Generator.defineRegionInput([
        268,
        201,
        192,
        160
      ], (function (param) {
          return Generator.setBooleanInputValue("Hide Jacket", !hideJacket);
        }));
  Generator.defineRegionInput([
        383,
        373,
        128,
        160
      ], (function (param) {
          return Generator.setBooleanInputValue("Hide Left Sleeve", !hideLeftSleeve);
        }));
  Generator.defineRegionInput([
        99,
        373,
        128,
        160
      ], (function (param) {
          return Generator.setBooleanInputValue("Hide Right Sleeve", !hideRightSleeve);
        }));
  Generator.defineRegionInput([
        383,
        587,
        128,
        160
      ], (function (param) {
          return Generator.setBooleanInputValue("Hide Left Pant", !hideLeftPant);
        }));
  Generator.defineRegionInput([
        99,
        587,
        128,
        160
      ], (function (param) {
          return Generator.setBooleanInputValue("Hide Right Pant", !hideRightPant);
        }));
  if (alexModel) {
    Generator.drawImage("Background-Alex", [
          0,
          0
        ]);
  } else {
    Generator.drawImage("Background-Steve", [
          0,
          0
        ]);
  }
  Generator.drawTextureLegacy("Skin", steve.base.head.right, {
        x: 74,
        y: 89,
        w: 64,
        h: 64
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.head.front, {
        x: 138,
        y: 89,
        w: 64,
        h: 64
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.head.left, {
        x: 202,
        y: 89,
        w: 64,
        h: 64
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.head.back, {
        x: 266,
        y: 89,
        w: 64,
        h: 64
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.head.top, {
        x: 138,
        y: 25,
        w: 64,
        h: 64
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.head.bottom, {
        x: 138,
        y: 153,
        w: 64,
        h: 64
      }, "Vertical", undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.body.right, {
        x: 268,
        y: 233,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.body.front, {
        x: 300,
        y: 233,
        w: 64,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.body.left, {
        x: 364,
        y: 233,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.body.back, {
        x: 396,
        y: 233,
        w: 64,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.body.top, {
        x: 300,
        y: 201,
        w: 64,
        h: 32
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.body.bottom, {
        x: 300,
        y: 329,
        w: 64,
        h: 32
      }, "Vertical", undefined, undefined);
  if (alexModel) {
    Generator.drawTextureLegacy("Skin", alex.base.rightArm.right, {
          x: 107,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.rightArm.front, {
          x: 139,
          y: 405,
          w: 24,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.rightArm.left, {
          x: 163,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.rightArm.back, {
          x: 195,
          y: 405,
          w: 24,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.rightArm.top, {
          x: 139,
          y: 373,
          w: 24,
          h: 32
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.rightArm.bottom, {
          x: 139,
          y: 501,
          w: 24,
          h: 32
        }, "Vertical", undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.leftArm.right, {
          x: 415,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.leftArm.front, {
          x: 447,
          y: 405,
          w: 24,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.leftArm.left, {
          x: 471,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.leftArm.back, {
          x: 391,
          y: 405,
          w: 24,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.leftArm.top, {
          x: 447,
          y: 373,
          w: 24,
          h: 32
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", alex.base.leftArm.bottom, {
          x: 447,
          y: 501,
          w: 24,
          h: 32
        }, "Vertical", undefined, undefined);
  } else {
    Generator.drawTextureLegacy("Skin", steve.base.rightArm.right, {
          x: 99,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.rightArm.front, {
          x: 131,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.rightArm.left, {
          x: 163,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.rightArm.back, {
          x: 195,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.rightArm.top, {
          x: 131,
          y: 373,
          w: 32,
          h: 32
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.rightArm.bottom, {
          x: 131,
          y: 501,
          w: 32,
          h: 32
        }, "Vertical", undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.leftArm.right, {
          x: 415,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.leftArm.front, {
          x: 447,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.leftArm.left, {
          x: 479,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.leftArm.back, {
          x: 383,
          y: 405,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.leftArm.top, {
          x: 447,
          y: 373,
          w: 32,
          h: 32
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.base.leftArm.bottom, {
          x: 447,
          y: 501,
          w: 32,
          h: 32
        }, "Vertical", undefined, undefined);
  }
  Generator.drawTextureLegacy("Skin", steve.base.rightLeg.right, {
        x: 99,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.rightLeg.front, {
        x: 131,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.rightLeg.left, {
        x: 163,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.rightLeg.back, {
        x: 195,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.rightLeg.top, {
        x: 131,
        y: 587,
        w: 32,
        h: 32
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.rightLeg.bottom, {
        x: 131,
        y: 715,
        w: 32,
        h: 32
      }, "Vertical", undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.leftLeg.right, {
        x: 415,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.leftLeg.front, {
        x: 447,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.leftLeg.left, {
        x: 479,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.leftLeg.back, {
        x: 383,
        y: 619,
        w: 32,
        h: 96
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.leftLeg.top, {
        x: 447,
        y: 587,
        w: 32,
        h: 32
      }, undefined, undefined, undefined);
  Generator.drawTextureLegacy("Skin", steve.base.leftLeg.bottom, {
        x: 447,
        y: 715,
        w: 32,
        h: 32
      }, "Vertical", undefined, undefined);
  if (!hideHelmet) {
    Generator.drawTextureLegacy("Skin", steve.overlay.head.right, {
          x: 74,
          y: 89,
          w: 64,
          h: 64
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.head.front, {
          x: 138,
          y: 89,
          w: 64,
          h: 64
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.head.left, {
          x: 202,
          y: 89,
          w: 64,
          h: 64
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.head.back, {
          x: 266,
          y: 89,
          w: 64,
          h: 64
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.head.top, {
          x: 138,
          y: 25,
          w: 64,
          h: 64
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.head.bottom, {
          x: 138,
          y: 153,
          w: 64,
          h: 64
        }, "Vertical", undefined, undefined);
  }
  if (!hideJacket) {
    Generator.drawTextureLegacy("Skin", steve.overlay.body.right, {
          x: 268,
          y: 233,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.body.front, {
          x: 300,
          y: 233,
          w: 64,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.body.left, {
          x: 364,
          y: 233,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.body.back, {
          x: 396,
          y: 233,
          w: 64,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.body.top, {
          x: 300,
          y: 201,
          w: 64,
          h: 32
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.body.bottom, {
          x: 300,
          y: 329,
          w: 64,
          h: 32
        }, "Vertical", undefined, undefined);
  }
  if (alexModel) {
    if (!hideRightSleeve) {
      Generator.drawTextureLegacy("Skin", alex.overlay.rightArm.right, {
            x: 107,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.rightArm.front, {
            x: 139,
            y: 405,
            w: 24,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.rightArm.left, {
            x: 163,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.rightArm.back, {
            x: 195,
            y: 405,
            w: 24,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.rightArm.top, {
            x: 139,
            y: 373,
            w: 24,
            h: 32
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.rightArm.bottom, {
            x: 139,
            y: 501,
            w: 24,
            h: 32
          }, undefined, undefined, undefined);
    }
    if (!hideLeftSleeve) {
      Generator.drawTextureLegacy("Skin", alex.overlay.leftArm.right, {
            x: 415,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.leftArm.front, {
            x: 447,
            y: 405,
            w: 24,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.leftArm.left, {
            x: 471,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.leftArm.back, {
            x: 391,
            y: 405,
            w: 24,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.leftArm.top, {
            x: 447,
            y: 373,
            w: 24,
            h: 32
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", alex.overlay.leftArm.bottom, {
            x: 447,
            y: 501,
            w: 24,
            h: 32
          }, undefined, undefined, undefined);
    }
    
  } else {
    if (!hideRightSleeve) {
      Generator.drawTextureLegacy("Skin", steve.overlay.rightArm.right, {
            x: 99,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.rightArm.front, {
            x: 131,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.rightArm.left, {
            x: 163,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.rightArm.back, {
            x: 195,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.rightArm.top, {
            x: 131,
            y: 373,
            w: 32,
            h: 32
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.rightArm.bottom, {
            x: 131,
            y: 501,
            w: 32,
            h: 32
          }, "Vertical", undefined, undefined);
    }
    if (!hideLeftSleeve) {
      Generator.drawTextureLegacy("Skin", steve.overlay.leftArm.right, {
            x: 415,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.leftArm.front, {
            x: 447,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.leftArm.left, {
            x: 479,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.leftArm.back, {
            x: 383,
            y: 405,
            w: 32,
            h: 96
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.leftArm.top, {
            x: 447,
            y: 373,
            w: 32,
            h: 32
          }, undefined, undefined, undefined);
      Generator.drawTextureLegacy("Skin", steve.overlay.leftArm.bottom, {
            x: 447,
            y: 501,
            w: 32,
            h: 32
          }, "Vertical", undefined, undefined);
    }
    
  }
  if (!hideRightPant) {
    Generator.drawTextureLegacy("Skin", steve.overlay.rightLeg.right, {
          x: 99,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.rightLeg.front, {
          x: 131,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.rightLeg.left, {
          x: 163,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.rightLeg.back, {
          x: 195,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.rightLeg.top, {
          x: 131,
          y: 587,
          w: 32,
          h: 32
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.rightLeg.bottom, {
          x: 131,
          y: 715,
          w: 32,
          h: 32
        }, "Vertical", undefined, undefined);
  }
  if (!hideLeftPant) {
    Generator.drawTextureLegacy("Skin", steve.overlay.leftLeg.right, {
          x: 415,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.leftLeg.front, {
          x: 447,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.leftLeg.left, {
          x: 479,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.leftLeg.back, {
          x: 383,
          y: 619,
          w: 32,
          h: 96
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.leftLeg.top, {
          x: 447,
          y: 587,
          w: 32,
          h: 32
        }, undefined, undefined, undefined);
    Generator.drawTextureLegacy("Skin", steve.overlay.leftLeg.bottom, {
          x: 447,
          y: 715,
          w: 32,
          h: 32
        }, "Vertical", undefined, undefined);
  }
  if (showFolds) {
    if (alexModel) {
      Generator.drawImage("Folds-Alex", [
            0,
            0
          ]);
    } else {
      Generator.drawImage("Folds-Steve", [
            0,
            0
          ]);
    }
  }
  if (showLabels) {
    return Generator.drawImage("Labels", [
                0,
                0
              ]);
  }
  
}

var generator_thumbnail = thumbnail;

var generator_instructions = Caml_option.some(instructions);

var generator = {
  id: id,
  name: name,
  thumbnail: generator_thumbnail,
  video: undefined,
  instructions: generator_instructions,
  images: images,
  textures: textures,
  script: script
};

exports.requireImage = requireImage;
exports.requireTexture = requireTexture;
exports.id = id;
exports.name = name;
exports.thumbnail = thumbnail;
exports.instructions = instructions;
exports.imageIds = imageIds;
exports.toImageDef = toImageDef;
exports.images = images;
exports.textures = textures;
exports.steve = steve;
exports.alex = alex;
exports.script = script;
exports.generator = generator;
/* thumbnail Not a pure module */