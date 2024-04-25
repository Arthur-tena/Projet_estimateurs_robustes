using Statistics
using Random
using Distributions

# Générer des données suivant une distribution de Pareto
function generate_pareto_data(n, β, xmin)
    u = rand(n)
    return xmin ./ (u .^ (1/β))
end

# Paramètres de la distribution de Pareto
n = 500          # Taille de l'échantillon
β = 1.5           # Paramètre de forme (doit être > 1)
xmin = 2.0        # Paramètre de position

data=generate_pareto_data(n,α,xmin)
#Loi normale N(0,1)


# Générer 1000 nombres aléatoires selon une distribution normale standard (moyenne = 0, écart-type = 1)
normale_standard = randn(1000)

# Générer une distribution normale avec moyenne 5 et écart-type 2
moyenne = 0
ecart_type = 1
normale_custom = moyenne .+ ecart_type .* normale_standard

data1=normale_custom



# Générer les données
data = generate_pareto_data(n, α, xmin)

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






function median_of_means(seq, n)
    if n > length(seq)
        n = ceil(Int, length(seq) / 2)
    end
    indic = repeat(1:n, inner = div(length(seq), n))
    indic = indic[randperm(length(indic))]  # Mélange les indices aléatoirement
    moyennes = [mean(seq[indic .== block]) for block in 1:n]
    return median(moyennes)
end

median_of_means(data,5)



using Statistics, Plots

using Statistics, Plots

function median_of_means_opt(seq, alpha=0.025)
    n = length(seq)
    k = abs(trunc(Int, 8 * log(1 / alpha)))
    m = div(n, k)
    means = [mean(seq[((i-1)*m+1):min(i*m, n)]) for i in 1:k]
    return median(means)
end

median_of_means_opt(data,0.99)

alpha = 0.025  # Valeur alpha pour le calcul de k
k = abs(trunc(Int, 8 * log(1 / alpha)))  # Calcul de k
m = 50  # Nombre de membres par groupe
ns = k .* m  # Taille de l'échantillon
x_bar = Float64[]
mom_opt = Float64[]

for n in ns
    x = rand(TDist(1.5), n)  # Génère des échantillons à partir d'une distribution t de Student avec df=1.5 et taille d'échantillon n
    push!(x_bar, mean(x))  # Calcule la moyenne empirique des échantillons générés et l'ajoute à x_bar
    push!(mom_opt, median_of_means_opt(x))  # Calcule l'estimation de la moyenne des moments optimal et l'ajoute à mom_opt
end

plot(ns, x_bar, label="empirical mean")  # Trace la moyenne empirique en fonction de la taille de l'échantillon
plot!(ns, mom_opt, label="mom_opt")  # Trace l'estimation de la moyenne des moments optimal en fonction de la taille de l'échantillon
xlabel!("Taille de l'échantillon")
ylabel!("Valeur")
title!("Comparaison entre la moyenne empirique et l'estimation de la moyenne des moments optimal")




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
