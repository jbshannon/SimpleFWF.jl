module SimpleFWF

using DataFrames, CSV

export readfwf, readfwf!

function fwfline(line, ranges; stripstr=true)
    data = String[]
    for r in ranges
        ldata = stripstr ? strip(SubString(line, r)) : SubString(line, r)
        push!(data, ldata)
    end
    return data
end

"""
    readfwf(source, ranges; stripstr=true) -> DataFrame

Reads a fixed-width file `source` into a `DataFrame` using pre-defined column widths in `ranges`.

# Examples
```julia-repl
julia> df = readfwf("sample.dat", (10:43, 53:60))
```
"""
function readfwf(source, ranges; stripstr=true)
    lines = eachline(source)

    # Construct DataFrame
    firstline, lines = Base.Iterators.peel(lines)
    colnames = fwfline(firstline, ranges)
    columns = Dict(Symbol(c) => String[] for c in colnames)
    df = DataFrame(columns)

    # Read data
    for line in lines
        push!(df, fwfline(line, ranges; stripstr))
    end
    return df
end

end