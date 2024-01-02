let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-modular-bendable"

let name = "Minecraft Modular Bendable Character"

let history = [
  "Design by Muzz_Ronin.",
  "06 Feb 2015 lostminer - Add user variables.",
  "13 Feb 2015 lostminer - Update to use new version of generator.",
  "22 Nov 2018 NinjolasNJM - Fixed rotations of tops and bottoms and the placement of arm textures, and made compatible with 1.8+ skins.",
  "30 Aug 2020 NinjolasNJM - Fixed a few more things such as the rotation of the bottom of the head and the bottom of the waist using the wrong textures, changed the tubes and tabs to look better on more skins, and updated the code comments.",
  "06 Jun 2021 NinjolasNJM - Converted to ReScript generator, and fixed the lines on the head.",
  "08 Dec 2023 NinjolasNJM - If you're reading this then Ninjolas forgot to change the history. Embarrassing!",
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/thumbnail-256.jpeg"),
}

/* let video: Generator.videoDef = {url: "https://www.youtube.com/embed/CyYn66Zm5n0?rel=0"} */

let imageIds = [
  "Foreground-1",
  "Folds-1",
  "Guide-1",
  "Foreground-2",
  "Folds-2",
  "Guide-2",
  "Foreground-3",
  "Folds-3",
  "Guide-3",
  "Extra",
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Skin",
    url: requireTexture("Skin64x64Steve"),
    standardWidth: 64,
    standardHeight: 64,
  },
]

let steve = Minecraft.Character.steve
let alex = Minecraft.Character.alex

