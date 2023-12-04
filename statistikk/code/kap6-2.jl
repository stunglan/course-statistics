using Statistics, CairoMakie, DataFrames, StatsBase, Distributions, Random, LinearAlgebra


fyrstikkebrennelengde = [22,23,19,28,27,26,25,24,33,30,20,28,26,24,43,27,18,15,25,32,25,32,20,29,23,36,19,25,27,30,17,20,24,27,24,35,27,23,29,23,30,31,35,26,28,28,22,30,21,29,30,18,27,23,25,27,29,28,28,23]

mean(fyrstikkebrennelengde)
var(fyrstikkebrennelengde)  # varians
std(fyrstikkebrennelengde)  # standardavvik


# eksempel 6.10

salmonellatilfelle = [1495,1537,1545,1488,1805,1649,1942,1234,1367]

mean(salmonellatilfelle)
std(salmonellatilfelle)
quantile(salmonellatilfelle, [0.05, 0.5, 0.95])

# confidence interval
function t_test(x; conf_level=0.95)
    alpha = (1 - conf_level)
    tstar = quantile(TDist(length(x)-1), 1 - alpha/2)
    SE = std(x)/sqrt(length(x))
    
    lo, hi = mean(x) .+ [-1, 1] * tstar * SE
    "($lo, $hi)"

end

t_test(salmonellatilfelle)


