---
math: true
title: "Deriving the Damped and Forced Harmonic Equation"
date: 2025-05-25T10:35:04+02:00
draft: false
tags: ["physics", "waves", "maths"]
---

Similar to the previous post, this is an exercise I have to make sure I'm able
to do in my sleep for Uni, so here's a blog post in case I have to revisit how
to do it. It's not specially difficult, but there's a couple tricks that I
always get wrong, and practice makes perfect :)

## Differential equation

The idea is to derive the solutions to the damped and forced single dimension
harmonic vibration, for that we start, from Newton's, to the equation:

$$
m\ddot{x} + b\dot{x} + kx = F_0\cos{\left(\omega t + \phi\right)}
$$

Where $b$ is the damping coefficient (assumed linear), and
$F_0\cos{\left(\omega t+\phi\right)}$ is the driving force, and $k$ is the
"equivalent spring" constant.

This is an ordinary second order differential equation, for which we can find
the solutions by summing up the solution to the **homogeneous** equation, and
one **particular** solution.

## Homogeneous solution

Let's start with the **homogeneous** equation:

$$
m\ddot{x} + b\dot{x} + kx = 0
$$

Let's re-shuffle this a bit to leave the $\ddot{x}$ multiplied by 1:

$$
\ddot{x} + \frac{b}{m}\dot{x} + \frac{k}{m}x = 0
$$

Now here we can replace the other two factors, by the identities
$\omega_0^2 = \frac{k}{m}$, and $2\gamma=\frac{b}{m}$. $\omega_0$ is the natural
frequency of the system, this is, the one it would have if it was a non-damped,
non-forced harmonic vibration, some books start directly with this formula to
avoid using $k$.

**NOTE**: in some books, they use $\gamma = \frac{b}{m}$

So we end up with the equation:

$$
\ddot{x} + 2\gamma\dot{x} + \omega_0^2x = 0
$$

From here the characteristic equation is:

$$
r^2 + 2\gamma r + \omega_0^2 = 0
$$

That has solution:

$$
r = \frac{-\gamma \pm \sqrt{4\gamma^2 - 4\omega_0^2}}{2}
$$

Re-shuffling a bit:

$$
r = -\gamma \pm \sqrt{\gamma^2 - \omega_0^2}
$$

Using the definition $\omega_\gamma = \sqrt{\omega_0^2 - \gamma^2}$ we get the
equation (note that to flip the terms inside $\sqrt...$, we have to extract
$i$):

$$
r = -\gamma \pm i\omega_\gamma
$$

The solution to the differential equation will depend on the sign of
$\omega_0^2 - \gamma^2$.

Let's start with the hardest one :)

### Underdamped: $\omega_0^2 - \gamma^2  > 0$

This means that the roots are two complex conjugate numbers
$r_1 = \overline{r_2} \in\mathbb{C}$, and $\omega_\gamma \in \mathbb{R}$.
Following up on that:

$$
\begin{align*}
    r_1 &= -\gamma + i\sqrt{\omega_0^2 - \gamma^2} \\\\
    r_2 &= -\gamma - i\sqrt{\omega_0^2 - \gamma^2} \\\\
    x_h(t) &= C_1 e^{\left(-\gamma + i\omega_\gamma \right)t} \\\\
        &+ C_2 e^{\left(-\gamma - i\omega_\gamma\right)t} \\\\
    x_h(t) &= C_1 e^{-\gamma t}e^{i\omega_\gamma t} \\\\
        &+ C_2 e^{-\gamma t}e^{-i\omega_\gamma t} \\\\
\end{align*}
$$

Remembering Euler's identity:

$$
\begin{align*}
    Ae^{i\alpha} &= A\cos{\alpha} + iA\sin{\alpha} \\\\
    x_h(t) &= C\_1 e^{-\gamma t}\left[
            \cos{\left(\omega_\gamma t\right)}
            + i\sin{\left(\omega_\gamma t\right)}
        \right] \\\\
        &+ C\_2 e^{-\gamma t}\left[
            \cos{\left(\omega_\gamma t\right)}
            - i\sin{\left(\omega_\gamma t\right)}
        \right] \\\\
    x_h(t) &= e^{-\gamma t}\left[
        \left(C_1+C_2\right)\cos{\left(\omega_\gamma t\right)}
        + i\left(C_1-C_2\right)\sin{\left(\omega_\gamma t\right)}
        \right] \\\\
\end{align*}
$$

Bear with me, now as $C_1 = a+bi;C_2= c+di\in\mathbb{C}$, we expand:

