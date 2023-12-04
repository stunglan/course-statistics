using Distributions
using CairoMakie

b = Binomial(90, 0.42)

cdf(b, 39)


# side 178
h = Hypergeometric(20, 80, 30)

pdf(h, 9)
cdf(h, 9)
mean(h)
var(h)

# side 182

λ = 3 # antal pasienter per time

p = Poisson(2.5*λ)

mean(p)
pdf(p, 10)

cmap = resample_cmap(:linear_wcmr_100_45_c42_n256, 256;    alpha = rand(256))
fig = Figure(resolution = (600, 400))
ax = Axis(fig[1, 1])
barplot!(0:20,pdf.(p,0:20),gap=0)
fig

cdf(p,10)
cdf(p,10) - cdf(p,4)























































































































































