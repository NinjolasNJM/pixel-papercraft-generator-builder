
let id: zombie-generator


let name: Zombie Generator

let history = [
"Originally developed by minecraftpapercrafttemplates"
]

let instructions = {
  let zombieTexture = requireTexture("Zombie")
  '

## How to use the Zombie Generator

Download a zombie texture and put it in the box to turn it into a template.
'
}

let imageIds = [
  "Background"
  "Folds"
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Skin",
    url: requireTexture("zombie"),
    standardWidth: 64,
    standardHeight: 32,
  },
]

let script = () => {
  // Define user inputs
  Generator.defineTextureInput("Skin", {standardWidth: 64, standardHeight: 32, choices: []})

s
  Generator.defineBooleanInput("Show Folds", true)
  

  let showFolds = Generator.getBooleanInputValue("Show Folds")


  Generator.drawImage("Background", (0, 0))

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
