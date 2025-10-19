= Robust Statistics: Halfspace Depth

- If $q$ is outside the point cloud, you can draw a line such that almost all points are on one side and none on the other — so the depth is 0 or 1 → not central at all.

- If $q$ is inside, any line through it will have some points on both sides — the more balanced this always is, the higher the depth.

Show that there is always at least one point $q$ whose halfspace depth is $Omega(n)$ — meaning that its depth is proportional to $n$ (some constant fraction of $n$).

To prove this I can assume there're no 3 points on the same line. In order to prove that exists a function $Omega(n)$ I could show it with an algorithm.
