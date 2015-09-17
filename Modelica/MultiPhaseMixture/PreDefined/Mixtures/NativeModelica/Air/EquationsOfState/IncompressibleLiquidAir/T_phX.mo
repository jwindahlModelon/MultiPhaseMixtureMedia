within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.IncompressibleLiquidAir;
function T_phX
  "Return temperature from pressure, specific entropy and mass fraction"
    input Modelica.SIunits.AbsolutePressure                  p "Pressure";
    input Modelica.SIunits.SpecificEnthalpy                  h
    "Specific enthalpy";
    input Modelica.SIunits.MassFraction[                 :] X
    "Mass fractions of composition";
    output Modelica.SIunits.Temperature                  T "temperature";

algorithm
    T := data.reference_T + (h - data.reference_h - (p - data.reference_p)/data.reference_d)/data.cp_const;
end T_phX;
