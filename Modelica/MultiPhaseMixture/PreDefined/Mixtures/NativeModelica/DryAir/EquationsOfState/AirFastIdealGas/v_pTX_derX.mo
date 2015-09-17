within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
function v_pTX_derX
  "Return specific volume derivative with respect to individual mass fraction"
  input Modelica.SIunits.AbsolutePressure
                               p "Pressure";
  input Modelica.SIunits.Temperature
                          T "Temperature";
  input Modelica.SIunits.MassFraction[
                           nS] X "Mass fraction";
  output Modelica.SIunits.SpecificVolume[
                              nS] v_derX "Specific volume derivative";
algorithm
  v_derX:=T/p*R;
    annotation(smoothOrder=5);
end v_pTX_derX;
