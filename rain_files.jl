using DataFrames, CSV, Downloads, Dates
using DataFramesMeta, StatsBase
using StatsPlots
using Random
using Distributions

# Montpellier

df = CSV.read("C:/Users/aicha/OneDrive/Bureau/Estimateur_Robuste/Projet_estimateurs_robustes/RR_STAID002207.txt", DataFrame; comment="#", normalizenames=true, dateformat="yyyymmdd", types=Dict(:DATE => Date, :RR => Float64), header = 21)
size(df)

@subset!(df, :Q_RR .!= 9) # Enlever les valeurs manquantes
df1=@transform!(df, :RR = :RR *0.1) # Convertir les valeurs en mm/m²


@df df stephist(:RR, norm = :pdf) # Histogramme des précipitations
ylims!(1e-4,1) # Limite de l'axe des ordonnées
yaxis!(:log10) # Echelle logarithmique
xlabel!("Rain/day (mm/m²)") # Titre de l'axe des abscisses
ylabel!("PDF")  # Titre de l'axe des ordonnées

mean(df.RR) # Moyenne des précipitations

# Focus only on 1 day of the year to have 78 i.i.d data

date_extreme = @subset(df, :RR .> 200).DATE[1] #Identifie la première date où les précipitations dépassent 200 mm/m² (29/09/2014)
iid_data =  @subset(df, monthday.(:DATE) .== monthday.(date_extreme)) # Sélectionne les données du DataFrame df qui correspondent au mois et au jour de cette date extrême.
@df iid_data stephist(:RR, norm = :pdf)
ylims!(1e-4,1)
yaxis!(:log10)
xlabel!("Rain/day (mm/m²)")
ylabel!("PDF")

mean(iid_data.RR)
println("La moyenne des précipitations est de ", mean(iid_data.RR), " mm/m²")
print(idd_data.RR)

function median_of_means_th(X)
    alpha=0.025
    n = length(X)
    k = trunc(Int, 8 * log(1 / alpha))
    m = div(n, k)
    indic = repeat(1:k, inner = m)
    indic = indic[randperm(length(indic))]
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]

    return median(moyennes)
end

median_of_means_th(iid_data.RR)

function median_of_means(X, k)
    if k > length(X)
        k = ceil(Int, length(X) / 2)
    end
    indic = repeat(1:k, inner = div(length(X), k))
    indic = indic[randperm(length(indic))]  # Mélange les indices aléatoirement
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]
    return median(moyennes)
end



median_of_means(iid_data.RR, 4)



#A partir de 30 blocs, l'estimateur converge vers 0, or median_of_means_th(iid_data.RR)=0.1 donc cela semble possitif de prendre k=30
# Nombre de blocs (k) à tester
k_values = 1:50

# Calculer l'estimateur pour chaque valeur de k
estimateurs = [median_of_means(iid_data.RR, k) for k in k_values]

# Tracer l'évolution de l'estimateur en fonction de k
plot(k_values, estimateurs, marker=:circle, xlabel="Nombre de blocs (k)", ylabel="Estimateur Mom",
    title="Évolution de l'estimateur MOM en fonction de k", legend=false)
savefig("C:/Users/aicha/OneDrive/Bureau/Plot/K_pluie_MTP_MoM.pdf")
#
#median_of_means(iid_data.RR, 30)
#
#alphas= 0.01:0.01:0.1
#X = iid_data.RR
#Y = [median_of_means_th(X[1:i]) for i in 1:n]
#plot(1:n, Y, label = "Median of means", xlabel = "Taille de l'échantillon
#", ylabel = "MoM", title = "Evolution de l'estimateur MoM en fonction de n")
#
#
##Je veux maintenant tracer l'evolution de l'estimateur median_of_means_th en fonction de alpha pour alpha allant de 0.01 à 0.1
#
#alphas= 0.01:0.01:0.1
#X = iid_data.RR
#Y= [median_of_means_th(X) for alpha in alphas]
#plot(alphas, Y, label = "Median of means", xlabel = "alpha", ylabel = "MoM", title = "Evolution de l'estimateur MoM en fonction de alpha")
#
#Z=rand(Weibull(0.5),100000)
#function execute_n_times_and_find_extremes(n::Int, X)
#    # Vecteur pour stocker les résultats
#    results = Vector{Float64}(undef, n)
#    
#    # Exécution de la fonction n fois et stockage des résultats
#    for i in 1:n
#        results[i] = median_of_means_th(X)
#    end
#    
#    # Trouver la valeur minimale et maximale
#    min_value = minimum(results)
#    max_value = maximum(results)
#    mean_value = mean(results)
#    
#    return min_value, max_value,mean_value
#end
#
#execute_n_times_and_find_extremes(1000, Z)
#
##function median_of_means_minsker(X, k)
##    if k > length(X)
##        k = ceil(Int, length(X) / 2)
##    end
##    
##    n = length(X)
##    all_combinations = collect(combinations(1:n,k))
#    means_vector = Float64[]
#
#    for combination in all_combinations
#        indic = falses(n)
#        indic[combination] .= true
#        moyennes = [mean(X[indic .== true]) for _ in 1:k]
#        push!(means_vector, mean(moyennes))
#    end
#    
#    return median(means_vector)
#end

#using Combinatorics
#median_of_means_minsker(iid_data.RR, 6)






date_extreme = @subset(df, :RR .> 200).DATE[2] #Identifie la première date où les précipitations dépassent 200 mm/m² (29/09/2014)
iid_data1 =  @subset(df, monthday.(:DATE) .== monthday.(date_extreme)) # Sélectionne les données du DataFrame df qui correspondent au mois et au jour de cette date extrême.
@df iid_data stephist(:RR, norm = :pdf)
ylims!(1e-4,1)
yaxis!(:log10)
xlabel!("Rain/day (mm/m²)")
ylabel!("PDF")

median_of_means_th(iid_data1.RR)
mean(iid_data1.RR)

print(iid_data1.RR)


