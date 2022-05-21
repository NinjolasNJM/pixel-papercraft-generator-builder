// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Jimp = require("jimp");
var Path = require("path");
var Js_dict = require("rescript/lib/js/js_dict.js");
var Imageinfo = require("imageinfo");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Child_process = require("child_process");
var Belt_SortArray = require("rescript/lib/js/belt_SortArray.js");

var makeError = ((reason) => new Error(reason));

function makeSafeFileName(prefix, version) {
  return prefix + "_" + version.replace(/[-\.]/g, "_");
}

function hasImageExtension(path) {
  return path.endsWith(".png");
}

function toImageWithInfo(path) {
  var match = Path.parse(path);
  var file = Fs.readFileSync(path);
  var info = Imageinfo(file);
  return {
          name: match.name,
          path: path,
          info: info
        };
}

function isDirectory(path) {
  return Fs.statSync(path).isDirectory();
}

function isFile(path) {
  return Fs.statSync(path).isFile();
}

function isImageFile(path) {
  if (path.endsWith(".png")) {
    return Fs.statSync(path).isFile();
  } else {
    return false;
  }
}

function readImagesInDirectory(directoryPath) {
  return Fs.readdirSync(directoryPath).map(function (fileName) {
                  return directoryPath + "/" + fileName;
                }).filter(isImageFile).map(toImageWithInfo);
}

function sortImagesByHeight(images) {
  return Belt_SortArray.stableSortBy(images, (function (image1, image2) {
                return image1.info.height - image2.info.height | 0;
              }));
}

function calculateImagesWithCoordinates(images, canvasWidth) {
  var imagesSorted = sortImagesByHeight(images);
  var nextx = {
    contents: 0
  };
  var nexty = {
    contents: 0
  };
  var rowHeight = {
    contents: 0
  };
  var canvasHeight = {
    contents: 0
  };
  var coordinates = {};
  Belt_Array.forEach(imagesSorted, (function (sourceImage) {
          var info = sourceImage.info;
          var width = info.width;
          var name = sourceImage.name;
          if (width > canvasWidth) {
            console.log("WARNING: " + name + " has width " + String(width) + " greater than the canvas width " + String(canvasWidth) + " and was not added");
            return ;
          }
          var height = info.height;
          var match;
          if ((nextx.contents + width | 0) > canvasWidth) {
            var y = nexty.contents + rowHeight.contents | 0;
            nextx.contents = 0 + width | 0;
            nexty.contents = y;
            canvasHeight.contents = canvasHeight.contents + rowHeight.contents | 0;
            rowHeight.contents = height;
            match = [
              0,
              y
            ];
          } else {
            var x = nextx.contents;
            var y$1 = nexty.contents;
            nextx.contents = x + width | 0;
            if (height > rowHeight.contents) {
              rowHeight.contents = height;
            }
            match = [
              x,
              y$1
            ];
          }
          coordinates[name] = [
            match[0],
            match[1],
            width,
            height
          ];
          
        }));
  canvasHeight.contents = canvasHeight.contents + rowHeight.contents | 0;
  var imagesWithCoordinates = Belt_Array.reduce(images, [], (function (acc, image) {
          var match = Js_dict.get(coordinates, image.name);
          if (match === undefined) {
            return acc;
          }
          var imageWithCoordinates_coordinates = [
            match[0],
            match[1]
          ];
          var imageWithCoordinates = {
            image: image,
            coordinates: imageWithCoordinates_coordinates
          };
          return Belt_Array.concat(acc, [imageWithCoordinates]);
        }));
  return [
          imagesWithCoordinates,
          canvasWidth,
          canvasHeight.contents
        ];
}

function makeCanvas(width, height) {
  return new Promise((function (resolve, reject) {
                new Jimp(width, height, (function (error, canvas) {
                        if (error == null) {
                          if (canvas == null) {
                            return reject(makeError("An error occurred creating the canvas"));
                          } else {
                            return resolve(canvas);
                          }
                        } else {
                          return reject(error);
                        }
                      }));
                
              }));
}

function makeTiledImagesCanvas(images, canvasWidth) {
  var match = calculateImagesWithCoordinates(images, canvasWidth);
  var canvasHeight = match[2];
  var canvasWidth$1 = match[1];
  var imagesWithCoordinates = match[0];
  return makeCanvas(canvasWidth$1, canvasHeight).then(function (canvas) {
                return Belt_Array.reduce(imagesWithCoordinates, Promise.resolve(canvas), (function (acc, imageWithCoordinates) {
                              var coordinates = imageWithCoordinates.coordinates;
                              var y = coordinates[1];
                              var x = coordinates[0];
                              return Jimp.read(imageWithCoordinates.image.path).then(function (image) {
                                          return acc.then(function (canvas) {
                                                      return Promise.resolve(canvas.blit(image, x, y));
                                                    });
                                        });
                            }));
              }).then(function (canvas) {
              return Promise.resolve([
                          imagesWithCoordinates,
                          canvas,
                          canvasWidth$1,
                          canvasHeight
                        ]);
            });
}

