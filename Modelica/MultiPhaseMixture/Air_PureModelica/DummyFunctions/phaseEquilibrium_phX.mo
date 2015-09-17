within MultiPhaseMixture.Air_PureModelica.DummyFunctions;
function phaseEquilibrium_phX
extends MultiPhaseMixtureMedia.Interfaces.ThermoProperties_phX.phaseEquilibrium( X=reference_X);
input PhaseLabel phaseLabel=PhaseLabel.Overall "Phase label";
algorithm
  assert(false,"Not implemented");
end phaseEquilibrium_phX;
