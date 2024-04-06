let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-snow-golem"

let name = "Minecraft Snow Golem"

let history = [
  "Originally developed by minecraftpapercrafttemplates"
]

let thumbnail: Generator.thumbnailDef = {
  url: Generator.requireImage("./thumbnail/v2-thumbnail-256.jpeg"),

let instructions = { 
  let snow_golemTexture = requireTexture("snow_golem")
  `
# How to use the Snow Golem generator

Get the snow golem texture you want and scale it to 640 x 740 pixels. 
Or, alternatively, download this texture: ![Snow_Golem Texture](${snow_golemTexture})
and edit it in MS Paint or any graphics software. 
  `

let imageIds = [
  "Background",
  "Folds",
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Snow Golem",
    url: requireTexture("snow_golem"),
    standardWidth: 640,
    standardHeight: 640,
  },
]

let script = () => {
  // Define user inputs
  Generator.defineTextureInput("Skin", {standardWidth: 640, standardHeight: 640,choices: []})

  // Define user variables
  Generator.defineBooleanInput("Show Folds", true)
  
  // Get user variables
  let showFolds = Generator.getBooleanInputValue("Show Folds")
  
  // Background
  Generator.drawImage("Background", (0, 0))

 // Folds
  if showFolds {
    Generator.drawImage("Folds", (0, 0))
  }

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  history: history,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: Some(<Generator.Markdown> {instructions} </Generator.Markdown>),
  images: images,
  textures: textures,
  script: script,
}