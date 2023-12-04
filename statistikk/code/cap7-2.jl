using CairoMakie, DataFrames, StatsBase, Distributions, Random, LinearAlgebra
x = [75,145,55,88,122]
y = [0.48,1.09,0.53,0.97,0.78]

scatter(x,y)

cov(x,y)