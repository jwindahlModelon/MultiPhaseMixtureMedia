within MultiPhaseMixture.Air_PureModelica.EquationsOfState.IncompressibleLiquidAir;
function v_pTX
  "Compute specific voume as function of pressure, temperature and composition"

  input Modelica.SIunits.AbsolutePressure
                               p "Pressure";
  input Modelica.SIunits.Temperature
                          T "Temperature";
  input Modelica.SIunits.MassFraction
                           X[:] "Mass fractions of moist air";
  output Modelica.SIunits.SpecificVolume
                              v "Specific volume";
algorithm
  v := 1/data.reference_d;
 annotation(smoothOrder = 2.0);
end v_pTX;
