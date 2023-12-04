# https://towardsdatascience.com/random-walks-with-python-8420981bc4bc


using Random
using CairoMakie

dims = 1
step_n = 10000
step_set = [-1, 0, 1]
origin = zeros(1, dims)

# Simulate steps in 1D
steps = rand(step_set, step_n, dims)
path = vcat(origin, cumsum(steps, dims = 1))
start = path[1:1, :]
stop = path[end:end, :]


fig = Figure(resolution=(600, 400))
ax = Axis(fig[1, 1])
lines!(ax,path[:,1],color = :blue)
scatter!(origin[:],start[:], markersize =10, color = :red)
scatter!(step_n+1,stop[1], markersize =10, color = :black)
fig


