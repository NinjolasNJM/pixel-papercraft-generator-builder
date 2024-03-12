let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")
module TexturePicker = TexturePicker
module Face = TextureFace
module Types = MinecraftDiorama_Types
module Markdown = Generator.Markdown
module TextureVersions = TextureVersions

let id = "minecraft-diorama"

let name = "Minecraft Diorama"

let history = ["24 Jan 2024 NinjolasNJM - Initial Script Finished"]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/v2-thumbnail-256.jpeg"),
}

let images: array<Generator.imageDef> = [
  {id: "Title Portrait", url: Generator.requireImage("./images/TitlePortrait.png")},
  {id: "Title Landscape", url: Generator.requireImage("./images/TitleLandscape.png")},
]

let textures: array<Generator.textureDef> = Belt.Array.concat(
  TextureVersions.allTextureDefs,
  [
    {
      id: "Tab",
      url: requireTexture("Tab"),
      standardWidth: 128,
      standardHeight: 128,
    },
    {
      id: "Tab Left",
      url: requireTexture("TabLeft"),
      standardWidth: 128,
      standardHeight: 128,
    },
    {
      id: "Tab Right",
      url: requireTexture("TabRight"),
      standardWidth: 128,
      standardHeight: 128,
    },
    {
      id: "Tab Middle",
      url: requireTexture("TabMiddle"),
      standardWidth: 128,
      standardHeight: 128,
    },
    {
      id: "Fold",
      url: requireTexture("Fold"),
      standardWidth: 128,
      standardHeight: 128,
    },
    {
      id: "Debug",
      url: requireTexture("debug"),
      standardWidth: 128,
      standardHeight: 128,
    },
  ],
)

let definitions = Belt.Array.concat(
  TextureVersions.itemDefinitions,
  TextureVersions.blockDefinitions,
)

let script = () => {
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
      enableRotation=true
      enableErase=true
    />
  })

  let editMode = Generator.defineAndGetSelectInput(
    "Edit Mode",
    ["Blocks", "Tabs", "Folds", "Scale"],
  )

  let baseSize = Generator.defineAndGetSelectInput("Base Size", ["800%", "400%", "200%", "Custom"])

  let dioramaWidth = switch baseSize {
  | "800%" => 800
  | "400%" => 400
  | "200%" => 200
  | "Custom" =>
    Generator.defineAndGetRangeInput("Size", {min: 100, max: 1600, value: 800, step: 50})
  | _ => 128
  }

  // if baseSize is not custom, = dioramaWidth
  // if baseSize is custom, define boolean, and then = rangeInput

  let pageFormat = Generator.defineAndGetBooleanInput("Landscape Mode", false)

  Generator.usePage(~isLandscape=pageFormat, "Page")
  // Scale
  let options = ref(Types.Scale.draw(dioramaWidth, pageFormat, editMode))

  // Blocks
  Types.Block.draw(options)

  // Tabs
  Types.Tabs.draw(options)

  // Folds
  Types.Folds.draw(options)

  /*
   options has a default setting.
   Options is editable by scale.
   The edited options is accessible by the other draw functions, and by scale. 
   When options is updated, all draw functions are updated.
 */

  /* How it will work: 
Have diorama size as is, renamed to base size
WHen scale mode is on, have another width, height options
This will somehow be stored in a region input
Pass just dioramaWidth to options, with height and widths in arrays
Define scale first so that the others get options?
 */
  Generator.defineButtonInput("Clear", () => {
    // Save things we don't want cleared
    let currentTextureChoice = Generator.getStringInputValue("SelectedTextureFrame")
    let currentVersionId = versionId
    let currentEditMode = editMode
    let currentPageFormat = pageFormat

    // Clear everything
    Generator.clearStringInputValues()
    Generator.clearBooleanInputValues()
    Generator.clearSelectInputValues()

    // Restore everything except the blocks, tabs and folds
    Generator.setStringInputValue("SelectedTextureFrame", currentTextureChoice)
    Generator.setSelectInputValue("Version", currentVersionId)
    Generator.setSelectInputValue("Edit Mode", currentEditMode)
    Generator.setBooleanInputValue("Landscape Mode", currentPageFormat)
  })

  pageFormat
    ? Generator.drawImage("Title Landscape", (0, 0))
    : Generator.drawImage("Title Portrait", (0, 0))
  Generator.fillBackgroundColorWithWhite()
  Generator.fillBackgroundColorWithWhite()
}

let generator: Generator.generatorDef = {
  id,
  name,
  history,
  thumbnail: None, // Some(thumbnail),
  video: None,
  instructions: None,
  images,
  textures,
  script,
}
