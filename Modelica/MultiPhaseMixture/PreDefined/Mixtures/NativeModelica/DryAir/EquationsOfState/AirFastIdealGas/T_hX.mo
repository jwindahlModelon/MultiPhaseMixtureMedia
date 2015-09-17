within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
function T_hX "Compute temperature from specific enthalpy and mass fraction"

  input Modelica.SIunits.SpecificEnthalpy
                          h "specific enthalpy";
  input Modelica.SIunits.MassFraction[
                      nS] X "mass fractions of composition";
  output Modelica.SIunits.Temperature
                      T "temperature";
algorithm
assert(analyticInverseTfromh,"T_phX: No analytic inverse for polynomials with npol_Cp > 3");

  T := if data[1].npol_Cp == 0 then
 T0 + (h -
 (if excludeEnthalpyOfFormation then 0.0 else NASAData[:].Hf * X) -
 (if referenceChoice == Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K then data[:].H0 * X else 0.0) -
 (if referenceChoice == Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined then h_offset[:] * X else 0.0))
 /(data[:].cp_coeff[1] * X) else
 sqrt(max(1e-6,((data[:].cp_coeff[2]*X)/(data[:].cp_coeff[1]*X))^2 +
  2/(data[:].cp_coeff[1]*X)*((data[:].cp_coeff[2]*X)*T0 + h -
  (if excludeEnthalpyOfFormation then 0.0 else NASAData[:].Hf * X) -
  (if referenceChoice == Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K then data[:].H0 * X else 0.0) -
  (if referenceChoice == Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined then h_offset[:] * X else 0.0)) +
  T0^2)) - (data[:].cp_coeff[2]*X)/(data[:].cp_coeff[1]*X);
                                 //data[1].npol_Cp == 1
  annotation (smoothOrder=5);
end T_hX;
