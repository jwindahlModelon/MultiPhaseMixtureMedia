within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
function s0_T "Temperature dependent part of the entropy, single component"

input Modelica.SIunits.Temperature
                        T "temperature";
input Integer index "Medium species identifier";
output Modelica.SIunits.SpecificEntropy
                             s "specific entropy";
algorithm
  s :=(data[index].s_coeff[3]*T + data[index].s_coeff[2]*Modelica.Math.log(T)
     +data[index].s_coeff[1]);
end s0_T;
