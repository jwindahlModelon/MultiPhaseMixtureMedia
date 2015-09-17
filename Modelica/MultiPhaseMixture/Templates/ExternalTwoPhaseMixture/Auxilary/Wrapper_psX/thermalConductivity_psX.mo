within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function thermalConductivity_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real lambda;
algorithm
lambda:=Wrapper.thermalConductivity(state);
    annotation(Inline = false,
             LateInline = true);
end thermalConductivity_psX;
