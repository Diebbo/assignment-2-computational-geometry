#import "@preview/arkheion:0.1.0": arkheion, arkheion-appendices

#show: arkheion.with(
  title: "Computational Geometry (2025) Theory Questions",
  authors: (
    (name: "Diego Barbieri", email: "au802245@uni.au.dk", affiliation: "Aarhus University"),
    (name: "Gioele Scandaletti", email: "au802245@uni.au.dk", affiliation: "Aarhus University"),
    (name: "Samuele Esposito", email: "au802245@uni.au.dk", affiliation: "Aarhus University"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract: [
    Answers to the theory questions project for the Computational Geometry course.
  ],
  // keywords: ("Cryptology", "Information Theory", "Entropy"),
)
#set cite(style: "chicago-author-date")
#show link: underline

#line(length: 100%)

= Analysis of Marriage before Conquest
*a. Show that the algorithm runs in $O(n log h)$ time.*

Let us recall the pseudocode of the algorithm:
```
MbC(P : ℓ, r):
1. Find median x-coordinate xm partition into Pℓ & Pr
2. Find the bridge, u_v, over x_m
3. Remove the points below the bridge
4. Recurse: MbC(Pℓ : ℓ, u_x) & MbC(Pr : v_x, r)
```

To prove that the total time is $O(n log h)$ we need to analyze each step of the function while also considering the recursive part.
1. By assuming that the points in the input array are already sorted by x-coordinate, finding the median can be done in $O(1)$ time. Partitioning the points into two halves can be done in $O(n)$ time by iterating through all the points and adding them to the left or right half depending on their x-coordinate. So the total time for this step is $O(n)$. The median point is called $p_m = (x_m, y_m)$.
2. The second point is a little less trivial than the rest of them. To achieve this goal in $O(n)$ time, we need to reduce the problem into Linear Programming. 

  Let's first remark how to set up a LP problem in a 2 dimensional space. We have two variables unknown $x_1, x_2$, and we want to maximise a function $c_1 x_1 + c_2 x_2$. At the same time we have a set of $m$ constraints:
  $
  a_(1,1) x_1 + a_(1,2) x_2 <= b_1 \
  a_(2,1) x_1 + a_(2,2) x_2 <= b_2 \
  dots \
  a_(m,1) x_1 + a_(m,2) x_2 <= b_m 
  $

  If we consider for our problem the following:
  - $x_1$ as the slope of the line
  - $x_2$ as the y-intercept of the line
  - $c_1 = -x_m $ (the slope of the line connecting the two median points), $c_2 = -1$ . They both have a negative sign because we want to minimize the $x_1 dot x_m + x_2$.
  - each point $p_i = (p_(i,x), p_(i,y))$ as a constraint $p_(i,x) x_1 + x_2 >= p_(i,y)$
  - $m = n$ (the number of points)
  
  We can see that the solution of this LP problem will give us the line with the minimum y-intercept in the coordinate $x=x_m$ that is above all the points, which is exactly what we want.
  Since we have $n$ constraints and we are in a 2 dimensional space, we can solve this LP problem in $O(n)$ time using Megiddo's algorithm.

  At last we calculate the two points $u$ and $v$ that are the point on the line with respectively the minimum and maximum x-coordinate.

3. As in step 1, we need to iterate through all the points to remove all of them not satisfying the condition (being under the bridge): $O(n)$ time. It's important to note the amount of remaining points is at most $n - 2$ since at least the two points forming the bridge will remain, as well as only the points on the convex hull can remain.

4. Finally the algorithm is called twice on the two new halves that have respectively at most $n\/2$ points to analyze.

Putting everything together we can write the following recurrence relation:
$T(n, h) = T(n_1, h_1) + T(n_2, h_2) + O(n)$ where $n_1 + n_2 <= n$ and $h_1 + h_2 = h - 1$ and $n_1 <= ceil(n / 2)$ and $n_2 <= floor(n \/ 2)$. 
Therefore, we can consider the worst case where no points can be removed in step 3, so we have $n_1 = n_2 = n \/ 2$ and $h_1 + h_2 = h - 1$. Thus we can simplify the relation to:
$T(n, h) = 2 T(n\/2, h - 1) + O(n)$.

At each level, there're at most $2^j$ subproblems, each of size at most $n/2^j$ and each removing one edge from the convex hull. There will be at most $h$ total considered subproblems. In the worst case, there will be exactly $2^j$ subproblems at level $j$. Hence, after $L$ levels, we have $>= 2^L$ edges removed from the convex hull (which has $h-1$ total edges) and when $2^L >= h$ the process ends. This means that the height of the recursion tree is at most $log(h)$.

At each level, we do $O(n)$ work, therefore the total time is $O(n log h)$.

*b. 
We consider $x_1 < dots < x_h$ the points of the upper hull and let $n_i$ be the number of points $p=(x,y)$ such that $x_i < x < x_(i+1)$ for $i = 1, ... , h-1$. Show that the upper hull computation in the Marriage before Conquest algorithm runs in time
$ O(sum_(i=1)^(h-1) n_i log (n / n_i)) $.*

Let us fix an interval $I_i = (x_i, x_(i+1))$ for some $i$ in $1, ..., h-1$, containing $n_i$ points.
After the first division, each recursive subproblem contains at most $n/2$ points. Therefore, at level $t$ of the recursion tree, any subproblem contains at most $n/2^t$ points.

A point belonging to bucket $i$ stops being processed once the recursion reaches a level $t_i$ such that $n/2^(t_i) <= n_i$. More formally, the interval $I_i$ is still being processed at level $t$ only if the corresponding subproblem contains more than $α n_i$ points, for some constant $α > 1$. Hence:

$
n/2^t > alpha n_i
=> 2^t < n/(α n_i)
=> t < log(n/n_i) + O(1)
$

Therefore, each point in bucket $i$ is processed at most $O(log(n\/n_i))$ times.
Since there are $n_i$ points in bucket $i$, the total amount of work for this bucket is $O(n_i log(n\/n_i))$. Summing over all buckets gives:

$
sum_(i=1)^(h-1) O(n_i log(n/n_i)) = O(sum_(i=1)^(h-1) n_i log(n/n_i))
$
