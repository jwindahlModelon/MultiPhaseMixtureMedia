within MultiPhaseMixture.Interfaces.NewInterfaces;
partial model CriticalProperties
  input Modelica.SIunits.MassFraction[nS] X(start=Constants.reference_X)
    "Mass fractions (= (component mass)/total mass  m_i/m)"   annotation (Dialog(group="Inputs"));

  output Modelica.SIunits.Pressure pc "Critical Absolute pressure of medium" annotation (Dialog(group="Inputs",enable=inputs==1 or inputs==2 or inputs==4));
  output Modelica.SIunits.SpecificEnthalpy hc
    "Critical specific enthalpy of medium"                                          annotation (Dialog(group="Inputs",enable=inputs==2));
  output Modelica.SIunits.Density dc "Critical density of medium" annotation (Dialog(group="Inputs",enable=inputs==3));
  output Modelica.SIunits.Temperature Tc "Critical temperature of medium" annotation (Dialog(group="Inputs",enable=inputs==1 or inputs==3));

  annotation (Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={85,170,255},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        radius=20)}));
end CriticalProperties;
