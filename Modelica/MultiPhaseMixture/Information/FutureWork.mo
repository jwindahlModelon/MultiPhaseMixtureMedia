within MultiPhaseMixture.Information;
class FutureWork "Future Work"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>First the framework needs to be further tested. It would be interesting to also test it for other application libraries and use cases.</p>
<p>Its possible to improve the framework in following directions: </p>
<ul>
<li>Implement an infrastructure for native Modelica implementation of fluids with support of various equations of states and mixing rules including phase equilibrium solvers. The later could be an interesting research topic on how to best formulate these algorithms in a declarative way. A difficulty with the equation based approach is the initialization part, where it would be interesting to see how property models can be formulated to better support initialization. For example by using the homotopy operator. </li>
<li>Extend the C-interface back end to support more property packages such as MultiFlash. </li>
<li>Adding additional functionality such as reaction properties. Support of more derivatives, see missing properties in MultiPhaseMixture.Information.ComparisonModelicaMedia.</li>
</ul>
</html>"));
end FutureWork;
