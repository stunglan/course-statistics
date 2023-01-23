using Distributions

# Define a normal distribution with mean = 0 and standard deviation = 1
beta_distribution = Beta(11.0, 11.0)



# Define the x-values at which to evaluate the PDF
x = range(0.0, stop=1.0, length=100)

# Evaluate the PDF at each x-value
y = pdf(beta_distribution, 0.5)

# Plot the PDF
using Plots
plot(x, x -> pdf(beta_distribution, x))



# Q1 
# Beta(1,0.5)
# $a* = a + x$   
# $b* = b + n -x

astar = 1.0 + 10.0
bstar = 0.5 + 20.0 - 10.0

Beta(astar, bstar)

# Q1 
# Beta(100,100)
# $a* = a + x$   
# $b* = b + n -x

astar = 100 + 50.0
bstar = 100 + 100 - 50.0

Beta(astar, bstar)

## plot at 0.5

b1 = Beta(1, 1)
b20 = Beta(11, 11)

pdf(b20, 0.5) / pdf(b1, 0.5)

plot(x, x -> pdf(b1, x), color=:grey)
plot!(x, x -> pdf(b20, x), color="dodgerblue")

###

b1 = Beta(1, 1)
b20 = Beta(11, 11)

pdf(b20, 0.5) / pdf(b1, 0.5)

plot(x, x -> pdf(b1, x), color=:grey)
plot!(x, x -> pdf(b20, x), color="dodgerblue")



# binominalposteriour mean

function plotbayesian(n, x)

    aprior = 1.0
    bprior = 1.0

    ymax = 10

    alikelihood = x + 1
    blikelihood = n - x + 1

    aposterior = aprior + alikelihood - 1
    bposterior = bprior + blikelihood - 1

    theta = range(0.0, 1.0, 1000)

    betaprior = Beta(aprior, bprior)
    betalikelihood = Beta(alikelihood, blikelihood)
    betaposteriour = Beta(aposterior, bposterior)

    plot(theta, x -> pdf(betaprior, x), color=:grey, label="prior")
    plot!(theta, x -> pdf(betalikelihood, x), linestyle=:dash, color=:blue, label="likelihood")
    plot!(theta, x -> pdf(betaposteriour, x), linestyle=:dot, color=:red, label="posteriour")
    ylabel!("Density")
    xlabel!("θ")
    ylims!(0, ymax)

    LL = quantile(betaposteriour, 0.025)
    UL = quantile(betaposteriour, 0.975)
    vline!([aposterior / (aposterior + bposterior)], color=:gray, linewidth=3, label=false)
    vline!([LL, UL], linewidth=1, label=false)
    iLL = theta .< LL
    uLL = theta .> UL
    plot!(theta[iLL], x -> pdf(betaposteriour, x), fillrange=zero(theta[iLL]), fc=:gray, label=false)
    plot!(theta[uLL], x -> pdf(betaposteriour, x), fillrange=zero(theta[iLL]), fc=:gray, label=false)
    m =
        title!("Mean posterior $(round(aposterior / (aposterior + bposterior),digits=2)) Credible interval $(round(LL,digits=2)) ; $(round(UL,digits=2))")

end


n = 20 # total trials
x = 18 # no of success



plotbayesian(n, x)