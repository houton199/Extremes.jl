var documenterSearchIndex = {"docs":
[{"location":"contributing/#Contributing-1","page":"Contributing","title":"Contributing","text":"","category":"section"},{"location":"contributing/#","page":"Contributing","title":"Contributing","text":"Contributions are welcomed. Here's the workflow for development of new features, refactoring and bugfix.","category":"page"},{"location":"contributing/#","page":"Contributing","title":"Contributing","text":"master             # Stable branch, always ready to be tagged\ndev (or develop)   # Development branch. New features, refactoring, bug and hotfix are integrated into dev before going into master.\nfeature/           # New feature needs a `feature` prefix\n   struct-eva      # Example of a new feature named `struct-eva`   \nrefactor/          # Refactoring are tagged with a `refactor` prefix\n   struct-eva      # Example of refactoring the `struct-eva` feature\nbug/               # Prefix for bugs found during development\n   data-fix        # Example where we fix a dataset\nhotfix/            # Prefix for hotfix (bugs for deployed versions)\n   example-fix     # Example of a bugfix","category":"page"},{"location":"#Extremes-for-Julia-documentation-1","page":"Extremes for Julia documentation","title":"Extremes for Julia documentation","text":"","category":"section"},{"location":"#High-level-API-1","page":"Extremes for Julia documentation","title":"High level API","text":"","category":"section"},{"location":"#","page":"Extremes for Julia documentation","title":"Extremes for Julia documentation","text":"getcluster(y::Array{<:Real,1}, u₁::Real , u₂::Real=0.0)\ngetcluster(df::DataFrame, u₁::Real, u₂::Real=0.0)\ngevfitbayes(y::Array{<:Real}; warmup::Int=0, niter::Int=1000, thin::Int=1, stepSize::Array{<:Real,1}=[.1,.1,.05])\ngevfit(y::Array{T,1} where T<:Real)\ngevfit(y::Array{Float64,1}, location_covariate::Array{Float64,1}; initialvalues::Array{Float64,1}=Float64[])\ngpdfit(y::Array{T} where T<:Real; threshold::Real=0.0)\ngpdfitbayes(data::Array{Float64,1}; threshold::Real=0, niter::Int = 10000, warmup::Int = 5000,  thin::Int = 1, stepSize::Array{<:Real,1}=[.1,.1])","category":"page"},{"location":"#Extremes.getcluster","page":"Extremes for Julia documentation","title":"Extremes.getcluster","text":"getcluster(y::Array{<:Real,1}, u₁::Real , u₂::Real=0)\n\nReturns a DataFrame with clusters for exceedance models. A cluster is defined as a sequence where values are higher than u₂ with at least a value higher than threshold u₁.\n\n\n\n\n\n","category":"function"},{"location":"#Extremes.getcluster","page":"Extremes for Julia documentation","title":"Extremes.getcluster","text":"getcluster(df::DataFrame, u₁::Real, u₂::Real=0)\n\nReturns a DataFrame with clusters for exceedance models. A cluster is defined as a sequence where values are higher than u₂ with at least a value higher than threshold u₁.\n\n\n\n\n\n","category":"function"},{"location":"#Extremes.gevfitbayes-Tuple{Array{#s3,N} where N where #s3<:Real}","page":"Extremes for Julia documentation","title":"Extremes.gevfitbayes","text":"gevfitbayes(y::Array{<:Real}; warmup::Int=0, niter::Int=1000, thin::Int=1, stepSize::Array{<:Real,1}=[.1,.1,.05])\n\nFits a GEV...\n\n\n\n\n\n","category":"method"},{"location":"#Extremes.gevfit-Tuple{Array{T,1} where T<:Real}","page":"Extremes for Julia documentation","title":"Extremes.gevfit","text":"gevfit(y::Vector{<:Real},initialvalues::Vector{<:Real}=Float64[])\n\nFit the Generalized Extreme Value (GEV) distribution to data using maximum likelihood. Return an object of Type GeneralizedExtremeValue.\n\ngevfit(y):                Fits the GEV distribution to the data y.\ngevfit(y, initialvalues=initialvalues): Fits the GEV distribution to the data y using initialvalues as initial values.\n\n\n\n\n\n","category":"method"},{"location":"#Extremes.gpdfitbayes-Tuple{Array{Float64,1}}","page":"Extremes for Julia documentation","title":"Extremes.gpdfitbayes","text":"gpdfitbayes(data::Array{Float64,1}; threshold::Real=0, niter::Int = 10000, warmup::Int = 5000,  thin::Int = 1, stepSize::Array{<:Real,1}=[.1,.1])\n\nFits a Generalized Pareto Distribution (GPD)\n\n\n\n\n\n","category":"method"},{"location":"#Low-level-API-1","page":"Extremes for Julia documentation","title":"Low level API","text":"","category":"section"},{"location":"#","page":"Extremes for Julia documentation","title":"Extremes for Julia documentation","text":"Extremes.gumbelfitpwmom(x::Array{T,1} where T<:Real)\nExtremes.gevfitlmom(x::Array{T,1} where T<:Real)\nExtremes.getinitialvalues(y::Array{T,1} where T<:Real)\nExtremes.gevhessian(y::Array{N,1} where N<:Real,μ::Real,σ::Real,ξ::Real)\nExtremes.gpdfitmom(y::Array{T} where T<:Real; threshold::Real=0.0)","category":"page"},{"location":"#Extremes.gumbelfitpwmom-Tuple{Array{T,1} where T<:Real}","page":"Extremes for Julia documentation","title":"Extremes.gumbelfitpwmom","text":"gumbelfitpwmom(x::Array{T,1} where T<:Real)\n\nFits a Gumbel distribution using ...\n\n\n\n\n\n","category":"method"},{"location":"#Extremes.gevfitlmom-Tuple{Array{T,1} where T<:Real}","page":"Extremes for Julia documentation","title":"Extremes.gevfitlmom","text":"gevfitlmom(x::Array{T,1} where T<:Real)\n\nFit a GEV distribution with L-Moment method.\n\n\n\n\n\n","category":"method"},{"location":"#Extremes.gpdfitmom-Tuple{Array{T,N} where N where T<:Real}","page":"Extremes for Julia documentation","title":"Extremes.gpdfitmom","text":"gpdfitmom(y::Array{T} where T<:Real; threshold::Real=0.0)\n\nFit a Generalized Pareto Distribution over y.\n\n\n\n\n\n","category":"method"}]
}
