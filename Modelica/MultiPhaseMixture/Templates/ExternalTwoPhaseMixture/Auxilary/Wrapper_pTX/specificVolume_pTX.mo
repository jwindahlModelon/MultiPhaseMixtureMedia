within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function specificVolume_pTX
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.Temperature T;
  input Real X[nC]=reference_X;
  output Modelica.SIunits.SpecificVolume v_out;
  input Properties state;
//  output Real v_out;
algorithm
   v_out:=1/state.d_overall;
    annotation(Inline = false,
             LateInline = true);
end specificVolume_pTX;
