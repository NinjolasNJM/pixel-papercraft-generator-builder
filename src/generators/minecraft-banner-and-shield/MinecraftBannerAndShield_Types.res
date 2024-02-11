module Face = TextureFace

module Banner = {
  let drawBanner = (textureId: string, ox: int, oy: int) => {
    Face.drawCuboid(textureId, Minecraft.Banner.banner.cloth, (ox, oy), (128, 256, 5), ())
    //Face.drawCuboid(textureId, Minecraft.Banner.banner.cloth, (ox, oy), (128, 256, 5), ())
  }

  let draw = (bannerId: string, ox: int, oy: int, showFolds: bool) => {
    drawBanner(bannerId, ox, oy)

    //Generator.drawImage("Tabs-Banner", (ox - 32, oy - 1))

    //if showFolds {
    //  Generator.drawImage("Folds-Banner", (ox - 32, oy - 1))
    //}
  }
}
