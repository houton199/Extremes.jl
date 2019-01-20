
function gevloglike(y::Real,μ::Real,σ::Real,ξ::Real)

    @assert σ >= 0 "The scale parameter must be positive"

    z = (y-μ)/σ

    if abs(ξ) > eps()
        if (1+ξ*z) <= 0
            loglike = -Inf
        else
            loglike = -log(σ) - (1/ξ+1)*log1p(ξ*z) - (1+ξ*z).^(-1/ξ)
        end
    else
        loglike = -log(σ) - z - exp(-z)
    end

    return loglike
end

function gumbelfitpwmom(x::Array{N,1} where N)

    n = length(x)
    y = sort(x)
    r = 1:n

    # Probability weighted moments
    b₀ = mean(y)
    b₁ = 1/n/(n-1)*sum( y[i]*(n-i) for i=1:n)

    # Gumbel parameters estimations
    σ̂ = (b₀ - 2*b₁)/log(2)
    μ̂ = b₀ - Base.MathConstants.eulergamma*σ̂

    return [μ̂, σ̂]
end

function gevfitlmom(x::Array{N,1} where N)

    n = length(x)
    y = sort(x)
    r = 1:n

    #     L-Moments estimations (Cunnane, 1989)
    b₀ = mean(y)
    b₁ = sum( (r .- 1).*y )/n/(n-1)
    b₂ = sum( (r .- 1).*(r .- 2).*y ) /n/(n-1)/(n-2)

    # GEV parameters estimations
    c = (2b₁ - b₀)/(3b₂ - b₀) - log(2)/log(3)
    k = 7.859c + 2.9554c^2
    σ = k *( 2b₁-b₀ ) /(1-2^(-k))/gamma(1+k)
    μ = b₀ - σ/k*( 1-gamma(1+k) )

    ξ = -k

    return [μ, σ, ξ]
end

# function gevfit(y::Array{N,1} where N; method="ml", initialvalues=Float64[], location_covariate=Float64[], logscale_covariate =Float64[])
function gevfit(y::Array{N,1} where N; method="ml", initialvalues::Array{Float64}=Float64[], location_covariate::Array{Float64}=Float64[])

    if method == "ml"

        if isempty(initialvalues)
            θ₀ = gevfitlmom(y)
            loglike_initial = sum(gevloglike.(y,θ₀...))
            if !isfinite(loglike_initial)
                θ₀ = [gumbelfitpwmom(y)...,0]
            end
        end

        if isempty(location_covariate)

            initialvalues = zeros(4)
            initialvalues[1] = θ₀[1]
            initialvalues[2] = log(θ₀[2])
            initialvalues[3] = θ₀[3]

            fobj(μ, ϕ, ξ) = sum(gevloglike.(y,μ,exp(ϕ),ξ))
            mle = Model(solver=IpoptSolver(print_level=0,sb="yes"))
            JuMP.register(mle,:fobj,3,fobj,autodiff=true)
            @variable(mle, μ, start = initialvalues[1])
            @variable(mle, ϕ, start = initialvalues[2])
            @variable(mle, ξ, start = initialvalues[3])
            @NLobjective(mle, Max, fobj(μ, ϕ, ξ) )
            solution  = JuMP.solve(mle)

            if solution == :Optimal
                θ = [getvalue(μ) exp(getvalue(ϕ)) getvalue(ξ)]
                logl = getobjectivevalue(mle)
                bic = -2*logl + 3*log(length(y))
            else
                error("The algorithm did not find a solution.")
            end


        else # location covariate is provided

            initialvalues = zeros(4)
            initialvalues[1] = θ₀[1]
            initialvalues[3] = log(θ₀[2])
            initialvalues[4] = θ₀[3]

            if isapprox(mean(location_covariate),0,atol=eps())
                b = 0
            else
                b = mean(location_covariate)
            end

            if isapprox(mean(location_covariate),1,atol=eps())
                a = 1
            else
                a = std(location_covariate)
            end

            x = (location_covariate .- b)./a

            fobj_location(μ₀, μ₁, ϕ, ξ) = sum(gevloglike.(y,μ₀ .+ μ₁*x,exp(ϕ),ξ))
            mle = Model(solver=IpoptSolver(print_level=2, sb="yes"))
            JuMP.register(mle,:fobj_location,4,fobj_location,autodiff=true)
            @variable(mle, μ₀, start=  initialvalues[1])
            @variable(mle, μ₁, start = initialvalues[2])
            @variable(mle, ϕ, start = initialvalues[3])
            @variable(mle, ξ, start= initialvalues[4])
            # @NLconstraint(mle, my_constr[i = 1:n], ξ/exp(ϕ)*(y[i]-μ₀-μ₀*x[i]) >= -1)
            @NLobjective(mle, Max, fobj_location(μ₀, μ₁, ϕ, ξ) )
            solution  = JuMP.solve(mle)

            if solution == :Optimal
                θ = [getvalue(μ₀) getvalue(μ₁) exp(getvalue(ϕ)) getvalue(ξ)]
                logl = getobjectivevalue(mle)
                bic = -2*logl + 4*log(length(y))
            else
                error("The algorithm did not find a solution.")
            end

        end

    elseif method == "lmom"
        θ = gevfitlmom(y)
        logl = Float64[]
        bic = Float64[]
    end

    bmfit = Dict(:params => vec(θ), :logL => logl, :BIC => bic)

end


function gevhessian(y::Array{N,1} where N,μ::Real,σ::Real,ξ::Real)

    #= Estimate the hessian matrix evaluated at (μ, σ, ξ) for the iid gev random sample y =#

    logl(θ) = sum(gevloglike.(y,θ[1],θ[2],θ[3]))

    H = ForwardDiff.hessian(logl, [μ σ ξ])

end
