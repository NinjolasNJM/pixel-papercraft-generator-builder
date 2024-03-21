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

  // Top Half of Chest
    Generator.drawTextureLegacy(
    "Chest",
    {x: ?, y: ?, w: ?, h: ?},
    {x: ? + ox, y: ? + oy, w: ?, h: ?},
    (),
  ) 
  
  // Right
    Generator.drawTextureLegacy(
    "Chest",
    {x: 281, y: 140, w: 139, h: 49},
    {x: 147 + ox, y: 360 + oy, w: 76, h: 27},
    (),
  ) 
  
   // Back
    Generator.drawTextureLegacy(
    "Chest",
    {x: 140, y: 141, w: 139, h: 49},
    {x: 375 + ox, y: 360 + oy, w: 76, h: 27},
    (),
  ) 
  
  // Left
    Generator.drawTextureLegacy(
    "Chest",
    {x: 0, y: 140, w: 139, h: 49},
    {x: 299 + ox, y: 360 + oy, w: 76, h: 27},
    (),
  ) 

  // Front
    Generator.drawTextureLegacy(
    "Chest",
    {x: 421, y: 140, w: 139, h: 49},
    {x: 223 + ox, y: 360 + oy, w: 76, h: 27},
    (),
  ) 

  // Top
    Generator.drawTextureLegacy(
    "Chest",
    {x: 281, y: 0, w: 139, h: 141},
    {x: 223 + ox, y: 283 + oy, w: 77, h: 77},
    (),
  ) 

  // That part similar to the roof of the mouth idk how to say it lol
    Generator.drawTextureLegacy(
    "Chest",
    {x: 140, y: 0, w: 139, h: 141},
    {x: 224 + ox, y: 387 + oy, w: 77, h: 77},
    (),
  ) // Bottom Half of Chest
