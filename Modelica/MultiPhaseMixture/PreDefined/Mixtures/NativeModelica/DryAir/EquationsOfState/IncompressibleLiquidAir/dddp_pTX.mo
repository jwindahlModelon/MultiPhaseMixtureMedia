within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.IncompressibleLiquidAir;
function dddp_pTX "Compute partial derivative of density wrt. pressure"

   input Modelica.SIunits.AbsolutePressure
                                p "Pressure";
   input Modelica.SIunits.Temperature
                           T "Temperature";
   input Modelica.SIunits.MassFraction
                            X[:] "Mass fractions";
   output Real dddp(unit="kg/(m3.Pa)");
algorithm
   dddp := 0;
end dddp_pTX;
