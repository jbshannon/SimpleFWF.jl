using SimpleFWF
using Test

@testset "SimpleF.jl" begin
    # Write your tests here.
end


# include("main.jl")
# using DataFrames, CSV

# ## Set parameters
# source = "sample.dat"
# ranges = (1:9, 10:43, 44:52, 53:60)

# ## Get a messed-up DataFrame using CSV.jl
# df = CSV.File(source; delim=' ', ignorerepeated=true) |> DataFrame

# ## Try the standard reader
# df = SimpleFWF.readfwf(source, ranges)

# ## Try the mutating reader
# # Construct df manually
# firstline = readline(source)
# colnames = SimpleFWF.fwfline(firstline, ranges)
# columns = Dict(Symbol(c) => String[] for c in colnames)
# df = DataFrame(columns)

# # Call reader
# SimpleFWF.readfwf!(df, source, ranges)
