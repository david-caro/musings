---
math: true
tags: ["physics", "quantum physics"]
title: "Rydberg Energy From Bohr Principles"
date: 2026-09-08T09:07:08+02:00
draft: false
---


This is another small derivation that I liked, starting from the Bohr postulates and classical mechanics,
we get to the formulas for the [Bohr radius](https://en.wikipedia.org/wiki/Bohr_radius) and the [Rydberg
energy](https://en.wikipedia.org/wiki/Rydberg_constant#Alternative_expressions).


The [Bohr postulates](https://en.wikipedia.org/wiki/Bohr_model) are:

* Electrons revolve around the nucleus in stationary orbits that do not decay, or radiate energy.
* Angular momentum is quantized: $L = n\hbar$ ($n$ being an integer $\ge 0$)
* Electrons do not absorve or emmit energy continuously, they only do so in "packets" jumping from one stable orbit to
  the next (absorving a photon) or to the previous (emmiting a photon).


With that in mind, we can consider an electron going around the nucleus in a circular orbit, balanced by the [Coulomb
force](https://en.wikipedia.org/wiki/Coulomb%27s_law), so the centripetal acceleration has to match it:

$$
m\frac{v^2}{r} = \frac{ke^2Z}{r^2}
$$

Note that we are considering only [**hydrogenic** atoms](https://en.wikipedia.org/wiki/Hydrogen-like_atom), this is,
atoms with only one electron, but $Z$ protons (thus the $e\dot Ze$ factor in the Columb force). Also, $e$ here is the
electron charge, $m$ is the mass of the electron and $k=\frac{1}{4\pi\epsilon_0}$ is the Columb constant.

With this, we can then use the second Bohr postulate to replace the velocity $v$:

$$
\begin{align*}
L &= mvr = n\hbar \\\\
v &= \frac{n\hbar}{rm} \\\\
m\frac{v^2}{r} &= \frac{m}{r}\left(\frac{n\hbar}{rm}\right)^2 = \frac{n^2\hbar^2}{mr^3} = \frac{ke^2Z}{r^2} \\\\
n^2\hbar^2 &= ke^2Zrm \\\\
r &= a_n = \frac{\hbar^2}{ke^2m}\frac{n^2}{Z} \\\\
\end{align*}
$$

And this is the Bohr radius \o/

From here, we can then get the total energy ($E_t$) of the electron ($T$ is the kinetic energy, and $V$ the potential
one, in this case, the Coulomb potential):

$$
\begin{align*}
E_t &= T + V \\\\
T &= \frac{1}{2}mv^2 = \frac{1}{2}\frac{ke^2Z}{r} \\\\
V &= -\frac{ke^2Z}{r} \\\\
E_t &= \frac{1}{2}\frac{ke^2Z}{r} - \frac{ke^2Z}{r} = -\frac{ke^2Z}{2r} = -\frac{1}{2}\left(\frac{ke^2}{\hbar}\right)^2\frac{Z^2}{n^2} \\\\
    &= -E_R\frac{Z^2}{n^2} \\\\
E_R &= \frac{1}{2}\left(\frac{ke^2}{\hbar}\right)^2
\end{align*}
$$

So here we have it! This $E_R$ factor is the Rydberg energy!

This was really useful as alternative to remembering the formula for it during exams xd
