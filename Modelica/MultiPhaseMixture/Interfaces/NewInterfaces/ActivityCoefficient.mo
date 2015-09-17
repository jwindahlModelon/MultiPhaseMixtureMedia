within MultiPhaseMixture.Interfaces.NewInterfaces;
partial model ActivityCoefficient
  constant Integer ns=nS;
  input Modelica.SIunits.Pressure p "Pressure" annotation (Dialog(group="Inputs"));
  input Modelica.SIunits.Temperature T "Temperature" annotation (Dialog(group="Inputs"));
  input Modelica.SIunits.AmountOfSubstance[ns] N_1ph
    "Molar substance for the specified phase" annotation (Dialog(group="Inputs"));
   output Real gamma[ns](each unit="1")
    "Activity coefficients for specified phase";
equation

  annotation (Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={85,170,255},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        radius=20)}));
end ActivityCoefficient;
