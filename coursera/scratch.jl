
using Makie
using CairoMakie
using Distributions
using Random


xs = range(0, stop=10, length=100)
μs = log.(xs)
σs = rand(length(xs))


fig = Figure(resolution=(600, 400))
# create a line plot with errorbars
ax = Axis(fig[1, 1], xlabel="x", ylabel="y")
CairoMakie.lines!(xs, μs, color=:blue)
CairoMakie.scatter!(xs, μs, color=:black)
CairoMakie.errorbars!(xs, μs, σs, color=:red)
CairoMakie.band!(xs, μs - σs / 2, μs + σs / 2, color=:blue, levels=range(0, stop=1, length=100), orientation=:vertical)
fig


f,ax,l = lines(-4 .. 4, TDist(10),; linewidth=5,label="10",axis=(xlabel=L"x", title="10",ylabel="Density"))
lines!(ax,-4 .. 4, TDist(3); linewidth=5,label="3")
lines!(ax,-4 .. 4, TDist(2),; linewidth=5,label="2")
lines!(ax,-4 .. 4, TDist(1),; linewidth=5,label="1")
axislegend(ax)


