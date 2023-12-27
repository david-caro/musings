---
title: "Quantum Physics - Free Particle 1d"
date: 2023-12-22T11:17:27+01:00
tags: [physics, "quantum physics", "jupyter notebook", python]
math: true
---

Today let's have a look to a single particle, going around without any potential. So we get the same time-independent Schrödinger equation as we got inside the [infinite square well]({{<ref "2023-12-19-quantum-physics-infinite-well-1d/index.md#inside">}}):

$$
-\frac{\hbar^2}{2m}\frac{d^2\psi}{dx^2} = E\psi
$$

A single solution for this is the same as for the infinite well, but this time we will use the exponential form, as that will help us later:

$$
\psi(x) = Ae^{ikx} + Be^{-ikx} \hspace{0.5cm}\text{where }k\equiv\frac{\sqrt{2mE}}{\hbar}
$$

Now adding the time dependent bits (the "wiggle factor"):

$$
\psi(x) = Ae^{ik\left(x - \frac{\hbar k}{2m}t\right)} + Be^{-ik\left(x-\frac{\hbar k}{2m}t\right)}
$$

Here we recognize this as two waves, one moving right and one moving left.

But, this is a function that can't be normalized, this means that **there's no such thing as a free particle with a specific energy**.

But lucky us, we can normalize an infinite sum of them, so we can use exactly that :)

This is what we call a **wave packet**.

Then, using an integral instead (and keeping only one of the waves, as the other is just a ):
$$
\psi(x, t) = \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{+\infty}\phi(k)e^{i\left(kx-\frac{\hbar k^2}{2m}t\right)}
$$

And, using the [**Plancherel's theorem**](https://en.wikipedia.org/wiki/Plancherel_theorem) (and the [**Fourier transform**](https://en.wikipedia.org/wiki/Fourier_transform)), we end up with the solution for $\phi(k)$:

$$
\phi(k) = \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{+\infty}\psi(x, 0)e^{-ikx}dx
$$

And now we only depend on $\psi(x, 0)$ to have the whole system defined, win!

Given all this, let's assume that we have a wave packet that has a peak at a $k_0$ value (if there's no distinguishable shape for the packet, the notion of "packet velocity" has no meaning). Given that, we can then approximate $\omega$ by [**Taylor expansion**](https://en.wikipedia.org/wiki/Taylor_series) and we can keep only the first two terms:

$$
\omega(k) \approx \omega_0 + \omega'_0(k - k_0)
$$

Now centering the integral ($r \equiv k - k_0$) at $k_0$, and doing a bit of mangling, we get:
$$
\psi(x, t) \approx \frac{1}{\sqrt{2\pi}}e^{i(k_0x-\omega_0t)}\int_{-\infty}^{+\infty}\phi(k_0 + r)e^{ir(x-\omega'_0r)t}dr
$$

$$
\omega = \frac{\hbar k^2}{2m}
$$

And this can be recognized as a wave (the left exponential) traveling at speed $\frac{\omega_0}{k}$, bundled in an envelop wave (the right exponential) that travels at the speed $\omega'_0$.
So we have (at $k=k_0$):

$$
v_\text{phase} = \frac{\omega}{k} = \frac{\hbar k}{2m}
$$
$$
v_\text{group} = \omega'(k) = \frac{\hbar k}{m} = 2 v_\text{phase}
$$


You can find an animation on the jupyter notebook [here](https://github.com/david-caro/musings/blob/main/content/posts/2023-12-22-Quantum-physics-free-particle-1d/code/free-particle.ipynb).

Note that you might have to run locally for the interactive plot to show.