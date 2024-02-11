// https://minecraft.fandom.com/wiki/Tint
// If you're reading this, here's a reminder to move this into a more sensible area, like having it be per generator somehow
type tint = {
  name: array<string>,
  color: string,
}

let grassTints = [
  {name: ["Badlands"], color: "#90814D"},
  {name: ["Desert"], color: "#BFB755"},
  {name: ["Jungle"], color: "#59C93C"},
  {name: ["Jungle Edge"], color: "#64C73F"},
  {name: ["Forest"], color: "#79C05A"},
  {name: ["Birch Forest"], color: "#88BB67"},
  {name: ["Dark Forest"], color: "#507A32"},
  {name: ["Swamp"], color: "#6A7039"},
  {name: ["Swamp (Cold)"], color: "#4C763C"},
  {name: ["Plains"], color: "#91BD59"},
  {name: ["Ocean"], color: "#8EB971"},
  {name: ["Mushroom Fields"], color: "#55C93F"},
  {name: ["Mountains"], color: "#8AB689"},
  {name: ["Snowy Beach"], color: "#83B593"},
  {name: ["Giant Tree Taiga"], color: "#86B87F"},
  {name: ["Taiga"], color: "#86B783"},
  {name: ["Snowy Tundra"], color: "#80B497"},
]

let foliageTints = [
  {name: ["Badlands"], color: "#9E814D"},
  {name: ["Desert"], color: "#AEA42A"},
  {name: ["Jungle"], color: "#30BB0B"},
  {name: ["Jungle Edge"], color: "#3EB80F"},
  {name: ["Forest"], color: "#59AE30"},
  {name: ["Birch Forest"], color: "#6BA941"},
  {name: ["Swamp"], color: "#6A7039"},
  {name: ["Plains"], color: "#77AB2F"},
  {name: ["Ocean"], color: "#71A74D"},
  {name: ["Mushroom Fields"], color: "#2BBB0F"},
  {name: ["Mountains"], color: "#6DA36B"},
  {name: ["Snowy Beach"], color: "#64A278"},
  {name: ["Giant Tree Taiga"], color: "#68A55F"},
  {name: ["Taiga"], color: "#68A464"},
  {name: ["Snowy Tundra"], color: "#60A17B"},
]

let waterTints = [
  {name: ["Most name"], color: "#3F76E4"},
  {name: ["Cold Ocean"], color: "#3D57D6"},
  {name: ["Frozen Ocean"], color: "#3938C9"},
  {name: ["Lukewarm Ocean"], color: "#45ADF2"},
  {name: ["Swamp"], color: "#617B64"},
  {name: ["Warm Ocean"], color: "#43D5EE"},
]

let dyeTints = [
  {name: ["Leather"], color: "#A06540"},
  {name: ["Black"], color: "#1D1D21"},
  {name: ["Red"], color: "#B02E26"},
  {name: ["Green"], color: "#5E7C16"},
  {name: ["Brown"], color: "#835432"},
  {name: ["Blue"], color: "#3C44AA"},
  {name: ["Purple"], color: "#8932B8"},
  {name: ["Cyan"], color: "#169C9C"},
  {name: ["Light Gray"], color: "#9D9D97"},
  {name: ["Gray"], color: "#474F52"},
  {name: ["Pink"], color: "#F38BAA"},
  {name: ["Lime"], color: "#80C71F"},
  {name: ["Yellow"], color: "#FED83D"},
  {name: ["Light Blue"], color: "#3AB3DA"},
  {name: ["Magenta"], color: "#C74EBD"},
  {name: ["Orange"], color: "#F9801D"},
  {name: ["White"], color: "#F9FFFE"},
]

type tints = {
  grass: array<tint>,
  foliage: array<tint>,
  water: array<tint>,
  dye: array<tint>,
}

let tints: tints = {
  grass: grassTints,
  foliage: foliageTints,
  water: waterTints,
  dye: dyeTints,
}
