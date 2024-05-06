using DataFrames, CSV, Downloads, Dates
using DataFramesMeta, StatsBase
using StatsPlots

df = CSV.read("RR_STAID002207.txt", DataFrame; comment="#", normalizenames=true, dateformat="yyyymmdd", types=Dict(:DATE => Date, :RR => Float64), header = 21)

@subset!(df, :Q_RR .!= 9)
@transform!(df, :RR = :RR *0.1)

@df df stephist(:RR, norm = :pdf)
ylims!(1e-4,1)
yaxis!(:log10)
xlabel!("Rain/day (mm/m²)")
ylabel!("PDF")

mean(df.RR)

# Focus only on 1 day of the year to have 78 i.i.d data

date_extreme = @subset(df, :RR .> 200).DATE[1]
iid_data =  @subset(df, monthday.(:DATE) .== monthday.(date_extreme))
@df iid_data stephist(:RR, norm = :pdf)
ylims!(1e-4,1)
yaxis!(:log10)
xlabel!("Rain/day (mm/m²)")
ylabel!("PDF")

mean(iid_data.RR)
