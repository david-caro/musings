---
math: true
tags: ["physics", "maths", "quantum physics"]
title: "De Broglie From Wavefunction"
date: 2026-09-08T08:28:14+02:00
draft: false
---

This is a small derivation of the De Broglie wavelength formula that I found kinda cute, and don't want to forget about.


We start with the wave equation of a free particle:

$$
\Psi(x, t) = Ae^{-i\(kx-\omega t\)}
$$

Here $k = \frac{2\pi}{\lambda}$ is the wave number, and $\omega$ the angular frequency.

Now we apply the operator momentum $\hat{p} = -i\hbar\partial_{x}$:

$$
\hat{p}\Psi(x, t) = -i\hbar\partial_x\Psi(x, t)= -i\hbar\[-ikAe^{-i\(kx-\omega t\)}\] = \hbar k\Psi(x, t)
$$


So we have that the eigenvalue of $\hat{p}$ is $\hbar k=\frac{2\pi\hbar}{\lambda} = \frac{h}{\lambda}$, and from here, we
just rearrange to get the original De Broglie postulate for the wavelength of a moving massive object:

$$
\lambda = \frac{h}{p}
$$