function writeTileImage(canvas, tileImagePath) {
  return canvas.writeAsync(tileImagePath);
}

function writeTileJson(imagesWithCoordinates, tileJsonPath) {
  var tileInfos = Belt_Array.map(imagesWithCoordinates, (function (imagesWithCoordinates) {
          var coordinates = imagesWithCoordinates.coordinates;
          var image = imagesWithCoordinates.image;
          var info = image.info;
          return {
                  name: image.name,
                  x: coordinates[0],
                  y: coordinates[1],
                  width: info.width,
                  height: info.height
                };
        }));
  var json = JSON.stringify(tileInfos, null, 2);
  Fs.writeFileSync(tileJsonPath, json);
  
}

function printStdOutput(stdout, stderr) {
  if (!(stdout == null) && stdout.length > 0) {
    console.log(stdout);
  }
  if (!(stderr == null) && stderr.length > 0) {
    console.log(stderr);
    return ;
  }
  
}

function formatReScriptFile(path) {
  return new Promise((function (resolve, reject) {
                Child_process.exec("npx rescript format " + path, (function (exn, stdout, stderr) {
                        if (exn == null) {
                          printStdOutput(stdout, stderr);
                          return resolve(undefined);
                        } else {
                          return reject(exn);
                        }
                      }));
                
              }));
}

function writeTileReScript(id, tileImagePath, tileInfos, canvasWidth, canvasHeight, tileReScriptPath) {
  var match = Path.parse(tileImagePath);
  var code = "\n    // This is a generated file\n\n    let texture: Generator.textureDef = {\n      id: \"" + id + "\",\n      url: Generator.requireImage(\"./" + match.base + "\"),\n      standardWidth: " + String(canvasWidth) + ",\n      standardHeight: " + String(canvasHeight) + ",\n    }\n\n    let tiles = " + JSON.stringify(tileInfos) + "\n\n    let data = (texture, tiles)\n  ";
  Fs.writeFileSync(tileReScriptPath, code);
  return formatReScriptFile(tileReScriptPath);
}

function makeTiledImages(id, sourceDirectory, outputDirectory, outputPrefix) {
  var fileName = makeSafeFileName(outputPrefix, id);
  var basePath = outputDirectory + "/" + fileName;
  var tileImagePath = basePath + ".png";
  var tileJsonPath = basePath + ".json";
  var tileReScriptPath = basePath + ".res";
  var images = readImagesInDirectory(sourceDirectory);
  return makeTiledImagesCanvas(images, 512).then(function (results) {
              var canvasHeight = results[3];
              var canvasWidth = results[2];
              var imagesWithCoordinates = results[0];
              return results[1].writeAsync(tileImagePath).then(function (param) {
                          writeTileJson(imagesWithCoordinates, tileJsonPath);
                          var tileInfos = Belt_Array.map(imagesWithCoordinates, (function (imageWithCoordinates) {
                                  var image = imageWithCoordinates.image;
                                  var info = image.info;
                                  var coordinates = imageWithCoordinates.coordinates;
                                  return {
                                          name: image.name,
                                          x: coordinates[0],
                                          y: coordinates[1],
                                          width: info.width,
                                          height: info.height
                                        };
                                }));
                          return writeTileReScript(id, tileImagePath, tileInfos, canvasWidth, canvasHeight, tileReScriptPath);
                        });
            });
}

exports.makeError = makeError;
exports.makeSafeFileName = makeSafeFileName;
exports.hasImageExtension = hasImageExtension;
exports.toImageWithInfo = toImageWithInfo;
exports.isDirectory = isDirectory;
exports.isFile = isFile;
exports.isImageFile = isImageFile;
exports.readImagesInDirectory = readImagesInDirectory;
exports.sortImagesByHeight = sortImagesByHeight;
exports.calculateImagesWithCoordinates = calculateImagesWithCoordinates;
exports.makeCanvas = makeCanvas;
exports.makeTiledImagesCanvas = makeTiledImagesCanvas;
exports.writeTileImage = writeTileImage;
exports.writeTileJson = writeTileJson;
exports.printStdOutput = printStdOutput;
exports.formatReScriptFile = formatReScriptFile;
exports.writeTileReScript = writeTileReScript;
exports.makeTiledImages = makeTiledImages;
/* fs Not a pure module */
