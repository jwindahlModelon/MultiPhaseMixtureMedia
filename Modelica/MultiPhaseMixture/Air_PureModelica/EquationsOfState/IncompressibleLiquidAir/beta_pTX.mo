within MultiPhaseMixture.Air_PureModelica.EquationsOfState.IncompressibleLiquidAir;
function beta_pTX
  "Return specific volumetric expansion coefficient as a function of pressure p, temperature T and composition X"

   input Modelica.SIunits.AbsolutePressure
                                p "Pressure";
   input Modelica.SIunits.Temperature
                           T "Temperature";
   input Modelica.SIunits.MassFraction
                            X[:] "Mass fractions ";
   output Real  beta(unit="1/K") "Volumetric expansion coefficient";
algorithm
  beta := data.beta_const;
  annotation(smoothOrder = 2.0);
end beta_pTX;
