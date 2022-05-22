let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-toothpick-bendable"

let name = "Minecraft Toothpick Bendable Character"

let history = [
  "Originally developed by jojesper.",
  "06 Feb 2015 lostminer - Add user variables.",
  "13 Feb 2015 lostminer - Update to use new version of generator.",
  "02 Oct 2020 NinjolasNJM: Updated to use 1.8+ skins, and cleaned up the design",
  "21 May 2022 NinjolasNJM - Converted to ReScript generator",
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/thumbnail-256.jpg"),
}

let video: Generator.videoDef = {url: "https://www.youtube.com/embed/f6y82gAIKf4?rel=0"}

let imageIds = ["Foreground", "Folds", "Labels"]
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

let script = () => {
  // Define user inputs
  Generator.defineTextureInput("Skin", {standardWidth: 64, standardHeight: 64, choices: []})

  // Define user variables
  //Generator.defineBooleanInput("Show Overlay", true)
  Generator.defineBooleanInput("Show Folds", true)
  Generator.defineBooleanInput("Show Labels", true)

  // Get user variable values
  //let showOverlay = Generator.getBooleanInputValue("Show Overlay")
  let showFolds = Generator.getBooleanInputValue("Show Folds")
  let showLabels = Generator.getBooleanInputValue("Show Labels")

  let hideHelmet = Generator.getBooleanInputValue("Hide Helmet")
  let hideJacket = Generator.getBooleanInputValue("Hide Jacket")
  let hideLeftSleeve = Generator.getBooleanInputValue("Hide Left Sleeve")
  let hideRightSleeve = Generator.getBooleanInputValue("Hide Right Sleeve")
  let hideLeftPant = Generator.getBooleanInputValue("Hide Left Pant")
  let hideRightPant = Generator.getBooleanInputValue("Hide Right Pant")

  // Define regions
  Generator.defineRegionInput((41, 16, 256, 192), () => {
    Generator.setBooleanInputValue("Hide Helmet", !hideHelmet)
  })
  Generator.defineRegionInput((340, 40, 194, 202), () => {
    Generator.setBooleanInputValue("Hide Jacket", !hideJacket)
  })
  Generator.defineRegionInput((361, 265, 185, 185), () => {
    Generator.setBooleanInputValue("Hide Left Sleeve", !hideLeftSleeve)
  })
  Generator.defineRegionInput((52, 265, 185, 185), () => {
    Generator.setBooleanInputValue("Hide Right Sleeve", !hideRightSleeve)
  })
  Generator.defineRegionInput((377, 467, 128, 261), () => {
    Generator.setBooleanInputValue("Hide Left Pant", !hideLeftPant)
  })
  Generator.defineRegionInput((93, 467, 128, 261), () => {
    Generator.setBooleanInputValue("Hide Right Pant", !hideRightPant)
  })

  // Head
  let ox = 41
  let oy = 16
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 8, w: 8, h: 8},
    {x: 0 + ox, y: 64 + oy, w: 64, h: 64},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 8, w: 8, h: 8},
    {x: 64 + ox, y: 64 + oy, w: 64, h: 64},
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 8, w: 8, h: 8},
    {x: 128 + ox, y: 64 + oy, w: 64, h: 64},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 8, w: 8, h: 8},
    {x: 192 + ox, y: 64 + oy, w: 64, h: 64},
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 0, w: 8, h: 8},
    {x: 64 + ox, y: 0 + oy, w: 64, h: 64},
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 0, w: 8, h: 8},
    {x: 64 + ox, y: 128 + oy, w: 64, h: 64},
    ~flip=#Vertical,
    (),
  ) // Bottom

  // Upper Body
  let ox = 340
  let oy = 40
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 20, w: 4, h: 8},
    {x: 0 + ox, y: 32 + oy, w: 32, h: 64},
    (),
  ) //upper body
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 20, w: 8, h: 8},
    {x: 32 + ox, y: 32 + oy, w: 64, h: 64},
    (),
  ) //upper body 2
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 20, w: 4, h: 8},
    {x: 96 + ox, y: 32 + oy, w: 32, h: 64},
    (),
  ) //upper body-
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 20, w: 8, h: 6},
    {x: 128 + ox, y: 32 + oy, w: 64, h: 48},
    (),
  ) //upper body 2-
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 24, w: 8, h: 4},
    {x: 32 + ox, y: 96 + oy, w: 64, h: 32},
    (),
  ) //upper body 2--
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 16, w: 8, h: 4},
    {x: 32 + ox, y: 0 + oy, w: 64, h: 32},
    (),
  ) //upper body 3

  // Bottom Body
  let ox = 342
  let oy = 186
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 25, w: 4, h: 7},
    {x: 0 + ox, y: 0 + oy, w: 32, h: 56},
    (),
  ) //Bottom body
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 27, w: 8, h: 5},
    {x: 32 + ox, y: 17 + oy, w: 64, h: 39},
    (),
  ) //Bottom body 2
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 25, w: 4, h: 7},
    {x: 96 + ox, y: 0 + oy, w: 32, h: 56},
    (),
  ) //Bottom body-
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 27, w: 8, h: 5},
    {x: 128 + ox, y: 16 + oy, w: 64, h: 40},
    (),
  ) //Bottom body 3

  // Upper Right Hand
  let ox = 109
  let oy = 265
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 16, w: 16, h: 12},
    {x: 0 + ox, y: 0 + oy, w: 128, h: 96},
    (),
  ) //upper right hand
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 26, w: 4, h: 2},
    {x: 128 + ox, y: 128 + oy, w: 32, h: 32},
    ~rotateLegacy=180.0,
    (),
  ) //upper right hand 2

  // Bottom Right Hand
  let ox = 52
  let oy = 362
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 25, w: 16, h: 7},
    {x: 0 + ox, y: 0 + oy, w: 128, h: 56},
    (),
  ) //bottom right hand
  Generator.drawTextureLegacy(
    "Skin",
    {x: 48, y: 16, w: 4, h: 4},
    {x: 32 + ox, y: 56 + oy, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) //bottom right hand 2

  // Upper Left Hand
  let ox = 361
  let oy = 265
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 48, w: 12, h: 12},
    {x: 32 + ox, y: 0 + oy, w: 96, h: 96},
    (),
  ) //upper left hand
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 52, w: 4, h: 8},
    {x: 0 + ox, y: 32 + oy, w: 32, h: 64},
    (),
  ) //upper left hand 2
  Generator.drawTextureLegacy(
    "Skin",
    {x: 36, y: 58, w: 4, h: 2},
    {x: 32 + ox, y: 128 + oy, w: 32, h: 32},
    ~rotateLegacy=180.0,
    (),
  ) //upper left hand 3

  // Bottom Left Hand
  let ox = 418
  let oy = 362
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 57, w: 12, h: 7},
    {x: 32 + ox, y: 0 + oy, w: 96, h: 56},
    (),
  ) //bottom left hand
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 57, w: 4, h: 7},
    {x: 0 + ox, y: 0 + oy, w: 32, h: 56},
    (),
  ) //bottom left hand 2
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 48, w: 4, h: 4},
    {x: 64 + ox, y: 56 + oy, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) //bottom left hand 3

  // Upper Right Leg
  let ox = 93
  let oy = 467
  Generator.drawTextureLegacy(
    "Skin",
    {x: 12, y: 20, w: 4, h: 4},
    {x: 64 + ox, y: 19 + oy, w: 32, h: 32},
    ~rotateLegacy=180.0,
    (),
  ) //upper right leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 4, y: 16, w: 4, h: 4},
    {x: 32 + ox, y: 19 + oy, w: 32, h: 32},
    (),
  ) //upper right leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 20, w: 16, h: 9},
    {x: 0 + ox, y: 51 + oy, w: 128, h: 72},
    (),
  ) //upper right leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 12, y: 25, w: 4, h: 4},
    {x: 64 + ox, y: 155 + oy, w: 32, h: 32},
    ~rotateLegacy=180.0,
    (),
  ) //upper right leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 30, w: 4, h: 2},
    {x: 0 + ox, y: 35 + oy, w: 32, h: 16},
    (),
  ) //upper left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 30, w: 4, h: 2},
    {x: 64 + ox, y: 35 + oy, w: 32, h: 16},
    ~flip=#Horizontal,
    (),
  ) //upper left leg

  // Lower Right Leg
  let ox = 93
  let oy = 640
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 25, w: 16, h: 7},
    {x: 0 + ox, y: 0 + oy, w: 128, h: 56},
    (),
  ) //lower right leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 16, w: 4, h: 4},
    {x: 32 + ox, y: 56 + oy, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) //lower right leg

  // Upper Left Leg
  let ox = 377
  let oy = 467
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 48, w: 4, h: 4},
    {x: 64 + ox, y: 19 + oy, w: 32, h: 32},
    (),
  ) //upper left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 52, w: 4, h: 4},
    {x: 96 + ox, y: 19 + oy, w: 32, h: 32},
    ~rotateLegacy=180.0,
    (),
  ) //upper left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 52, w: 12, h: 9},
    {x: 32 + ox, y: 51 + oy, w: 96, h: 72},
    (),
  ) //upper left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 52, w: 4, h: 9},
    {x: 0 + ox, y: 51 + oy, w: 32, h: 72},
    (),
  ) //upper left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 57, w: 4, h: 4},
    {x: 96 + ox, y: 155 + oy, w: 32, h: 32},
    ~rotateLegacy=180.0,
    (),
  ) //upper right leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 30, w: 4, h: 2},
    {x: 32 + ox, y: 35 + oy, w: 32, h: 16},
    ~flip=#Horizontal,
    (),
  ) //upper left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 30, w: 4, h: 2},
    {x: 96 + ox, y: 35 + oy, w: 32, h: 16},
    (),
  ) //upper left leg

  // Lower Left Leg
  let ox = 377
  let oy = 640
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 57, w: 12, h: 7},
    {x: 32 + ox, y: 0 + oy, w: 96, h: 56},
    (),
  ) //lower left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 57, w: 4, h: 7},
    {x: 0 + ox, y: 0 + oy, w: 32, h: 56},
    (),
  ) //lower left leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 48, w: 4, h: 4},
    {x: 64 + ox, y: 56 + oy, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) //lower left leg

  //Overlays

  if !hideHelmet {
    // Head
    let ox = 41
    let oy = 16
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 8, w: 8, h: 8},
      {x: 0 + ox, y: 64 + oy, w: 64, h: 64},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 8, w: 8, h: 8},
      {x: 64 + ox, y: 64 + oy, w: 64, h: 64},
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 8, w: 8, h: 8},
      {x: 128 + ox, y: 64 + oy, w: 64, h: 64},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 56, y: 8, w: 8, h: 8},
      {x: 192 + ox, y: 64 + oy, w: 64, h: 64},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 0, w: 8, h: 8},
      {x: 64 + ox, y: 0 + oy, w: 64, h: 64},
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 0, w: 8, h: 8},
      {x: 64 + ox, y: 128 + oy, w: 64, h: 64},
      ~flip=#Vertical,
      (),
    ) // Bottom
  }
  if !hideJacket {
    // Upper Body
    let ox = 340
    let oy = 40
    Generator.drawTextureLegacy(
      "Skin",
      {x: 16, y: 36, w: 4, h: 8},
      {x: 0 + ox, y: 32 + oy, w: 32, h: 64},
      (),
    ) //upper body
    Generator.drawTextureLegacy(
      "Skin",
      {x: 20, y: 36, w: 8, h: 8},
      {x: 32 + ox, y: 32 + oy, w: 64, h: 64},
      (),
    ) //upper body 2
    Generator.drawTextureLegacy(
      "Skin",
      {x: 28, y: 36, w: 4, h: 8},
      {x: 96 + ox, y: 32 + oy, w: 32, h: 64},
      (),
    ) //upper body-
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 36, w: 8, h: 6},
      {x: 128 + ox, y: 32 + oy, w: 64, h: 48},
      (),
    ) //upper body 2-
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 40, w: 8, h: 4},
      {x: 32 + ox, y: 96 + oy, w: 64, h: 32},
      (),
    ) //upper body 2--
    Generator.drawTextureLegacy(
      "Skin",
      {x: 20, y: 32, w: 8, h: 4},
      {x: 32 + ox, y: 0 + oy, w: 64, h: 32},
      (),
    ) //upper body 3

    // Bottom Body
    let ox = 342
    let oy = 186
    Generator.drawTextureLegacy(
      "Skin",
      {x: 16, y: 41, w: 4, h: 7},
      {x: 0 + ox, y: 0 + oy, w: 32, h: 56},
      (),
    ) //Bottom body
    Generator.drawTextureLegacy(
      "Skin",
      {x: 20, y: 43, w: 8, h: 5},
      {x: 32 + ox, y: 17 + oy, w: 64, h: 39},
      (),
    ) //Bottom body 2
    Generator.drawTextureLegacy(
      "Skin",
      {x: 28, y: 41, w: 4, h: 7},
      {x: 96 + ox, y: 0 + oy, w: 32, h: 56},
      (),
    ) //Bottom body-
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 43, w: 8, h: 5},
      {x: 128 + ox, y: 16 + oy, w: 64, h: 40},
      (),
    ) //Bottom body 3
  }
  if !hideRightSleeve {
    // Upper Right Hand
    let ox = 109
    let oy = 265
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 32, w: 16, h: 12},
      {x: 0 + ox, y: 0 + oy, w: 128, h: 96},
      (),
    ) //upper right hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 44, y: 42, w: 4, h: 2},
      {x: 128 + ox, y: 128 + oy, w: 32, h: 32},
      ~rotateLegacy=180.0,
      (),
    ) //upper right hand 2

    // Bottom Right Hand
    let ox = 52
    let oy = 362
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 41, w: 16, h: 7},
      {x: 0 + ox, y: 0 + oy, w: 128, h: 56},
      (),
    ) //bottom right hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 32, w: 4, h: 4},
      {x: 32 + ox, y: 56 + oy, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //bottom right hand 2
  }
  if !hideLeftSleeve {
    // Upper Left Hand
    let ox = 361
    let oy = 265
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 48, w: 12, h: 12},
      {x: 32 + ox, y: 0 + oy, w: 96, h: 96},
      (),
    ) //upper left hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 60, y: 52, w: 4, h: 8},
      {x: 0 + ox, y: 32 + oy, w: 32, h: 64},
      (),
    ) //upper left hand 2
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 58, w: 4, h: 2},
      {x: 32 + ox, y: 128 + oy, w: 32, h: 32},
      ~rotateLegacy=180.0,
      (),
    ) //upper left hand 3

    // Bottom Left Hand
    let ox = 418
    let oy = 362
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 57, w: 12, h: 7},
      {x: 32 + ox, y: 0 + oy, w: 96, h: 56},
      (),
    ) //bottom left hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 60, y: 57, w: 4, h: 7},
      {x: 0 + ox, y: 0 + oy, w: 32, h: 56},
      (),
    ) //bottom left hand 2
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 48, w: 4, h: 4},
      {x: 64 + ox, y: 56 + oy, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //bottom left hand 3
  }
  if !hideRightPant {
    // Upper Right Leg
    let ox = 93
    let oy = 467
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 36, w: 4, h: 4},
      {x: 64 + ox, y: 19 + oy, w: 32, h: 32},
      ~rotateLegacy=180.0,
      (),
    ) //upper right leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 32, w: 4, h: 4},
      {x: 32 + ox, y: 19 + oy, w: 32, h: 32},
      (),
    ) //upper right leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 36, w: 16, h: 9},
      {x: 0 + ox, y: 51 + oy, w: 128, h: 72},
      (),
    ) //upper right leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 41, w: 4, h: 4},
      {x: 64 + ox, y: 155 + oy, w: 32, h: 32},
      ~rotateLegacy=180.0,
      (),
    ) //upper right leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 16, y: 46, w: 4, h: 2},
      {x: 0 + ox, y: 35 + oy, w: 32, h: 16},
      (),
    ) //upper left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 16, y: 46, w: 4, h: 2},
      {x: 64 + ox, y: 35 + oy, w: 32, h: 16},
      ~flip=#Horizontal,
      (),
    ) //upper left leg

    // Lower Right Leg
    let ox = 93
    let oy = 640
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 41, w: 16, h: 7},
      {x: 0 + ox, y: 0 + oy, w: 128, h: 56},
      (),
    ) //lower right leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 32, w: 4, h: 4},
      {x: 32 + ox, y: 56 + oy, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //lower right leg
  }
  if !hideLeftPant {
    // Upper Left Leg
    let ox = 377
    let oy = 467
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 48, w: 4, h: 4},
      {x: 64 + ox, y: 19 + oy, w: 32, h: 32},
      (),
    ) //upper left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 52, w: 4, h: 4},
      {x: 96 + ox, y: 19 + oy, w: 32, h: 32},
      ~rotateLegacy=180.0,
      (),
    ) //upper left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 52, w: 12, h: 9},
      {x: 32 + ox, y: 51 + oy, w: 96, h: 72},
      (),
    ) //upper left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 52, w: 4, h: 9},
      {x: 0 + ox, y: 51 + oy, w: 32, h: 72},
      (),
    ) //upper left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 57, w: 4, h: 4},
      {x: 96 + ox, y: 155 + oy, w: 32, h: 32},
      ~rotateLegacy=180.0,
      (),
    ) //upper right leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 28, y: 46, w: 4, h: 2},
      {x: 32 + ox, y: 35 + oy, w: 32, h: 16},
      ~flip=#Horizontal,
      (),
    ) //upper left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 28, y: 46, w: 4, h: 2},
      {x: 96 + ox, y: 35 + oy, w: 32, h: 16},
      (),
    ) //upper left leg

    // Lower Left Leg
    let ox = 377
    let oy = 640
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 57, w: 12, h: 7},
      {x: 32 + ox, y: 0 + oy, w: 96, h: 56},
      (),
    ) //lower left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 57, w: 4, h: 7},
      {x: 0 + ox, y: 0 + oy, w: 32, h: 56},
      (),
    ) //lower left leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 48, w: 4, h: 4},
      {x: 64 + ox, y: 56 + oy, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //lower left leg
  }

  // Foreground
  Generator.drawImage("Foreground", (0, 0))

  // Fold Lines
  if showFolds {
    Generator.drawImage("Folds", (0, 0))
  }

  // Labels
  if showLabels {
    Generator.drawImage("Labels", (0, 0))
  }
}

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  history: history,
  thumbnail: Some(thumbnail),
  video: Some(video),
  instructions: None,
  images: images,
  textures: textures,
  script: script,
}
