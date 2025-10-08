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
1. The first step requires to go through all the n nodes in order to calculate the middle point. $O(n)$ time.
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
  - $c_1 = 0$ and $c_2 = 1$
  - each point $p_i = (p_(i,x), p_(i,y))$ as a constraint $p_(i,x) x_1 + x_2 >= p_(i,y)$
  - $m = n$ (the number of points)
  
  We can see that the solution of this LP problem will give us the line with the maximum y-intercept that is above all the points, which is exactly what we want.
  Since we have $n$ constraints and we are in a 2 dimensional space, we can solve this LP problem in $O(n)$ time using Megiddo's algorithm.

3. As in step 1, we need to iterate through all the points to remove all of them not satisfying the condition (being above the bridge, $y >= u_x x + u_y$). $O(n)$ time. It's important to note the amount of remaining points is at most $n - 2$ since at least the two points forming the bridge will remain, as well as only the points on the convex hull can remain.
4. Finally the algorithm is called twice on the two new halves that have respectively at most $n/2$ points to analyze. We can give a better bound on the number of points, since we know that only the points on the convex hull can remain, and we know that the convex hull has $h$ points. So we can say that each half will have at maximum $n/2$ points but also at maximum $h-1$ points.

Putting everything together we can write the following recurrence relation:
$T(n, h) = T(n_1, h_1) + T(n_2, h_2) + O(n)$ where $n_1 + n_2 <= n - 2$ and $h_1 + h_2 <= h - 1$. Thus, if we take a closer look at the recursion tree we can see that we will have at maximum $h$ levels (since at each level we reduce the number of points on the convex hull by at least one) and at each level we do $O(n)$ work. So the total time will be $O(n log h)$.


*b. 
We consider $x_1 < dots < x_h$ the points of the upper hull and let $n_i$ be the number of points $p=(x,y)$ such that $x_i < x < x_(i+1)$ for $i = 1, ... , h-1$. Show that the upper hull computation in the Marriage before Conquest algorithm runs in time
$ O(sum_(i=1)^(h-1) n_i log (n / n_i)) $.*

To prove this we will use the same reasoning as before for the recurrence relation, but this time we will consider the number of points in each interval between two consecutive points on the convex hull.

We can write the following recurrence relation:
$T(n, h) = T(n_1, h_1) + T(n_2, h_2) + O(n)$ 

We cannot apply the Master Theorem directly since we have two variables, $n$ and $h$. However we can use the recursion tree to analyze the time complexity. The informal idea is that at each level of the tree we do $O(n_i)$ work (to check for all the points in the interval) that we need to do for each of the $h-1$ intervals. Because we are dealing with a binary tree, the height of the tree will be $O(log(n / n_i))$ for each interval. Thus, the total time will be the sum of the work done at each level of the tree for each interval, which is $O(sum_(i=1)^(h-1) n_i log (n / n_i))$.


