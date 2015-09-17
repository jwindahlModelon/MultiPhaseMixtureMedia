within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.Tests;
model SaturationPressure_dew_TFZ
    extends Modelica.Icons.Example;

  parameter Modelica.SIunits.Temperature T=108;
  parameter Modelica.SIunits.MassFraction X[nS]={0.763,0.235,0.002}
    "Mass fraction in liquid phase";
  parameter Modelica.SIunits.MassFraction Y[nS]={0.763,0.235,0.002}
    "Mass fraction in vapor phase";
  SatPhaseEquilibriumProperties dewPoint_TY(
    inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
    T=T,
    Z_start={0.763,0.235,0.002},
    Z=Y,
    F=createPhaseFractionVector({"Vapor"}, {1}))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-56,56},{52,18}},
          lineColor={28,108,200},
          textString="Creates a system of 4 unknowns, ideal is 1=pressure")}));
end SaturationPressure_dew_TFZ;
