within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
function logFugacityCoefficient_pTN
  "Natural logarithm of fugacity coefficients"
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Modelica.SIunits.Temperature";
  input Modelica.SIunits.AmountOfSubstance[nC] N_1ph
    "Molar substance for the specified phase";
  input Integer phaseLabel=PhaseLabelLiquid "Phase label";
  output Real log_phi[nC] "Natural logarithm of fugacity coefficients";
// protected
//   Real phi[nC] "Fugacity coefficients";
// algorithm
//   phi:=fugacityCoefficient_pTN();
//   for i in 1:nC loop
//      log_phi[i]:=log(phi[i]);
//   end for;
protected
  Modelica.SIunits.Pressure p_min=1e-8;
algorithm
  log_phi:=log(fugacity_pTN(p,T,N_1ph,phaseLabel)/max(p,p_min));

  annotation (smoothOrder=5,Documentation(info="<html>
<p>The natural logarithmic fugacity coefficient arises frequently in thermodynamic expressions. According to [1], &QUOT;unlike the fugacity itself this quantity is also well- defined at zero concentration of a a compound and the logarithmic form allows a wider range of numerical values to be represented&QUOT;.</p>
<h4><span style=\"color:#008000\">Reference</span></h4>
<p>[1] Cape-Open specification, Thermodynamic and Physical Properties v1.1.</p>
</html>"));
end logFugacityCoefficient_pTN;
