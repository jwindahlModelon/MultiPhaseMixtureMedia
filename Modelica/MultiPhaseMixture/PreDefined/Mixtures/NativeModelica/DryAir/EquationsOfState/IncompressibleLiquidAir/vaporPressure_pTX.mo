within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.IncompressibleLiquidAir;
function vaporPressure_pTX
  "function that returns the vaporPressure given the temperature"

  input Modelica.SIunits.AbsolutePressure
                               p "Pressure";
  input Modelica.SIunits.Temperature
                          T "Temperature";
  input Modelica.SIunits.MassFraction[
                           :] X "Mass fractions of composition";
  output Modelica.SIunits.AbsolutePressure
                                pVap "Vapor pressure";
algorithm
  assert(false, "Vapor pressure not implemented for incompressible fluid");
end vaporPressure_pTX;