$$
\begin{align*}
    x_h(t) &= e^{-\gamma t}\left[
        \left(a+c+i(b+d)\right)\cos{\left(\omega_\gamma t\right)}
        + i\left(a-c+i(b-d)\right)\sin{\left(\omega_\gamma t\right)}
        \right] \\\\
    x_h(t) &= e^{-\gamma t}\left[
        \left(a+c\right)\cos{\left(\omega_\gamma t\right)}
        +i(b+d)\cos{\left(\omega_\gamma t\right)}
        +i\left(a-c\right)\sin{\left(\omega_\gamma t\right)}
        -\left(b-d\right)\sin{\left(\omega_\gamma t\right)}
        \right] \\\\
    x_h(t) &= e^{-\gamma t}\left[
        \left(a+c\right)\cos{\left(\omega_\gamma t\right)}
        + \left(d-b\right)\sin{\left(\omega_\gamma t\right)}
        + i\left(
            \left(b+d\right)\cos{\left(\omega_\gamma t\right)}
            +\left(a-c\right)\sin{\left(\omega_\gamma t\right)}
        \right)
        \right] \\\\
\end{align*}
$$

So, as $a,b,c,d \in \mathbb{R}$, and as **we only care about the real
solutions**, **because we know that the solution we want is real**, we can
discard everything that's multiplied by $i$ from there. So if we declare
$A=\left(a+c\right)$, and $B=\left(d-b\right)$, we get the formula that you'd
find in most textbooks:

$$
\begin{align*}
    x_h(t) &= e^{-\gamma t}\left(
        A\cos{\left(\omega_\gamma t\right)}
        + B\sin{\left(\omega_\gamma t\right)}
        \right) \\\\
\end{align*}
$$

Note that this is a harmonic oscillation that fades with time (multiplied by
$e^{-\gamma t}$), where the exponential is the envelope.

### Critically damped: $\omega_0^2 - \gamma^2 = 0$

This means that there's a double real root, $\omega_\gamma = 0$.

$$
r_1 = r_2 = -\gamma
$$

So we get the solution:

$$
x_h(t) = \left(C_1 + tC_2\right)e^{-\gamma t}
$$

This also fades with time, but it does not oscillate like the previous (no
$\cos$ or $\sin$).

### Overdamped: $\omega_0^2 - \gamma^2 < 0$

In this case, we have two real roots $r_1 \ne r_2 \in \mathbb{R}$, and
$\omega_\gamma \in \mathbb{C}$:

$$
\begin{align*}
    r_1 &= -\gamma + \sqrt{\gamma^2 - \omega_0^2} \\\\
    r_2 &= -\gamma  - \sqrt{\gamma^2 - \omega_0^2} \\\\
    x_h(t) &= C_1 e^{\left(-\gamma + \sqrt{\gamma^2 - \omega_0^2}\right)t} \\\\
        &+ C_2 e^{\left(-\gamma - \sqrt{\gamma^2 - \omega_0^2}\right)t} \\\\
\end{align*}
$$

Here, as $\gamma > 0$, $\gamma^2 - \omega_0^2 > 0$, and
$\sqrt{\gamma^2 - \omega_0^2} < \sqrt{\gamma^2} = \gamma$, we know that the
exponent of $e$ is always negative, so both terms in the solution tend to 0 for
$t\to\infty$.

And there's also no oscillation, just like the critically damped, but we can
guess from the terms that it tends to 0 less quickly than the critically damped
solution.

## Particular solution

