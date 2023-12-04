# https://blogs.sas.com/content/iml/2021/06/14/simulate-iman-conover-transformation.html
# implement the correlation in julia

using Statistics, StatsBase, DataFrames, CairoMakie, Distributions, Random, LinearAlgebra, StatsPlots, StatsBase, StatsFuns, StatsModels, GLM, HypothesisTests, CategoricalArrays, CSV, Clustering

N = 100

Random.seed!(1234)

# generate N random number from normal Distributions
x = rand(Normal(0,1),N)
# generate N random number from lognormal Distributions
y = rand(LogNormal(0,1),N)
# generate N random number from exponental Distributions
z = rand(Exponential(1),N)
# generate N random number from uniform Distrsbutions
w = rand(Uniform(0,1),N)

m = [x y z w]



# %%

corrplot(m,label = ["Normal" "LogNormal" "Exponential" "Uniform"],grid = false, size = (600, 500))

corspearman(m)

# %%

using Pkg
Pkg.add("Statistics")
Pkg.add("Distributions")
Pkg.add("LinearAlgebra")

using Statistics
using Distributions
using LinearAlgebra

function iman_conover_transform(X, C)
    N = size(X, 1)
    S = zeros(N, size(X, 2))
    
    # T1: Create normal scores of each column
    for i in 1:size(X, 2)
        ranks = sortperm(X[:, i], alg=PartialQuickSort(N)) # tied ranks
        S[:, i] = quantile(Normal(), (ranks .- 0.5) / N) # van der Waerden scores
    end
    
    # T2: Apply two linear transformations to the scores
    CS = cor(S) # correlation of scores
    Q = cholesky(CS).L # Cholesky root of correlation of scores
    P = cholesky(C).L # Cholesky root of target correlation
    T = Q \ P # same as inv(Q) * P
    Y = S * T # transform scores: Y has rank corr close to target C
    
    # T3: Permute or reorder data in the columns of X to have the same ranks as Y
    W = similar(X)
    for i in 1:size(Y, 2)
        rank = sortperm(Y[:, i])
        tmp = sort(X[:, i])
        W[:, i] = tmp[rank] # reorder the column of X by the ranks of Y
    end
    
    return W
end

# Example usage:
# X = rand(10, 3) # Your data matrix
# C = cor(X) # Your target rank correlation matrix
# W = iman_conover_transform(X, C)
# println(W)

X = rand(10, 3)
C = cor(X)
W = iman_conover_transform(X, C)

X = m
C = [1.0 0.75 -0.70 0; 0.75 1.0 -0.95 0.0; -0.70 -0.95 1.0 -0.3; 0.0 0.0 -0.3 1.0]

W = iman_conover_transform(X, C)


corrplot(W,label = ["newNormal" "newLogNormal" "newExponential" "newUniform"],grid = false, size = (600, 500))


rankcorr = corspearman(W)




# %%
N = size(X, 1)
S = zeros(N, size(X, 2))
  # T1: Create normal scores of each column
for i in 1:size(X, 2)
    ranks = sortperm(X[:, i], alg=PartialQuickSort(N)) # tied ranks
    S[:, i] = quantile(Normal(), (ranks .- 0.5) / N) # van der Waerden scores
end
CS = cor(S)
Q = cholesky(CS).L 
P = cholesky(C).L # Cholesky root of target correlation
T = Q \ P # same as inv(Q) * P
Y = S * T 