import CSV,StatsBase, DataFrames, Statistics
#import StatsPlots
using CairoMakie
set_theme!(; CairoMakie=(; px_per_unit=5.0)) 

df = CSV.read("data/chap2.csv", DataFrames.DataFrame)

df

StatsBase.summarystats(df[!, :Resultat])
StatsBase.skewness(df[!, :Resultat])
StatsBase.kurtosis(df[!, :Resultat])
StatsBase.span(df[!, :Resultat])
StatsBase.var(df[!, :Resultat])
StatsBase.std(df[!, :Resultat])
StatsBase.mean(df[!, :Resultat])
StatsBase.median(df[!, :Resultat])
StatsBase.mode(df[!, :Resultat])
StatsBase.iqr(df[!, :Resultat])
StatsBase.maximum(df[!, :Resultat])
StatsBase.minimum(df[!, :Resultat])
StatsBase.quantile(df[!, :Resultat], [0.25, 0.5, 0.75])
StatsBase.countmap(df[!, :Resultat])    


# one observation in the small bin and three in the large
obs = [0.5, 1.5, 1.5, 2.5];

# a small and a large bin
bins = [0, 1, 7];

h = StatsBase.fit(StatsBase.Histogram, obs, bins)

h.weights
h.edges[1][2:end]

fig = Figure()
ax = CairoMakie.Axis(fig, xlabel = "Resultat", ylabel = "Fréquence", xticks = 0:1:7, yticks = 0:1:3)

CairoMakie.lines!(ax, h.edges[1][2:end], h.weights, color = :black, linewidth = 2, linestyle = :solid)

fig

fig = Figure(resolution = (600, 400))
ax = CairoMakie.Axis(fig, xlabel = "Resultat", ylabel = "Fréquence", xticks = 0:1:7, yticks = 0:1:3)

CairoMakie.barplot!(ax, h.edges[1][2:end], h.weights, color = :black, linewidth = 2, linestyle = :solid)

fig