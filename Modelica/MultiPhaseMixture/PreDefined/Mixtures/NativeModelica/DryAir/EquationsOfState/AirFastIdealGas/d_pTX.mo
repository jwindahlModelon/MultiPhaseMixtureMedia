within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
function d_pTX "Compute density"
 input Modelica.SIunits.AbsolutePressure
                               p "Pressure";
  input Modelica.SIunits.Temperature
                          T "Temperature";
  input Modelica.SIunits.MassFraction[
                           nS] X "Mass fraction";
  output Modelica.SIunits.Density
                       d "Density";
algorithm
    d := p/((R*X)*T);
  annotation(smoothOrder=5);
end d_pTX;
