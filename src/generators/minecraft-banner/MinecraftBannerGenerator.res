let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = banner-generator

let name = Banner Generator

let history = [
  "Originally developed by minecraftpapercrafttemplates"
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/v2-thumbnail-256.jpeg"),
}

let instructions = {
  let creeperTexture = requireTexture("creeper")
  `
# Welcome to the Banner Generator

In this generator, you may upload an image of a banner and it will convert it into a papercraft template.

`
let imageIds = [
  "Background"
  "Folds"
  "Labels"

]

let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef

let textures: array<Generator.textureDef> = [
  {
    id: "Banner",
    url: requireTexture("banner"),
    standardWidth: 640,
    standardHeight: 640,
  },
]

let script = () => {
  // Define user inputs
  Generator.defineTextureInput("Skin", {standardWidth: 640, standardHeight: 640, choices: []})

  // Define user variables
  Generator.defineBooleanInput("Show Folds", true)
  Generator.defineBooleanInput("Show Labels", true)
  

  // Get user variables
  let showFolds = Generator.getBooleanInputValue("Show Folds")
  let showLabels = Generator.getBooleanInputValue("Show Labels")
  
 
  Generator.drawImage("Background", (0, 0))

  // 
  let ox = 164
  let oy = 110
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 8, w: 8, h: 8},
    {x: 0 + ox, y: 64 + oy, w: 64, h: 64},
    (),
  )

