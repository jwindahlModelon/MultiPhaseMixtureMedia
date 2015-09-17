within MultiPhaseMixture.Air_PureModelica.EquationsOfState.AirFastIdealGas;
function cp_T_der "Derivative of cp(T)"
  input Modelica.SIunits.Temperature                  T "Temperature";
  input Integer index "Medium species identifier";
  input Real T_der "Temperature derivative";
  output Real cp_der "Derivative of specific heat capacity";
algorithm
  cp_der :=
    MultiPhaseMixture.Air_PureModelica.EquationsOfState.Utilities.Polynomials.derivativeValue(
    data[index].cp_coeff, T)*T_der;
  annotation(smoothOrder=1);
end cp_T_der;
