using Distributions
using RobustMeans
using Plots
using Random

function median_of_means_th(X)
    alpha=0.001
    n = length(X)
    k = trunc(Int, 8 * log(1 / alpha))
    m = div(n, k)
    indic = repeat(1:k, inner = m)
    indic = indic[randperm(length(indic))]
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]

    return median(moyennes)
end

n = 8 * 7
M = 10^5 # M = 10^7 is used for the plot
α = 3.1
distribution = Pareto(α)
μ = mean(distribution) # True mean
σ = std(distribution) # True std
x = rand(distribution, M, n) # M realization of samples of size n

# Store all the realizations into a Dictionary
p = 1 # Parameter of MinskerNdaoud
δ = 3exp(-8) # 0.001
estimators = [EmpiricalMean(), Catoni(σ), Huber(σ), LeeValiant(), MinskerNdaoud(p)]
short_names = ["EM", "CA", "HU", "LV", "MN", "MoM"]
estimates = Dict{MeanEstimator,Vector}()
for estimator in estimators
    estimates[estimator] = [mean(r, δ, estimator) for r in eachrow(x)]
end

# Plotting
plot()
for (i, estimator) in enumerate(estimators)
    plot!(estimates[estimator], label=short_names[i], legend=:topleft, linealpha=0.8, linewidth=2)
end
xlabel!("Sample Number")
ylabel!("Estimate Value")
title!("Estimation Performance Comparison")

using Distributions
using RobustMeans
using Plots
using Random

# Define the median_of_means_th function
function median_of_means_th1(X; alpha=0.001)
    n = length(X)
    k = trunc(Int, 8 * log(1 / alpha))
    m = div(n, k)
    indic = repeat(1:k, inner = m)
    indic = indic[randperm(length(indic))]
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]
    return median(moyennes)
end

# Parameters
n = 8 * 7
M = 10^5 # Adjust M to a lower value for quicker testing
α = 3.1
distribution = Pareto(α)
μ = mean(distribution) # True mean
σ = std(distribution) # True std
x = rand(distribution, M, n) # M realizations of samples of size n

# Store all the realizations into a Dictionary
p = 1 # Parameter of MinskerNdaoud
δ = 3exp(-8) # 0.001
estimators = [EmpiricalMean(), Catoni(σ), Huber(σ)]
short_names = ["EM", "CA", "HU"]
estimates = Dict{String, Vector{Float64}}()

# Calculate estimates for each estimator
for (i, estimator) in enumerate(estimators)
    estimates[short_names[i]] = [mean(r, δ, estimator) for r in eachrow(x)]
end

# Calculate estimates for median_of_means_th
estimates["MoM"] = [median_of_means_th1(r) for r in eachrow(x)]

# Plotting
plot()
for (name, values) in estimates
    plot!(values, label=name, legend=:topleft, linealpha=0.8, linewidth=2)
end
xlabel!("Sample Number")
ylabel!("Estimate Value")
title!("Estimation Performance Comparison")



using Distributions
using RobustMeans
using Plots
using Random

# Définir la fonction median_of_means_th
function median_of_means_th(X)
    alpha = 0.001
    n = length(X)
    k = trunc(Int, 8 * log(1 / alpha))
    m = div(n, k)
    indic = repeat(1:k, inner = m)
    indic = indic[randperm(length(indic))]
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]
    return median(moyennes)
end

n = 8 * 7
M = 10^5 # M = 10^7 is used for the plot
α = 3.1
distribution = Pareto(α)
μ = mean(distribution) # True mean
σ = std(distribution) # True std
x = rand(distribution, M, n) # M realization of samples of size n

# Store all the realizations into a Dictionary
p = 1 # Parameter of MinskerNdaoud
δ = 3exp(-8) # 0.001
estimators = [EmpiricalMean(), Huber(σ)]
short_names = ["EM", "HU", "MoM"]

# Initialize estimates dictionary
estimates = Dict{Any,Vector}()
for estimator in estimators
    estimates[estimator] = [mean(r, δ, estimator) for r in eachrow(x)]
end

# Calculer les estimations pour l'estimateur MoM
mom_estimates = [median_of_means_th(r) for r in eachrow(x)]
estimates["MoM"] = mom_estimates

# Plotting
plot()
for (i, estimator) in enumerate(estimators)
    plot!(estimates[estimator], label=short_names[i], legend=:topleft, linealpha=0.8, linewidth=2)