So we have now our homogeneous solution (well, solutions, depending on the type
of damping). Now we need a particular solution to the equation, this can be done
in many ways, but let's try using the method of
[undetermined coefficients](https://en.wikipedia.org/wiki/Method_of_undetermined_coefficients).

Remembering the full differential equation is:

$$
m\ddot{x} + b\dot{x} + kx = F_0\cos{\left(\omega t + \phi\right)}
$$

We see that the right side $f(x) = F_0\cos{\left(\omega t + \phi\right)}$, at
this point, we can go ahead or do a little trick to simplify the calculations.

For oscillations, we can always think of the solution as the real part of an
imaginary function. And in that case, we can also imagine the driving force as
the real part of an imaginary function. If we do this, this allows us to do the
change:

$$
\begin{align*}
x_p(t) &= \text{Re}(z(t))  = \text{Re}(Ae^{i\left(\omega t - \delta\right)})\\\\
F_0\cos{\left(\omega t + \phi\right)} &= \text{Re}(F_0e^{i\left(\omega t + \phi\right)}) \\\\
\end{align*}
$$

Getting the derivatives:

$$
\begin{align*}
    \dot{z}(t) &= i\omega Ae^{i\left(\omega t - \delta\right)} = i\omega z\\\\
    \ddot{z}(t) &= -\omega^2 Ae^{i\left(\omega t - \delta\right)} = -\omega^2z\\\\
\end{align*}
$$

Substituting in the differential equation:

$$
\begin{align*}
    m\ddot{z} + b\dot{z} + kz &= F_0e^{i\left(\omega t + \phi\right)}\\\\
    -m\omega^2Ae^{i\left(\omega t - \delta\right)}
    + ib\omega Ae^{i\left(\omega t - \delta\right)}
    + k Ae^{i\left(\omega t - \delta\right)}
    &= F_0e^{i\left(\omega t + \phi\right)}\\\\
    -m\omega^2A + ib\omega A + kA &= F_0e^{i\left(\phi + \delta\right)}\\\\
    -m\omega^2A + ib\omega A + kA &= F_0\left[\cos{\left(\phi + \delta\right)} + i\sin{\left(\phi + \delta\right)}\right]\\\\
\end{align*}
$$

From here, we can separate the real and the imaginary parts of the complex
numbers, leaving the equations:

$$
\begin{align*}
    -m\omega^2A + kA &= F_0\cos{\left(\phi + \delta\right)} \\\\
    b\omega A &= F_0\sin{\left(\phi + \delta\right)} \\\\
\end{align*}
$$

Squaring and summing them, we get $A$:

$$
\begin{align*}
    \left(-m\omega^2 + k\right)^2A^2 + b^2\omega^2A^2 &= F_0^2\left[
        \cos^2{\left(\phi + \delta\right)}
        + \sin^2{\left(\phi + \delta\right)}
    \right]\\\\
    \left(-m\omega^2 + k\right)^2A^2 + b^2\omega^2A^2 &= F_0^2 \\\\
    A^2\left[\left(-m\omega^2 + k\right)^2 + b^2\omega^2\right] &= F_0^2 \\\\
    A^2 &= \frac{F_0^2}{\left(-m\omega^2 + k\right)^2 + b^2\omega^2} \\\\
    A &= \sqrt{\frac{F_0^2}{\left(-m\omega^2 + k\right)^2 + b^2\omega^2}} \\\\
    A &= \frac{F_0}{\sqrt{\left(k - m\omega^2 \right)^2 + b^2\omega^2}} \\\\
\end{align*}
$$

Going back to the definitions of $\gamma = \frac{b}{m}$ and
$\omega_0^2 = \frac{k}{m}$, we have:

$$
\begin{align*}
    A &= \frac{F_0}{\sqrt{m\left(\omega_0^2-\omega^2 \right)^2 + b^2\omega^2}} \\\\
    A &= \frac{\frac{F_0}{m}}{\sqrt{\left(\omega_0^2-\omega^2 \right)^2 + \gamma^2\omega^2}} \\\\
\end{align*}
$$

And diving one with the other, we get the $\phi + \lambda$:

$$
\begin{align*}
    \frac{b\omega}{kA - m\omega^2A } &= \tan{\left(\phi + \delta\right)} \\\\
    \left(\phi + \delta\right) &=  \arctan{\left(\frac{b\omega}{kA - m\omega^2A }\right)} \\\\
    \delta &=  \arctan{\left(\frac{b\omega}{k - m\omega^2 }\right)} - \phi \\\\
    \delta &=  \arctan{\left(\frac{\gamma\omega}{\omega_0^2 - \omega^2 }\right)} - \phi \\\\
\end{align*}
$$

So overall we get:

$$
\begin{align*}
    x_p(t) &= A\cos{\left(\omega t + \delta\right)} \\\\
    \delta &=  \arctan{\left(\frac{\gamma\omega}{\omega_0^2 - \omega^2 }\right)} - \phi \\\\
    A &= \frac{\frac{F_0}{m}}{\sqrt{\left(\omega_0^2-\omega^2 \right)^2 + \gamma^2\omega^2}} \\\\
\end{align*}
$$

**Note** here that this solution does not tend to 0 when $t\to\infty$, but
instead it's a harmonic vibration with the same frequency as the driving force,
but with a delay of $\delta - \phi$ radians.

## Summing everything up

So we end up with a solution with two parts:

$$
\begin{align*}
    x(t) &= x_h(t) + x_p(t)
\end{align*}
$$

One that fades with time, that is usually called **transient** (that's $x_h$),
and one that remains, that is called **stationary** ($x_p$).
