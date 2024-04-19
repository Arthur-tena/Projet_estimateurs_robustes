using Statistics

function median_of_means(seq, n)
    if n > length(seq)
        n = ceil(Int, length(seq) / 2)
    end
    indic = repeat(1:n, inner = div(length(seq), n))
    indic = indic[randperm(length(indic))]  # Mélange les indices aléatoirement
    moyennes = [mean(seq[indic .== block]) for block in 1:n]
    return median(moyennes)
end

M = 0
population1 = M .+ 3 * randn(1000)

result = median_of_means(population1, 50)
println("La médiane des moyennes des blocs est: ", result)

function rob_median_of_means(seq, n, l)
    res = [median_of_means(seq, n) for _ in 1:l]
    return mean(res)
end

resultat=rob_median_of_means(population1,50,100)