end

# Tracer les estimations MoM
plot!(estimates["MoM"], label="MoM", legend=:topleft, linealpha=0.8, linewidth=2)
hline!([1.4761904761904763], label="Espérance", c=:black, linestyle=:dash, linealpha=0.8, linewidth=2)

xlabel!("Echantillon")
ylabel!("Valeur de l'estimation")
title!("Comparaison des performances d'estimation")

savefig("C:/Users/aicha/OneDrive/Bureau/Plot/Comparaison_perf_Mean.pdf")



using Distributions
using RobustMeans
using Plots
using Random

# Définir la fonction median_of_means_th
function median_of_means_th(X)
    alpha = 0.001
    n = length(X)
    k = trunc(Int, 8 * log(1 / alpha))
    m = div(n, k)
    indic = repeat(1:k, inner = m)
    indic = indic[randperm(length(indic))]
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]
    return median(moyennes)
end

n = 8 * 7
M = 10^5 # M = 10^7 is used for the plot
α = 3.1
distribution = Pareto(α)
μ = mean(distribution) # True mean
σ = std(distribution) # True std
x = rand(distribution, M, n) # M realization of samples of size n

# Store all the realizations into a Dictionary
p = 1 # Parameter of MinskerNdaoud
δ = 3exp(-8) # 0.001
estimators = [EmpiricalMean(), Catoni(σ), Huber(σ)]
short_names = ["EM", "CA", "HU", "MoM"]

# Initialize estimates dictionary
estimates = Dict{Any,Vector}()
for estimator in estimators
    estimates[estimator] = [mean(r, δ, estimator) for r in eachrow(x)]
end

# Calculer les estimations pour l'estimateur MoM
mom_estimates = [median_of_means_th(r) for r in eachrow(x)]
estimates["MoM"] = mom_estimates


using StatsPlots, LaTeXStrings
gr()
plot_font = "Computer Modern" # To have nice LaTeX font plots.
default(
    fontfamily = plot_font,
    linewidth = 2,
    label = nothing,
    grid = true,
    framestyle = :default
)
# The plot 
begin
    plot(thickness_scaling = 2, size = (1000, 600))
    plot!(Normal(), label = L"\mathcal{N}(0,1)", c = :black, alpha = 0.6)
    for (ns, s) in enumerate(estimators)
        W = √(n) * (estimates[s] .- μ) / σ
        stephist!(W, alpha = 0.6, norm = :pdf, label = short_names[ns], c = ns)
        
    end

    vline!([0], label = :none, c = :black, lw = 1, alpha = 0.9)
    yaxis!(:log10, yminorticks = 9, minorgrid = :y, legend = :topright, minorgridlinewidth = 1.2)
    ylims!((1/M*10, 2))
    ylabel!(L"\sqrt{n}(\hat{\mu}_n-\mu)/\sigma", tickfonthalign = :center)
    xlims!((-5, 10))
    yticks!(10.0 .^ (-7:-0))
end





using Distributions
using RobustMeans
using Plots
using Random

# Définir la fonction median_of_means_th
function median_of_means_th(X)
    alpha = 0.001
    n = length(X)
    k = trunc(Int, 8 * log(1 / alpha))
    m = div(n, k)
    indic = repeat(1:k, inner = m)
    indic = indic[randperm(length(indic))]
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]
    return median(moyennes)
end

n = 8 * 7
M = 10^5 # M = 10^7 is used for the plot
α = 3.1
distribution = Pareto(α)
μ = mean(distribution) # True mean
σ = std(distribution) # True std
x = rand(distribution, M, n) # M realization of samples of size n

# Store all the realizations into a Dictionary
p = 1 # Parameter of MinskerNdaoud
δ = 3exp(-8) # 0.001
estimators = [EmpiricalMean(), Catoni(σ), Huber(σ)]
short_names = ["EM", "HU", "MoM"]

# Initialize estimates dictionary
estimates = Dict{Any,Vector}()
for estimator in estimators
    estimates[estimator] = [mean(r, δ, estimator) for r in eachrow(x)]
end

# Calculer les estimations pour l'estimateur MoM
mom_estimates = [median_of_means_th(r) for r in eachrow(x)]
estimates["MoM"] = mom_estimates

