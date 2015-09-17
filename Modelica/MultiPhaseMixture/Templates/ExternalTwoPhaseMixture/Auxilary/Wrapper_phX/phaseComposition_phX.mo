within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function phaseComposition_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Integer phaseIndex "Phase index";
  input Properties state;
  output Real Y[nC];
algorithm

   Y:=Wrapper.phaseComposition(phaseIndex,state);

 annotation(Inline = false,LateInline=true);
end phaseComposition_phX;
