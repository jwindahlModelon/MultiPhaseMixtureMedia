within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function phaseComposition_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Integer phaseIndex "Phase index";
  input Properties state;
  output Real Y[nC];
algorithm

   Y:=Wrapper.phaseComposition(phaseIndex,state);

 annotation(Inline = false,LateInline=true);
end phaseComposition_psX;
