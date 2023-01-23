using Plots


values = Vector{Int64}()
for i in 1:6
    for j in 1:6
        push!(values, i + j)
    end
end



values

scatterhist(values, bins=range(1, 12, length=13), normalize=:pdf)
xticks!(2:12)


using StatsBase
countmap(values)