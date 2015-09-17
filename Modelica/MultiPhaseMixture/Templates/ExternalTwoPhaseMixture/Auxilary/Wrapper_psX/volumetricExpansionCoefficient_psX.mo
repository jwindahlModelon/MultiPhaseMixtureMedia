within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function volumetricExpansionCoefficient_psX

  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output Real beta;

algorithm
 beta:=Wrapper.volumetricExpansionCoefficient(state);
 annotation(Inline = false,LateInline=true);
end volumetricExpansionCoefficient_psX;
