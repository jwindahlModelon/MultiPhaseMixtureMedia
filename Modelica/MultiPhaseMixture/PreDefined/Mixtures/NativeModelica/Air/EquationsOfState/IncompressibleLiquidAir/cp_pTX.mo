within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.IncompressibleLiquidAir;
function cp_pTX
  "Return specific heat capacity as a function of pressure p, temperature T and composition X"

   input Modelica.SIunits.AbsolutePressure
                                p "Pressure";
   input Modelica.SIunits.Temperature
                           T "Temperature";
   input Modelica.SIunits.MassFraction
                            X[:] "Mass fractions ";
   output Modelica.SIunits.SpecificHeatCapacity
                                     cp "Specific heat capacity";
algorithm
  cp := data.cp_const;
  annotation(smoothOrder = 2.0);
end cp_pTX;
