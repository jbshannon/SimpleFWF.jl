# SimpleFWF.jl

[![CI](https://github.com/jbshannon/SimpleFWF.jl/workflows/CI/badge.svg)](https://github.com/jbshannon/SimpleFWF.jl/actions?query=workflow%3ACI)
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/jbshannon/SimpleFWF.jl)

Simple proof-of-concept reader for fixed-width files in Julia. Based on [this discussion](https://discourse.julialang.org/t/reading-fixed-width-files-a-preliminary-solution/60525) on the JuliaLang Discourse.

## Installation

Since it's not a registered package, simply `add` by pointing to this repo.

```julia-repl
julia> ]
(env) add https://github.com/jbshannon/SimpleFWF.jl 
```

## Examples

Consider a fixed-width file with spaces in each column.

```julia-repl
julia> for line in eachline("examples/sample.dat")
       println(line)
       end
COLUMN A COLUMN B                          COLUMN C COLUMN D
       1 SOME VERY LONG STRING WITH SPACES 0.5      01/01/21
       2 ANOTHER VERY LONG STRING          1.0      02/01/21
       3 MORE STRINGS                      1.5      03/01/21
       4 STILL MORE STRINGS                2.0      04/01/21
       5 FIVE STRINGS                      2.5      05/01/21
       6 SIX STRINGS                       3.0      06/01/21
       7 SIX PLUS ONE STRINGS              3.5      07/01/21
       8 EIGHT STRINGS                     4.0      08/01/21
       9 NINE STRINGS                      4.5      09/01/21
      10 TEN STRINGS                       5.0      10/01/21
      11 ELEVEN STRINGS                    5.5      11/01/21
```

The [current fixed-width solution](https://csv.juliadata.org/stable/#Fixed-Width-Files) from CSV.jl mangles the file pretty badly.

```julia-repl
julia> using CSV, DataFrames

julia> df = CSV.File("examples/sample.dat"; delim=' ', ignorerepeated=true) |> DataFrame
┌ Warning: thread = 1 warning: parsed expected 8 columns, but didn't reach end of line around data row: 2. Ignoring any extra columns on this row
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:606
┌ Warning: thread = 1 warning: only found 5 / 8 columns around data row: 4. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 6 / 8 columns around data row: 5. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 5 / 8 columns around data row: 6. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 5 / 8 columns around data row: 7. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 7 / 8 columns around data row: 8. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 5 / 8 columns around data row: 9. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 5 / 8 columns around data row: 10. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 5 / 8 columns around data row: 11. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
┌ Warning: thread = 1 warning: only found 5 / 8 columns around data row: 12. Filling remaining columns with `missing`
└ @ CSV ~/.julia/packages/CSV/CJfFO/src/file.jl:605
11×8 DataFrame
 Row │ COLUMN   A       COLUMN_1  B        COLUMN_2  C         COLUMN_3  D        
     │ Int64?   String  String    String   String    String?   String?   String?  
─────┼────────────────────────────────────────────────────────────────────────────
   1 │       1  SOME    VERY      LONG     STRING    WITH      SPACES    0.5
   2 │ missing  2       ANOTHER   VERY     LONG      STRING    1.0       02/01/21
   3 │       3  MORE    STRINGS   1.5      03/01/21  missing   missing   missing  
   4 │       4  STILL   MORE      STRINGS  2.0       04/01/21  missing   missing  
   5 │       5  FIVE    STRINGS   2.5      05/01/21  missing   missing   missing  
   6 │       6  SIX     STRINGS   3.0      06/01/21  missing   missing   missing  
   7 │       7  SIX     PLUS      ONE      STRINGS   3.5       07/01/21  missing  
   8 │       8  EIGHT   STRINGS   4.0      08/01/21  missing   missing   missing  
   9 │       9  NINE    STRINGS   4.5      09/01/21  missing   missing   missing  
  10 │      10  TEN     STRINGS   5.0      10/01/21  missing   missing   missing  
  11 │      11  ELEVEN  STRINGS   5.5      11/01/21  missing   missing   missing  
```

This package handles fixed-width files by explicitly declaring column widths.

```julia-repl
julia> using SimpleFWF

julia> ranges = (1:9, 10:43, 44:52, 53:60)

julia> df = readfwf("examples/sample.dat", ranges)

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
