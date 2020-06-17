module Irace

using RCall
## We check that the scenario is valid. This will also try to execute
# target.runner.
function checkIraceScenario(scenario, parameters)
    R"""
        library(irace)
        params  <- readParameters(text = $parameters)
        checkIraceScenario($scenario, parameters = params)
    """
end


## We are now ready to launch irace. We do it by means of the irace
# function. The function will print information about its
# progress. This may require a few minutes, so it is not run by default.
function irace(scenario, parameters)
    R"""
    library(irace)
    params  <- readParameters(text = $parameters)
    tuned_confs <- irace(scenario = $scenario, parameters = params)
    """
    @rget tuned_confs
end

function readParameters(text)
    R"""
    library(irace)
    res  <- readParameters(text = $text)
    """
    @rget res
end

function configurations_print(tuned_confs)
    R"""
    library(irace)
    configurations.print($tuned_confs)
    """
end

## We can print the best configurations found by irace as follows:
#configurations.print(tuned.confs)

end # module
