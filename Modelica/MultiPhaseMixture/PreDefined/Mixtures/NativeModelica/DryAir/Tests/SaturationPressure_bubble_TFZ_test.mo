within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model SaturationPressure_bubble_TFZ_test
    extends Modelica.Icons.Example;
    package Medium=MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

  parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.MassFraction X[nC]={0.763,0.235,0.002}
    "Mass fraction in liquid phase";
  parameter Modelica.SIunits.MassFraction Y[nC]={0.763,0.235,0.002}
    "Mass fraction in vapor phase";
  SatPhaseEquilibriumProperties bubblePoint_TY(
    inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
    T=T,
    Z_start={0.763,0.235,0.002},
    Z=X,
    F=createPhaseFractionVector({"Liquid"}, {1}))
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
 Modelica.SIunits.Density d_bubble;
 final parameter Integer LIQUID=Medium.getPhaseIndex("Liquid");
equation
  d_bubble= bubblePoint_TY.d_overall;
  //alternative
  d_bubble_alt= bubblePoint_TY.d_1ph[LIQUID];
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end SaturationPressure_bubble_TFZ_test;
