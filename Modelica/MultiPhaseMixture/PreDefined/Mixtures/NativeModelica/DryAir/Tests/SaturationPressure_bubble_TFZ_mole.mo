within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model SaturationPressure_bubble_TFZ_mole
    extends Modelica.Icons.Example;

  parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.MassFraction X[nS]={0.763,0.235,0.002}
    "Mass fraction in liquid phase";
  parameter Modelica.SIunits.MoleFraction Xm[nS]=massToMoleFractions(X,MMX);
  parameter Modelica.SIunits.MassFraction Y[nS]={0.763,0.235,0.002}
    "Mass fraction in vapor phase";
 parameter Modelica.SIunits.MoleFraction Ym[nS]=massToMoleFractions(Y,MMX);

  SatPhaseEquilibriumProperties bubblePoint_T(
    T=T,
    Z_start={0.763,0.235,0.002},
    inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ_mole,
    Fm=createPhaseFractionVector({"Liquid"}, {1}),
    Zm=Xm) annotation (Placement(transformation(extent={{14,10},{34,30}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-70,88},{38,50}},
          lineColor={28,108,200},
          textString="Creates a system of 1 unknowns, ideal is 1=pressure")}));
end SaturationPressure_bubble_TFZ_mole;
