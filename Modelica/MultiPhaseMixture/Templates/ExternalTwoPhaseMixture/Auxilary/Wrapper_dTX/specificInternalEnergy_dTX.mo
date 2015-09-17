within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function specificInternalEnergy_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real u;
algorithm
   u:=state.h_overall-state.p_overall/state.d_overall;
    annotation(Inline = false,
             LateInline = true);
end specificInternalEnergy_dTX;
