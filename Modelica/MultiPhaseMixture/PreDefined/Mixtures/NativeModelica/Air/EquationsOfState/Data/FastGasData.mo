within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.Data;
record FastGasData
  constant Modelica.SIunits.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";

  constant Integer npol_Cp(min=0) "degree of heat capacity polynomial";

  constant Real[:] cp_coeff "Coefficients for cp";
  constant Real[3] s_coeff "Coefficients for entropy";
  constant Real TMIN "Lower bound for fitting [K]";
  constant Real TMAX "Upper bound for fitting [K]";
end FastGasData;
