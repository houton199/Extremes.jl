---
title: 'Extremes.jl: A Julia package for extremes'
tags:
  - Julia
  - Extremes
  - Statistics
  - non-stationary
authors:
  - name: Jonathan Jalbert^[Custom footnotes for e.g. denoting who the corresspoinding author is can be included like this.]
    orcid: TO ADD
    affiliation: 1 # (Multiple affiliations must be quoted)
  - name: Marylou Farmer
    affiliation: 1
  - name: Philippe Roy
    orcid: 0000-0003-1239-7589
    affiliation: 2
affiliations:
 - name: École Polytechnique de Montréal
   index: 1
 - name: Hydro-Québec
   index: 2
 
date: 15 September 2020
bibliography: paper.bib
---

# Summary

Extremes plays a crucial role in statistics [bla bla]. Examples of applications : Climate change studies, hydrology, economics. An important aspect that is not covered by other packages is the handling of non-stationarity. This is particularly true for climate change studies where the trends are documented. This affects the estimation of future extreme events and a clear understanbding of the impactsd of CC on infrastructures.

Extremes.jl provides exhaustive high-performance functions for the analysis of extreme values in Julia. In particular, methods for block maxima and threshold exceedances models are implemented, such as:

* Parameter estimation by probability weighted moments, maximum likelihood and Bayesian procedure.
* Stationary and non-stationary models.
* Diagnostic plots for assessing model accuracy.
* Return level estimation.

The package is largely based on the books of `@Coles:2001`, An Introduction to Statistical Modeling of Extreme Values, and of `@Beirlant:2004` Statistics of Extremes: Theory and Applications. The Tutorial section illustrates the package functionalities by reproducing many results obtained by [Coles:2001].

# Statement of need 

`Extremes.jl` is a Jython package for Extremes modelling. Juia is a high-performance 
language that leverage LLVM for Just-in-Time compilation. The API for `Extremes.jl` was
designed to provide a clear approach, leveragin the multiple-dispatch capabilities of Julia.

`Extremes.jl` was designed to be used by extremes researchers,
students in courses on extremes but also by engineers needing robust and powerful estimations of extremes.

It has already been used in a number of scientific publications [@Pearson:2017] and has also been
used in graduate courses on Galactic dynamics to, e.g., provide interactive
visualizations of textbook material [@Binney:2008]. The combination of speed,
design, and support for Astropy functionality in `Gala` will enable exciting
scientific explorations of forthcoming data releases from the *Gaia* mission
[@gaia] by students and experts alike.

# Mathematics

Single dollars ($) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left\{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$

You can also use plain \LaTeX for equations
\begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation}
and refer to \autoref{eq:fourier} from text.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Fenced code blocks are rendered with syntax highlighting:
```python
for n in range(10):
    yield f(n)
```	

# Acknowledgements

We acknowledge contributions from [...].

# References
