---
title: "General relativity - Tensors, metrics and other creatures part II"
date: 2024-02-19T22:25:35+01:00
tags: [physics, "general relativity", maths, python]
math: true
---

## Tensors, revisited

### Playing with tensors

Now can can start operating with the tensors \o/

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

## Flat manifolds

### Covariant derivative

## Curved manifolds

### Parallel transport, Lie transport, Covariant derivative and Killing's vector

### Geodesics
