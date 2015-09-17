within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function phaseComposition_dTX
input Modelica.SIunits.Density d "Density";
input Modelica.SIunits.Temperature T "Temperature";
input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
input Integer phaseIndex "Phase index";
  input Properties state;
output Real Y[nC];
algorithm

 Y:=Wrapper.phaseComposition(phaseIndex,state);

  annotation (Inline=false, LateInline=true);
end phaseComposition_dTX;
