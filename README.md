# SimpleFWF.jl

[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)

Simple proof-of-concept reader for fixed-width files in Julia. Based on [this discussion](https://discourse.julialang.org/t/reading-fixed-width-files-a-preliminary-solution/60525) on the JuliaLang Discourse.

## Installation

Since it's not a registered package, simpy `add` by pointing to this repo.

```julia-repl
julia> ]
(env) add https://github.com/jbshannon/SimpleFWF.jl 
```

## Examples

```julia-repl
julia> ranges = (1:9, 10:43, 44:52, 53:60)

julia> df = readfwf("sample.dat", ranges)
```
