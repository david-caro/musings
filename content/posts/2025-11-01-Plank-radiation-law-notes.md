---
math: true
tags: ["physics", "quantum physics"]
title: "Planck's Radiation Law Notes"
date: 2025-11-01T18:17:10+01:00
draft: false
---

# Planck's radiation law

This law tells us the energy density of the radiation of a black body, given the
temperature of a black body, and usually one of the frequency of the light, or
it's wavelength ([wiki page](https://en.wikipedia.org/wiki/Planck%27s_law),
specially
[this section](https://en.wikipedia.org/wiki/Planck%27s_law#Correspondence_between_spectral_variable_forms)).

When using the frequency, it can be written like:

$$
\rho(\omega, T) = \frac{1}{\pi^2 c^3}\frac{\hbar \omega^3}{e^{\frac{\hbar \omega}{\kappa_B T}} - 1}
$$

Now, sometimes it's useful to have it depending on the wavelength instead of
$\omega$, but that transformation is not as simple as it would seem.

We have the equivalence:

$$
\omega = \frac{2\pi c}{\lambda}
$$

Now, a blind replacement would give (using also $\hbar = \frac{h}{2\pi}$):

$$
\rho(\lambda, T) \\
    = \frac{1}{\pi^2 c^3}\frac{\hbar \left(\frac{2\pi c}{\lambda}\right)^3}{e^{\frac{\hbar \frac{2\pi c}{\lambda}}{\kappa_B T}} - 1} \\
    = \frac{8\pi\hbar}{\lambda^3}\frac{1}{e^{\frac{2\pi\hbar c}{\lambda\kappa_B T}} - 1} \\
    = \frac{4h}{\lambda^3}\frac{1}{e^{\frac{hc}{\lambda\kappa_B T}} - 1} \\
$$

But this would be wrong! Well, kinda, let me explain.

The issue comes with what is the meaning of that formula. The full formula would
include a differential:

$$
\rho(\omega, T)d\omega = \frac{1}{\pi^2 c^3}\frac{\hbar \omega^3}{e^{\frac{\hbar \omega}{\kappa_B T}} - 1} d\omega
$$

So what we would want to do is to use lambda instead, that way we get:

$$
\rho(\omega, T)d\omega = \rho(\lambda, T)d\lambda
$$

And it's with that $d\lambda$ that issues come in. And there's two things to
keep into account:

- Remember from before $\omega = \frac{2\pi c}{\lambda}$
- These are energy distributions, both must be positive to have physical meaning

So from the first, we easily get $d\omega$:

$$
\frac{d\omega}{d\lambda} = \frac{d}{d\lambda}\frac{2\pi c}{\lambda} = - \frac{2\pi c}{\lambda^2}
$$

And from the second, when isolating the formula we want:

$$
\begin{align*}
    \rho(\lambda, T)d\lambda &= \rho(\omega, T)d\omega \\\\
    \rho(\lambda, T) &= \rho(\omega, T)\left|{\frac{d\omega}{d\lambda}}\right|\\\\
\end{align*}
$$

**Note that absolute value!** That is due to the second restriction above, the
energy has to still be positive!

With all this into account, we actually end up with the formula:

$$
\rho(\lambda, T) \\
    = \frac{8\pi hc}{\lambda^5}\frac{1}{e^{\frac{hc}{\lambda\kappa_B T}} - 1} \\
$$

That is a factor $\frac{1}{\lambda^2}$ of difference!
