@val external process: 'a = "process"

let isDevEnvironment: bool = process["env"]["NODE_ENV"] == "development"

/* let character: array<Generator.generatorDef> = [
  MinecraftCharacterGenerator.generator,
  MinecraftActionFigureGenerator.generator,
  MinecraftUltimateBendableGenerator.generator,
  MinecraftCharacterMiniGenerator.generator,
]

let mobCharacter: array<Generator.generatorDef> = [
  MinecraftCreeperCharacterGenerator.generator,
  MinecraftCatCharacterGenerator.generator,
  MinecraftCowCharacterGenerator.generator,
  MinecraftEndermanCharacterGenerator.generator,
  MinecraftGolemCharacterGenerator.generator,
  MinecraftPigCharacterGenerator.generator,
  MinecraftSquidCharacterGenerator.generator,
  MinecraftVillagerCharacterGenerator.generator,
  MinecraftWolfCharacterGenerator.generator,
  MinecraftAxolotlCharacterGenerator.generator,
]

let mob: array<Generator.generatorDef> = [
  MinecraftCreeperGenerator.generator,
  MinecraftEndermanGenerator.generator,
  MinecraftGolemGenerator.generator,
  MinecraftHorseGenerator.generator,
  MinecraftPigGenerator.generator,
  MinecraftCatGenerator.generator,
]

// Blocks, Items and Accessories
let utility: array<Generator.generatorDef> = [
  MinecraftBlockGenerator.generator,
  MinecraftItemGenerator.generator,
  MinecraftCapeAndElytraGenerator.generator,
  MinecraftCharacterHeadsGenerator.generator,
]

let mod: array<Generator.generatorDef> = [
  MinecraftMutantCharacterGenerator.generator,
  DalekModDalekGenerator.generator,
]

let other: array<Generator.generatorDef> = [AmogusBendableGenerator.generator]

// Incomplete and in development
let dev: array<Generator.generatorDef> = isDevEnvironment
  ? [MinecraftWitherGenerator.generator]
  : []

let test: array<Generator.generatorDef> = isDevEnvironment
  ? [ExampleGenerator.generator, TestingGenerator.generator]
  : [] 
 */

let ninjolasNJM: array<Generator.generatorDef> = [MinecraftBlockGenerator.generator]

let paperDoggy: array<Generator.generatorDef> = [MinecraftBlockGenerator.generator]

let all = Belt.Array.concatMany([ninjolasNJM, paperDoggy])
