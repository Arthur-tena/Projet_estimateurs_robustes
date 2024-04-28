using Plots
using Distributions
using SpecialFunctions

lambda = 1.5
k = 2.0

mu = lambda * gamma(1 + 1/k)

println("La moyenne théorique de la distribution de Weibull est : ", mu)

# Plot de la médiane des moyennes en fonction de la valeur de c

function median_of_means_opt_C(seq, alpha=0.025)
    if alpha <= 0 || alpha > 1
        throw(ArgumentError("alpha doit être supérieur à 0 et inférieur ou égal à 1"))
    end
    
    medians = []
    for c in 1:40
        n = length(seq)
        k = abs(trunc(Int, c * log(1 / alpha)))
        m = div(n, k)
        means = [mean(seq[((i-1)*m+1):min(i*m, n)]) for i in 1:k]
        push!(medians, median(means))
    end
    return medians
end

# Data
# Loi exponentielle
# Moyenne théorique = 2
data1 = rand(Exponential(2), 10000)

#Loi de Pareto
#Moyenne théorique =3
data2 = rand(Pareto(1.5, 1.0),10000)

# Loi de Weibull

data3 = rand(Weibull(1.5, 2.0),10000)

#Calcul de la moyenne théorique de la distribution de Weibull
lambda = 1.5
k = 2.0
mu = lambda * gamma(1 + 1/k)
println("La moyenne théorique de la distribution de Weibull est : ", mu)


#Plot d'une loi exponentielle de paramètre 2

# Tracer le graphique
plot(1:40, median_of_means_optC(data1,0.025), xlabel="Valeur de c", ylabel="Estimateur (médiane des moyennes)", 
    title="Estimateur en fonction de la valeur de c", legend=false)

# Ajout de la droite verticale à x = 8
vline!([8], color=:red, linestyle=:dash, label="x = 8")

# Ajout de la droite horizontale à y = mean(data1)
hline!([mean(data1)], color=:blue, linestyle=:dash, label="y = mean(data1)")



# Plot d'une loi de Pareto

# Tracer le graphique
plot(1:40, median_of_means_optC(data2,0.025), xlabel="Valeur de c", ylabel="Estimateur (médiane des moyennes)", 
    title="Estimateur en fonction de la valeur de c", legend=false)

# Ajout de la droite verticale à x = 8
vline!([8], color=:red, linestyle=:dash, label="x = 8")

# Ajout de la droite horizontale à y = mean(data2)
hline!([mean(data2)], color=:blue, linestyle=:dash, label="y = mean(data2)")

# Plot d'une loi de Weibull

# Tracer le graphique
plot(1:40, median_of_means_optC(data3,0.025), xlabel="Valeur de c", ylabel="Estimateur (médiane des moyennes)", 
    title="Estimateur en fonction de la valeur de c", legend=false)

# Ajout de la droite verticale à x = 8  
vline!([8], color=:red, linestyle=:dash, label="x = 8")

# Ajout de la droite horizontale à y = mean(data3)
hline!([mean(data3)],color=:blue, linestyle=:dash, label="y = mean(data3)"

#Fonction de l'évolution de l'estimateur en fonction de alpha

function median_of_meanAlpha(X)
    medians = Float64[]  # Utiliser Float64[] pour créer un vecteur vide de Float64
    alphas = 0.001:0.001:0.1  # Plage d'alphas de 0.001 à 0.1
    tolerance = 1e-10  # Valeur de tolérance pour alpha
    for alpha in alphas
        n = length(X)
        if alpha > tolerance
            k = abs(trunc(Int, 8 * log(1 / alpha)))
            m = div(n, k)
            means = [mean(X[((i-1)*m+1):min(i*m, n)]) for i in 1:k]
            push!(medians, median(means))
        else
            push!(medians, NaN)
        end
    end
    return  alphas,medians  # Retourner également le vecteur d'alphas
end
    

#Plot sur une Loi exponentielle de paramètre 2

#Mean=2

plot(median_of_meanAlpha(data1), xlabel="Valeur de α", ylabel="Estimateur (médiane des moyennes)", 
        title="Estimateur en fonction de la valeur de α", legend=false)

# Ajout de la droite horizontale à y = mean(data1)
hline!([mean(data1)], color=:blue, linestyle=:dash, label="y = mean(data1)")


#Plot sur une Loi de Pareto


plot(median_of_meanAlpha(data2), xlabel="Valeur de α", ylabel="Estimateur (médiane des moyennes)", 
        title="Estimateur en fonction de la valeur de α", legend=false)

#Plot sur une Loi de Weibull

plot(median_of_meanAlpha(data3), xlabel="Valeur de α", ylabel="Estimateur (médiane des moyennes)", 
        title="Estimateur en fonction de la valeur de α", legend=false)



#Fonction qui génére un graphque avec mom vs la moyenne empirique

function simulate_means_and_mom(k, m_range, dist)
    ns = k .* m_range
    x_bar = Float64[] 
    mom = Float64[] 

    for n in ns
        x = rand(dist, n)
        push!(x_bar, mean(x))
        push!(mom, median_of_means_opt(x, 0.025))
    end

    plot(ns, x_bar, label="Empirical Mean", title="Empirical Mean vs Median of Means", xlabel="Sample Size", ylabel="Mean")
    plot!(ns, mom, label="Median of Means")
end


# Estimateur naif invinté par Arthur le grand

function rob_median_of_means(seq,l)
    res = [median_of_means_opt_C(seq, 0.025) for _ in 1:l]
    return mean(res)
end

# Plot de l'estimateur en fonction de la valeur de C

plot(rob_median_of_means(data1,1000), xlabel="Valeur de C", ylabel="Estimateur (médiane des moyennes)", 
        title="Estimateur en fonction de la valeur de C", legend=false)

# Plot de l'estimateur en fonction de la valeur de C

plot(rob_median_of_means(data2,1000), xlabel="Valeur de C", ylabel="Estimateur (médiane des moyennes)", 
        title="Estimateur en fonction de la valeur de C", legend=false)

# Plot de l'estimateur en fonction de la valeur de C

plot(rob_median_of_means(data3,1000), xlabel="Valeur de C", ylabel="Estimateur (médiane des moyennes)", 
        title="Estimateur en fonction de la valeur de C", legend=false)