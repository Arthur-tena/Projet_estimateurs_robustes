using Statistics
using Random
using Distributions

Pareto(3)

function median_of_means_opt(seq, alpha=0.025)
    if alpha <= 0 || alpha > 1
        throw(ArgumentError("alpha doit être supérieur à 0 et inférieur ou égal à 1"))
    end
    
    n = length(seq)
    k = abs(trunc(Int, 8 * log(1 / alpha)))
    m = div(n, k)
    means = [mean(seq[((i-1)*m+1):min(i*m, n)]) for i in 1:k]
    return median(means)
end


median_of_means_opt(data,0.15)

#Plot pour les estimateurs en fonctions de alpha
seq=data
alphas = collect(0.001:0.001:0.1)  # Choisir une plage d'alpha
estimates = [median_of_means_opt(seq, alpha) for alpha in alphas]

plot(alphas, estimates, xlabel="Alpha", ylabel="Estimateur", label="", title="Estimateur en fonction de Alpha")

# Appliquer la fonction median_of_means avec différents nombres de blocs
println("Médiane des moyennes avec 20 blocs:", median_of_means_opt(data, 0.025))


# Fonction qui répéte le median of mean plusieurs fois

function rob_median_of_means(seq, n, l)
    res = [median_of_means(seq, n) for _ in 1:l]
    return mean(res)
end

resultat=rob_median_of_means(population1,50,100)



function bootstrap_IC(data, alpha=0.025, R=1000)
    n = length(data)
    bootstrap_estimates = [median_of_means_opt(data[rand(1:n, n)], alpha) for _ in 1:R]
    
    lower_bound = quantile(bootstrap_estimates, 0.025)
    upper_bound = quantile(bootstrap_estimates, 0.975)
    
    return [lower_bound, upper_bound]
end

bootstrap_IC(data,0.025,1000)




using Distributions
using Random


function median_of_means(seq, n)
    if n > length(seq)
        n = ceil(Int, length(seq) / 2)
    end
    indic = repeat(1:n, inner = div(length(seq), n))
    indic = indic[randperm(length(indic))]  # Mélange les indices aléatoirement
    moyennes = [mean(seq[indic .== block]) for block in 1:n]
    return median(moyennes)
end

X=[2,5,8,10,53,12,14,35,20,17,15,6,4,9,11,19,13,14,48,8]
Y=[2,5,8,10,12,14,20,17,15,6,4,9,11,19,13,14,8]
mean(Y)

median(X)
mean(X)
median_of_means(X, 5)

function median_of_mean_opt(X,alpha=0.025)
    n=lenght(X)
    k=abs(trunc(Int,8*log(1/alpha)))
    m=div(n,k)
    indic=repeat(1:k,inner=m)
    indic=shuffle(indic)
    moyennes=[mean(X[indic.==block]) for block in 1:k]
    return median(moyennes) 
end
data1 = rand(Exponential(2), 10000)
median_of_mean_opt(data1,0.025)

using Random
function median_of_mean_opt(X,alpha=0.025)
    n=length(X)
    k=abs(trunc(Int,8*log(1/alpha)))
    m=div(n,k)
    indic=repeat(1:k,inner=m)
    indic=shuffle(indic)
    moyennes=[mean(X[indic.==block]) for block in 1:k]
    return median(moyennes) 
end


data1 = rand(Exponential(2), 10000)
median_of_mean_opt(data1,0.025)

using Random

function median_of_mean_opt(X, alpha=0.025)
    n = length(X)
    k = abs(trunc(Int, 8 * log(1 / alpha)))
    m = div(n, k)
    indic = repeat(1:k, inner=m)
    shuffle!(indic)
    moyennes = [mean(X[indic .== block]) for block in 1:k]
    return median(moyennes) 
end

data1 = rand(Exponential(2), 10000)
println(median_of_mean_opt(data1, 0.025))

function median_of_means_opt













using Plots

function median_of_means_opt(seq, alpha=0.025)
    if alpha <= 0 || alpha > 1
        throw(ArgumentError("alpha doit être supérieur à 0 et inférieur ou égal à 1"))
    end
    
    n = length(seq)
    k = max(1, min(n, abs(trunc(Int, 8 * log(1 / alpha)))))
    m = div(n, k)
    means = [mean(seq[((i-1)*m+1):min(i*m, n)]) for i in 1:k]
    return median(means)
end

# Générer les données
data = generate_pareto_data(n, β, xmin)

# Exécution de la fonction avec alpha=0.15
estimate = median_of_means_opt(data, alpha)
println("Estimateur avec alpha=0.15 : ", estimate)

# Plot pour les estimateurs en fonction de alpha
alphas = collect(0.001:0.001:0.999)  # Choisir une plage d'alpha
estimates = [median_of_means_opt(data, alpha) for alpha in alphas]

plot(alphas, estimates, xlabel="Alpha", ylabel="Estimateur", label="", title="Estimateur en fonction de Alpha")


function median_of_means_opt2(X, alpha=0.025)
    n = length(X)
    k = trunc(Int, 8*log(1/alpha))
    m = n ÷ k
    indic = repeat(1:k, inner = m)
    indic .= shuffle(indic)  # Utilisation de shuffle pour mélanger les indices
    moyennes = [mean(X[indic .== block]) for block in 1:k]
    return median(moyennes)
end

median_of_means_opt2(data, 0.025)

#Fonction sans le sample

function median_of_means_opt(seq, alpha=0.025)
    n = length(seq)
    k = abs(trunc(Int, 8 * log(1 / alpha)))
    m = div(n, k)
    means = [mean(seq[((i-1)*m+1):min(i*m, n)]) for i in 1:k]
    return median(means)
end

