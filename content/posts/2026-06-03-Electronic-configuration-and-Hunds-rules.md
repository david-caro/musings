---
title: "Electronic Configuration and Hund's Rules"
date: 2026-06-03T12:00:00+01:00
tags: ["physics", "quantum physics", "chemistry", "atomic physics"]
math: true
draft: false
---

I'm having a hard time trying to memorize this, so writing a small article here
in the hopes it will help.

When filling electrons into atomic orbitals, three rules govern how nature
arranges them to minimise energy. These are
[**Hund's rules**](https://en.wikipedia.org/wiki/Hund%27s_rules), and
understanding them requires first revisiting
[quantum numbers](https://en.wikipedia.org/wiki/Quantum_number) and the
[Pauli exclusion principle](https://en.wikipedia.org/wiki/Pauli_exclusion_principle).

## Quantum numbers

Each electron in an atom is described by four quantum numbers:

- **[Principal quantum number](https://en.wikipedia.org/wiki/Principal_quantum_number)**
  $n = 1, 2, 3, \ldots$: determines the shell (energy level).
- **[Azimuthal (orbital) quantum number](https://en.wikipedia.org/wiki/Azimuthal_quantum_number)**
  $\ell = 0, 1, \ldots, n-1$: determines the subshell shape. By convention:
  $\ell=0 \to s$, $\ell=1 \to p$, $\ell=2 \to d$, $\ell=3 \to f$.
- **[Magnetic quantum number](https://en.wikipedia.org/wiki/Magnetic_quantum_number)**
  $m_\ell = -\ell, \ldots, 0, \ldots, +\ell$: gives the $2\ell + 1$ orbital
  orientations within a subshell.
- **[Spin quantum number](https://en.wikipedia.org/wiki/Spin_quantum_number)**
  $m_s = +\tfrac{1}{2}$ or $-\tfrac{1}{2}$: the two spin states of an electron.

The **Pauli exclusion principle** states that no two electrons in the same atom
can share all four quantum numbers. This is ultimately a consequence of
electrons being [fermions](https://en.wikipedia.org/wiki/Fermion) (particles
with half-integer spin), whose many-body wavefunction must be antisymmetric
under exchange.

A subshell with quantum number $\ell$ has $2\ell + 1$ orbitals, and each orbital
can hold at most 2 electrons (spin up and spin down), so the maximum occupancy
of a subshell is $2(2\ell+1)$.

| Subshell | $\ell$ | Orbitals | Max electrons |
| :------: | :----: | :------: | :-----------: |
|   $s$    |   0    |    1     |       2       |
|   $p$    |   1    |    3     |       6       |
|   $d$    |   2    |    5     |      10       |
|   $f$    |   3    |    7     |      14       |

## The Aufbau principle

Before stating Hund's rules, recall the
[**Aufbau principle**](https://en.wikipedia.org/wiki/Aufbau_principle):
subshells are filled in order of increasing energy. The approximate ordering is
given by the $(n + \ell)$ rule
([Madelung's rule](https://en.wikipedia.org/wiki/Aufbau_principle#Madelung_energy_ordering_rule)):
lower $n + \ell$ first; when equal, lower $n$ first:

$$
1s \to 2s \to 2p \to 3s \to 3p \to 4s \to 3d \to 4p \to 5s \to 4d \to \ldots
$$

Hund's rules apply _within_ a partially filled subshell once we start placing
electrons into its degenerate orbitals.

## Hund's rules

### Rule 1: Maximise total spin $S$

> For a given electron configuration, the term with the **maximum total spin
> $S$** (equivalently, the highest
> [spin multiplicity](<https://en.wikipedia.org/wiki/Multiplicity_(chemistry)>)
> $2S+1$) has the lowest energy.

Electrons with the same spin cannot occupy the same orbital (Pauli), so they end
up in _different_ orbitals and avoid each other spatially. This reduces
electron-electron repulsion, lowering the energy. In practice this means: **fill
each orbital with one electron (all spin-up) before pairing any spins.**

### Rule 2: Maximise total orbital angular momentum $L$

> Among terms with the same $S$, the one with the **largest total orbital
> angular momentum $L$** has the lowest energy.

Classically, electrons orbiting in the same direction avoid each other more
effectively than electrons orbiting in opposite directions, so larger $L$ means
less repulsion and lower energy.

$L$ is obtained by combining the individual $m_\ell$ values:

$$
L = \left| \sum_i m_{\ell_i} \right|_{\text{max}}
$$

(More precisely, $L$ is the maximum value of the total $M_L = \sum_i m_{\ell_i}$
over the valid assignments consistent with Pauli and with the $S$ from Rule 1.)

### Rule 3: $J$ depends on subshell filling

> Given $S$ and $L$, the total angular momentum $J = |L - S|$ for a **less than
> half-filled** subshell, and $J = L + S$ for a **more than half-filled** (or
> exactly half-filled if $L \neq 0$) subshell.

The total angular momentum $\mathbf{J} = \mathbf{L} + \mathbf{S}$ can range from
$|L - S|$ to $L + S$ in integer steps. Rule 3 picks the ground-state $J$ based
on the sign of the
[spin-orbit coupling](https://en.wikipedia.org/wiki/Spin%E2%80%93orbit_interaction)
constant:

- **Less than half-filled**: spin-orbit coupling is positive, so the state with
  _antiparallel_ $\mathbf{L}$ and $\mathbf{S}$ (i.e., $J = |L-S|$) has the
  lowest energy.
- **More than half-filled**: spin-orbit coupling is negative (the subshell can
  be thought of in terms of positive "holes"), so _parallel_ alignment
  ($J = L+S$) has the lowest energy.
- **Exactly half-filled** with $L = 0$ (e.g., the $p^3$ or $d^5$
  configurations): $J = S$.

### Spectroscopic symbol

The [spectroscopic term symbol](https://en.wikipedia.org/wiki/Term_symbol)
summarising all three rules is written:

$$
{}^{2S+1}L_J
$$

where $L$ is denoted by a capital letter ($S, P, D, F, \ldots$ for
$L = 0,1,2,3,\ldots$).

## Examples

### Carbon (C), $1s^2\, 2s^2\, 2p^2$

The two $2p$ electrons go into the three $p$ orbitals ($m_\ell = -1, 0, +1$).

**Rule 1**: maximise $S$. Place one electron per orbital, both spin-up:

$$
m_\ell: \quad \boxed{\uparrow} \quad \boxed{\uparrow} \quad \boxed{\phantom{\uparrow}}
$$

Total spin: $S = \tfrac{1}{2} + \tfrac{1}{2} = 1$, multiplicity $2S+1 = 3$
(triplet).

**Rule 2**: maximise $L$. The maximum $M_L$ consistent with the above is
$m_\ell = +1$ and $m_\ell = 0$, giving $M_L = 1$, so $L = 1$ ($P$ state).

**Rule 3**: subshell is less than half-filled ($2 < 3$), so
$J = |L - S| = |1-1| = 0$.

Ground state of Carbon: ${}^3P_0$.

### Nitrogen (N), $1s^2\, 2s^2\, 2p^3$

Three $2p$ electrons, one per orbital.

**Rule 1**: all spin-up gives $S = \tfrac{3}{2}$, multiplicity $4$ (quartet).

$$
m_\ell: \quad \boxed{\uparrow} \quad \boxed{\uparrow} \quad \boxed{\uparrow}
$$

**Rule 2**: $M_L = (+1) + 0 + (-1) = 0$, so $L = 0$ ($S$ state).

**Rule 3**: half-filled, $L = 0$, so $J = S = \tfrac{3}{2}$.

Ground state of Nitrogen: ${}^4S_{3/2}$.

### Oxygen (O), $1s^2\, 2s^2\, 2p^4$

Four $2p$ electrons, one subshell past half-filling.

**Rule 1**: three go in spin-up (one per orbital), the fourth must pair with one
of them (spin-down):

$$
m_\ell: \quad \boxed{\uparrow\downarrow} \quad \boxed{\uparrow} \quad \boxed{\uparrow}
$$

Net $S = 1$, multiplicity $3$ (triplet).

**Rule 2**: the paired electron (at $m_\ell = +1$, say) contributes
$+1 + (-1) = 0$ to $M_L$ with its partner; the remaining two contribute
$0 + (-1) = -1$... but we want the maximum $M_L$. The best assignment puts the
doubly occupied orbital at $m_\ell = -1$: $M_L = (-1-1) + 0 + 1 = -1$, i.e.,
$|M_L|_\text{max} = 1$, giving $L = 1$ ($P$ state).

**Rule 3**: more than half-filled ($4 > 3$), so $J = L + S = 1 + 1 = 2$.

Ground state of Oxygen: ${}^3P_2$.

### Iron (Fe), $[\text{Ar}]\, 3d^6\, 4s^2$

Note that $2s^2$ is full, so the outer orbital is actually $3d^6$. Six $3d$
electrons, five $d$ orbitals ($m_\ell = -2,-1,0,+1,+2$).

**Rule 1**: five spin-up, one pairing (spin-down) in the $m_\ell = -2$ orbital:

$$
m_\ell{:} \quad \boxed{\uparrow\downarrow} \quad \boxed{\uparrow} \quad \boxed{\uparrow} \quad \boxed{\uparrow} \quad \boxed{\uparrow}
$$

$S = 2$, multiplicity $5$ (quintet).

**Rule 2**: $M_L = (-2-2) + (-1) + 0 + 1 + 2 = -2$... again choosing to minimise
cancellation: putting the extra electron at $m_\ell = +2$ gives
$M_L = (2+2) + 1 + 0 + (-1) + (-2) = 2$, so $L = 2$ ($D$ state).

**Rule 3**: more than half-filled ($6 > 5$), so $J = L + S = 2 + 2 = 4$.

Ground state of Iron: ${}^5D_4$.

## LS coupling vs jj coupling

There's two main ways to couple angular momentum for multielectronic atoms,
[**LS coupling**](https://en.wikipedia.org/wiki/Angular_momentum_coupling#LS_coupling)(also
called Russell-Saunders coupling) and
[**jj coupling**](https://en.wikipedia.org/wiki/Angular_momentum_coupling#jj_coupling).
The two schemes differ in which interactions are treated as dominant.

### LS coupling (Russell-Saunders)

In LS coupling, electron-electron repulsion is much stronger than spin-orbit
interaction. The hierarchy of interactions is:

1. **Electron-electron repulsion** couples the individual orbital angular
   momenta $\ell_i$ into a total $L$, and the individual spins $s_i$ into a
   total $S$.
2. **Spin-orbit interaction** (weaker) then couples $L$ and $S$ into the total
   $J$.

This is the regime where Hund's rules apply. A good quantum number set is
$(L, S, J, M_J)$, and term symbols ${}^{2S+1}L_J$ are meaningful.

LS coupling works well for **light atoms** (roughly $Z \lesssim 30$). In these
atoms, spin-orbit coupling is a small perturbation on top of the
electron-electron structure.

### jj coupling

In jj coupling, spin-orbit interaction is much stronger than electron-electron
repulsion. The hierarchy is reversed:

1. **Spin-orbit interaction** couples each electron's own $\ell_i$ and $s_i$
   into an individual $j_i = \ell_i + s_i$.
2. **Residual electron-electron repulsion** (weaker) then couples the individual
   $j_i$ into the total $J$.

$L$ and $S$ are no longer good quantum numbers separately. The relevant set is
the collection of individual $j_i$ values and the total $J$. States are labelled
by $(j_1, j_2, \ldots)_J$ rather than by a term symbol.

jj coupling describes **heavy atoms** (roughly $Z \gtrsim 60$), such as lead
(Pb, $Z=82$) or bismuth (Bi, $Z=83$), where relativistic effects amplify
spin-orbit coupling enormously.

### Why spin-orbit coupling grows with $Z$

For a hydrogen-like ion the spin-orbit coupling constant scales as:

$$
\xi \propto \frac{Z^4}{n^3}
$$

where $n$ is the principal quantum number. Electron-electron repulsion scales
only as $Z$ (shielded nuclear charge). So for large $Z$ the ratio
$\xi / E_{\text{ee}}$ grows rapidly and spin-orbit coupling wins.
