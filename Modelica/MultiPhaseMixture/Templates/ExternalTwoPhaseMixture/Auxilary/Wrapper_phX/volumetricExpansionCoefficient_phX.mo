within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function volumetricExpansionCoefficient_phX

  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output Real beta;

algorithm
 beta:=Wrapper.volumetricExpansionCoefficient(state);
 annotation(Inline = false,LateInline=true);
end volumetricExpansionCoefficient_phX;
