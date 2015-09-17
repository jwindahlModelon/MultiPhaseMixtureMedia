within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.IncompressibleLiquidAir;
function kappa_pTX
  "Return specific Isothermal compressibility as a function of pressure p, temperature T and composition X"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction
                             X[:] "Mass fractions ";
    output Modelica.SIunits.IsothermalCompressibility
                                           kappa "Isothermal compressibility";
algorithm
    kappa := data.kappa_const;
   annotation(smoothOrder = 2.0);
end kappa_pTX;
