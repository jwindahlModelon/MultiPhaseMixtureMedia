within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.AirFastIdealGas;
function h_TX_der
input Modelica.SIunits.Temperature
                       T "Temperature";
 input Modelica.SIunits.MassFraction
                        X[nS] "Independent Mass fractions of gas mixture";
 input Real                     dT(unit="K/s") "Temperature derivative";
 input Real[                    nS] dX(unit="1/s") "Mass fraction derivative";
 output Real                          h_der(unit="J/(kg.s)")
    "Specific enthalpy derivative at temperature T";
algorithm
 h_der := dT*cp_TX(T,X) +  dX*{h_T(T,i) for i in 1:nS};
 annotation(smoothOrder=1);
end h_TX_der;
