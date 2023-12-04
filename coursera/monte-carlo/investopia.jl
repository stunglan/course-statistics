# https://en.wikipedia.org/wiki/Monte_Carlo_method

# Monte Carlo methods (or Monte Carlo experiments) are a broad class of computational algorithms that rely on repeated random sampling to obtain numerical results.
# Their essential idea is using randomness to solve problems that might be deterministic in principle.


using CairoMakie


function monte_carlo_pi(n)
    count = 0
    for i in 1:n
        x = rand()
        y = rand()
        if x^2 + y^2 <= 1
            count += 1
        end
    end
    return 4 * count / n
end

pi_hyp = monte_carlo_pi(1000000)