let id = "minecraft-chest"

let name = "Minecraft Chest"

let history = [
  "Originally developed by minecraftpapercrafttemplates."
]

let thumbnail: Generator.thummbnailDef = { 
  url: Generator.requireImage("./thumbnail/thumbnail.256.jpeg"),
}

let instructions = { 
  let chestTexture = requireTexture("Chest")
  `
## Welcome to the Chest generator!
  
### Upload a texture of your own chest or select a chest already put for you!
`
  }

let imageIds = [ 
  "Background",
  "Folds",
  "Labels"
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Skin"
    url: requireTexture("Chest")
    standardWidth: 640
    standardHeight: 640
  },
]

let script = () => {

  Generator.defineTextureInput("Skin",{standardWidth: 640, standardHeight: 640, choices: []})


  Generator.defineTextureInput("Show Folds", true)
  Generator.defineTextureInput("Show Labels", true)


  let showFolds = Generator.getBooleanInputValue("Show Folds")
  let showLabels = Generator.getBooleanInputValue("Show Labels")


  Generator.drawImage("Background", (0, 0))

  // Right
    Generator.drawTextureLegacy(
    "Chest",
    {x: 281, y: 140, w: 139, h: 49},
    {x: 0 + ox, y: 64 + oy, w: 64, h: 64},
    (),
  ) 
  
  // Back
    Generator.drawTextureLegacy(
    "Chest",
    {x: 140, y: 140, w: 139, h: 49},
    {x: 0 + ox, y: 64 + oy, w: 64, h: 64},
    (),
  ) 
