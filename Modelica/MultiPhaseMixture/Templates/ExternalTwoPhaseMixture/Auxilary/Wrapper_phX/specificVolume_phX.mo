within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function specificVolume_phX
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.SpecificEnthalpy h;
  input Real X[nC]=reference_X;
  output Modelica.SIunits.SpecificVolume v_out;
  input Properties state;

algorithm
   v_out:=1/state.d_overall;
    annotation(Inline = false,
             LateInline = true);
end specificVolume_phX;
