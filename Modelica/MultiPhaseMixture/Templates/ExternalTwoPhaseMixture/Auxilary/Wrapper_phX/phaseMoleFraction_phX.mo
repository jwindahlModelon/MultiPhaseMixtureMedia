within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function phaseMoleFraction_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Integer phaseIndex "Phase index";
  input Properties state;
  output Modelica.SIunits.MoleFraction Y "Phase Mole fraction";
algorithm
   Y:=Wrapper.phaseMoleFraction(phaseIndex,state);
 annotation(Inline = false,LateInline=true);
end phaseMoleFraction_phX;
