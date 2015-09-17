within MultiPhaseMixture.Air_PureModelica.EquationsOfState.AirFastIdealGas;
function cp_TX "Compute specific heat capacity for a mixture component"

input Modelica.SIunits.Temperature
                        T "temperature";
input Modelica.SIunits.MassFraction[
                         nS] X "mass fraction";
output Modelica.SIunits.SpecificHeatCapacity
                                  cp "specific heat capacity";
algorithm
  cp := X*{cp_T(T,i) for i in 1:nS};
  annotation(smoothOrder=2);
end cp_TX;
