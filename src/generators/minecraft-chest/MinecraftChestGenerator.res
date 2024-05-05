let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png");
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png");

let id = "minecraft-chest";

let name = "Minecraft Chest Generator";

let history = [
  "Originally developed by minecraftpapercrafttemplates."
];

let thumbnail: Generator.thumbnailDef = { 
  url: Generator.requireImage("./thumbnail/thumbnail-256.jpeg"),
};

let instructions = `
  ## Welcome to the Chest generator!
  ### This is still in Beta Development
  ### Upload a texture of your own chest or select a chest already put for you!
  ### Unfortunately, I couldn't make the folds transparent so I will let someone else do the job. :(
`;

let imageIds = [ 
  "Background",
];
let toImageDef = (id) => ({id: id, url: requireImage(id)});
let images: array<Generator.imageDef> = Js.Array2.map(toImageDef, imageIds);

let textures: array<Generator.textureDef> = [
  {
    id: "Chest",
    url: requireTexture("Chest"),
    standardWidth: 640,
    standardHeight: 640
  },
  {
    id: "Ender Chest",
    url: requireTexture("EnderChest"),
    standardWidth: 640,
    standardHeight: 640
  },
  {
    id: "Trapped Chest",
    url: requireTexture("TrappedChest"),
    standardWidth: 640,
    standardHeight: 640
  },
  {
    id: "Christmas Chest",
    url: requireTexture("ChristmasChest"),
    standardWidth: 640,
    standardHeight: 640
  },
];

let script = () => {
  Generator.defineTextureInput("Chest",{standardWidth: 640, standardHeight: 640, choices: []});

  Generator.drawImage("Background", (0, 0));
  
  // Resto del script...
};

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  history: history,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: Some(instructions),
  images: images,
  textures: textures,
  script: script,
};
