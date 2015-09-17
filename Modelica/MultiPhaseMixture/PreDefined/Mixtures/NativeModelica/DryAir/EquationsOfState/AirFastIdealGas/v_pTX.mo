within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
function v_pTX "Compute specific volume"
  input Modelica.SIunits.AbsolutePressure
                             p "Pressure";
input Modelica.SIunits.Temperature
                        T "Temperature";
input Modelica.SIunits.MassFraction[
                         nS] X "Mass fraction";
output Modelica.SIunits.SpecificVolume
                            v "Specific volume";
algorithm
  v := ((R*X)*T)/p;
  annotation(smoothOrder=5);
end v_pTX;
