within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function specificEnthalpy_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real h_out;
algorithm
   h_out:=state.h_overall;
    annotation(Inline = false,
             LateInline = true);
end specificEnthalpy_dTX;
