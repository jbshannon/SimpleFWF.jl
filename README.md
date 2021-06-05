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

11×4 DataFrame
 Row │ COLUMN A  COLUMN B                           COLUMN C  COLUMN D
     │ String    String                             String    String
─────┼─────────────────────────────────────────────────────────────────
   1 │ 1         SOME VERY LONG STRING WITH SPACES  0.5       01/01/21
   2 │ 2         ANOTHER VERY LONG STRING           1.0       02/01/21
   3 │ 3         MORE STRINGS                       1.5       03/01/21
   4 │ 4         STILL MORE STRINGS                 2.0       04/01/21
   5 │ 5         FIVE STRINGS                       2.5       05/01/21
   6 │ 6         SIX STRINGS                        3.0       06/01/21
   7 │ 7         SIX PLUS ONE STRINGS               3.5       07/01/21
   8 │ 8         EIGHT STRINGS                      4.0       08/01/21
   9 │ 9         NINE STRINGS                       4.5       09/01/21
  10 │ 10        TEN STRINGS                        5.0       10/01/21
  11 │ 11        ELEVEN STRINGS                     5.5       11/01/21

```
