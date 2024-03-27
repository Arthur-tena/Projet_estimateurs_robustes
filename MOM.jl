using Statistics
using Random


# Configuration de la graine pour la génération de nombres aléatoires
Random.seed!(1813)

# Génération d'une population normalement distribuée
population = randn(1000)  # loc=0, scale=1 par défaut

# Sélection d'un échantillon aléatoire de la population
sample = rand(population, 100)

# Affichage des moyennes de la population et de l'échantillon, et du carré de leur différence
println(mean(population))
println(mean(sample))
println((mean(population) - mean(sample))^2)

function mediane_des_moyennes(seq, n_blocs)
    longueur_seq = length(seq)
    if n_blocs > longueur_seq  # pour éviter que n_blocs > nombre d'observations
        n_blocs = ceil(Int, longueur_seq / 2)
    end
    # division de seq en n_blocs blocs aléatoires
    indic = repeat(1:n_blocs, 1, Int(longueur_seq / n_blocs))
    shuffle!(indic)
    # calcul et enregistrement de la moyenne par bloc
    moyennes = [mean(seq[indic .== bloc]) for bloc in 1:n_blocs]
    # retourne la médiane des moyennes
    return median(moyennes)
end

# En supposant que la variable population est définie
# println(mediane_des_moyennes(population, 10))
# println(mean(population))
# println((mean(population) - mediane_des_moyennes(population, 10))^2)
