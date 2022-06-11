let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-minecart"

let name = "Minecraft Minecart"

let history = ["30 Jun NinjolasNJM - first release"]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/thumbnail-256.jpeg"),
}

let instructions = "
To make blocks that fit in a minecart, go to the Block Generator and select the block's type to be \"Minecart Block\".
"

let imageIds = ["Foreground"]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Minecart",
    url: requireTexture("minecart"),
    standardWidth: 64,
    standardHeight: 32,
  },
]

module Map = {
  type map = {
    bottom: Generator_Builder.cuboid,
    sides: Generator_Builder.cuboid,
  }

  let minecart = {
    bottom: Generator_Builder.makeCuboid((0, 10), (20, 16, 2)),
    sides: Generator_Builder.makeCuboid((0, 0), (16, 8, 2)),
  }
}

let script = () => {
  // Define the user inputs
  Generator.defineTextureInput(
    "Minecart",
    {
      standardWidth: 64,
      standardHeight: 32,
      choices: [],
    },
  )

  // Define user variables
  Generator.defineBooleanInput("Show Folds", true)

  // Get user variable values
  let showFolds = Generator.getBooleanInputValue("Show Folds")

  // Minecart

  let ox = 249
  let oy = 245

  // Center
  Generator.drawTexture(
    "Minecart",
    (26, 14, 16, 12),
    (ox - 16, oy + 16, 128, 96),
    ~rotate=-90.0,
    (),
  )

  // Front Side

  Generator.drawTexture("Minecart", Map.minecart.sides.front, (ox - 16, oy - 64, 128, 64), ())
  Generator.drawTexture("Minecart", Map.minecart.sides.top, (ox - 16, oy - 80, 128, 16), ())
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.back,
    (ox - 16, oy - 144, 128, 64),
    ~rotate=180.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.bottom.right,
    (ox + 40, oy - 216, 16, 128),
    ~rotate=-90.0,
    (),
  )

  // Right Side

  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.front,
    (ox + 64, oy + 32, 128, 64),
    ~rotate=90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.top,
    (ox + 104, oy + 56, 128, 16),
    ~rotate=90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.back,
    (ox + 144, oy + 32, 128, 64),
    ~rotate=-90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.left,
    (ox + 200, oy - 40, 16, 64),
    ~rotate=-90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.right,
    (ox + 200, oy + 104, 16, 64),
    ~rotate=-90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.bottom.bottom,
    (ox + 168, oy + 56, 160, 16),
    ~flip=#Vertical,
    ~rotate=90.0,
    (),
  )

  // Back Side

  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.front,
    (ox - 16, oy + 128, 128, 64),
    ~rotate=180.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.top,
    (ox - 16, oy + 192, 128, 16),
    ~rotate=180.0,
    (),
  )
  Generator.drawTexture("Minecart", Map.minecart.sides.back, (ox - 16, oy + 208, 128, 64), ())
  Generator.drawTexture(
    "Minecart",
    Map.minecart.bottom.left,
    (ox + 40, oy + 216, 16, 128),
    ~rotate=-90.0,
    (),
  )

  // Left Side

  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.front,
    (ox - 96, oy + 32, 128, 64),
    ~rotate=-90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.top,
    (ox - 136, oy + 56, 128, 16),
    ~rotate=-90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.back,
    (ox - 176, oy + 32, 128, 64),
    ~rotate=90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.left,
    (ox - 120, oy + 104, 16, 64),
    ~rotate=90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.sides.right,
    (ox - 120, oy - 40, 16, 64),
    ~rotate=90.0,
    (),
  )
  Generator.drawTexture(
    "Minecart",
    Map.minecart.bottom.top,
    (ox - 232, oy + 56, 160, 16),
    ~rotate=90.0,
    (),
  )

  // Bottom
  Generator.drawTexture(
    "Minecart",
    Map.minecart.bottom.front,
    (ox - 32, oy + 304, 160, 128),
    ~rotate=-90.0,
    (),
  )

  let drawFolds = () => {
    // Center Lines
    Generator.drawFoldLine((ox - 1, oy - 64), (ox - 1, oy + 192))
    Generator.drawFoldLine((ox + 96, oy - 64), (ox + 96, oy + 192))

    Generator.drawFoldLine((ox - 80, oy - 1), (ox + 176, oy - 1))
    Generator.drawFoldLine((ox - 80, oy + 128), (ox + 176, oy + 128))

    // Top Lines
    Generator.drawFoldLineRect((ox - 16, oy - 160, 128, 96))
    Generator.drawFoldLine((ox - 16, oy - 80), (ox + 112, oy - 80))

    // Right Lines
    Generator.drawFoldLineRect((ox + 176, oy - 16, 80, 160))
    Generator.drawFoldLine((ox + 160, oy), (ox + 160, oy + 128))

    // Bottom Lines
    Generator.drawFoldLineRect((ox - 16, oy + 192, 128, 256))
    Generator.drawFoldLine((ox - 16, oy + 207), (ox + 112, oy + 207))
    Generator.drawFoldLine((ox - 16, oy + 288), (ox + 112, oy + 288))

    // Left Lines
    Generator.drawFoldLineRect((ox - 160, oy - 16, 80, 160))
    Generator.drawFoldLine((ox - 64, oy), (ox - 64, oy + 128))
  }

  // Draw the Foreground image
  Generator.drawImage("Foreground", (0, 0))

  // Folds
  if showFolds {
    drawFolds()
  }
}

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  history: history,
  thumbnail: None,
  video: None,
  instructions: Some(<Generator.Markdown> {instructions} </Generator.Markdown>),
  images: images,
  textures: textures,
  script: script,
}
