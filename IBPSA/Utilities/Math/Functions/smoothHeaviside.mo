within IBPSA.Utilities.Math.Functions;
function smoothHeaviside
  "Twice continuously differentiable approximation to the Heaviside function"
  extends Modelica.Icons.Function;
  input Real x "Argument";
  output Real y "Result";
algorithm
 y := max(0, min(1, x^3*(10+x*(-15+6*x))));

 annotation (smoothOrder = 2,
 Documentation(info="<html>
<p>
Twice continuously differentiable approximation to the
<code>Heaviside(.,.)</code> function.<br/>
Function is derived from a quintic polynomal going through (0,0) and (1,1), 
with zero first and second order derivatives at those points.<br/>
See Example <a href=\"modelica://IBPSA.Utilities.Math.Examples.SmoothHeaviside\">
IBPSA.Utilities.Math.Examples.SmoothHeaviside</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
Setpember 13, 2019, by Kristoff Six:<br/>
Once continuously differentiable replaced by twice continuously differentiable implementation. This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1202\">issue 1202</a>.
</li>
<li>
March 15, 2016, by Michael Wetter:<br/>
Replaced <code>spliceFunction</code> with <code>regStep</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/300\">issue 300</a>.
</li>
<li>
July 17, 2015, by Marcus Fuchs:<br/>
Add link to example.
</li>
<li>
February 5, 2015, by Filip Jorissen:<br/>
Added <code>smoothOrder = 1</code>.
</li>
<li>
July 14, 2010, by Wangda Zuo, Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end smoothHeaviside;
