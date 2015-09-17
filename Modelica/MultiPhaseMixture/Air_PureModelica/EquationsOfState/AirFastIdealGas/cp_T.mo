within MultiPhaseMixture.Air_PureModelica.EquationsOfState.AirFastIdealGas;
function cp_T
  "Compute specific heat capacity at constant pressure, low T region"
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Integer index "Medium species identifier";
    output Modelica.SIunits.SpecificHeatCapacity
                                      cp
    "Specific heat capacity at temperature T";
algorithm
  cp :=
    MultiPhaseMixture.Air_PureModelica.EquationsOfState.Utilities.Polynomials.evaluate(
    data[index].cp_coeff, T);
    annotation (derivative(zeroDerivative=index)=cp_T_der);
end cp_T;
