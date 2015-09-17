within MultiPhaseMixture.Air_PureModelica.DummyFunctions;
function specificVolume_phX
extends MultiPhaseMixtureMedia.Interfaces.ThermoProperties_phX.specificVolume(X=reference_X);
input PhaseLabel phaseLabel=PhaseLabel.Overall "Phase label";
algorithm
  assert(false,"Not implemented");
end specificVolume_phX;
