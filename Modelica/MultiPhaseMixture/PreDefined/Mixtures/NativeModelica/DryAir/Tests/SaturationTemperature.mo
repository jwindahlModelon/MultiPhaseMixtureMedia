within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model SaturationTemperature
    extends Modelica.Icons.Example;

 // parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.MassFraction X[nS]={0.763,0.235,0.002}
    "Mass fraction in liquid phase";
  parameter Modelica.SIunits.MassFraction Y[nS]={0.763,0.235,0.002}
    "Mass fraction in vapor phase";
  SatPhaseEquilibriumProperties bubblePoint_pX(
    F={1,0},
    Z=X,
    Z_start={0.763,0.235,0.002},
    inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
    p=250000) annotation (Placement(transformation(extent={{-80,2},{-60,22}})));
  SatPhaseEquilibriumProperties dewPoint_pY(
    Z_start={0.763,0.235,0.002},
    F={0,1},
    Z=Y,
    inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
    p=250000) annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
end SaturationTemperature;