let script = () => {
  // Define user inputs
  Generator.defineTextureInput("Skin", {standardWidth: 64, standardHeight: 64, choices: []})

  // Define user variables
  Generator.defineSelectInput("Skin Model Type", ["Steve", "Alex"])
  //Generator.defineBooleanInput("Show Overlay", true)
  Generator.defineBooleanInput("Show Folds", true)
  //Generator.defineBooleanInput("Show Color Codes", true)
  //Generator.defineBooleanInput("Show Labels", true)

  // Get user variable values
  let isAlexModel = Generator.getSelectInputValue("Skin Model Type") === "Alex"
  //let showOverlay = Generator.getBooleanInputValue("Show Overlay")
  let showFolds = Generator.getBooleanInputValue("Show Folds")
  //let showLabels = Generator.getBooleanInputValue("Show Labels")
  let char = isAlexModel ? alex : steve

  let showHeadOverlay = Generator.getBooleanInputValueWithDefault("Show Head Overlay", true)
  let showBodyOverlay = Generator.getBooleanInputValueWithDefault("Show Body Overlay", true)
  let showLeftArmOverlay = Generator.getBooleanInputValueWithDefault("Show Left Arm Overlay", true)
  let showRightArmOverlay = Generator.getBooleanInputValueWithDefault(
    "Show Right Arm Overlay",
    true,
  )
  let showLeftLegOverlay = Generator.getBooleanInputValueWithDefault("Show Left Leg Overlay", true)
  let showRightLegOverlay = Generator.getBooleanInputValueWithDefault(
    "Show Right Leg Overlay",
    true,
  ) /*

  //Define regions
  Generator.defineRegionInput((10, 534, 192, 256), () => {
    Generator.setBooleanInputValue("Hide Helmet", !hideHelmet)
  })
  Generator.defineRegionInput((35, 50, 192, 328), () => {
    Generator.setBooleanInputValue("Hide Jacket", !hideJacket)
  })
  Generator.defineRegionInput((265, 50, 128, 320), () => {
    Generator.setBooleanInputValue("Hide Left Sleeve", !hideLeftSleeve)
  })
  Generator.defineRegionInput((425, 426, 128, 320), () => {
    Generator.setBooleanInputValue("Hide Right Sleeve", !hideRightSleeve)
  })
  Generator.defineRegionInput((425, 10, 128, 360), () => {
    Generator.setBooleanInputValue("Hide Left Pant", !hideLeftPant)
  })
  Generator.defineRegionInput((265, 386, 128, 360), () => {
    Generator.setBooleanInputValue("Hide Right Pant", !hideRightPant)
  }) */

  let drawHead = ((ox, oy): Generator_Builder.position) => {
    let scale = (64, 64, 64)
    Minecraft.drawCuboid("Skin", char.base.head, (ox, oy), scale, ~orientation=#South, ())
    if showHeadOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.head, (ox, oy), scale, ())
    }
  }

  let drawBody = ((ox, oy): Generator_Builder.position) => {
    let scale = (64, 96, 32)
    Minecraft.drawCuboid("Skin", char.base.body, (ox, oy), scale, ())
    if showBodyOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.body, (ox, oy), scale, ())
    }
  }

  let drawBody2 = ((ox, oy): Generator_Builder.position) => {
    let scale = (64, 96, 32)
    Minecraft.drawCuboid("Skin", char.base.body, (ox, oy), scale, ~center=#Bottom, ())
    if showBodyOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.body, (ox, oy), scale, ())
    }
  }

  let drawRightArm = ((ox, oy): Generator_Builder.position) => {
    let scale = char == alex ? (24, 96, 32) : (32, 96, 32)
    Minecraft.drawCuboid("Skin", char.base.rightArm, (ox, oy), scale, ())
    if showRightArmOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.rightArm, (ox, oy), scale, ())
    }
  }
  let drawLeftArm = ((ox, oy): Generator_Builder.position) => {
    let scale = char == alex ? (24, 96, 32) : (32, 96, 32)
    Minecraft.drawCuboid("Skin", char.base.leftArm, (ox, oy), scale, ~orientation=#East, ())
    if showLeftArmOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.leftArm, (ox, oy), scale, ~orientation=#East, ())
    }
  }
  let drawRightLeg = ((ox, oy): Generator_Builder.position) => {
    let scale = (32, 96, 32)
    Minecraft.drawCuboid(
      "Skin",
      char.base.rightLeg,
      (ox, oy),
      scale,
      ~center=#Left,
      ~orientation=#East,
      (),
    )
    if showRightLegOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.rightLeg, (ox, oy), scale, ())
    }
  }
  let drawLeftLeg = ((ox, oy): Generator_Builder.position) => {
    let scale = (32, 96, 32)
    Minecraft.drawCuboid("Skin", char.base.leftLeg, (ox, oy), scale, ~center=#Right, ())
    if showLeftLegOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.leftLeg, (ox, oy), scale, ~orientation=#East, ())
    }
  }

  // draw Pages
  let drawPage1 = {
    Generator.usePage("Page 1")
    Generator.drawImage("Guide-1", (0, 0))
    drawHead((156, 28)) // Head
    drawBody((188, 316)) // Body
    Generator.drawTexture("Skin", (16, 20, 4, 4), (116, 348, 32, 32), ()) // Right Square
    Generator.drawTexture("Skin", (28, 20, 4, 4), (404, 324, 32, 32), ()) // Left Square
    Generator.drawTexture("Skin", (53, 21, 2, 2), (26, 490, 18, 18), ()) // Right Back Circle
    Generator.drawTexture("Skin", (45, 53, 2, 2), (66, 490, 18, 18), ()) // Left Back Circle
    Generator.drawTexture("Skin", (44, 20, 4, 4), (424, 458, 32, 32), ()) // Right Front Circle
    Generator.drawTexture("Skin", (36, 52, 4, 4), (66, 490, 32, 32), ()) // Left Front Circle
    //Generator.drawImage("Foreground-1", (0, 0))
    if showFolds {
      Generator.drawImage("Folds-1", (0, 0))
    }
  }
  let drawPage2 = {
    Generator.usePage("Page 2")
    Generator.drawImage("Guide-2", (0, 0))
    let (ox, oy) = (36, 484)
    drawRightLeg((ox, oy))
    let (ox, oy) = (172, 484)
    drawLeftLeg((ox, oy))
    Generator.drawImage("Foreground-2", (0, 0))
    if showFolds {
      Generator.drawImage("Folds-2", (0, 0))
    }
  }
  let drawPage3 = {
    Generator.usePage("Page 3")
    Generator.drawImage("Guide-3", (0, 0))
    let (ox, oy) = (28, 148)
    drawRightArm((ox, oy))
    //Generator.drawImage("Foreground-3", (0, 0))
    if showFolds {
      Generator.drawImage("Folds-3", (0, 0))
    }
  }

  // Page 1

  drawPage1

  // Page 2

  drawPage2

  // Page 3

  drawPage3

  /* Labels
  if showLabels {
    Generator.drawImage("Labels", (0, 0))
  } */
}

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  history: history,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: None,
  images: images,
  textures: textures,
  script: script,
}

/* How it's done:
 // Draw Page 1
 drawPage1()
 if alex draw Foreground ALex 1 else draw foreground 1,
 draw folds 1
 //drawPage2()
 etc..
 */
