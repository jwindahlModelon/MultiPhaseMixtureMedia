within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.AirFastIdealGas;
function v_pTX_derT "Compute specific volume derivative"

  input Modelica.SIunits.AbsolutePressure
                               p "Pressure";
  input Modelica.SIunits.Temperature
                          T "Temperature";
  input Modelica.SIunits.MassFraction[
                           nS] X "Mass fraction";
  output Real                                 v_derT(unit="m3/(kg.K)")
    "Specific volume derivative";
algorithm
  v_derT := (R*X)/p;
  annotation(smoothOrder=5);
end v_pTX_derT;
