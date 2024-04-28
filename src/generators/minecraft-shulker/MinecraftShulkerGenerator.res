let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-shulker"

let name = "Minecraft Shulker"

let history = [ 
"Originally developed by minecraftpapercrafttemplates"
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/v2-thumbnail-256.jpeg"),
}

let instructions = {
let shulkerTexture = requireTexture("shulker")
  `
# Welcome to the shulker generator! 

The way the generator works is like any other. You download a texture and then you sumbit it here for a papercraft to enjoy! 
`
}

let imageIds = [
  "Background",
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Skin",
    url: requireTexture("shulker"),
    standardWidth: 640,
    standardHeight: 640,
  },
]

let script = () => {
  // Define user inputs
  Generator.defineTextureInput("Skin", {standardWidth: 640, standardHeight: 640, choices: []})



  // Background
  Generator.drawImage("Background", (0, 0))