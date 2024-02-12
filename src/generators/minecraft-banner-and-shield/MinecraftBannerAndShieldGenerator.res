module Markdown = Generator.Markdown
module TexturePicker = TexturePicker
module TextureVersions = TextureVersions
module Types = MinecraftBannerAndShield_Types

let id = "minecraft-banner-and-shield"

let name = "Minecraft Banner And Shield"

let history = ["Nobody Knows"]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/v2-thumbnail-256.jpeg"),
}

let instructions = `

`

let images: array<Generator.imageDef> = [
  {id: "Background", url: Generator.requireImage("./images/Background.png")},
]

let textures: array<Generator.textureDef> = Js.Array.concat(
  MinecraftSkins.skins,
  Js.Array.concat(
    TextureVersions.bannerTextureDefs,
    [
      {
        id: "Banner Base",
        url: Generator.requireImage("./textures/banner_base.png"),
        standardWidth: 64,
        standardHeight: 64,
      },
      {
        id: "Shield Base- No Pattern",
        url: Generator.requireImage("./textures/shield_base_nopattern.png"),
        standardWidth: 64,
        standardHeight: 64,
      },
      {
        id: "Shield Base",
        url: Generator.requireImage("./textures/shield_base.png"),
        standardWidth: 64,
        standardHeight: 64,
      },
    ],
  ),
)

let definitions = TextureVersions.bannerDefinitions

let script = () => {
  //Generator.usePage(~size=Generator_PageSize.a4Triple, "Page")

  // Show a drop down of different texture versions
  Generator.defineSelectInput("Version", TextureVersions.versionIds(definitions))
  let versionId = Generator.getSelectInputValue("Version")

  // Get the current selected version
  let textureVersion = TextureVersions.findVersion(versionId, definitions)

  // Show the Texture Picker
  // When a texture is selected, we need to encode it into a string variable
  Generator.defineCustomStringInput("SelectedTextureFrame", (onChange: string => unit) => {
    <TexturePicker
      textureVersion
      onSelect={selectedTexture => {
        onChange(TexturePicker.SelectedTexture.encode(selectedTexture))
      }}
      singleStack=true
    />
  })

  // Define the Show Folds Variable
  Generator.defineBooleanInput("Show Folds", true)

  let showFolds = Generator.getBooleanInputValue("Show Folds")

  Generator.defineSelectInput("Number of Banners", ["1", "2"])
  let numberOfBanners =
    Generator.getSelectInputValue("Number of Banners")
    ->Belt.Int.fromString
    ->Belt.Option.getWithDefault(1)

  Generator.drawImage("Background", (0, 0))

  // Decode the selected texture
  let selectedTextureFrame = TexturePicker.SelectedTexture.decode(
    Generator.getStringInputValue("SelectedTextureFrame"),
  )

  // Decode the added textures
  let selectedTextureFrames = TexturePicker.SelectedTexture.decodeArray(
    Generator.getStringInputValue("SelectedTextureFrames"),
  )

  for i in 1 to numberOfBanners {
    let bannerId = Js.Int.toString(i)

    let typeName = "Banner " ++ bannerId ++ " Type"
    Generator.defineSelectInput(typeName, ["Banner"])
    let bannerType = Generator.getSelectInputValue(typeName)

    let ox = 100
    let oy = 12 + 400 * (i - 1)

    switch bannerType {
    | "Banner" => Types.Banner.draw("SelectedTextureFrames", ox, oy, showFolds)
    | _ => ()
    }
    Minecraft.drawCuboid("Skin", Minecraft.Character.steve.base.head, (ox, oy), (64, 64, 64), ())
    Minecraft.drawCuboid(
      "Skin",
      Minecraft.Character.steve.base.head,
      (ox, oy + 192),
      (64, 64, 64),
      (),
    )
  }

  // Show a button which adds the selected texture to the page
  Generator.defineButtonInput("Add Pattern", () => {
    switch selectedTextureFrame {
    | Some(selectedTextureFrame) => {
        let selectedTextureFrames = Belt.Array.concat(selectedTextureFrames, [selectedTextureFrame])
        Generator.setStringInputValue(
          "SelectedTextureFrames",
          TexturePicker.SelectedTexture.encodeArray(selectedTextureFrames),
        )
      }
    | None => ()
    }
  })
  // Show a button which removes the last texture from the page
  Generator.defineButtonInput("Remove Pattern", () => {
    let _ = Js.Array2.pop(selectedTextureFrames)
    Generator.setStringInputValue(
      "SelectedTextureFrames",
      TexturePicker.SelectedTexture.encodeArray(selectedTextureFrames),
    )
  })

  // Show a button which allows the items to be cleared
  Generator.defineButtonInput("Clear", () => {
    Generator.setStringInputValue(
      "SelectedTextureFrames",
      TexturePicker.SelectedTexture.encodeArray([]),
    )
  })

  //Minecraft.drawCuboid("Banner Base", Minecraft.Banner.banner.cloth, (100, 100), (160, 320, 8), ())
}

let generator: Generator.generatorDef = {
  id,
  name,
  history,
  thumbnail: None, //Some(thumbnail),
  video: None,
  instructions: None, //Some(<Markdown> {instructions} </Markdown>),
  images,
  textures,
  script,
}