using StatsPlots, LaTeXStrings
gr()
plot_font = "Computer Modern" # To have nice LaTeX font plots.
default(
    fontfamily = plot_font,
    linewidth = 2,
    label = nothing,
    grid = true,
    framestyle = :default
)
# The plot 
begin
    plot(thickness_scaling = 2, size = (1000, 600))
    plot!(Normal(), label = L"\mathcal{N}(0,1)", c = :black, alpha = 0.6)
    for (ns, s) in enumerate(estimators)
        W = √(n) * (estimates[s] .- μ) / σ
        stephist!(W, alpha = 0.6, norm = :pdf, label = short_names[ns], c = ns)
    end

    # Ajouter le tracé pour l'estimateur MoM
    W_mom = √(n) * (mom_estimates .- μ) / σ
    stephist!(W_mom, alpha = 0.6, norm = :pdf, label = "MoM", c = 4)

    vline!([0], label = :none, c = :black, lw = 1, alpha = 0.9)
    yaxis!(:log10, yminorticks = 9, minorgrid = :y, legend = :topright, minorgridlinewidth = 1.2)
    ylims!((1/M*10, 2))
    ylabel!(L"\sqrt{n}(\hat{\mu}_n-\mu)/\sigma", tickfonthalign = :center)
    xlims!((-5, 10))
    yticks!(10.0 .^ (-7:-0))
end


savefig("C:/Users/aicha/OneDrive/Bureau/Plot/Estimateur_centre_Mean.pdf")


using Distributions
using RobustMeans
using Plots
using Random

# Définir la fonction median_of_means_th
function median_of_means_th(X)
    alpha = 0.001
    n = length(X)
    k = trunc(Int, 8 * log(1 / alpha))
    m = div(n, k)
    indic = repeat(1:k, inner = m)
    indic = indic[randperm(length(indic))]
    moyennes = [mean(X[findall(indic .== block)]) for block in 1:k]
    return median(moyennes)
end

n = 8 * 7
M = 10^5 # M = 10^7 is used for the plot
α = 3.1
distribution = Pareto(α)
μ = mean(distribution) # True mean
σ = std(distribution) # True std
x = rand(distribution, M, n) # M realization of samples of size n

# Store all the realizations into a Dictionary
p = 1 # Parameter of MinskerNdaoud
δ = 3exp(-8) # 0.001
estimators = [EmpiricalMean(), Huber(σ)]
short_names = ["EM", "HU", "MoM"]

# Initialize estimates dictionary
estimates = Dict{Any,Vector}()
for estimator in estimators
    estimates[estimator] = [mean(r, δ, estimator) for r in eachrow(x)]
end

# Calculer les estimations pour l'estimateur MoM
mom_estimates = [median_of_means_th(r) for r in eachrow(x)]
estimates["MoM"] = mom_estimates

using StatsPlots, LaTeXStrings
gr()
plot_font = "Computer Modern" # To have nice LaTeX font plots.
default(
    fontfamily = plot_font,
    linewidth = 2,
    label = nothing,
    grid = true,
    framestyle = :default
)

# The plot 
begin
    plot(thickness_scaling = 2, size = (1000, 600))
    plot!(Normal(), label = L"\mathcal{N}(0,1)", c = :black, alpha = 0.6)
    for (ns, s) in enumerate(estimators)
        W = √(n) * (estimates[s] .- μ) / σ
        stephist!(W, alpha = 0.6, norm = :pdf, label = short_names[ns], c = ns)
    end

    # Ajouter le tracé pour l'estimateur MoM
    W_mom = √(n) * (mom_estimates .- μ) / σ
    stephist!(W_mom, alpha = 0.6, norm = :pdf, label = "MoM", c = 4)

    vline!([0], label = :none, c = :black, lw = 1, alpha = 0.9)
    yaxis!(:log10, yminorticks = 9, minorgrid = :y, legend = :topright, minorgridlinewidth = 1.2)
    ylims!((1/M*10, 2))
    ylabel!(L"\sqrt{n}(\hat{\mu}_n-\mu)/\sigma", tickfonthalign = :center)
    xlims!((-5, 10))
    yticks!(10.0 .^ (-7:-0))
end


savefig("C:/Users/aicha/OneDrive/Bureau/Plot/Estimateur_centre_Mean.pdf")


X=Pareto(3.1)
mean(X)