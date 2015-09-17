within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.AirFastIdealGas;
function h_TX "Return specific enthalpy"
 input Modelica.SIunits.Temperature
                        T "Temperature";
input Modelica.SIunits.MassFraction
                         X[nS] "Independent Mass fractions of gas mixture";
output Modelica.SIunits.SpecificEnthalpy
                              h "Specific enthalpy at temperature T";
algorithm
 h := X*{h_T(T,i) for i in 1:nS};
 annotation (derivative=h_TX_der);
end h_TX;
