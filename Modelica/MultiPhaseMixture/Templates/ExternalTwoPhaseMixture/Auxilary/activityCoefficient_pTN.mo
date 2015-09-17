within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
function activityCoefficient_pTN
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Modelica.SIunits.Temperature";
  input Modelica.SIunits.AmountOfSubstance[nC] N_1ph
    "Molar substance for the specified phase";
   output Real gamma[nC](each unit="1")
    "Activity coefficients for specified phase";
algorithm
  assert(false, "Not implemented");
  annotation (Documentation(info="<html>
<p>An activity coefficient is a factor used in thermodynamics to account for deviations from ideal behaviour in a mixture of chemical substances.</p>
<p>It&apos;s common to define an activity coefficient for liquid mixtures that can&apos;t be described by an equation of state. </p>
<p>Examples of commonly used activity coefficient models are:</p>
<ul>
<li>one parameter Margules</li>
<li>two parameter Margules</li>
<li>van Laar</li>
<li>Wilson equation</li>
<li>NRTL equation</li>
<li>UNIFAc metjpd</li>
</ul>
<h4><span style=\"color:#008000\">Definition</span></h4>
<p>Activity coefficient gamma is defined by equation:</p>
<p>f_i_liquid=x_i*gamma_i(p,T,x)*f_i_liquid(p,T)</p>
<h4><span style=\"color:#008000\">Reference</span></h4>
<p>Chemical and engineering thermodynamics, Stanley I. Sander, 3:rd edition, page 401.</p>
<p>Chemical Engineering Thermodynamics, Pradeep Ahuja, page 453</p>
</html>"));
end activityCoefficient_pTN;
