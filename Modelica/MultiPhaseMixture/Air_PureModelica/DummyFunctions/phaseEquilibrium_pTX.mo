within MultiPhaseMixture.Air_PureModelica.DummyFunctions;
function phaseEquilibrium_pTX
extends MultiPhaseMixtureMedia.Interfaces.ThermoProperties_pTX.phaseEquilibrium(
     X=reference_X);
input PhaseLabel phaseLabel=PhaseLabel.Overall "Phase label";
algorithm
  assert(false,"Not implemented");
end phaseEquilibrium_pTX;
