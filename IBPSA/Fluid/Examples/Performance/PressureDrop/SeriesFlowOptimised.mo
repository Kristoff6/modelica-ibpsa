within IBPSA.Fluid.Examples.Performance.PressureDrop;
model SeriesFlowOptimised
  "Series connection with prescribed flow and optimised parameters"
  extends SeriesFlow(resSeries(  each from_dp=true));
  annotation (Documentation(revisions="<html>
<ul>
<li>
May 26, 2017, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Example model that demonstrates how translation statistics 
depend on the type of boundary conditions, 
the parallel/series configuration of the components 
and the value of parameter <code>from_dp</code>.
</p>
</html>"), __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/Examples/Performance/PressureDrop/SeriesFlowOptimised.mos"
        "Simulate and plot"));
end SeriesFlowOptimised;
