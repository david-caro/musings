---
title: "General relativity - Tensors, metrics and other creatures part II"
date: 2024-03-13T22:20:20+01:00
tags: [physics, "general relativity", maths]
math: true
---

## Previous post in the series

If you did not check it out, the first part of this post is
[here]({{<ref "/posts/2024-02-19-General-relativity---Tensors,-metrics-and-other-creatures-part-I.md">}}).

## Tensors, revisited

### Playing with tensors

Some tensor definitions:

- [Symmetric tensor](https://en.wikipedia.org/wiki/Symmetric_tensor): Is a
  tensor in which the coordinates are the same by swapping any set of indices,
  for the first two indices:

  $$
  T_{\mu\nu\rho} = T_{\nu\mu\rho}
  $$

  For the last two:

  $$
  T_{\mu\nu\rho} = T_{\mu\rho\nu}
  $$

  For all of them:

  $$
  T_{\mu\nu\rho} = T_{\mu\rho\nu} = T_{\rho\mu\nu} = T_{\rho\nu\mu} = T_{\nu\mu\rho} = T_{\nu\rho\mu}
  $$

- [Antisymmetric tensor](https://en.wikipedia.org/wiki/Antisymmetric_tensor):
  similar to a symmetric tensor, but when one of the indices is swapped, the
  sign swaps too:

  $$
  T_{\mu\nu\rho} = - T_{\mu\rho\nu}
  $$

- [Trace](<https://en.wikipedia.org/wiki/Trace_(linear_algebra)>): This is the
  sum of all the diagonal coordinates (that is, the contraction on it's indices)
  of a $(1, 1)$ tensor, and it's denoted by the tensor letter without indices:

  $$
  T = {T^\nu}_\nu
  $$

  And for a $(0, 2)$ tensor it means the sum of the diagonal of the tensor
  **after raising one index**:

  $$
  T = {T^{\sigma}}\_{\sigma} = g^{\nu\sigma}T_{\nu\sigma}
  $$

And some operations:

- [Contraction](https://en.wikipedia.org/wiki/Tensor_contraction): Given a
  tensor of rank $(k, l)$, we can convert it into a tensor of rank $(k-1, l-1)$
  by summing over one upper index with a lower index:

  $$
  {S^{\mu\rho}}\_{\sigma} = {T^{\mu\nu\rho}}_{\sigma\nu}
  $$

  We will do this for many things, like multiplying matrices or the interior
  product. Note that in general, it does matter which of the upper indices is
  contracted with which of the lower indices:

  $$
  {T^{\mu\nu\rho}}\_{\sigma\nu} \neq {T^{\mu\rho\nu}}\_{\sigma\nu}
  $$

- [Raising and lowering indices](https://en.wikipedia.org/wiki/Raising_and_lowering_indices):
  Using contraction and the metric, we can raise or lower an index from a
  tensor:

  $$
  {T^{\mu\nu\rho}}\_{\sigma} = {\eta^{\mu\gamma}}{T^{\nu\rho}}\_{\gamma\sigma}
  $$

  This with the inverse of the metric, gives an easy way to turn vectors into
  one-forms and viceversa:

  $$
    V_\mu = \eta_{\rho\mu}V^\rho \\\\
    \omega^\mu = \eta^{\rho\mu}\omega_\mu
  $$

- Symmetrization: You take the sum of all the permutations, and divide by the
  number of elements, denoted by $\left(...\right)$ around the symmetrized
  indices:
  $$
  {T_{(\nu_1\nu_2...\nu_{n})\mu}}^{\rho}
  = \frac{1}{!n}\left(
  {T_{\nu_1\nu_2...\nu_{n}\mu}}^{\rho} + {T_{\nu_2\nu_1...\nu_{n}\mu}}^{\rho} + ...
  \right)
  $$
- Antisymmetrization: Similar to symmetrization, but substracting the elements
  with odd number of changes in the indices, denoted by $[...]$ around the
  antisymmetrized indices:
  $$
  {T_{[\nu_1\nu_2...\nu_{n}]\mu}}^{\rho}
  = \frac{1}{!n}\left(
  {T_{\nu_1\nu_2\nu_3...\nu_{n}\mu}}^{\rho} - {T_{\nu_2\nu_1\nu_3...\nu_{n}\mu}}^{\rho} + {T_{\nu_2\nu_3\nu_1...\nu_{n}\mu}}^{\rho} ...
  \right)
  $$

## Curved space

### [Riemann manifolds](https://en.wikipedia.org/wiki/Riemannian_manifold)

We introduced a manifold as a space that when looked closely resembles euclidean
space. But we could think of it also as a set (of anything) that can be
parametrized in a continuous way, of which the parameters are the coordinates,
and the number of parameters the dimension of the manifold.

For general relativity, we will focus only on differentiable manifolds, and from
those, the ones that have a metric defined, these are called **Riemann
manifolds**.

This metric has to be a $
\begin{pmatrix}
0 \\\\
2
\end{pmatrix}
$ symmetric tensor,
and as our metric is indefinite ($g(V,V)$ can be positive, negative or 0), this
would actually be a **pseudo-Riemann manifold**.

We want that when looked closely, the space should resemble the flat space. To
achieve that, the metric should have the same trace than the $\eta$ of flat
space (that is, ${g^\alpha}\_\alpha = +2$), that way, as the metric is
symmetric, we can always find a coordinate transformation that will give the
flat space metric.

But, this does not extend to the whole space, so we will have that at any point
$P$ we can find a metric that resembles the flat space metric up to the second
derivative:

$$
g\_{\alpha\beta}(P) = \eta\_{\alpha\beta} \\\\
g\_{\alpha\beta,\gamma}(P) = 0 \\\\
g\_{\alpha\beta,\gamma\lambda}(P) \neq 0 \\
$$

### [Christoffel symbol](https://en.wikipedia.org/wiki/Christoffel_symbols)

There's several things that get more complicated in a curved space, and one of
them is the partial derivatives. These are very useful, but they are not
tensorial, thus they can't be generalized to any coordinate system inside the
curved manifold (our goal with most of our objects).

So we want a tensorial expression of the partial derivative, that in flat
spacetime gives the partial derivative as we know it. To do so, we have to
introduce first the **Christoffel symbol**, this is what wil give us a way to
connect vectors from different tangent spaces in nearby points of the manifold
(what is called a **connection**).

These can be defined from the metric $g$:

$$
\begin{align}
\Gamma^\lambda\_{\mu\nu} = \frac{1}{2}g^{\lambda\sigma}(\partial\_\mu g\_{\nu\sigma} + \partial\_\nu g\_{\sigma\mu} - \partial\_\sigma g\_{\mu\nu}) = \frac{1}{2}g^{\lambda\sigma}(g\_{\nu\sigma,\mu} + g\_{\sigma\mu,\nu} - g\_{\mu\nu,\sigma})
\end{align}
$$

Note that the Christoffel symbol is **not** a tensor, that's why it's called
_symbol_.

### [Covariant derivative](https://en.wikipedia.org/wiki/Covariant_derivative)

With the Christoffel symbol at hand, we can define a generalized version of the
partial derivative, that will be a tensorial object (note the two different
notations, some books will use one or the other). The covariant derivative for a
vector is:

$$
\{{V^\lambda}\_{;\mu}} = \nabla_\mu V^\lambda = {V^\lambda}\_{,\mu} + V^\sigma\Gamma^\lambda\_{\sigma\mu}
$$

The second term comes from the fact that in a curved spacetime, the basis
vectors of a space do not remain constant, so in a flat spacetime with cartesian
coordinates, we will have that the Christoffel symbols vanish
$\Gamma^\lambda\_{\mu\nu} = 0$ (in polar coordinates the basis vectors are not
constant, so they Christoffel symbols don't vanish).

For a one-form we will have:

$$
\{p_{\lambda;\mu}} = \nabla_\mu p = p_{\lambda,\mu} - p_\nu\Gamma^\nu\_{\lambda\mu}
$$

Essentially, for every upper index, we get a positive Christoffel symbol, and
for each lower a negative one, so we can generalize it for any tensor:

$$
\{T^{\mu\_1\mu\_2...\mu\_j}}\_{\nu\_1\nu\_2...\nu\_k;\lambda} = \{T^{\mu\_1\mu\_2...\mu\_j}}\_{\nu\_1\nu\_2...\nu\_k,\lambda} \\\
\+ \{T^{\rho\mu\_2...\mu\_j}}\_{\nu\_1\nu\_2...\nu\_k}\Gamma^{\mu\_1}\_{\lambda\rho} \+ \{T^{\mu\_1\rho...\mu\_j}}\_{\nu\_1\nu\_2...\nu\_k}\Gamma^{\mu\_2}\_{\lambda\rho} \+ ... \\\
\- \{T^{\mu\_1\mu\_2...\mu\_j}}\_{\rho\nu\_2...\nu\_k}\Gamma^{\rho}\_{\lambda\nu\_1} \- \{T^{\mu\_1\mu\_2...\mu\_j}}\_{\nu\_1\rho...\nu\_k}\Gamma^{\rho}\_{\lambda\nu\_2} \- ...
$$

### [Parallel transport](https://en.wikipedia.org/wiki/Parallel_transport)

Now, in a curved manifold, the usual notion of parallel vectors loses meaning.
To regain a more generic sense of parallelism, we will have to introduce what's
called **parallel transport**, this takes advantage that we can still talk about
local parallelism and that a curve has infinite points that are together close
enough so we can consider them in the same flat space.

A bit more clearly, we would say that a vector $\vec{V}$ is parallel transported
along a curve if for infinitesimally close points we move the vector in a way
that makes the previous and next steps parallel to each other, and of the same
magnitude. Note that it might still be that for non-infinitesimally close
points, the vectors might change direction and/or magnitude.

Putting this in equations, given then a tangent vector to a parametrized curve
at a point $P$, $\vec{T} = \frac{d\vec{x}}{d\lambda}$, and a vector at that
point $\vec{V}$:

$$
\frac{dV^\mu}{d\lambda} = T^\nu {V^\mu}\_{,\nu} = T^\nu {V^\mu}_{;\nu} = 0 \quad \text{at} \quad P
$$

Where the first two equalities depend on the coordinates chosen, but the last
equality is a tensorial expression, valid on all basis.

### [Geodesics](https://en.wikipedia.org/wiki/Geodesic)

Given the last equality in the parallel transport, we can define a new type of
curves, the ones that are as "straight" as possible, by demanding that they
parallel transport their own tangent vector. This is a generalization of a
straight line in flat space.

Put in formula, for a tangent vector $T$ and a parameter $\lambda$ we have:

$$
T^\mu = \frac{dx^\mu}{d\lambda} \\\\
T^\nu\frac{\partial}{\partial{x^\nu}} = \frac{d}{d\lambda} \\\\
T^\mu{T^\nu}\_{;\mu} = 0 \quad \text{; parallel transport of T} \\\\
\frac{d}{d\lambda}\left(\frac{dx^\mu}{d\lambda}\right) + {\Gamma^\mu}_{\rho\nu}\frac{dx^\rho}{d\lambda}\frac{dx^\mu}{d\lambda} = 0
$$

And this last formula is called the **geodesic formula**. Given a set of initial
conditions (position and direction), you get only one solution, a geodesic.
Though you can define many different parameters $\lambda$ that solve this
equation, but all of them will be linear transformations of each other, and all
are called **affine** parameters.

### [Riemann curvature tensor](https://en.wikipedia.org/wiki/Riemann_curvature_tensor)

Imagine now that we have a two curves that intersect, and we duplicate both of
them creating two more curves very close to the original ones, giving a small
"square". And that we have a vector on one of the corners. If we parallel
transport it around the "square" shape, we find that the change in the vector
after the transport, is linearly dependent on the area of the "square", and the
magnitude of the original vector by the proportion:

$$
\begin{align}
{R^\mu}\_{\nu\rho\sigma} :=
{\Gamma^\mu}\_{\nu\sigma,\rho}
\- {\Gamma^\mu}\_{\nu\rho,\sigma}
\+ {\Gamma^\mu}\_{\alpha\rho}{\Gamma^\alpha}\_{\nu\sigma}
\- {\Gamma^\mu}\_{\alpha\sigma}{\Gamma^\alpha}\_{\nu\rho}
\end{align}
$$

And this is characteristic of the curvature of the space, so much that we'll
call it **Riemann curvature tensor**. Note that ${R^\mu}_{\nu\sigma\rho} = 0$
for flat manifolds

Another way of expressing the Riemann curvature tensor, is as the commutator of
the covariant derivatives of the tensor, for a $ \begin{pmatrix} 1 \\\\ 1
\end{pmatrix} $ tensor:

$$
\begin{align}
\left[\nabla\_\mu , \nabla\_\nu\right]{T^{\rho}}\_\sigma
= {R^{\rho}}\_{\lambda\mu\nu}{T^{\lambda}}\_{\sigma}
\+ {{R\_\sigma}^\lambda}\_{\mu\nu}{T^{\rho}}\_\lambda
\end{align}
$$

Where we have one Riemann tensor for each index in the tensor $T$.

We can derive some identities out of it, if we look at it at the local inertial
frame at point $P$, and taking advantage that the Christoffel symbols vanish
(not the derivatives though), the symmetry of the metric and the fact that
partial derivatives commute, we end up with:

$$
R\_{\mu\nu\rho\sigma}
= g\_{\mu\lambda}{R^\lambda}\_{\nu\rho\sigma}
= \frac{1}{2}\left(
  g\_{\mu\sigma,\nu\rho}
  \- g\_{\mu\rho,\nu\sigma}
  \+ g\_{\nu\rho,\mu\sigma}
  \- g\_{\nu\sigma,\mu\rho}
\right)
$$

and in this form, we easily get:

$$
\begin{align}
R\_{\mu\nu\rho\sigma} = -R\_{\nu\mu\rho\sigma} = -R\_{\mu\nu\sigma\rho} = R\_{\sigma\rho\mu\nu} \\\\
R\_{\mu\nu\rho\sigma} + R\_{\mu\sigma\nu\rho} + R\_{\mu\rho\sigma\nu} = 0
\end{align}
$$

#### [Geodesic deviation](https://en.wikipedia.org/wiki/Geodesic_deviation)

When you have two geodesics that start parallel in a curved space, they do not
remain parallel in general, and the deviation of the two can be summarized with
the **geodesic deviation equation** as follows:

$$
\begin{align}
\nabla\_T\nabla\_T X^\mu = {R^\mu}_{\nu\rho\sigma}T^\nu T^\rho X^\sigma
\end{align}
$$

Where $T$ is the tangent vector of the geodesic and $X$ is the vector connecting
one geodesic to the other at regular intervals of the affine parameter $\lambda$
($X^\mu = dx^\mu/d\lambda$).

### [Bianchi identities](https://en.wikipedia.org/wiki/Curvature_form#Bianchi_identities)

If we do the partial derivative of the Riemann tensor ($(2)$) with respect to
$x^\lambda$, keeping the result in a local lorentz frame
(${\Gamma^\mu}_{\nu\rho} = 0$), keeping in mind that
$g\_{\mu\nu} = g\_{\nu\mu}$, and that partial derivatives commute, we end up
with:

$$
\begin{align}
R\_{\mu\nu\rho\sigma;\lambda} + R\_{\mu\nu\lambda\rho;\sigma} + R\_{\mu\nu\sigma\lambda;\rho} = 0
\end{align}
$$

This is the a tensor equation called **Bianchi identities**, and as such is
valid in any system.

### [Ricci tensor and scalar](https://en.wikipedia.org/wiki/Ricci_curvature)

When contracting the Riemann tensor on the first and thrird indices, we get the
**Ricci tensor**:

$$
\begin{align}
R\_{\mu\nu} = {R^{\rho}}\_{\mu\rho\nu} = R\_{\nu\mu}
\end{align}
$$

Other contractions give either $0$, or $\pm R_{\mu\nu}$.

When contracting the Ricci tensor with the metric, we get the **Ricci scalar**:

$$
\begin{align}
R = g^{\mu\nu}R\_{\mu\nu} = g^{\mu\nu}g^{\rho\sigma}R\_{\rho\mu\sigma\nu}
\end{align}
$$

### [Einstein tensor](https://en.wikipedia.org/wiki/Einstein_tensor)

By using the Ricci contractions on the Bianchi identities twice, we end up with
the
[**twice-contacted Bianchi identities**](https://en.wikipedia.org/wiki/Contracted_Bianchi_identities):

$$
\begin{align}
(2{R^\mu}\_\nu - {\delta^\mu}\_\nu R)\_{;\mu} = 0
\end{align}
$$

And looking at these, we can come up with a symmetric tensor:

$$
G^{\mu\nu} = R^{\mu\nu} - \frac{1}{2}g^{\mu\nu}R = G^{\nu\mu}
$$

That makes $(10)$ end up:

$$
{G^{\nu\mu}}\_{;\mu} = 0
$$

Telling us that $G^{\mu\nu}$, that we call **Einstein tensor** is divergence
free, and constructed directly from the Riemann tensor and the metric.

This will be very important when solving the Einstein field equations.

## Next post in the series

Will be delayed a bit, but it's being worked on!
