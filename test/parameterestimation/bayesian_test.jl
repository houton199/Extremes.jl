@testset "bayesian.jl" begin
    @testset "fitbayes(model; niter, warmup)" begin

        # stationary GEV Bayesian fit
        n = 5000

        μ = 0.0
        σ = 1.0
        ξ = 0.1

        ϕ = log(σ)
        θ = [μ; ϕ; ξ]

        pd = GeneralizedExtremeValue(μ, σ, ξ)
        y = rand(pd, n)

        model = Extremes.BlockMaxima(Variable("y", y))

        fm = Extremes.fitbayes(model, niter=500, warmup=400)

        infq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.025)
        supq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.975)

        @test infq <= θ
        @test θ <= supq

        # non-stationary GEV Bayesian fit
        n = 5000

        x₁ = randn(n)
        x₂ = randn(n)
        x₃ = randn(n) / 10

        μ = 1.0 .+ x₁
        ϕ = -0.5 .+ x₂
        ξ = x₃

        ϕ = log(σ)
        θ = [1.0; 1.0; -0.5; 1.0; 0.0; 1.0]

        pd = GeneralizedExtremeValue.(μ, σ, ξ)
        y = rand.(pd)

        model = Extremes.BlockMaxima(Variable("y", y), locationcov = [Variable("x₁", x₁)], logscalecov = [Variable("x₂", x₂)], shapecov = [Variable("x₃", x₃)])

        fm = Extremes.fitbayes(model, niter=500, warmup=400)

        infq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.025)
        supq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.975)

        @test infq <= θ
        @test θ <= supq

        # stationary GP bayes fit
        n = 5000

        σ = 1.0
        ξ = 0.1

        ϕ = log(σ)
        θ = [ϕ; ξ]

        pd = GeneralizedPareto(σ, ξ)
        y = rand(pd, n)

        model = Extremes.ThresholdExceedance(Variable("y", y))

        fm = Extremes.fitbayes(model, niter=500, warmup=400)

        infq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.025)
        supq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.975)

        @test infq <= θ
        @test θ <= supq

        # non-stationary GP Bayesian fit
        n = 5000

        x₁ = randn(n) / 3
        x₂ = randn(n) / 10

        ϕ = -.5 .+ x₁
        ξ = x₂

        σ = exp.(ϕ)
        θ = [-.5; 1.0; 0.0; 1.0]

        pd = GeneralizedPareto.(σ, ξ)
        y = rand.(pd)

        model = Extremes.ThresholdExceedance(Variable("y", y), logscalecov = [Variable("x₁", x₁)], shapecov = [Variable("x₂", x₂)])

        fm = Extremes.fitbayes(model, niter=500, warmup=400)

        infq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.025)
        supq = quantile!.([fm.sim.value[:,:,1][:,i] for i in 1:length(θ)], 0.975)

        @test infq <= θ
        @test θ <= supq

end

    include(joinpath("bayesian", "bayesian_gev_test.jl"))
    include(joinpath("bayesian", "bayesian_gp_test.jl"))

end
