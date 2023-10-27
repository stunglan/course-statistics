using Plots


values = Vector{Int64}()
for i in 1:6
    for j in 1:6
        push!(values, i + j)
    end
end



values

histogram(values, bins=range(1.5, 12.5, length=12), label=false)
xticks!(2:12)
title!("how many combinations makes a value")


using StatsBase
countmap(values)