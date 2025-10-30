= Robust Statistics: Halfspace Depth

Given a set of $n$ points $P$ in the plane, the halfspace depth of a point $q$ is defined as the minimum number of points of $P$ contained in any closed halfspace that contains $q$.

Show that there exists a point $q$ with halfspace depth at least $Omega(n)$.

Before starting the proof, we need to assume that we're bounding the considered area with a convex shape (a square) that contains all the points in $P$.

To prove that there exists a point $q$ with halfspace depth $Omega(n)$, we need to first divide the plane into two regions by a line $l$ such that each region contains at least $floor(n/2)$ points.
We consider $l$ as the vertical line situated on the median x-coordinate of the points in $P$. Thus, $l$ will have at least $floor(n/2)$ points on each side and which we regard as two separate sets of points.

By the 2-dimensional case of the *ham sandwich theorem*, also known as pancake theorem, we know that there exists a line $r$ that divides each one of two sets of points in half.

Assuming that there are no three points of $P$ on the same line, the two lines cannot be parallel:
if $r$ was vertical, then it would be either on the left side of $l$ or the right side, hence it couldn't split in half, respectively, the right set of points defined by $l$ or the right one. If $l = r$, then it wouldn't split any set.

Since the lines aren't parallel, there will be a point $q$ where they will intersect. The two lines will divide the plane in four regions and, by construction, each one of them will contain at least $floor(n/4)$ points of P.

Every line that goes through $q$ will divide the plane in two half-plane, and each one of them will contain at least a whole region defined by the two lines $l$ and $r$. Therefore, every half-plane defined by a line that goes through $q$ will contain at least $floor(n/4)$ points, hence $q$ has halfspace depth of at least $floor(n/4) = Omega(n)$

$square$

