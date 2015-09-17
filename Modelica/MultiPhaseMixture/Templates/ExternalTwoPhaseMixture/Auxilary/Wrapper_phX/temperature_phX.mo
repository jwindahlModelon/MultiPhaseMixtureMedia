within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function temperature_phX
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.SpecificEnthalpy h;
  input Real X[nC]=reference_X;
  output Modelica.SIunits.Temperature T_out;
  input Properties state;
algorithm
   T_out:=state.T_overall;
    annotation(Inline = false,
             LateInline = true);
end temperature_phX;
