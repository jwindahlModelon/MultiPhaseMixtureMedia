within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function specificEnthalpy_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real h_out;
algorithm
   h_out:=state.h_overall;
    annotation(Inline = false,
             LateInline = true);
end specificEnthalpy_psX;
