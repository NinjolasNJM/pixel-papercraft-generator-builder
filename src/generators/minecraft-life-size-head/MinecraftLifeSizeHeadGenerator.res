let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-life-size-head"

let name = "Minecraft Life Size Head"

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/thumbnail.jpeg"),
}

let imageIds = ["Background", "Titles"]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Skin",
    url: requireTexture("Steve"),
    standardWidth: 64,
    standardHeight: 64,
  },
]

let script = () => {
  // Define the user inputs
  Generator.defineTextureInput(
    "Skin",
    {
      standardWidth: 64,
      standardHeight: 64,
      choices: [],
    },
  )

  // Define user variables
  Generator.defineSelectInput("Helmet", ["Attached", "Separate", "None"])
  Generator.defineBooleanInput("Show Titles", true)

  // Get user variable values
  let helmetStyle = Generator.getSelectInputValue("Helmet")
  let showTitles = Generator.getBooleanInputValue("Show Titles")

  let showHelmet = helmetStyle !== "None"

  let m = 55
  let w = 880

  // Draw Helmet
  let drawHelmet = () => {
    Generator.drawTexture("Skin", (32, 8, 8, 8), (m, m, w, w), ()) // Right
    Generator.drawTexture("Skin", (40, 8, 8, 8), (m * 2 + w, m, w, w), ()) // Front
    Generator.drawTexture("Skin", (48, 8, 8, 8), (m * 3 + w * 2, m, w, w), ()) // Left
    Generator.drawTexture("Skin", (56, 8, 8, 8), (m, m * 2 + w, w, w), ()) // Back
    Generator.drawTexture("Skin", (40, 0, 8, 8), (m * 2 + w, m * 2 + w, w, w), ()) // Top
    Generator.drawTexture(
      "Skin",
      (48, 0, 8, 8),
      (m * 3 + w * 2, m * 2 + w, w, w),
      ~flip=#Vertical,
      (),
    ) // Bottom
  }

  // Use Life Size Page
  Generator.usePageLifeSize("Head")

  // Background
  Generator.drawImage("Background", (0, 0))

  // Head

  Generator.drawTexture("Skin", (0, 8, 8, 8), (m, m, w, w), ()) // Right
  Generator.drawTexture("Skin", (8, 8, 8, 8), (m * 2 + w, m, w, w), ()) // Front
  Generator.drawTexture("Skin", (16, 8, 8, 8), (m * 3 + w * 2, m, w, w), ()) // Left
  Generator.drawTexture("Skin", (24, 8, 8, 8), (m, m * 2 + w, w, w), ()) // Back
  Generator.drawTexture("Skin", (8, 0, 8, 8), (m * 2 + w, m * 2 + w, w, w), ()) // Top
  Generator.drawTexture(
    "Skin",
    (16, 0, 8, 8),
    (m * 3 + w * 2, m * 2 + w, w, w),
    ~flip=#Vertical,
    (),
  ) // Bottom

  //Helmet

  if showHelmet {
    if helmetStyle === "Separate" {
      // Titles
      if showTitles {
        Generator.drawImage("Titles", (0, 0))
      }
      Generator.usePageLifeSize("Helmet")
      Generator.drawImage("Background", (0, 0))
    }
    drawHelmet()
  }

  // Titles
  if showTitles {
    Generator.drawImage("Titles", (0, 0))
  }
}

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: None,
  images: images,
  textures: textures,
  script: script,
}
