within MultiPhaseMixture.Air_PureModelica.EquationsOfState.AirFastIdealGas;
function h_T
  "Return specific enthalpy for a single speciesReturn specific enthalpy for a single species"
input Modelica.SIunits.Temperature
                        T "Temperature";
input Integer index "Medium species identifier";
output Modelica.SIunits.SpecificEnthalpy
                              h "Specific enthalpy at temperature T";
algorithm
  h :=
    MultiPhaseMixture.Air_PureModelica.EquationsOfState.Utilities.Polynomials.integralValue(
    data[index].cp_coeff,
    T,
    T0) + (if excludeEnthalpyOfFormation then 0.0 else NASAData[index].Hf) + (
    if referenceChoice == Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K
     then data[index].H0 else 0.0) + (if referenceChoice == Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined
     then h_offset[index] else 0.0);
  annotation(smoothOrder=5);
end h_T;
