using Distributions
using Plots

function mybinominal(theta, x, n)
    factorial(n) * theta^x * (1 - theta)^(n - x) / (factorial(x) * factorial(n - x))
end

function m(theta)
    mybinominal(theta, 0, 10)
end

mybinominal(0.5, 8, 10)

plot(m, 0.0, 1.0)

function dbinom(x, n, theta)
    binom = Distributions.Binomial(n, theta)
    pdf(binom, x)
end



## no 2
n = 100
x = 50
H0 = 0.5
H1 = 1 / 13
dbinom(x, n, H0)
dbinom(x, n, H1)

plot(toheta -> dbinom(x, n, theta), 0.0, 1.0)

plot(theta -> dbinom(5, 10, theta), 0.0, 1.0)
plot!(theta -> dbinom(50, 100, theta), 0.0, 1.0)
plot!(theta -> dbinom(500, 1000, theta), 0.0, 1.0)
