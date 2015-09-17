within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.Tests;
model ThermoProperties
  extends Modelica.Icons.Example;
   package Medium = MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air;

//  parameter Boolean checkPhase=Medium.checkPhases({"Vapor5"});
  parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.Pressure p=11e5;
  parameter Modelica.SIunits.MassFraction Z[nS]={0.763,0.235,0.002}
    "Mass fraction feed";

  Medium.ThermoProperties props(
    init(p=1000000), inputs=MultiPhaseMixture.Interfaces.Inputs.pTX)
    annotation (Placement(transformation(extent={{-64,38},{-44,58}})));
equation

end ThermoProperties;
