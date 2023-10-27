using Makie
using CairoMakie
using Distributions

#create a julia function to plot  the binominal distribution using makie

function plot_binominal(n, p)
    x = 0:n
    y = binomial(n, x) .* p .^ x .* (1 - p) .^ (n - x)
    plot(x, y, label="binominal distribution")
end

plot_binominal(10, 0.5)

#create a julia function to plot the poisson distribution using makie

function plot_poisson(λ)
    x = 0:λ
    y = exp(-λ) .* λ .^ x ./ factorial.(x)
    plot(x, y, label="poisson distribution")
end

plot_poisson(10)

#create a julia function to plot the normal distribution using makie

function plot_normal(μ, σ)
    x = -5:0.1:5
    y = exp.(-0.5 .* ((x .- μ) ./ σ) .^ 2) ./ (σ .* sqrt(2π))
    plot(x, y, label="normal distribution")
end

f, ax1, b = barplot(
    Bernoulli(0.5);
    width=0.3,
    axis=(;
        title=L"p=0.5",
        xlabel=L"\theta",
        ylabel="Mass",
        xticks=0:1,
        limits=(nothing, nothing, 0, 1),
    ),
)
ax2 = Axis(
    f[1, 2]; title=L"p=0.2", xlabel=L"\theta", xticks=0:1, limits=(nothing, nothing, 0, 1)
)
barplot!(ax2, Bernoulli(0.2); width=0.3)
linkaxes!(ax1, ax2)
f


f, ax1, b = barplot(
    NegativeBinomial(1, 0.5); axis=(; title=L"k=1", xlabel=L"\theta", ylabel="Mass")
)
ax2 = Axis(f[1, 2]; title=L"k=2", xlabel=L"\theta")
barplot!(ax2, NegativeBinomial(4, 0.9))
linkaxes!(ax1, ax2)
f

using Turing

@model function dice_throw(y)
    #Our prior belief about the probability of each result in a six-sided dice.
    #p is a vector of length 6 each with probability p that sums up to 1.
    p ~ Dirichlet(6, 1)

    #Each outcome of the six-sided dice has a probability p.
    for i in eachindex(y)
        y[i] ~ Categorical(p)
    end
end;

y = [1,2,3,4,5,6]
dice_throw(y)
y

using Random

Random.seed!(123);

my_data = rand(DiscreteUniform(1, 6), 1_000);

model = dice_throw(my_data);

chain = sample(model, NUTS(), 1_000);

summaries, quantiles = describe(chain);

summaries

sum([idx * i for (i, idx) in enumerate(summaries[:, :mean])])

using AlgebraOfGraphics
using AlgebraOfGraphics: density
#exclude additional information such as log probability
params = names(chain, :parameters)
chain_mapping =
    mapping(params .=> "sample value") *
    mapping(; color=:chain => nonnumeric, row=dims(1) => renamer(params))
plt1 = data(chain) * mapping(:iteration) * chain_mapping * visual(Lines)
plt2 = data(chain) * chain_mapping * density()
f = Figure(; resolution=(800, 600))
draw!(f[1, 1], plt1)
draw!(f[1, 2], plt2; axis=(; ylabel="density"))
f