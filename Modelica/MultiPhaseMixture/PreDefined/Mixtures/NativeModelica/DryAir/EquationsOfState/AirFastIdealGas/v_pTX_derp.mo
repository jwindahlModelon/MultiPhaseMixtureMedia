within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
function v_pTX_derp "Compute specific volume derivative"

  input Modelica.SIunits.AbsolutePressure
                               p "Pressure";
  input Modelica.SIunits.Temperature
                          T "Temperature";
  input Modelica.SIunits.MassFraction[
                           nS] X "Mass fraction";
  output Real                              v_derp(unit="m3/(kg.Pa)")
    "Specific volume derivative";
algorithm
  v_derp := -((R*X)*T)/(p*p);
  annotation(smoothOrder=5);
end v_pTX_derp;
