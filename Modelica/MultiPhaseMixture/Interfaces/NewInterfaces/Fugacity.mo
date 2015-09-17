within MultiPhaseMixture.Interfaces.NewInterfaces;
partial model Fugacity
  constant Integer ns=nS;
  input Modelica.SIunits.Pressure p "Pressure" annotation (Dialog(group="Inputs"));
  input Modelica.SIunits.Temperature T "Temperature" annotation (Dialog(group="Inputs"));
  input Modelica.SIunits.AmountOfSubstance[ns] N_1ph
    "Molar substance for the specified phase" annotation (Dialog(group="Inputs"));
  output Modelica.SIunits.Pressure f[ns] "Fugacity";
  output Real phi[ns](each unit="1") "Fugacity coefficients";
  output Real log_phi[ns] "Natural logarithm of fugacity coefficients";
equation

  annotation (Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={85,170,255},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        radius=20)}));
end Fugacity;
