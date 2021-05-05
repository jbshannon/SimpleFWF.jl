# SimpleFWF.jl

Simple proof-of-concept reader for fixed-width files in Julia. Based on [this discussion](https://discourse.julialang.org/t/reading-fixed-width-files-a-preliminary-solution/60525) on the JuliaLang Discourse.

## Examples

```julia-repl
julia> ranges = (10:43, 53:60)

julia> df = readfwf("sample.dat", ranges)
```
