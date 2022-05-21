let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-action-figure"

let name = "Minecraft Action Figure"

let history = [
  "Minecraft Action Figure Character Generator",
  "Originally developed by frownieman",
  "13 Jul 2016 frownieman - posted to the enjin forum",
  "21 May 2022 NinjolasNJM - Converted to ReScript generator.",
  "Credit to Gootube2000 for the normal Character Generator",
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/thumbnail-614.jpg"),
}

let imageIds = ["Background", "Folds", "Labels", "Connectors"]
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
  //Generator.defineSelectInput("Skin Model Type", ["Steve", "Alex"])
  Generator.defineTextureInput("Skin", {standardWidth: 64, standardHeight: 64, choices: []})

  // Define user variables
  //Generator.defineBooleanInput("Hand Notches", false)
  //Generator.defineBooleanInput("Show Overlay", true)
  Generator.defineBooleanInput("Show Folds", true)
  Generator.defineBooleanInput("Show Labels", true)

  // Get user variable values
  //let alexModel = Generator.getSelectInputValue("Skin Model Type") === "Alex"

  //let handNotches = Generator.getBooleanInputValue("Hand Notches")

  let showFolds = Generator.getBooleanInputValue("Show Folds")
  let showLabels = Generator.getBooleanInputValue("Show Labels")
  //let showOverlay = Generator.getBooleanInputValue("Show Overlay")

  let hideHelmet = Generator.getBooleanInputValue("Hide Helmet")
  let hideJacket = Generator.getBooleanInputValue("Hide Jacket")
  let hideLeftSleeve = Generator.getBooleanInputValue("Hide Left Sleeve")
  let hideRightSleeve = Generator.getBooleanInputValue("Hide Right Sleeve")
  let hideLeftPant = Generator.getBooleanInputValue("Hide Left Pant")
  let hideRightPant = Generator.getBooleanInputValue("Hide Right Pant")

  // Define regions
  Generator.defineRegionInput((73, 25, 256, 192), () => {
    Generator.setBooleanInputValue("Hide Helmet", !hideHelmet)
  })
  Generator.defineRegionInput((267, 201, 192, 144), () => {
    Generator.setBooleanInputValue("Hide Jacket", !hideJacket)
  })
  Generator.defineRegionInput((382, 373, 128, 160), () => {
    Generator.setBooleanInputValue("Hide Left Sleeve", !hideLeftSleeve)
  })
  Generator.defineRegionInput((98, 373, 128, 160), () => {
    Generator.setBooleanInputValue("Hide Right Sleeve", !hideRightSleeve)
  })
  Generator.defineRegionInput((382, 587, 128, 208), () => {
    Generator.setBooleanInputValue("Hide Left Pant", !hideLeftPant)
  })
  Generator.defineRegionInput((98, 587, 128, 208), () => {
    Generator.setBooleanInputValue("Hide Right Pant", !hideRightPant)
  })

  // Background
  Generator.drawImage("Background", (0, 0))

  // Head
  let ox = 73
  let oy = 25
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 8, w: 8, h: 8},
    {x: ox, y: oy + 64, w: 64, h: 64},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 8, w: 8, h: 8},
    {x: ox + 64, y: oy + 64, w: 64, h: 64},
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 8, w: 8, h: 8},
    {x: ox + 128, y: oy + 64, w: 64, h: 64},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 8, w: 8, h: 8},
    {x: ox + 192, y: oy + 64, w: 64, h: 64},
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 0, w: 8, h: 8},
    {x: ox + 64, y: oy, w: 64, h: 64},
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 0, w: 8, h: 8},
    {x: ox + 64, y: oy + 128, w: 64, h: 64},
    ~flip=#Vertical,
    (),
  ) // Bottom

  // Torso
  let ox = 267
  let oy = 201
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 20, w: 4, h: 12},
    {x: ox, y: oy + 32, w: 32, h: 96},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 20, w: 8, h: 12},
    {x: ox + 32, y: oy + 32, w: 64, h: 96},
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 20, w: 4, h: 12},
    {x: ox + 96, y: oy + 32, w: 32, h: 96},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 20, w: 8, h: 12},
    {x: ox + 128, y: oy + 32, w: 64, h: 96},
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 16, w: 8, h: 4},
    {x: ox + 32, y: oy, w: 64, h: 32},
    (),
  ) // Top

  // Torso To Leg Connectors
  let ox = 267
  let oy = 329
  Generator.drawTextureLegacy("Skin", {x: 0, y: 20, w: 4, h: 3}, {x: ox, y: oy, w: 32, h: 24}, ()) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 52, w: 4, h: 3},
    {x: ox + 96, y: oy, w: 32, h: 24},
    (),
  ) // Left

  // Torso Connectors
  let ox = 273
  let oy = 358
  Generator.drawTextureLegacy(
    "Skin",
    {x: 1, y: 21, w: 2, h: 2},
    {x: ox + 1, y: oy, w: 16, h: 16},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 25, y: 53, w: 2, h: 2},
    {x: ox + 98, y: oy, w: 16, h: 16},
    (),
  ) // Left

  // Right Arm
  let ox = 98
  let oy = 373
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 21, w: 4, h: 12},
    {x: ox, y: oy + 40, w: 32, h: 96},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 20, w: 4, h: 12},
    {x: ox + 32, y: oy + 32, w: 32, h: 96},
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 48, y: 20, w: 4, h: 12},
    {x: ox + 64, y: oy + 32, w: 32, h: 96},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 52, y: 20, w: 4, h: 12},
    {x: ox + 96, y: oy + 32, w: 32, h: 96},
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 16, w: 4, h: 4},
    {x: ox + 64, y: oy + 32, w: 32, h: 32},
    ~rotateLegacy=-90.0,
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 52, w: 4, h: 1},
    {x: ox + 64, y: oy - 5, w: 32, h: 5},
    ~flip=#Vertical,
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 48, y: 16, w: 4, h: 4},
    {x: ox + 32, y: oy + 128, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Bottom

  // Right Shoulder
  let ox = 136
  let oy = 303
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 20, w: 4, h: 4},
    {x: ox - 32, y: oy, w: 32, h: 32},
    (),
  ) // Right
  Generator.drawTextureLegacy("Skin", {x: 48, y: 20, w: 4, h: 4}, {x: ox, y: oy, w: 32, h: 32}, ()) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 52, y: 20, w: 4, h: 4},
    {x: ox + 32, y: oy, w: 32, h: 32},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 20, w: 4, h: 4},
    {x: ox - 32, y: oy - 32, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Right Inner
  Generator.drawTextureLegacy(
    "Skin",
    {x: 48, y: 20, w: 4, h: 4},
    {x: ox, y: oy - 32, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Left Inner
  Generator.drawTextureLegacy(
    "Skin",
    {x: 52, y: 20, w: 4, h: 4},
    {x: ox + 32, y: oy - 32, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Back Inner

  // Right Shoulder Conectors
  let ox = 113
  let oy = 245
  Generator.drawTextureLegacy("Skin", {x: 45, y: 21, w: 2, h: 2}, {x: ox, y: oy, w: 16, h: 16}, ()) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 53, y: 21, w: 2, h: 2},
    {x: ox + 61, y: oy, w: 16, h: 16},
    (),
  ) // Left

  // Left Arm
  let ox = 414
  let oy = 373
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 52, w: 4, h: 12},
    {x: ox, y: oy + 32, w: 32, h: 96},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 36, y: 52, w: 4, h: 12},
    {x: ox + 32, y: oy + 32, w: 32, h: 96},
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 53, w: 4, h: 11},
    {x: ox + 64, y: oy + 40, w: 32, h: 88},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 52, w: 4, h: 12},
    {x: ox - 32, y: oy + 32, w: 32, h: 96},
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 36, y: 48, w: 4, h: 4},
    {x: ox + 32, y: oy, w: 32, h: 32},
    ~rotateLegacy=90.0,
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 20, w: 4, h: 1},
    {x: ox, y: oy - 5, w: 32, h: 5},
    ~flip=#Vertical,
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 40, y: 48, w: 4, h: 4},
    {x: ox + 32, y: oy + 128, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Bottom

  // Left Shoulder
  let ox = 511
  let oy = 341
  Generator.drawTextureLegacy(
    "Skin",
    {x: 36, y: 52, w: 4, h: 4},
    {x: ox + 32, y: oy, w: 32, h: 32},
    (),
  ) // Right
  Generator.drawTextureLegacy("Skin", {x: 32, y: 52, w: 4, h: 4}, {x: ox, y: oy, w: 32, h: 32}, ()) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 52, w: 4, h: 4},
    {x: ox - 32, y: oy, w: 32, h: 32},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 36, y: 52, w: 4, h: 4},
    {x: ox + 32, y: oy - 32, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Right Inner
  Generator.drawTextureLegacy(
    "Skin",
    {x: 32, y: 52, w: 4, h: 4},
    {x: ox, y: oy - 32, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Left Inner
  Generator.drawTextureLegacy(
    "Skin",
    {x: 44, y: 52, w: 4, h: 4},
    {x: ox - 32, y: oy - 32, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Back Inner

  // Left Shoulder Conectors
  let ox = 485
  let oy = 380
  Generator.drawTextureLegacy(
    "Skin",
    {x: 37, y: 53, w: 2, h: 2},
    {x: ox + 67, y: oy, w: 16, h: 16},
    (),
  ) // Right
  Generator.drawTextureLegacy("Skin", {x: 45, y: 53, w: 2, h: 2}, {x: ox, y: oy, w: 16, h: 16}, ()) // Left

  // Right Leg
  let ox = 98
  let oy = 587
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 20, w: 4, h: 12},
    {x: ox, y: oy + 32, w: 32, h: 96},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 4, y: 20, w: 4, h: 12},
    {x: ox + 32, y: oy + 32, w: 32, h: 96},
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 20, w: 4, h: 12},
    {x: ox + 64, y: oy + 32, w: 32, h: 96},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 12, y: 20, w: 4, h: 12},
    {x: ox + 96, y: oy + 32, w: 32, h: 96},
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 4, y: 16, w: 4, h: 4},
    {x: ox + 32, y: oy, w: 32, h: 32},
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 52, w: 4, h: 1},
    {x: ox + 32, y: oy - 8, w: 32, h: 8},
    ~flip=#Horizontal,
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 16, w: 4, h: 4},
    {x: ox + 32, y: oy + 128, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Bottom

  // Right Leg Curves
  let ox = 98
  let oy = 611
  Generator.drawTextureLegacy("Skin", {x: 0, y: 20, w: 4, h: 1}, {x: ox, y: oy, w: 32, h: 8}, ()) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 20, w: 4, h: 1},
    {x: ox + 64, y: oy, w: 32, h: 8},
    (),
  ) // Left

  // Left Leg
  let ox = 414
  let oy = 587
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 52, w: 4, h: 12},
    {x: ox, y: oy + 32, w: 32, h: 96},
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 52, w: 4, h: 12},
    {x: ox + 32, y: oy + 32, w: 32, h: 96},
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 52, w: 4, h: 12},
    {x: ox + 64, y: oy + 32, w: 32, h: 96},
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 52, w: 4, h: 12},
    {x: ox - 32, y: oy + 32, w: 32, h: 96},
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 48, w: 4, h: 4},
    {x: ox + 32, y: oy, w: 32, h: 32},
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 12, y: 20, w: 4, h: 1},
    {x: ox + 32, y: oy - 8, w: 32, h: 8},
    ~flip=#Horizontal,
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 48, w: 4, h: 4},
    {x: ox + 32, y: oy + 128, w: 32, h: 32},
    ~flip=#Vertical,
    (),
  ) // Bottom

  // Left Leg Curves
  let ox = 414
  let oy = 611
  Generator.drawTextureLegacy("Skin", {x: 16, y: 52, w: 4, h: 1}, {x: ox, y: oy, w: 32, h: 8}, ()) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 52, w: 4, h: 1},
    {x: ox + 64, y: oy, w: 32, h: 8},
    (),
  ) // Left

  if !hideHelmet {
    // Head2
    let ox = 73
    let oy = 25
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 8, w: 8, h: 8},
      {x: ox, y: oy + 64, w: 64, h: 64},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 8, w: 8, h: 8},
      {x: ox + 64, y: oy + 64, w: 64, h: 64},
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 8, w: 8, h: 8},
      {x: ox + 128, y: oy + 64, w: 64, h: 64},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 56, y: 8, w: 8, h: 8},
      {x: ox + 192, y: oy + 64, w: 64, h: 64},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 0, w: 8, h: 8},
      {x: ox + 64, y: oy, w: 64, h: 64},
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 0, w: 8, h: 8},
      {x: ox + 64, y: oy + 128, w: 64, h: 64},
      ~flip=#Vertical,
      (),
    ) // Bottom
  }
  if !hideJacket {
    // Torso2
    let ox = 267
    let oy = 201
    Generator.drawTextureLegacy(
      "Skin",
      {x: 16, y: 36, w: 4, h: 12},
      {x: ox, y: oy + 32, w: 32, h: 96},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 20, y: 36, w: 8, h: 12},
      {x: ox + 32, y: oy + 32, w: 64, h: 96},
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 28, y: 36, w: 4, h: 12},
      {x: ox + 96, y: oy + 32, w: 32, h: 96},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 36, w: 8, h: 12},
      {x: ox + 128, y: oy + 32, w: 64, h: 96},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 20, y: 32, w: 8, h: 4},
      {x: ox + 32, y: oy, w: 64, h: 32},
      (),
    ) // Top

    // Torso To Leg Connectors2
    let ox = 267
    let oy = 329
    Generator.drawTextureLegacy("Skin", {x: 0, y: 36, w: 4, h: 3}, {x: ox, y: oy, w: 32, h: 24}, ()) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 52, w: 4, h: 3},
      {x: ox + 96, y: oy, w: 32, h: 24},
      (),
    ) // Left

    // Torso Connectors2
    let ox = 273
    let oy = 358
    Generator.drawTextureLegacy(
      "Skin",
      {x: 1, y: 36, w: 2, h: 2},
      {x: ox + 1, y: oy, w: 16, h: 16},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 9, y: 53, w: 2, h: 2},
      {x: ox + 98, y: oy, w: 16, h: 16},
      (),
    ) // Left
  }
  if !hideRightSleeve {
    // Right Arm2
    let ox = 98
    let oy = 373
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 37, w: 4, h: 11},
      {x: ox, y: oy + 40, w: 32, h: 88},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 44, y: 36, w: 4, h: 12},
      {x: ox + 32, y: oy + 32, w: 32, h: 96},
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 36, w: 4, h: 12},
      {x: ox + 64, y: oy + 32, w: 32, h: 96},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 36, w: 4, h: 12},
      {x: ox + 96, y: oy + 32, w: 32, h: 96},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 44, y: 32, w: 4, h: 4},
      {x: ox + 96, y: oy, w: 32, h: 32},
      ~rotateLegacy=90.0,
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 36, w: 4, h: 1},
      {x: ox + 64, y: oy - 5, w: 32, h: 5},
      ~flip=#Vertical,
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 32, w: 4, h: 4},
      {x: ox + 32, y: oy + 128, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Bottom

    // Right Shoulder2
    let ox = 136
    let oy = 303
    Generator.drawTextureLegacy(
      "Skin",
      {x: 44, y: 36, w: 4, h: 4},
      {x: ox - 32, y: oy, w: 32, h: 32},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 36, w: 4, h: 4},
      {x: ox, y: oy, w: 32, h: 32},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 36, w: 4, h: 4},
      {x: ox + 32, y: oy, w: 32, h: 32},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 44, y: 36, w: 4, h: 4},
      {x: ox - 32, y: oy - 32, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Right Inner
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 36, w: 4, h: 4},
      {x: ox, y: oy - 32, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Left Inner
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 36, w: 4, h: 4},
      {x: ox + 32, y: oy - 32, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Back Inner

    // Right Shoulder Conectors2
    let ox = 113
    let oy = 245
    Generator.drawTextureLegacy(
      "Skin",
      {x: 45, y: 37, w: 2, h: 2},
      {x: ox, y: oy, w: 16, h: 16},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 53, y: 37, w: 2, h: 2},
      {x: ox + 61, y: oy, w: 16, h: 16},
      (),
    ) // Left
  }
  if !hideLeftSleeve {
    // Left Arm2
    let ox = 414
    let oy = 373
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 52, w: 4, h: 12},
      {x: ox, y: oy + 32, w: 32, h: 96},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 52, w: 4, h: 12},
      {x: ox + 32, y: oy + 32, w: 32, h: 96},
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 56, y: 53, w: 4, h: 11},
      {x: ox + 64, y: oy + 40, w: 32, h: 88},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 60, y: 52, w: 4, h: 12},
      {x: ox - 32, y: oy + 32, w: 32, h: 96},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 48, w: 4, h: 4},
      {x: ox, y: oy + 32, w: 32, h: 32},
      ~rotateLegacy=270.0,
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 56, y: 52, w: 4, h: 1},
      {x: ox, y: oy - 5, w: 32, h: 5},
      ~flip=#Vertical,
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 56, y: 48, w: 4, h: 4},
      {x: ox + 32, y: oy + 128, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Bottom

    // Left Shoulder
    let ox = 511
    let oy = 341
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 52, w: 4, h: 4},
      {x: ox + 32, y: oy, w: 32, h: 32},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 52, w: 4, h: 4},
      {x: ox, y: oy, w: 32, h: 32},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 60, y: 52, w: 4, h: 4},
      {x: ox - 32, y: oy, w: 32, h: 32},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 52, y: 52, w: 4, h: 4},
      {x: ox + 32, y: oy - 32, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Right Inner
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 52, w: 4, h: 4},
      {x: ox, y: oy - 32, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Left Inner
    Generator.drawTextureLegacy(
      "Skin",
      {x: 60, y: 52, w: 4, h: 4},
      {x: ox - 32, y: oy - 32, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Back Inner

    // Left Shoulder Conectors
    let ox = 485
    let oy = 380
    Generator.drawTextureLegacy(
      "Skin",
      {x: 53, y: 53, w: 2, h: 2},
      {x: ox + 67, y: oy, w: 16, h: 16},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 61, y: 53, w: 2, h: 2},
      {x: ox, y: oy, w: 16, h: 16},
      (),
    ) // Left
  }
  if !hideRightPant {
    // Right Leg2
    let ox = 98
    let oy = 587
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 36, w: 4, h: 12},
      {x: ox, y: oy + 32, w: 32, h: 96},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 36, w: 4, h: 12},
      {x: ox + 32, y: oy + 32, w: 32, h: 96},
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 36, w: 4, h: 12},
      {x: ox + 64, y: oy + 32, w: 32, h: 96},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 36, w: 4, h: 12},
      {x: ox + 96, y: oy + 32, w: 32, h: 96},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 32, w: 4, h: 4},
      {x: ox + 32, y: oy, w: 32, h: 32},
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 36, w: 4, h: 1},
      {x: ox + 32, y: oy - 8, w: 32, h: 8},
      ~flip=#Horizontal,
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 32, w: 4, h: 4},
      {x: ox + 32, y: oy + 128, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Bottom

    // Right Leg Curves
    let ox = 98
    let oy = 611
    Generator.drawTextureLegacy("Skin", {x: 0, y: 36, w: 4, h: 1}, {x: ox, y: oy, w: 32, h: 8}, ()) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 36, w: 4, h: 1},
      {x: ox + 64, y: oy, w: 32, h: 8},
      (),
    ) // Left
  }
  if !hideLeftPant {
    // Left Leg2
    let ox = 414
    let oy = 587
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 52, w: 4, h: 12},
      {x: ox, y: oy + 32, w: 32, h: 96},
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 52, w: 4, h: 12},
      {x: ox + 32, y: oy + 32, w: 32, h: 96},
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 52, w: 4, h: 12},
      {x: ox + 64, y: oy + 32, w: 32, h: 96},
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 52, w: 4, h: 12},
      {x: ox - 32, y: oy + 32, w: 32, h: 96},
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 48, w: 4, h: 4},
      {x: ox + 32, y: oy, w: 32, h: 32},
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 52, w: 4, h: 1},
      {x: ox + 32, y: oy - 8, w: 32, h: 8},
      ~flip=#Horizontal,
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 48, w: 4, h: 4},
      {x: ox + 32, y: oy + 128, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) // Bottom

    // Left Leg Curves2
    let ox = 414
    let oy = 611
    Generator.drawTextureLegacy("Skin", {x: 0, y: 52, w: 4, h: 1}, {x: ox, y: oy, w: 32, h: 8}, ()) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 52, w: 4, h: 1},
      {x: ox + 64, y: oy, w: 32, h: 8},
      (),
    ) // Left
  }

  // Fold Lines
  if showFolds {
    Generator.drawImage("Folds", (0, 0))
  }
  // Draw a special overlay
  Generator.drawImage("Connectors", (0, 0))

  // Labels
  if showLabels {
    Generator.drawImage("Labels", (0, 0))
  }

  //Generator.drawText( "Pixel Papercraft", 350, 9, (), )
  //Generator.drawText( "pixelpapercraft.com", 350, 30, (), )
  //Generator.drawText( "Generator by frownieman", 350, 49, (), )
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
