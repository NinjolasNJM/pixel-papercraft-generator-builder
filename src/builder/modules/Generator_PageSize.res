type size = {width: int, height: int}

type t = {px: size, mm: size}

let a4: t = {
  px: {width: 595, height: 842},
  mm: {width: 210, height: 297},
}

let a4Triple: t = {
  px: {width: 1785, height: 2526},
  mm: {width: 210, height: 297},
}

let a3: t = {
  px: {width: 842, height: 1190},
  mm: {width: 297, height: 420},
}
