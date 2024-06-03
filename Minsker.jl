#Minsker
using Distributions
using Combinatorics


function median_of_means_minsker(X, k)
    if k > length(X)
        k = ceil(Int, length(X) / 2)
    end
    
    n = length(X)
    all_combinations = collect(combinations(1:n,k))
    means_vector = Float64[]

    for combination in all_combinations
        indic = falses(n)
        indic[combination] .= true
        moyennes = [mean(X[indic .== true]) for _ in 1:k]
        push!(means_vector, mean(moyennes))
    end
    
    return median(means_vector)
end

X=rand(Pareto(2.2,3),50)
println(median_of_means_minsker(X, 7))