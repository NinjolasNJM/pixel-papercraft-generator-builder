let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-horse"

let name = "Minecraft Horse"

let history = ["11 Jul 2021 NinjolasNJM - Initial script finished."]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/v3-thumbnail-256.jpeg"),
}

let imageIds = [
  "Action Figure/Foreground-Horse-Action-Figure",
  "Foreground-Horse",
  "Foreground-Mule",
  "Folds-Horse",
  "Folds-Mule",
  "Labels",
]
let toImageDef = (id): Generator.imageDef => {id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Horse",
    url: requireTexture("horse_white"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Black Horse",
    url: requireTexture("horse_black"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Brown Horse",
    url: requireTexture("horse_brown"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Chestnut Horse",
    url: requireTexture("horse_chestnut"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Creamy Horse",
    url: requireTexture("horse_creamy"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Dark Brown Horse",
    url: requireTexture("horse_darkbrown"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Gray Horse",
    url: requireTexture("horse_gray"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "White Horse",
    url: requireTexture("horse_white"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Skeleton Horse",
    url: requireTexture("horse_skeleton"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Zombie Horse",
    url: requireTexture("horse_zombie"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Donkey",
    url: requireTexture("donkey"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Mule",
    url: requireTexture("mule"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Black Dots",
    url: requireTexture("horse_markings_blackdots"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "White",
    url: requireTexture("horse_markings_white"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "White Dots",
    url: requireTexture("horse_markings_whitedots"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "White Field",
    url: requireTexture("horse_markings_whitefield"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Leather",
    url: requireTexture("horse_armor_leather"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Gold",
    url: requireTexture("horse_armor_gold"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Iron",
    url: requireTexture("horse_armor_iron"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Diamond",
    url: requireTexture("horse_armor_diamond"),
    standardWidth: 64,
    standardHeight: 64,
  },
]

let script = () => {
  // Define user inputs
  Generator.defineTextureInput(
    "Horse",
    {
      standardWidth: 64,
      standardHeight: 64,
      choices: [
        "Black Horse",
        "Brown Horse",
        "Chestnut Horse",
        "Creamy Horse",
        "Dark Brown Horse",
        "Gray Horse",
        "White Horse",
        "Skeleton Horse",
        "Zombie Horse",
        "Donkey",
        "Mule",
      ],
    },
  )
  Generator.defineTextureInput(
    "Markings",
    {
      standardWidth: 64,
      standardHeight: 64,
      choices: ["Black Dots", "White", "White Dots", "White Field"],
    },
  )
  Generator.defineTextureInput(
    "Armor",
    {
      standardWidth: 64,
      standardHeight: 64,
      choices: ["Leather", "Gold", "Iron", "Diamond"],
    },
  )

  // Define user variables
  Generator.defineBooleanInput("Show Folds", true)
  Generator.defineBooleanInput("Show Labels", true)
  Generator.defineBooleanInput("Donkey / Mule Model", false)
  Generator.defineBooleanInput("Action Figure", false)

  // Get user variable values
  let showFolds = Generator.getBooleanInputValue("Show Folds")
  let showLabels = Generator.getBooleanInputValue("Show Labels")
  let muleModel = Generator.getBooleanInputValue("Donkey / Mule Model")
  let actionFigure = Generator.getBooleanInputValue("Action Figure")

  let horse = Minecraft.Horse.horse

  let drawHorse = (texture: string) => {
    // Head
    let (ox, oy) = (20, 20)
    let scale = (48, 40, 56)

    Minecraft.drawCuboid(texture, horse.head, (ox, oy), scale, ())

    // Mouth
    let (ox, oy) = (140, 142)
    let scale = (32, 40, 40)

    Minecraft.drawCuboid(texture, horse.mouth, (ox, oy), scale, ())

    // Neck
    let (ox, oy) = (24, 232)
    let scale = (32, 96, 56)

    Minecraft.drawCuboid(texture, horse.neck, (ox, oy), scale, ())

    // Mane
    let (ox, oy) = (321, 16)
    let scale = (16, 128, 16)

    Minecraft.drawCuboid(texture, horse.mane, (ox, oy), scale, ~center=#Back, ())

    // Tail
    let (ox, oy) = (224, 348)
    let scale = (24, 112, 32)

    Minecraft.drawCuboid(texture, horse.tail, (ox, oy), scale, ~center=#Back, ())

    // Horse Ears
    let horseEars = (ox: int, oy: int) => {
      let scale = (16, 16, 8)

      Minecraft.drawCuboid(texture, horse.horseEar, (ox, oy + 40), scale, ())
    }

    // Donkey / Mule Ears

    let muleEars = (ox: int, oy: int) => {
      let scale = (16, 56, 8)

      Minecraft.drawCuboid(texture, horse.muleEar, (ox, oy), scale, ())
    }

    // Left Ear
    let (ox, oy) = (332, 249)

    if muleModel {
      muleEars(ox, oy)
    } else {
      horseEars(ox, oy)
    }

    // Right Ear
    let ox = 256

    if muleModel {
      muleEars(ox, oy)
    } else {
      horseEars(ox, oy)
    }

    // Body
    let (ox, oy) = (40, 452)
    let scale = (80, 80, 176)

    Minecraft.drawCuboid(texture, horse.body, (ox, oy), scale, ~center=#Top, ())

    // Legs
    let drawLeg = (ox: int, oy: int, leftSide: bool) => {
      let scale = (32, 88, 32)
      if !leftSide {
        Minecraft.drawCuboid(texture, horse.leg, (ox, oy), scale, ())
      } else {
        Minecraft.drawCuboid(texture, horse.leg, (ox, oy), scale, ~orientation=#East, ())
      }
    }

    // Front Left Leg
    let (ox, oy) = (413, 58)

    drawLeg(ox, oy, true)

    // Front Right Leg
    let oy = 250

    drawLeg(ox, oy, false)

    // Back Left Leg
    let oy = 442

    drawLeg(ox, oy, true)

    // Back Right Leg
    let oy = 634

    drawLeg(ox, oy, false)
  }

  // For clarity while testing. This may end up being combined into the original, if the changes are minute enough
  let drawActionFigure = (texture: string) => {
    drawHorse(texture)
  }

  // Draw Horse
  if !actionFigure {
    drawHorse("Horse")
    drawHorse("Markings")
    drawHorse("Armor")
  } else {
    drawActionFigure("Horse")
    drawActionFigure("Markings")
    drawActionFigure("Armor")
  }

  // Foreground
  if actionFigure {
    Generator.drawImage("Action Figure/Foreground-Horse-Action-Figure", (0, 0))
  } else if muleModel {
    Generator.drawImage("Foreground-Mule", (0, 0))
  } else {
    Generator.drawImage("Foreground-Horse", (0, 0))
  }

  // Folds
  if showFolds {
    if muleModel {
      Generator.drawImage("Folds-Mule", (0, 0))
    } else {
      Generator.drawImage("Folds-Horse", (0, 0))
    }
  }

  // Labels
  if showLabels {
    Generator.drawImage("Labels", (0, 0))
  }
}

let generator: Generator.generatorDef = {
  id,
  name,
  history,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: None,
  images,
  textures,
  script,
}
