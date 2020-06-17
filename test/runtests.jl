using Irace
using Test

function test()
    parameters_table = """
     mean "" i (0, 5000)
     var "" r (0, 10)
     """

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

     scenario = Dict( :targetRunner => target_runner,
                      :instances => collect(1:10),
                      :maxExperiments => 10000,
                      # Do not create a logFile
                      :logFile => "")

    ## We use the irace function readParameters to read this table:
    #parameters = Irace.readParameters(parameters_table)
    println("------------------------")
    Irace.checkIraceScenario(scenario, parameters_table)
    println("========================")
    tuned= Irace.irace(scenario, parameters_table)
    Irace.configurations_print(tuned)
    true
end


@test test()
