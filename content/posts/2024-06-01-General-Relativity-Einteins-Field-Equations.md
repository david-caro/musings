---
math: true
tags: ["physics", "general relativity", "gravitation"]
title: "General Relativity Einstein's Field Equations"
date: 2024-06-01T16:38:40+02:00
draft: true
---

## Previous post in the series

If you did not check it out, the first part of this post is
[here]({{<ref "/posts/2024-03-13-General-relativity-Tensors-part-II.md">}}).

## Reminder of Newnonian field equations

In Newnonian gravity, the field equations can be described with the Poisson
equation:

$$
\nabla^2\Phi = 4\pi G\rho
$$

Where $\rho$ is the mass density, and $\nabla^2=\lambda^{ij}\delta_i\delta_j$ is
the Laplace operator.

This tells us how matter generates the field, but there's another formula that
tells us how that field affects matter, the acceleration from the gravitational
potential:

$$
\bm{a} = -\nabla\bm{\Phi}
$$

Now we want to find the equivalent of those formulas for general relativity.

First let's talk a bit on how to generalize any physics law and then we will
apply that to gravitation.

## Generalizing to curved space-time

One way to generalize laws of physics from flat to curved space-time, is usually
to:

- Take a law of physics valid in inertial coordinates.
- Write in in tensorial form (coordinate-invariant).
- The resulting law is now valid in curved space-time (ta-da!)

Let's put that to the test.

### Freely-falling particle

So in Newnonian gravity, we describe a freely falling particle (unaccelerated)
as the one for which the second derivative of the path $x^\mu(\lambda)$
vanishes:

$$
\frac{d^2 x^\mu}{d\lambda^2} = 0
$$

The issue here is that $\lambda$ might depend on one or more of $x^\mu$, so the
equation expanded is actually:

$$
\frac{dx^\nu}{d\lambda}\partial_\nu\frac{dx^\mu}{d\lambda} = 0
$$

So in order to make this tensorial, we have to replace that partial derivative
with a covariant one instead:

$$
\frac{dx^\nu}{d\lambda}\nabla_\nu\frac{dx^\mu}{d\lambda}
\= \frac{dx^\nu}{d\lambda}\(\frac{dx^\mu}{d\lambda} \+ \Gamma^{\mu}\_{\rho\sigma}\frac{dx^\sigma}{d\lambda}\)
\= \frac{d^2 x^\mu}{d\lambda^2} \+ \Gamma^{\mu}\_{\rho\sigma}\frac{dx^\rho}{d\lambda}\frac{dx^\sigma}{d\lambda}
\= 0
$$

And this, is the geodesic equation we saw before :)

### Energy-momentum conservation

In flat space-time, energy-momentum is conserved:

$$
\partial_\mu T^{\mu\nu} = 0
$$

And a very stright-forward generalization of this is just to use the covariant
derivative instead of the partial one:

$$
\nabla_\mu T^{\mu\nu} = 0
$$

And voila! We got a law valid for curved space-time too.

### Verifying that we still describe gravity

We can now validate that the equations that we have generalized, still describe
gravity by looking into their behavior when we approach the **Newnonian limit**,
this is:

- weak gravitational field
- particles are moving slowly with respect to light
- static gravitational field

The first point allows us to define the metric as the Minkowski one plus a small
perturbation ($1 >> h_{\mu\nu}$), that we can think of a $(0,2)$ tensor field
propagating in flat space:

$$
g_{\mu\nu} = \eta_{\mu\nu} + h_{\mu\nu}
$$

And we can discard any term of second order or higher on $h$ (**linearize**).

The second point means that $\frac{dt}{d\tau} >> \frac{dx^i}{d\tau}$, allowing
us to simplify the geodesic equation to one with only the $\Gamma^{\mu}_{00}$
components of the Christoffel symbols, and given that the field is static (third
point), we can discard any derivative of time:

