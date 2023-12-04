using Statistics, CairoMakie, DataFrames, StatsBase, Distributions, Random, LinearAlgebra


# oppgave 6.1

using Distributions

# Function to calculate the confidence interval
function calculate_confidence_interval(data::Vector{Float64}, confidence_level::Float64)
    n = length(data) # Sample size
    df = n - 1 # Degrees of freedom
    mean_data = mean(data) # Sample mean
    std_err = std(data) / sqrt(n) # Standard error of the mean

    # Create a t-distribution with df degrees of freedom
    t_dist = TDist(df)

    # Calculate the critical t-value for the two-tailed test
    t_crit = quantile(t_dist, (1 + confidence_level) / 2)

    # Calculate the margin of error
    margin_of_error = t_crit * std_err

    # Calculate the confidence interval
    lower_bound = mean_data - margin_of_error
    upper_bound = mean_data + margin_of_error

    return (lower_bound, upper_bound)
end

# Example usage with sample data and a 95% confidence level
sample_data = [2.3, 2.5, 2.1, 2.4, 2.2] # Replace with your own data
confidence_level = 0.95 # 95% confidence
ci = calculate_confidence_interval(sample_data, confidence_level)
println("The confidence interval is: (", round(ci[1], digits=2), ", ", round(ci[2], digits=2), ")")


function permute_solution(points; iteration=nothing)
    scale = 0.05
    
    # Copy the points array to avoid mutating the original data
    points = copy(points)
    
    # Choose a random index from the points array
    idx = rand(1:size(points, 1))
    
    # Add a normally distributed random vector to the chosen point
    points[idx, :] .+= randn(2) .* scale
    return points
end

