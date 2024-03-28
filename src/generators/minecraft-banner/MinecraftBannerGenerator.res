let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = banner-generator

let name = Banner Generator

let history = [
Originally developed by minecraftpapercrafttemplates
]

let video: Generator.videoDef = {url: "???"}

let instructions = `

# Welcome to the Banner Generator

In this generator, you may upload an image of a banner and it will convert it into a papercraft template.

`
let imageIds = [
  "Background"
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef

let textures: array<Generator.textureDef> = [
  {
    id: "Banner",
    url: requireTexture("banner"),
    standardWidth: 64,
    standardHeight: 32,
  },
]




