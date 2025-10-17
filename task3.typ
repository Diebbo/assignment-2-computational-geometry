
= Stabbing Segments

#let l = $cal(l)$
#let ss = $cal(S)$
#let vv = $cal(v)$

Let #ss be a set of $n$ line segments in the plane. We say #ss can be
stabbed if there exists a line $cal(l)$ that intersects all the segments in #ss.

*a. Show that if all the line segments in #ss are vertical, then we can decide whether #l exists or not in $O(n)$ time.*

We define the line #l as $y = m x + q$. To check whether the line #l intersects a vertical segment #vv, that can be defined as a triplets $(x_vv, y^1_vv, y^2_vv)$ where $y^1_vv < y^2_vv$, we need to check whether the following condition holds: 
$y^1_vv <= m x_vv + q <= y^2_vv$.

Therefore, we can define an LP problem, that will actually be just a constraint problem:
- Maximise: $0$
- Subject to the constraints:
  - $m x_vv + q >= y^1_vv$ $quad forall$ #vv in #ss
  - $m x_vv + q <= y^2_vv$ $quad forall$ #vv in #ss

The function to maximise is actually irrelevant, since we just want to check whether the constraints can be satisfied.

Since this is an LP problem in a 2 dimensional space with $2n$ constraints, we can solve it in $O(n)$ time using Megiddo's algorithm. If the LP problem has a solution, then the line #l exists, otherwise it doesn't.

*b. Show that in general, where the line segments can have arbitrary orientations, in $O(n^2)$ time we can decide if such a line #l exists.*

For showing this, we will use a theorem: \

*Theorem 1*:
If it exists a line #l that stabs a set of segment #ss, then there exists a line $#l'$ that stabs #ss and passes through at least one endpoint of segments in #ss.

*Proof of Theorem 1*:
/* The proof is too long to fit in the margin, so we'll skip it */


/* Bruh */
Let us assume that there exists a line #l that stabs a set of segments #ss, and that #l doesn't pass through any endpoint of segments in #ss. We can then choose a fixed point $P$ on the line and rotate the line #l around this point, until it passes through an endpoint of a segment in #ss. Since the line was intersecting all the segments before the rotation, and we rotated it around its center, it will still be intersecting all the segments after the rotation. Therefore, we have found a line $#l'$ that stabs #ss and passes through at least one endpoint of segments in #ss.
If, after the rotation, the line isn't intersecting all the segments anymore, this means we already passed through an endpoint, hence having already obtained a valid line $#l'$. 

It's also possible to apply this proof again, choosing as point $P$ the endpoint of a segment in #ss that intersects the new-found line, and rotating the line around this point until it passes through another endpoint of a segment in #ss. This way we can find a line $#l''$ that stabs #ss and passes through at least two endpoints of segments in #ss.

Using *Theorem 1*, we can now show how to solve the problem in $O(n^2)$ time.
We start by choosing an endpoint $P$ of a segment in #ss. Then, for each other segment in #ss, we consider its two endpoints, and we compute the line #l passing through $P$ and the considered endpoint. This will define an interval for the slope $m$ of the line #l, such that all the lines with slope $m$ in this interval will intersect the considered segment. We then intersect all these intervals, and if the intersection is non-empty, we can choose any slope $m$ in this intersection, and compute the corresponding y-intercept $q$ such that the line #l with slope $m$ and y-intercept $q$ passes through the point $P$. This line #l will then intersect all the segments in #ss.
Otherwise, if the intersection of all the intervals is empty, we choose another endpoint $P$ of a segment in #ss and repeat the process. If we exhaust all the endpoints in #ss without finding a valid line #l, then such a line doesn't exist.

Since there are $2n$ endpoints in #ss, and for each endpoint we need to consider $2(n-1)$ other endpoints, the total time complexity of this algorithm is $O(n^2)$.
