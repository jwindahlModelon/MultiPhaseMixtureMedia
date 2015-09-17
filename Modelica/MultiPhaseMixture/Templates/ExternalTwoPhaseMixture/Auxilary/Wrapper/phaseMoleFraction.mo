within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function phaseMoleFraction
  input Integer phaseIndex "Phase index";
  input Properties state;
  output Modelica.SIunits.MoleFraction Y "Phase Mole fraction";
algorithm
   Y:=state.phaseFraction[phaseIndex];
end phaseMoleFraction;
