using SimpleFWF
using DataFrames
using Test

@testset "Sample Data Test" begin
    example_data_dict = Dict(
        "COLUMN A" => string.(1:11),
        "COLUMN B" => [
            "SOME VERY LONG STRING WITH SPACES",
            "ANOTHER VERY LONG STRING",
            "MORE STRINGS",
            "STILL MORE STRINGS",
            "FIVE STRINGS",
            "SIX STRINGS",
            "SIX PLUS ONE STRINGS",
            "EIGHT STRINGS",
            "NINE STRINGS",
            "TEN STRINGS",
            "ELEVEN STRINGS",
        ],
        "COLUMN C" => string.(0.5:0.5:5.5),
        "COLUMN D" => [
            "01/01/21",
            "02/01/21",
            "03/01/21",
            "04/01/21",
            "05/01/21",
            "06/01/21",
            "07/01/21",
            "08/01/21",
            "09/01/21",
            "10/01/21",
            "11/01/21"
        ]
    )
    example_df = DataFrame(example_data_dict)
    file_path = joinpath(dirname(@__DIR__), "examples", "sample.dat")
    ranges = (1:9, 10:43, 44:52, 53:60)
    @test readfwf(file_path, ranges) == example_df
end

@testset "Sample Data No Headers Test" begin
    example_data_dict = Dict(
        "x_1" => string.(1:11),
        "x_2" => [
            "SOME VERY LONG STRING WITH SPACES",
            "ANOTHER VERY LONG STRING",
            "MORE STRINGS",
            "STILL MORE STRINGS",
            "FIVE STRINGS",
            "SIX STRINGS",
            "SIX PLUS ONE STRINGS",
            "EIGHT STRINGS",
            "NINE STRINGS",
            "TEN STRINGS",
            "ELEVEN STRINGS",
        ],
        "x_3" => string.(0.5:0.5:5.5),
        "x_4" => [
            "01/01/21",
            "02/01/21",
            "03/01/21",
            "04/01/21",
            "05/01/21",
            "06/01/21",
            "07/01/21",
            "08/01/21",
            "09/01/21",
            "10/01/21",
            "11/01/21"
        ]
    )
    example_df = DataFrame(example_data_dict)
    file_path = joinpath(dirname(@__DIR__), "examples", "sample_no_headers.dat")
    ranges = (1:9, 10:43, 44:52, 53:60)
    @test readfwf(file_path, ranges; headers=false) == example_df
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
