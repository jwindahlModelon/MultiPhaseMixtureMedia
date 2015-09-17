within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function phaseComposition_pTX
 input Modelica.SIunits.Pressure p "Pressure";
 input Modelica.SIunits.Temperature T "Temperature";
 input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
 input Integer phaseIndex "Phase index";
  input Properties state;
 output Real Y[nC];
algorithm

  Y:=Wrapper.phaseComposition(phaseIndex,state);

annotation(Inline = false,LateInline=true);
end phaseComposition_pTX;
