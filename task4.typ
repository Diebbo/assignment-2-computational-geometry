= Robust Statistics: Halfspace Depth

Given a set of $n$ points $P$ in the plane, the halfspace depth of a point $q$ is defined as the minimum number of points of $P$ contained in any closed halfspace that contains $q$.

Show that there exists a point $q$ with halfspace depth at least $Omega(n)$.

Before starting the proof, we need to assume that we're bounding the considered area with a convex shape (a square) that contains all the points in $P$.

To prove that the there exists a point $q$ with halfspace depth $Omega(n)$, we need to first divide the plane in two regions by a line $l$ such that each region contains at least $n/2$ points.
For simplicity, we can assume that $l$ is vertical and it will divide along the median x-coordinate of the points in $P$.

Because we are looking for an $n/4$ upper bound, we are reducing the problem into showing the existence of a second line $ell$ such that it divides the two regions created by $l$ in two halves.

To do so, we will consider the dual of the points in $P$.

In the dual space, each point $p_i = (x_i, y_i)$ is represented by a line $l_i: y = x_i * x - y_i$. 

Therefore, we need to find a point $q*$ in the dual space such that:
- in the left half-plane ($x < x_"median"$): $q*$ is below at least $n/4$ lines
- in the right half-plane ($x > x_"median"$): $q*$ is above at least $n/4$ lines

By the 2 dimension variation of the Ham Sandwich Theorem, we know that there exists a line that divides two sets of points in two halves.

Hence, we can apply the theorem to the set of intersection points of the lines in the dual space with the vertical line $x = x_"median"$ and find a line that divides the intersection points in two halves.

By doing so, we are able to find the point $q*$ that satisfies the two conditions above.

// Finding the lines becomes easy as can be stated as an LP problem.

$square$

