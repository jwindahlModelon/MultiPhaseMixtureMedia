within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.IncompressibleLiquidAir;
function d_pTX
  "Compute density as function of pressure, temperature and composition"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction
                             X[:] "Mass fractions ";
    output Modelica.SIunits.Density
                         d "Density";
algorithm
    d := data.reference_d;
   annotation(smoothOrder = 2.0);
end d_pTX;
