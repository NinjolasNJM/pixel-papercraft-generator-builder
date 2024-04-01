let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-llama"

let name = "Minecraft Llama"

let history = [
"Originally developed by minecraftpapercrafttemplates"
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/v2-thumbnail-256.jpeg"),
}

let instructions = {
  let llamaTexture = requireTexture("llama")
  `
# How to use the llama generator

To use the llama generator, simply upload a llama texture into the blue box. note that that llama texture MUST be 1000 x 500 pixels in size.

# How do I make a llama texture in the required size of 1000 x 500 pixels?

You just simply use the Minecraft wiki for the llama textures or edit this llama texture: ![Llama Texture](${LlamaTexture}) in Canva or MS paint.

 `
let imageIds = [
  "Background",
  "Labels",  
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef) 

let textures: array<Generator.textureDef> = [
  {
    id: "Creamy Llama",
    url: requireTexture("creamy-llama"),
    standardWidth: 1000,
    standardHeight: 500,
  },
  {
    id: "White Llama",
    url: requireTexture("white-llama"),
    standardWidth: 1000,
    standardHeight: 500,
  },
  {
    id: "Brown Llama",
    url: requireTexture("brown-llama"),
    standardWidth: 1000,
    standardHeight: 500,
  },
  { 
    id: "Gray Llama",
    url: requireTexture("gray-llama"),
    standardWidth: 1000,
    standardHeight: 500,
  },
]

let script = () => {
  // Define user inputs
  Generator.defineTextureInput("Skin", {standardWidth: 1000, standardHeight: 500, choices: [Brown Llama, Gray Llama, White Llama, Creamy Llama]})

  // Background
  Generator.drawImage("Background", (0, 0))

// add dimensions
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
