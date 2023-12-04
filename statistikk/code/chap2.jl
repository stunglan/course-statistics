import CSV,StatsBase, DataFrames, Statistics
#import StatsPlots
using CairoMakie
using GLMakie

CairoMakie.activate!()


set_theme!(; CairoMakie=(; px_per_unit=5.0)) 

df = CSV.read("data/chap2.csv", DataFrames.DataFrame)

studentno = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]


# one observation in the small bin and three in the large
obs = [0.5, 1.5, 1.5, 2.5];

# a small and a large bin
bins = [0, 1, 7];

h = StatsBase.fit(StatsBase.Histogram, obs, bins)

h.weights
h.edges[1][2:end]

fig = Figure()
ax = Axis(fig)

lines!(ax, h.edges[1][2:end])

fig

fig = Figure(resolution = (600, 400))
ax = CairoMakie.Axis(fig, xlabel = "Resultat", ylabel = "Fréquence", xticks = 0:1:7, yticks = 0:1:3)

CairoMakie.barplot!(ax, h.edges[1][2:end], h.weights, color = :black, linewidth = 2, linestyle = :solid)

fig