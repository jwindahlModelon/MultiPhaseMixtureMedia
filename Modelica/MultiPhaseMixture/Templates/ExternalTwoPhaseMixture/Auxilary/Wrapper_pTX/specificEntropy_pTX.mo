within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function specificEntropy_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real s;
algorithm
   s:=state.s_overall;
    annotation(Inline = false,
             LateInline = true);
end specificEntropy_pTX;
