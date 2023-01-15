using Statistics
using StatsKit.HypothesisTests
using StatsKit.Distributions

nSims = 100000 # number of simulated experiments
#nSims = 10 # number of simulated experiments
M = 106.0 # Mean IQ score in the sample (will be compared with 100 in a one-sample t-test)
M = 108.0 # Mean IQ score in the sample (will be compared with 100 in a one-sample t-test)
n = 26 # set sample size
n = 51 # set sample size
SD = 15 #power = power_t_test(d=(M - 100.0) / SD, n=n, sig_level=0.05, alternative=:two_sided).power # determines M when power > 0. When power = 0, will set M = 100.# SD of the simulated data

p = Array{Float64,1}(undef, nSims) # set up empty variable to store all simulated p-values

# Run simulation
for i in 1:nSims
    x = randn(n) .* SD .+ M # Simulate data with specified mean, standard deviation, and sample size
    o = OneSampleTTest(x, 100.0) # perform the t-test against mu (set to value you want to test against)
    t = o.t
    p[i] = pvalue(o)
end

# Check power by summing significant p-values and dividing by number of simulations
power = (sum(p .< 0.05) / nSims) # power

# Calculate power formally by power analysis

function power_t_test(; d, n, sig_level, alternative)
    if alternative == :two_sided
        h = abs(d)
        alpha = sig_level
        return ccdf(Normal(), cquantile(Normal(), alpha / 2) - h * sqrt(n)) + cdf(Normal(), quantile(Normal(), alpha / 2) - h * sqrt(n))
    end
    return error("only twosided implemented")
end
power = power_t_test(d=(M - 100.0) / SD, n=n, sig_level=0.05, alternative=:two_sided) # determines M when power > 0. When power = 0, will set M = 100.




# Plot figure
using Plots
bars = 100
Plots.histogram(p, bins=bars, xlabel="P-values", ylabel="number of p-values", title="P-value Distribution with $(round(power*100, digits=1))% Power", color=:gray, yformatter=yi -> "hh $yi")
Plots.histogram(p, bins=bars, ylims=(0, 10000), xlims=(0.0, 0.05), xlabel="P-values", ylabel="number of p-values", title="P-value Distribution with $(round(power*100, digits=1))% Power", color=:gray, yformatter=yi -> "hh $yi")
Plots.abline!(0, nSims / bars, color=:red, line=(:dash, 2))

