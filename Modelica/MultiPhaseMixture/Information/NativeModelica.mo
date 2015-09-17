within MultiPhaseMixture.Information;
class NativeModelica "Native Modelica implementation"

  annotation (Documentation(info="<html>
<p>With the model based interface it&apos;s p<span style=\"font-family: MS Shell Dlg 2;\">ossible to share MultiPhaseMixture.Interfaces between an external code based media and a native Modelica based media. </span></p>
<p><br><b>Advantages with a native Modelica media</b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">An advantage of using native Modelica code over external code is that the Modelica compiler has access to structural information on the dependency between inputs and outputs. This makes it possible to automatically differentiate, create analytical Jacobians and explore sparsity patterns that will increase robustness and performance of a simulation. </span></p>
<p><br><b>Flash calculations </b></p>
<p><br>With the model based apporach it&apos;s possible to<span style=\"font-family: Arial,sans-serif;\"> implement a medium using a declarative approach as demonstrated in </span><span style=\"font-family: NimbusRomNo9L-Regu;\">(</span><span style=\"font-family: Arial,sans-serif;\">Olsson </span><span style=\"font-family: NimbusRomNo9L-Regu;\">et al</span><span style=\"font-family: Arial,sans-serif;\">, 2005). It makes it possible to quickly create a medium with good performance. </span><span style=\"font-family: MS Shell Dlg 2;\">A difficulty with the equation based approach is the initialization part, where often start values close to the solution is required in order for the solver to find a solution. It would be interesting to see how property models can be formulated to better support initialization. For example by using the homotopy operator. <span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;</span><span style=\"font-family: Arial,sans-serif;\">This could be an interesting research topic on how to best formulate these algorithms in a declarative way.</span></p><p><br><b><span style=\"font-family: MS Shell Dlg 2;\">Example - DryAir mixture medium</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">See <a href=\"modelica://MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir\">MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir</a> </span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">References</span></b></p>
<ol>
<li>Hans Olsson, Hubertus Tummescheit and Hilding Elmqvist. Using Automatic Differentiation for Partial Derivatives of Functions in Modelica, <i>Proceedings of the 4th International Modelica 2005 Conference</i>, Hamburg, Germany, March 7-8 2005. </li>
</ol>
<p><br><br>&nbsp; </p>
</html>"));
end NativeModelica;
