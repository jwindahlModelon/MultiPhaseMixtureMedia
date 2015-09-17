within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function temperature_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real T_out;
algorithm
   T_out:=state.T_overall;
    annotation(Inline = false,
             LateInline = true);
end temperature_pTX;
