within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function specificInternalEnergy_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real u;
algorithm
   u:=state.h_overall-state.p_overall/state.d_overall;
    annotation(Inline = false,
             LateInline = true);
end specificInternalEnergy_pTX;
