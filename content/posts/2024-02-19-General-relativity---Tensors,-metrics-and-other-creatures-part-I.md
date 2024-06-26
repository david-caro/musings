---
title: "General relativity - Tensors, metrics and other creatures part I"
date: 2024-02-19T22:57:55+01:00
tags: [physics, "general relativity", maths]
math: true
---

Lately, I have started learning a bit about general relativity, and one of the
most basic concepts is a `tensor`, in this post I'll try to write down some
basic concepts.

## Some definitions

Note that all these definitions are of geometric entities that are independent
of the coordinates chosen to describe them. This will be very important as will
allow us to describe physics the same way independently of the coordinates and
generalize the results.

- [Field](<https://en.wikipedia.org/wiki/Field_(mathematics)>): We can
  informally define as a set of elements and two operations that given two
  elements of the set, return another one, being those operations addition and
  multiplication, with some properties:

  - Associativity:
    - $a + (b + c) = (a + b) + c$
    - $a*( b*c )=( a * b)*c$
  - Commutativity:
    - $a + b = b + a$
    - $a * b = b * a$
  - Distributivity:
    - $a * (b + c) = a * b + a * c$
  - Identity:
    - $\forall a \in F ; \exists \text{ } 0 \in F | 0 + a = a$
    - $\forall a \in F ; \exists \text{ } 1 \in F | 1 * a = a$
  - Inverse:
    - $\forall a \in F ; \exists \text{ } -a \in F | a + (-a) = 0$
    - $\forall a \in F ; \exists \text{ } a^{-1} \in F | a * a^{-1} = 1$

- [Scalar](<https://en.wikipedia.org/wiki/Scalar_(mathematics)>): This is each
  of the elements of a field, for example a complex number, or a real number.

- [Vector](<https://en.wikipedia.org/wiki/Vector_(mathematics_and_physics)>):
  It's a geometric entity that is defined by a magnitude and a direction,
  usually represented as a coordinate vector (set of coordinates from their
  field), for example a vector of dimension 4 would be
  $U = (3.5, 6.8i, 8.1 + 3i, 0)$ and often I'll refer to them with the symbol of
  the vector, and a superindex $U^\mu$ where the superindex goes from
  $0...\text{dim}(U)-1$ as a short version of the set of coordinates in a basis
  of the vector space ($U = U^\mu \hat{e}_{(\mu)}$)

- [Vector space $V$ over a field $F$](https://en.wikipedia.org/wiki/Vector_space#Definition_and_basic_properties):
  This is, similar to a field, it's a non-empty set of vectors, one binary
  operation, vector addition, $V\times V \rightarrow V$, that has the following
  properties (using arrows for vectors to avoid confusing them with scalars):

  - Associativity:
    $\vec{i} + (\vec{j} + \vec{k}) = (\vec{i} + \vec{j}) + \vec{k}$
  - Commutativity: $\vec{i} + \vec{j} = \vec{j} + \vec{i}$
  - Identity:
    $\forall \vec{k} \in V, \exists \text{ } \vec{0} \in V \text{ }| \vec{0} + \vec{k} = \vec{k}$
  - Inverse:
    $\forall \vec{v} \in V, \exists -\vec{v} \in V | \vec{v} + (-\vec{v}) = \vec{0}$

  And a binary function (scalar multiplication, $F\times V\rightarrow V$), with
  the properties:

  - Compatibility with scalar multiplication: $(ab)\vec{v} = a(b\vec{v})$
  - Identity: $1\vec{v}=\vec{v}$
  - Distributive with respective of vector addition:
    $a(\vec{v} + \vec{u}) = a\vec{v} + a\vec{u}$
  - Distributive with respective of field addition:
    $(a + b)\vec{v}=a\vec{v} + b\vec{v}$

- [One-form, covector, dual vector or linear form](https://en.wikipedia.org/wiki/Linear_form):
  It's a linear map from a vector space to it's field $\omega:V \rightarrow F$.
  Similarly as vectors, we usually will write them down as $\omega_\mu$, as the
  coordinates of that one-form in a basis of the dual space
  ($\omega = \omega_\mu\hat\theta^{(\mu)}$). Acting on a vector we have
  $\omega(V) = V^\mu\omega_\mu$.

  Note that we can now define vectors as a map from dual space to it's field
  $V(\omega)= \omega(V) = V^\mu\omega_\mu \in \real$

- [Dual space](https://en.wikipedia.org/wiki/Dual_space): Is the space generated
  by all the dual vectors.

- [Manifold](https://en.wikipedia.org/wiki/Manifold): In an informal way, a
  manifold is a topological space that resembles the Euclidean space (our common
  flat space) when you look closely. It has to be differentiable at any point.

- [Tangent vector of a curve on a manifold at a point](https://en.wikipedia.org/wiki/Tangent_vector):
  Given a parameterized curve on a manifold $x^\mu(\lambda)$ the tangent vector
  is: $V^\mu = \frac{dx^\mu}{d\lambda}$

- [Tangent space of a manifold at a point](https://en.wikipedia.org/wiki/Tangent_space):
  This is the vector space generated by all the tangent vectors of the manifold
  at that point.

- [Tangent bundle of a manifold](https://en.wikipedia.org/wiki/Tangent_bundle):
  this is the manifold created from the set of all the tangent spaces for each
  point in the manifold.

- [Coangent vector of a curve on a manifold at a point](https://en.wikipedia.org/wiki/Tangent_vector):
  This is just the dual vector of the tangent vector at that point.

- [Cotangent space of a manifold at a point](https://en.wikipedia.org/wiki/Tangent_space):
  And this as expected, the space generated by the cotangent vectors.

- [Cotangent bundle of a manifold](https://en.wikipedia.org/wiki/Cotangent_bundle):
  this is the manifold created from the set of all the cotangent spaces for each
  point in the manifold.

## Tensors

We can now generalize the concepts of vector, one-form and scalar into a tensor,
and define it as a multi-linear mapping, from 0 or more one-forms ($T^\*$), and
0 or more vectors ($T$), to a scalar in the field $F$:

$$
T : T^{\*}_1 \times ... \times T^{\*}_k \times T_1 \times ... \times T_l \rightarrow F
$$

We will say that the tensor if of rank (or type) $(k, l)$, where $k$ is the
number of one-forms, and $l$ the number of vectors it maps.

We can show the multi-linearity with the following equality for a $(1,1)$
tensor:

$$
T(a\omega + b\eta, cV + dW) = acT(\omega, V) + adT(\omega, W) + bcT(\eta, V) + bdT(\eta, W)
$$

### Tensor product and tensor vector space

We can defined the tensor product of two tensors, $T$ of rank $(k, l)$, and S of
rank $(m, n)$:

$$
T \otimes S (\omega^{(1)}, ..., \omega^{(k)}, ..., \omega^{(k+m)}, V^{(1}, ..., V^{(l)}, ..., V^{(l+n)})
\newline
= T(\omega^{(1)}, ..., \omega^{(k)}, V^{(1)}, ..., V^{(l)}) \times V(\omega^{(k+1)}, ..., \omega^{(K+m)}, V^{(l+1)}, ..., V^{(l+n)})
$$

With this, we can construct a vector space of all the tensors of a given rank
$(k, l)$, by taking the tensor product of the basis vector and the dual vectors:

$$
\hat{e}_{(\mu_1)}\otimes...\otimes \hat{e}\_{(\mu_k)} \otimes \hat\theta^{(\nu_1)} \otimes ... \otimes \hat\theta^{(\nu_l)}
$$

Then we have that in component notation, a tensor is:

$$
T = {T^{\mu\_1 ... \mu\_k}}_{\nu\_1 ... \nu_l}
\hat{e}\_{(\mu\_1)}\otimes...\otimes \hat{e}\_{(\mu_k)} \otimes \hat\theta^{(\nu\_1)} \otimes
... \otimes \hat\theta^{(\nu\_l)}
$$

And the shortcut notation will be ${T^{\mu_1 ... \mu_k}}_{\nu_1 ... \nu_l}$.

### Some common tensors

There's a bunch of examples, here's a few that we have introduced already and a
few we will look into in the future:

- $(0, 0)$: this would be just **a scalar**.
- $(0, 1)$: this is any vector, like **velocity**.
- $(1, 0)$: this is any one-form, a common one-form would be **the gradient** of
  a scalar (in several notations):
  $$
  d\phi=\frac{\partial{\phi}}{\partial{x_\mu}}\hat\theta_\mu
  = \nabla\phi
  = \begin{pmatrix}
  \frac{\partial{\phi}}{\partial{x_0}}, \\\\
  ..., \\\\
  \frac{\partial{\phi}}{\partial{x_\mu}}
  \end{pmatrix}
  = \phi_{,\mu}
  $$
- $(1, 1)$: an example of this kind of tensor is the **kronecker delta** (note
  that the order of the subindex and the superindex in this case does not
  matter),

  $$
  \delta^\mu_\nu =
  \begin{cases}
    1, & \text{if }\mu=\nu \\\\
    0, & \text{if }\mu\ne\nu \\
  \end{cases}
  $$

  Given a one-form, returns the same one-form, or given a vector returns the
  same vector (like the identity), and given a one-form and a vector returns a
  scalar.

- $(0, 2)$: The **metric** (that we'll see in a bit) is a very common example of
  this kind of tensor, and allows us to define the inner product (in different
  notations):

  $$
  \eta(V, W) = \eta_{\mu\nu}V^\mu W^\nu = \langle V, W \rangle = \langle V | W \rangle = V \cdot W
  $$

- $(2, 0)$: This could be the **inverse of the metric**, that we can define
  using the kronecker delta:
  $$
  \eta^{\mu\nu}\eta_{\nu\rho} = \eta_{\rho\nu}\eta^{\nu\mu} = \delta^\mu_\rho
  $$

## Flat spacetime - Minkowski space

Let's stop for a second, and get some physics in the mix. We can consider now
Euclidean space-time, where our coordinates are:

$$
x^\mu: \begin{cases}
x^0=ct \\\\
x^1=x \\\\
x^2=y \\\\
x^3=z \\\\
\end{cases}
$$

Here we choose to use units where $c=1$, then we can write a spacetime interval
between two events like:

$$
(\Delta s)^2 = -(c\Delta t)^2 + (\Delta x)^2 + (\Delta y)^2 + (\Delta z)^2
$$

### Metric

Defining the following tensor:

$$
\eta_{\mu\nu} = \begin{pmatrix}
-1 & 0 & 0 & 0 \\\\
0 & 1 & 0 & 0 \\\\
0 & 0 & 1 & 0 \\\\
0 & 0 & 0 & 1 \\\\
\end{pmatrix}
$$

We can simplify the formula for the interval between two events like:

$$
(\Delta s)^2 = \eta_{\mu\nu}\Delta x^\mu\Delta x^\nu
$$

We call that tensor the **metric** tensor, and specifically, the metric tensor
for the Euclidean space-time will be represented with $\eta$ (we'll use $g$ for
other spaces).

### Proper time

Now, one of the annoying things about our current definition of interval is that
it is negative for anything that moves slower than light, so we define instead
the **proper time**:

$$
(\Delta\tau)^2 = -(\Delta s)^2 = -\eta_{\mu\nu}x^\mu x^\nu
$$

This might look silly, but a great property of this proper time, is that it
**measures the time elapsed between two events as seen by an observer that is
moving between those events in a straight path**, and as such, it's independent
of the inertial reference frame chosen :)

It's also very interesting that **in spacetime, a straight path is the
longest**, that's where the paradox of the twins comes from, as the twin that
travels (and thus goes in a non-straight path) is the one that ages the
**least**, and it's the one that stays (that travels in a straight line, just
through time) is the one that ages the **most**.

### Line elements

But what about traveling in curves?

In order to travel in curves, just $\Delta s$ will not be enough, we have to get
infinitesimals of it, so we can define the **line element**:

$$
ds^2 = \eta_{\mu\nu}dx^\mu dx^\nu
$$

And we integrate over the prametrized curve $x^\mu(\lambda)$ (in Newtonian
physics we use $t$ as the parameter, but now we can use anything):

$$
\Delta s = \int{\sqrt{\eta_{\mu\nu}\frac{dx^\mu}{d\lambda}\frac{dx^\nu}{d\lambda}}d\lambda}
$$

As $\eta_{\mu\nu}$ is negative for timelike paths, we use the proper time
instead:

$$
\Delta \tau = \int{\sqrt{-\eta_{\mu\nu}\frac{dx^\mu}{d\lambda}\frac{dx^\nu}{d\lambda}}d\lambda}
$$

### Translations, rotations and boosts: Lorentz transformations

We can change to different frames in three different ways:

- Translations: shifting coordinates
- Rotations: just rotating in space, what it sounds like :)
- Boosts: adding a velocity

For translations, things are easy, as all we have to do is sum the difference to
get to the new coordinates (a prime index means a different frame/basis):

$$
x^\mu \rightarrow x^{\mu\prime} = \delta^{\mu\prime}_\mu(x^\mu + a^\mu)
$$

Where $a^\mu$ is the shift. And this keeps the intervals the same.

For rotations and boosts, for those we will have to use **Lorentz
transformations**, that are all the matrices that when multiplied by $x^\mu$
keep the interval invariant, this is:

$$
x^{\mu\prime} = \Lambda^{\mu\prime}_\nu x^\nu
$$

$$
(\Delta s)^2 = \eta_{\mu\nu}x^\mu x^\nu
= \eta_{\mu\prime\nu\prime}x^{\mu\prime}x^{\nu\prime} \\\\
= \eta_{\mu\prime\nu\prime}\Lambda^{\mu\prime}_\sigma x^\sigma \Lambda^{\nu\prime}\_{\rho} x^\rho
$$

So we have:

$$
\eta_{\mu\nu} = \Lambda^{\mu\prime}_\sigma \Lambda^{\nu\prime}\_{\rho} \eta\_{\mu\prime\nu\prime}
$$

A couple example Lorentz transformations:

- Rotation on the x-y plane:
  $$
  \Lambda^{\mu\prime}_\nu = \begin{pmatrix}
  1 & 0 & 0 & 0 \\\\
  0 & \cos{\theta} & \sin{\theta} & 0 \\\\
  0 & -\sin{\theta} & \cos{\theta} & 0 \\\\
  0 & 0 & 0 & 1 \\\\
  \end{pmatrix}
  $$

* Boost by $v = \tanh{\phi}$ (looks like a rotation on the time-x plane):

  $$
  \Lambda^{\mu\prime}_\nu = \begin{pmatrix}
  \cosh{\phi} & -\sinh{\phi} & 0 & 0 \\\\
  -\sinh{\phi} & \cosh{\phi} & 0 & 0 \\\\
  0 & 0 & 1 & 0 \\\\
  0 & 0 & 0 & 1 \\\\
  \end{pmatrix}
  $$

  This can be rewritten in a more usual way, where
  $\gamma = \frac{1}{\sqrt{1 - v^2}}$:

  $$
  \Lambda^{\mu\prime}_\nu = \begin{pmatrix}
  \gamma & -\gamma v & 0 & 0 \\\\
  -\gamma v & \gamma & 0 & 0 \\\\
  0 & 0 & 1 & 0 \\\\
  0 & 0 & 0 & 1 \\\\
  \end{pmatrix}
  $$

## Next post in the series

You can find the next part of this post
[here]({{<ref "/posts/2024-03-13-General-relativity-Tensors-part-II.md">}}).
