within MultiPhaseMixture.Air_PureModelica.DummyFunctions;
function density_phX
extends MultiPhaseMixtureMedia.Interfaces.ThermoProperties_phX.density(X=reference_X);
input PhaseLabel phaseLabel=PhaseLabel.Overall "Phase label";
algorithm
  assert(false,"Not implemented");
end density_phX;
