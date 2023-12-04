#https://medium.com/@c.oelrichs/simple-bayesian-models-of-economic-growth-eb9251ad4d55

using Distributions
using StatsBase
using CairoMakie

# Australia
dt = Normal(0.01696, 0.01481)

function gdp(α, β, σ, T)
    y = zeros(T)
    y[1] = 1
    for t in 2:T
        y[t] = α + β * y[t-1] + rand(dt) * σ
    end
    return y
end
cmap = resample_cmap(:linear_wcmr_100_45_c42_n256, 256;
    alpha = rand(256))


# Simple National Model
function xatt(x0,t,dk)
    x = zeros(t)
    x[1] = x0
    for y in 2:t
        yk = rand(dk)
        x[y] = x[y-1] * (yk+1)
    end
    return x
end


xatt(1,10,dt)

zeros(10)

fig = Figure(resolution = (800, 600))
ax = Axis(fig[1,1], xlabel = "x", ylabel = "y")

hist!(xatt(1,100,dt),normalization = :pdf, color = :values,
    colormap = cmap, strokewidth = 1, strokecolor = :black,
    bar_labels = :values, label_color = :black, label_size = 12,
    label_formatter=x-> round(x, digits=1))
#hidedecorations!(ax; grid = false)
fig


