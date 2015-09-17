within MultiPhaseMixture.Air_PureModelica.Tests;
model Flash
    extends Modelica.Icons.Example;
   package Medium = MultiPhaseMixture.Air_PureModelica;
  parameter Integer phaseIndex=
      MultiPhaseMixtureMedia.Interfaces.MultiPhaseMultiComponentModelsBased.getPhaseIndex(
                                                                   "Vapor");
//  parameter Boolean checkPhase=Medium.checkPhases({"Vapor5"});
  parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.Pressure p=11e5;
  parameter Modelica.SIunits.MassFraction Z[nS]={0.763,0.235,0.002}
    "Mass fraction feed";

  MultiPhaseProperties flash_pTZ(
    p=p,
    T=T,
    Z=Z,
    Z_start=Z,
    presentPhases={"Liquid"},
    init(p=1000000))
    annotation (Placement(transformation(extent={{-62,38},{-42,58}})));
end Flash;
