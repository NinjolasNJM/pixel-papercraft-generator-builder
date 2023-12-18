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
  let alexModel = Generator.getSelectInputValue("Skin Model Type") === "Alex"
  //let showOverlay = Generator.getBooleanInputValue("Show Overlay")
  let showFolds = Generator.getBooleanInputValue("Show Folds")
  //let showLabels = Generator.getBooleanInputValue("Show Labels")

  /* let hideHelmet = Generator.getBooleanInputValue("Hide Helmet")
  let hideJacket = Generator.getBooleanInputValue("Hide Jacket")
  let hideLeftSleeve = Generator.getBooleanInputValue("Hide Left Sleeve")
  let hideRightSleeve = Generator.getBooleanInputValue("Hide Right Sleeve")
  let hideLeftPant = Generator.getBooleanInputValue("Hide Left Pant")
  let hideRightPant = Generator.getBooleanInputValue("Hide Right Pant")

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

  // Page 1
  Generator.usePage("Page 1")
  Generator.drawImage("Guide-1", (0, 0))
  Generator.drawImage("Foreground-1", (0, 0))
  if showFolds {
    Generator.drawImage("Folds-1", (0, 0))
  }

  // Page 2
  Generator.usePage("Page 2")
  Generator.drawImage("Guide-2", (0, 0))
  Generator.drawImage("Foreground-2", (0, 0))
  if showFolds {
    Generator.drawImage("Folds-2", (0, 0))
  }

  // Page 3
  Generator.usePage("Page 3")
  Generator.drawImage("Guide-3", (0, 0))
  Generator.drawImage("Foreground-3", (0, 0))
  if showFolds {
    Generator.drawImage("Folds-3", (0, 0))
  }
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
