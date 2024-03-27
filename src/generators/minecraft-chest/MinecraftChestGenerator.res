let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-chest"

let name = "Minecraft Chest"

let history = [
  "Originally developed by minecraftpapercrafttemplates."
]

let thumbnail: Generator.thummbnailDef = { 
  url: Generator.requireImage("./thumbnail/thumbnail-256.jpeg"),
}

let instructions = { 
  let chestTexture = requireTexture("Chest")
  `
## Welcome to the Chest generator!
  ### This is still in Beta Development
### Upload a texture of your own chest or select a chest already put for you!
### Unfortunately, I couldn't make the folds transparent so I will let someone else do the job. :(

`
  }

let imageIds = [ 
  "Background",
]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Chest"
    url: requireTexture("Chest")
    standardWidth: 640
    standardHeight: 640
  },
]

let script = () => {

  Generator.defineTextureInput("Chest",{standardWidth: 640, standardHeight: 640, choices: []})


  Generator.drawImage("Background", (0, 0))
  
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
     ~flip=#Vertical,
    (),
  ) 

// The Floor of the Mouth i was talking about 
    Generator.drawTextureLegacy(
    "Chest",
    {x: 283, y: 190, w: 139, h: 141},
    {x: 224 + ox, y: 464 + oy, w: 77, h: 79},
     ~flip=#Vertical,
    (),
  )    

// Bottom right 
    Generator.drawTextureLegacy(
    "Chest",
    {x: 280, y: 330, w: 139, h: 100},
    {x: 147 + ox, y: 542 + oy, w: 77, h: 55},
     ~flip=#Vertical,
    (),
  ) 

// Bottom Front 
    Generator.drawTextureLegacy(
    "Chest",
    {x: 421, y: 330, w: 139, h: 100},
    {x: 224 + ox, y: 542 + oy, w: 78, h: 55},
     ~flip=#Vertical,
    (),
  ) 

// Bottom Left 
    Generator.drawTextureLegacy(
    "Chest",
    {x: 0, y: 330, w: 139, h: 100},
    {x: 300 + ox, y: 542 + oy, w: 77, h: 55},
     ~flip=#Vertical,
    (),
  ) 

// Bottom Back
    Generator.drawTextureLegacy(
    "Chest",
    {x: 142, y: 330, w: 139, h: 100},
    {x: 377 + ox, y: 542 + oy, w: 77, h: 55},
     ~flip=#Vertical,
    (),
  ) 

// Bottom
    Generator.drawTextureLegacy(
    "Chest",
    {x: 142, y: 192, w: 139, h: 139},
    {x: 233 + ox, y: 597 + oy, w: 78, h: 78},
     ~flip=#Vertical,
    (),
  ) 

// Tooth Top
    Generator.drawTextureLegacy(
    "Chest",
    {x: 10, y: 0, w: 20, h: 10},
    {x: 413 + ox, y: 465 + oy, w: 11, h: 5},
    (),
  ) 

// Tooth Bottom
    Generator.drawTextureLegacy(
    "Chest",
    {x: 30, y: 0, w: 20, h: 10},
    {x: 413 + ox, y: 492 + oy, w: 11, h: 5},
     ~flip=#Vertical,
    (),
  ) 

// Tooth Front
    Generator.drawTextureLegacy(
    "Chest",
    {x: 10, y: 10, w: 20, h: 40},
    {x: 413 + ox, y: 470 + oy, w: 11, h: 22},
    (),
  ) 

// Tooth Right
    Generator.drawTextureLegacy(
    "Chest",
    {x: 0, y: 10, w: 10, h: 40},
    {x: 408 + ox, y: 470 + oy, w: 5, h: 22},
    (),
  ) 

// Tooth Left
    Generator.drawTextureLegacy(
    "Chest",
    {x: 30, y: 10, w: 10, h: 40},
    {x: 424 + ox, y: 470 + oy, w: 5, h: 22},
    (),
  ) 

// Tooth Back
    Generator.drawTextureLegacy(
    "Chest",
    {x: 40, y: 10, w: 20, h: 40},
    {x: 428 + ox, y: 470 + oy, w: 11, h: 22},
    (),
  ) 

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  history: history,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: instructions,
  images: images,
  textures: textures,
  script: script,
}
