# Irace (wrapper) for Julia

You can configure your algorithms (hyper-parameters optimization) by using the Irace
package written in R. **Recommended only if your target algorithm is a julia function.**

## Installation

If your are using a windows OS, good look, I don't know if this wrapper is compatible.
However, if your are using some linux-based OS:

1. Install R
2. Open the R REPL and write `install.packages("irace")`

Now, you are able to install Irace in julia: Open the julia REPL and type `]`

```
Pkg> add https://github.com/jmejia8/Irace.git
```

## Example

Simple example.

Parameter definition (bounds, type, etc.)
```julia
parameters_table = """
 mean "" i (0, 5000)
 var "" r (0, 10)
 """
```

Target runner:
```julia
 target_runner(experiment, scenario) = begin
     instance = experiment[:instance]
     configuration = experiment[:configuration]

     value = configuration[!,:mean] + configuration[!,:var]*rand()

     return Dict(
        :cost => value,
        # :time => "",
        # :error => "",
        # :outputRaw => "",
        # :call => "",
     )
 end
```

Now, the scenario can be defined by using a dictionary and using the names
as in irace for R:
```julia
 scenario = Dict( :targetRunner => target_runner,
                  :instances => collect(1:10),
                  :maxExperiments => 10000,
                  # Do not create a logFile
                  :logFile => "")
```

Time to configure:
```julia
# (optional) check if you've configured  correctly
Irace.checkIraceScenario(scenario, parameters_table)

# get the results
tuned = Irace.irace(scenario, parameters_table)

# print the best configurations
Irace.configurations_print(tuned)
```
