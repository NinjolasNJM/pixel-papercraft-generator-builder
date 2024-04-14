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
## How to use the Shulker generator?
 You can use the generator by uploading a texture from Minecraft and it will convert it into a papercraft template.
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

// Top Half
// Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 160, y: 0, w: 160, h: 160},
    {x: 209 + ox, y: 232 + oy, w: 88, h: 90},
    (),
  )

// Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 321, y: 160, w: 160, h: 120},
    {x: 297 + ox, y: 322 + oy, w: 89, h: 65},
    (),
  )

// Front
  Generator.drawTextureLegacy(
    "Skin",
    {x: 160, y: 160, w: 160, h: 120},
    {x: 209 + ox, y: 322 + oy, w: 88, h: 65},
    (),
  )

// Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 160, w: 160, h: 120},
    {x: 121 + ox, y: 322 + oy, w: 88, h: 65},
    (),
  )