$$
\Gamma^{\mu}_{00}
= \frac{1}{2} g^{\mu\lambda}(\partial\_0g\_{\lambda 0} + \partial\_0g\_{0\lambda} - \partial\_\lambda g\_{00})
= -\frac{1}{2} g^{\mu\lambda}\partial\_\lambda g\_{00}
= -\frac{1}{2} \eta^{\mu\lambda}\partial\_\lambda h\_{00}
$$

Plugging this back into the full geodesic equation:

$$
\frac{d^2 x^\mu}{d\tau^2} = \frac{1}{2}\eta^{\mu\lambda}\partial\_\lambda h\_{00}\left(\frac{dt}{d\tau}\right)^2
$$

With this, given that $\partial_0 h_{00} = 0$ and focusing only on $\mu = 0$, we
get:

$$
\frac{d^2t}{d\tau^2} = 0
$$

And for the other space-like components we get:

$$
\frac{d^2 x^i}{d\tau^2} = \frac{1}{2}\left(\frac{dt}{d\tau}\right)^2 \partial\_i h\_{00}
$$

Moving $\left(\frac{dt}{d\tau}\right)^2$ to the other side:

$$
\frac{d^2 x^i}{d\tau^2}\left(\frac{d\tau}{dt}\right)^2
=  \frac{d^2 x^i}{dt^2}
= \frac{1}{2}\partial\_i h\_{00}
$$

And recalling the formula for the acceleration in a Newnonian gravitational
field we have:

$$
\frac{d^2 x^i}{dt^2}
= \frac{1}{2}\partial\_i h\_{00}
= -\nabla\Phi
$$

From which we can see that as we suspected this new formulation describes
Newnonian gravity if:

$$
h_{00} = -2\Phi
$$

And giving us the $00$ component of the metric:

$$
g\_{00} = (2\Phi - 1)
$$

## Searching for the field equations

Let's go back to the Newnonian field equation:

$$
\nabla^2\Phi = 4\pi G\rho
$$

Here we can see some structure:

- On the left hand side: Second order differential equation on the potential
- On the right hand side: mass density

Trying to make this tensorial, we would have something like:

$$
O(\bm{g}) = k\bm{T}
$$

We will see later that there's an extra term we can add $\Lambda g_{\mu\nu}$,
that will account for the **vacuum energy** ($\Lambda$ is called the
**cosmological constant**).But for now let's assume it's not there (or that
$\Lambda = 0$).

On the right hand side we have a $(0,2)$ tensor, so on the left hand side we
should have one too.

We can try using the d'Alembertian on the metric (wave operator,
$\Box\bm{g} = \nabla^\mu\nabla_\nu\bm{g}$) but the covariant derivative of the
metric always vanishes (we define the connection according to that). So we
should find something else.

What about the Ricci tensor $R_{\mu\nu}$? It has first and second derivatives of
the metric and it does not vanish yay \o/, let's roll with that:

$$
R_{\mu\nu} = kT_{\mu\nu}
$$

Let's double check the conservation of energy restriction:

$$
\nabla^\mu T_{\mu\nu} = 0 \rightarrow \nabla^\mu R_{\mu\nu} = 0
$$

And by the Bianchi identity (see [previous
post]({{<ref "/posts/2024-03-13-General-relativity-Tensors-part-II.md">}}). ) we
have:

$$
\nabla^\mu R_{\mu\nu} = \frac{1}{2}\nabla_\nu R
$$

So, taking into account the last three equations:

$$
\frac{1}{2}\nabla_\rho R = \frac{1}{2} \nabla_\rho g^{\mu\nu}R_{\mu\nu} =
\frac{1}{2} \nabla_\rho kg^{\mu\nu}T_{\mu\nu} = \frac{k}{2} \nabla_\rho T = 0
$$

And given that $T$ is a scalar, $\nabla_\rho T$ is just the partial derivative,
and $\nabla_\rho T = 0$ just tells us that T is constant everywhere.

This is ok for the vacuum, but definitely $T \neq 0$ inside matter, so close
enough but we have to find something else.

We can try instead Einstein's tensor (trace-reversed Ricci tensor):

$$
G\_{\mu\nu} = R\_{\mu\nu} - \frac{1}{2}Rg\_{\mu\nu}
$$
