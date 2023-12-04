import StatsBase, DataFrames, Statistics
using CairoMakie


# one observation in the small bin and three in the large
obs = [0.5, 1.5, 1.5, 2.5];

# a small and a large bin
bins = [0, 1, 7];

h = StatsBase.fit(StatsBase.Histogram, obs, bins)

h.weights
h.edges[1][2:end]

fig = Figure()
ax = Axis(fig[1,1])

lines!(ax, h.edges[1][2:end])

fig