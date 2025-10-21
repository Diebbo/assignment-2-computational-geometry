#import "@preview/cetz:0.4.2"
#import "figures/triangle-lens.typ": *

#set par(justify: true)

= Areas inside a polygon

*
Let $P$ be a polygon with $n$ vertices and $L$ be a lens.
Show that we can compute the total area of $L$ that lies inside $P$ in $O(n log n)$ time.
*

We know from the lectures that $P$ can be triangulated in $O(n log n)$ time into $n-2$ triangles.
Therefore, we just need to show that we can determine the area
of the intersection between a polygon and a lens in linear time.
Given a triangle and a lens, one can in constant time determine
the number and positions of the intersections between the perimeters of the two shapes.
Based on the number and "kind" of intersections,
the shapes can be put into one of several categories
(some examples can be found in @tri-lens-intersections).

#figure(
  triangle-lenses,
  caption: [Possible intersections between a triangle and a lens.],
) <tri-lens-intersections>

Based on the category, one can in constant time determine the area of the intersection.
Consider, for example, the first category.
Let $I,J$ be the points of intersection between
the two shapes' perimeters, on the left and right side respectively.
Let $C_l, C_r$ be the centers of the two circles on which $I$ and $J$ sit.
Let $T$ be the topmost intersection between the two circles bordering the lens.

Then, the area of the intersection between the two shapes is the sum of the following:
- the area of the triangle $"ITJ"$;
- the area of the circular sector defined on the left circle by the chord $"IT"$;
- the area of the circular sector defined on the right circle by the chord $"TJ"$.

#figure(
  triangle-lens-intersection-example,
  caption: [Example area calculation for a single triangle.],
) <tri-lens-intersection-example>

Since we can triangulate $P$ in $O(n log n)$ time,
and for each of the $n-2$ triangles we can compute the area of its intersection with $P$ in $O(1)$ time,
that means that the algorithm runs in $O(n log n + n) = O(n log n)$ time.
