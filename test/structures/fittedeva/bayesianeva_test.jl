@testset "bayesianeva.jl" begin

    x = collect(1.0:5.0)

    μ = x
    ϕ = 0.0
    ξ = 0.1

    σ = exp.(ϕ)

    pd = GeneralizedExtremeValue.(μ, σ, ξ)
    y = rand.(pd)

    fm = Extremes.BayesianEVA(
        Extremes.BlockMaxima(Variable("y", y), locationcov = [Variable("x", x)]),
        Mamba.Chains([0 1 0 .1; 0 1 0 .1]),
    )


    @testset "getdistribution(fittedmodel)" begin
        @test all(Extremes.getdistribution(fm)[1,:] .== pd)
        @test all(Extremes.getdistribution(fm)[2,:] .== pd)
    end


    @testset "quantile(fm, p)" begin
        # p not in [0, 1] throws
        @test_throws AssertionError Extremes.quantile(fm, -1)

        # Test with known values
        @test quantile(fm, .95)[1,:] ≈ quantile.(pd,.95)
        @test quantile(fm, .95)[2,:] ≈ quantile.(pd,.95)

    end

    @testset "returnlevel(fm, returnPeriod)" begin
        # returnPeriod < 0 throws
        @test_throws AssertionError Extremes.returnlevel(fm, -1)

        # Test with known values
        @test returnlevel(fm, 100).value[1,:] ≈ quantile.(pd,1-1/100)
        @test returnlevel(fm, 100).value[2,:] ≈ quantile.(pd,1-1/100)

    end

    @testset "cint(fm, returnPeriod, confidencelevel)" begin
        # returnPeriod < 0 throws
        @test_throws AssertionError cint(ReturnLevel(Extremes.BlockMaximaModel(fm), -1, [1.0]), 0.95)

        # confidencelevel not in [0, 1]
        @test_throws AssertionError cint(ReturnLevel(Extremes. BlockMaximaModel(fm), 1, [1.0]), -1)

        # TODO: Test with known values

    end

    threshold = 10.0

    x = Variable("x",collect(range(0, stop=1, length=1000)))
    ϕ = x.value
    σ = exp.(ϕ)

    pd = GeneralizedPareto.(threshold, σ, .1)

    y = rand.(pd) .- threshold

    fm = gpfitbayes(y, logscalecov = [x])

    @testset "returnlevel(fm, threshold, nobservation, nobsperblock, returnPeriod)" begin
        # returnPeriod < 0 throws
        @test_throws AssertionError returnlevel(fm, threshold, length(y), 1, -1)

        # TODO : Test with known values

    end

    @testset "cint(fm, threshold, nobservation, nobsperblock, returnPeriod, confidencelevel)" begin
        # returnPeriod < 0 throws
        @test_throws AssertionError cint(ReturnLevel(Extremes.PeakOverThreshold(fm, threshold, length(y), 1), -1, [1.0]), 0.95)

        # confidencelevel not in [0, 1]
        @test_throws AssertionError cint(ReturnLevel(Extremes.PeakOverThreshold(fm, threshold, length(y), 1), 1, [1.0]), -1)

        # Test with known values
        r = cint(returnlevel(fm, threshold, length(y), 1, 100), .95)
        q = quantile.(pd, 1-1/100)

        @test r[1][1] < q[1] < r[1][2]  # Beginning of interval
        @test r[end][1] < q[end] < r[end][2]  # End of interval

    end

    @testset "showfittedEVA(io, obj, prefix)" begin
        # print does not throw
        buffer = IOBuffer()
        @test_logs Extremes.showfittedEVA(buffer, fm, prefix = "\t")
    end

    @testset "showChain(io, chain, prefix)" begin
        # print does not throw
        buffer = IOBuffer()
        @test_logs Extremes.showChain(buffer, fm.sim)
    end

    @testset "cint(fm::BayesianEVA)" begin

        μ, ϕ, ξ = 100, log(5), .1
        y = rand(GeneralizedExtremeValue(μ,exp(ϕ), ξ), 1000)

        fm = gevfitbayes(y)

        @test_throws AssertionError cint(fm, 1.95)
        @test_throws AssertionError cint(fm, -1.95)

        confint = cint(fm)

        @test confint[1][1] < μ < confint[1][2]
        @test confint[2][1] < ϕ < confint[2][2]
        @test confint[3][1] < ξ < confint[3][2]

        confint = cint(fm, .99)

        @test confint[1][1] < μ < confint[1][2]
        @test confint[2][1] < ϕ < confint[2][2]
        @test confint[3][1] < ξ < confint[3][2]

    end

    @testset "findposteriormode(fm::BayesianEVA)" begin

        x = Variable("x", randn(10))
        μ = 10 .+ x.value
        σ = 1.0
        ξ = .1
        pd = GeneralizedExtremeValue.(μ, σ, ξ)
        y = rand.(pd)
        fm = Extremes.BayesianEVA(Extremes.BlockMaxima(Variable("y", y), locationcov=[x]),
            Mamba.Chains([10.0 1.0 0.0 .1; -10.0 1.0 0.0 .1; 20.0 1.0 0.0 .1]))

        θ̂ = Extremes.findposteriormode(fm)
        @test θ̂ ≈ [10.0; 1.0; 0.0; .1]

    end

end
