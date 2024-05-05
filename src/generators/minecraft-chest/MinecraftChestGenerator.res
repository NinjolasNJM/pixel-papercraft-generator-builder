let requireImage = id = > Generador. requireImage("./images/" ++ id ++ ".png")
let requireTexture = id = > Generador. requireImage("./textures/" ++ id ++ ".png")

let id = "minecraft-chest"

let name = "Cofre de Minecraft"
Deja que la historia = [
  "Desarrollado originalmente por minecraftpapercrafttemplates."
]
let thumbnail: Generador. thummbnailDef = { 
  url: Generador. requireImage("./thumbnail/thumbnail-256.jpeg"),
}
Instrucciones de LET  = { 
  let chestTexture = requireTexture("Cofre")
  `
## ¡Bienvenido al generador de cofres!
 ### Esto todavía está en desarrollo beta
### ¡Sube una textura de tu propio cofre o selecciona un cofre ya puesto para ti!
### Desafortunadamente, no pude hacer que los pliegues fueran transparentes, así que dejaré que otra persona haga el trabajo. :(
`
  }
let imageIds = [ 
  "Antecedentes",
]
let toImageDef = (id): Generador. imageDef => {id: id, url: requireImage(id)}
let images: array<Generator. imageDef> = imageIds->Js. Matriz2. map(toImageDef)
let textures: array<Generator. textureDef> = [
  {
    id: "Cofre"
    url: requireTexture("Cofre")
    standardWidth: 640
    standardAltura: 640
  },
]
let script = () => {
  Generador. defineTextureInput("Chest",{standardWidth: 640, standardHeight: 640, choices: []})
  Generador. drawImage("Fondo", (0, 0))
  
  Derecha
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 281, Y: 140, W: 139, H: 49},
    {X: 147 + Buey, Y: 360 + Oy, W: 76, H: 27},
    (),
  ) 
  
   Atrás
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 140, Y: 141, W: 139, H: 49},
    {X: 375 + Buey, Y: 360 + Oy, W: 76, H: 27},
    (),
  ) 
  
  Izquierda
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 0, Y: 140, W: 139, H: 49},
    {X: 299 + Buey, Y: 360 + Oy, W: 76, H: 27},
    (),
  ) 
  Frente
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 421, Y: 140, W: 139, H: 49},
    {X: 223 + Buey, Y: 360 + Oy, W: 76, H: 27},
    (),
  ) 
  Arriba
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 281, Y: 0, W: 139, H: 141},
    {X: 223 + Buey, Y: 283 + Oy, W: 77, H: 77},
    (),
  ) 
  Esa parte similar al paladar no sé cómo decirlo ja
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 140, Y: 0, W: 139, H: 141},
    {X: 224 + Buey, Y: 387 + Oy, W: 77, H: 77},
     ~flip=#Vertical,
    (),
  ) 
El Piso de la Boca del que estaba hablando 
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 283, Y: 190, W: 139, H: 141},
    {X: 224 + Buey, Y: 464 + Oy, W: 77, H: 79},
     ~flip=#Vertical,
    (),
  )    
Abajo a la derecha 
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 280, Y: 330, W: 139, H: 100},
    {x: 147 + buey, y: 542 + oy, w: 77, h: 55},
     ~flip=#Vertical,
    (),
  ) 
Parte inferior delantera 
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 421, Y: 330, W: 139, H: 100},
    {X: 224 + Buey, Y: 542 + Oy, W: 78, H: 55},
     ~flip=#Vertical,
    (),
  ) 
Abajo a la izquierda 
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 0, Y: 330, W: 139, H: 100},
    {X: 300 + Buey, Y: 542 + Oy, W: 77, H: 55},
     ~flip=#Vertical,
    (),
  ) 
Parte inferior trasera
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 142, Y: 330, W: 139, H: 100},
    {X: 377 + Buey, Y: 542 + Oy, W: 77, H: 55},
     ~flip=#Vertical,
    (),
  ) 
Fondo
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 142, Y: 192, W: 139, H: 139},
    {X: 233 + Buey, Y: 597 + Oy, W: 78, H: 78},
     ~flip=#Vertical,
    (),
  ) 
Parte superior del diente
    Generador. drawTextureLegacy(
    "Cofre",
    {x: 10, y: 0, w: 20, h: 10},
    {X: 413 + Buey, Y: 465 + Oy, W: 11, H: 5},
    (),
  ) 
Parte inferior del diente
    Generador. drawTextureLegacy(
    "Cofre",
    {x: 30, y: 0, w: 20, h: 10},
    {X: 413 + Buey, Y: 492 + Oy, W: 11, H: 5},
     ~flip=#Vertical,
    (),
  ) 
Frente del diente
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 10, Y: 10, W: 20, H: 40},
    {X: 413 + Buey, Y: 470 + Oy, W: 11, H: 22},
    (),
  ) 
Diente derecho
    Generador. drawTextureLegacy(
    "Cofre",
    {x: 0, y: 10, w: 10, h: 40},
    {x: 408 + buey, y: 470 + oy, w: 5, h: 22},
    (),
  ) 
Diente a la izquierda
    Generador. drawTextureLegacy(
    "Chest",
    {x: 30, y: 10, w: 10, h: 40},
    {x: 424 + ox, y: 470 + oy, w: 5, h: 22},
    (),
  ) 
Parte posterior del diente
    Generador. drawTextureLegacy(
    "Cofre",
    {X: 40, Y: 10, W: 20, H: 40},
    {X: 428 + Buey, Y: 470 + Oy, W: 11, H: 22},
    (),
  ) 
let generator: Generador. generatorDef = {
  id: id,
  nombre: nombre,
  Historia: historia,
  miniatura: Algunos(miniatura),
  video: Ninguno,
  Instrucciones: instrucciones,
  Imágenes: imágenes,
  texturas: texturas,
  script: guión,
}
