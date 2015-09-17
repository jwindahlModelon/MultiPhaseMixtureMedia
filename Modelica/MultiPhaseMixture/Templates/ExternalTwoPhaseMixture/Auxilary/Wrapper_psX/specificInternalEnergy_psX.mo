within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function specificInternalEnergy_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real u;
algorithm
   u:=state.h_overall-state.p_overall/state.d_overall;
    annotation(Inline = false,
             LateInline = true);
end specificInternalEnergy_psX;
