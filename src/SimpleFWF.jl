module SimpleFWF

using DataFrames, CSV

export readfwf

function fwfline(line, ranges; stripstr=true)
    data = String[]
    for r in ranges
        ldata = stripstr ? strip(SubString(line, r)) : SubString(line, r)
        push!(data, ldata)
    end
    return data
end

"""
    readfwf(source, ranges; stripstr=true, headers=true) -> DataFrame

Reads a fixed-width file `source` into a `DataFrame` using pre-defined column widths in `ranges`.

# Examples
```julia-repl
julia> df = readfwf("sample.dat", (10:43, 53:60))
```
"""
function readfwf(source, ranges; stripstr=true, headers=true)
    lines = eachline(source)

    # Construct DataFrame
    if headers
        firstline, lines = Base.Iterators.peel(lines)
        colnames = fwfline(firstline, ranges)
    else
        colnames = ["x_$i" for i in eachindex(ranges)]
    end
    columns = Dict(Symbol(c) => String[] for c in colnames)
    df = DataFrame(columns)

    # Read data
    for line in lines
        push!(df, fwfline(line, ranges; stripstr))
    end
    return df
end

end