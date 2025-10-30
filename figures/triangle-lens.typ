#import "@preview/cetz:0.4.2"

#let tri(x, y, z, this-fill: rgb("#A7E8A680")) = {
  import cetz.draw: *
  line(x, y, z, close: true, fill: this-fill)
}
#let lens(e1, e2, l, r) = {
  import cetz.draw: *
  let fill = rgb("#90BBF080")
  arc-through(e1, l, e2, fill: fill)
  arc-through(e1, r, e2, fill: fill)
}
#let point(p, name, label-top: false) = {
  import cetz.draw: *
  circle(p, radius: 0.025, name: name)

  let origin = name+".south-east"
  let anchor = "north-west"
  if label-top {
    origin = (rel: (0, 0.02), to: name+".north")
    anchor = "south"
  }
  content(origin, name, anchor: anchor)
}
#let opposite-arc-through(t, i, b) = {
  import cetz.draw: *
  let center = cetz.util.calculate-circle-center-3pt(t, i, b)
  let radius = cetz.vector.dist(i, center)
  let temp = (center.at(0), center.at(1)-radius, 0)
  arc-through(b, temp, t)
}

#let triangle-lenses = cetz.canvas({
  import cetz.draw: *
  scale(x: 3, y: 3)
  grid(
    (0, 0),
    (4, 2),
  )

  // Case 1: triangle inside
  tri(
    (0.35, 0.40),
    (0.65, 0.40),
    (0.5, 0.65),
  )
  lens((0.5, 0.15), (0.5, 0.85), (0.30, 0.5), (0.70, 0.5))

  // Case 2: lens inside
  tri(
    (1.10, 0.15),
    (1.90, 0.15),
    (1.5, 0.9),
  )
  lens((1.5, 0.20), (1.5, 0.75), (1.37, 0.5), (1.63, 0.5))

  // Case 3: disjoint
  tri(
    (2.3, 0.25),
    (2.9, 0.1),
    (2.7, 0.6),
  )
  lens((2.1, 0.5), (2.5, 0.9), (2.37, 0.9), (2.45, 0.6))

  // Case 4: "one circle"
  tri(
    (3.15, 0.25),
    (3.65, 0.5),
    (3.15, 0.8),
  )
  lens((3.6, 0.20), (3.6, 0.80), (3.47, 0.5), (3.83, 0.5))

  // Case 5: "one side"
  tri(
    (0.15, 1.45),
    (0.85, 1.45),
    (0.5, 1.9),
  )
  lens((0.5, 1.1), (0.5, 1.80), (0.35, 1.5), (0.65, 1.5))

  // Case 6: "one vertex, two sides, 4 intersections"
  tri(
    (1.15, 1.25),
    (1.85, 1.25),
    (1.5, 1.8),
  )
  lens((1.5, 1.15), (1.5, 1.95), (1.35, 1.5), (1.65, 1.5))

  // Case 7: "no vertices, two sides, 4 intersections"
  tri(
    (2.15, 1.25),
    (2.85, 1.25),
    (2.7, 1.8),
  )
  lens((2.5, 1.15), (2.5, 1.95), (2.35, 1.5), (2.65, 1.5))

  // Case 8: "one vertex, two sides"
  tri(
    (3.15, 1.2),
    (3.85, 1.2),
    (3.5, 1.8),
  )
  lens((3.5, 1.70), (3.5, 1.15), (3.30,  1.5), (3.70, 1.5))
})

#let triangle-lens-intersection-example = cetz.canvas({
  import cetz.draw: *
  scale(x: 2.5, y: 2.5)

  tri(
    (0.4, 0.9),
    (1.6, 0.9),
    (1, 1.8),
  )
  let b = (1, 0.2, 0)
  let t = (1, 1.6, 0)
  let i = (0.7, 0.9, 0)
  let j = (1.3, 0.9, 0)
  lens(b, t, i, j)
  point(t, "T", label-top: true)
  point(i, "I")
  point(j, "J")

  set-style(stroke: (dash: "dashed"))
  line("T", "I")
  line("T", "J")
})
