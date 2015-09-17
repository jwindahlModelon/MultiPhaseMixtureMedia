within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function volumetricExpansionCoefficient_dTX

  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output Real beta;

algorithm
 beta:=Wrapper.volumetricExpansionCoefficient(state);
 annotation(Inline = false,LateInline=true);
end volumetricExpansionCoefficient_dTX;
