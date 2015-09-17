within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model ThermoProperties
  extends Modelica.Icons.Example;
   package Medium = MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

//  parameter Boolean checkPhase=Medium.checkPhases({"Vapor5"});
  parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.Pressure p=11e5;
  parameter Modelica.SIunits.MassFraction Z[Medium.nC]={0.763,0.235,0.002}
    "Mass fraction feed";

  Medium.ThermoProperties thermoProperties(
    init(p=1000000), inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
    p=100000,
    T=573.15,
    Z=Medium.reference_X)
    annotation (Placement(transformation(extent={{-64,38},{-44,58}})));
equation

end ThermoProperties;
