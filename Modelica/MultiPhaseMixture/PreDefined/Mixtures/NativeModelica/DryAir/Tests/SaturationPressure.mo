within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model SaturationPressure
    extends Modelica.Icons.Example;

  parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.MassFraction X[nS]={0.763,0.235,0.002}
    "Mass fraction in liquid phase";
  parameter Modelica.SIunits.MassFraction Y[nS]={0.763,0.235,0.002}
    "Mass fraction in vapor phase";
  SatPhaseEquilibriumProperties bubblePoint_TX(
    inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
    T=T,
    Z=X,
    Z_start={0.763,0.235,0.002},
    F=Interfaces.createPhaseFractionVector({"Liquid"}, {1}))
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  SatPhaseEquilibriumProperties dewPoint_TY(
    inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
    T=T,
    Z_start={0.763,0.235,0.002},
    Z=Y,
    F=Interfaces.createPhaseFractionVector({"Liquid"}, {0}))
    annotation (Placement(transformation(extent={{-36,0},{-16,20}})));
end SaturationPressure;
