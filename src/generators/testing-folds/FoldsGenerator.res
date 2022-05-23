module PageSize = Generator.PageSize
module Folds = FoldsGenerator_Folds

let requireImage = fileName => Generator.requireImage("./images/" ++ fileName)
let requireTexture = fileName => Generator.requireImage("./textures/" ++ fileName)

let id = "testing-folds"

let name = "Folds"

let history = []

let images: array<Generator.imageDef> = [
  {
    id: "Dither",
    url: requireImage("Dither.png"),
  },
  {
    id: "Fold",
    url: requireImage("Fold.png"),
  },
]

let textures: array<Generator.textureDef> = [
  {
    id: "Colors",
    url: requireTexture("Colors.png"),
    standardWidth: 4,
    standardHeight: 4,
  },
  {
    id: "Creeper",
    url: requireTexture("Creeper.png"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Steve",
    url: requireTexture("Steve.png"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Steve256",
    url: requireTexture("Steve256.png"),
    standardWidth: 256,
    standardHeight: 256,
  },
  {
    id: "GrassTop",
    url: requireTexture("GrassTop.png"),
    standardWidth: 16,
    standardHeight: 16,
  },
  {
    id: "GrassSide",
    url: requireTexture("GrassSide.png"),
    standardWidth: 16,
    standardHeight: 16,
  },
  {
    id: "Apple",
    url: requireTexture("apple.png"),
    standardWidth: 16,
    standardHeight: 16,
  },
  {
    id: "Slime Ball",
    url: requireTexture("slime_ball.png"),
    standardWidth: 16,
    standardHeight: 16,
  },
  {
    id: "Bottle",
    url: requireTexture("potion.png"),
    standardWidth: 16,
    standardHeight: 16,
  },
  {
    id: "Diamond Sword",
    url: requireTexture("diamond_sword.png"),
    standardWidth: 16,
    standardHeight: 16,
  },
]

//Generator.drawImage("Dither", (x + w * 8, y + h * 8))
let script = () => {
  Generator.defineText("Test page for some generator features.")
  Generator.drawImage("Fold", (0, 0))
  let alpha = Folds.getCurrentPagePixelAlpha(0, 0)
  Generator.defineText("Folds Alpha = " ++ Belt.Int.toString(alpha))
  Generator.drawTexture("Slime Ball", (4, 0, 16, 12), (100, 100, 128, 128), ())
  Generator.drawTexture("Apple", (0, 0, 16, 16), (250, 200, 64, 64), ())
  Generator.drawTexture("Bottle", (0, 0, 16, 16), (200, 400, 112, 112), ~rotate=45.0, ())
  Generator.drawTexture("Diamond Sword", (0, 0, 16, 16), (300, 550, 128, 64), ~flip=#Horizontal, ())
  Generator.drawLine("#ff0000", (100, 100, 128, 128))
  //Folds.drawFolds((100, 100, 128, 128))
  //Folds.drawFolds((250, 200, 64, 64))
  //Folds.drawFolds((200, 400, 112, 112))
  //Folds.drawFolds((300, 550, 128, 64))
  Generator.fillBackgroundColor("#ffffff")
}

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  thumbnail: None,
  video: None,
  instructions: None,
  images: images,
  textures: textures,
  script: script,
  history: history,
}
