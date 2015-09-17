within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.Data;
record LinearFluid "Constants for a linear fluid"

  constant Modelica.SIunits.SpecificHeatCapacity
                                  cp_const
    "Specific heat capacity at constant pressure";
  constant Real beta_const(unit="1/K")
    "Thermal expansion coefficient at constant pressure";
  constant Modelica.SIunits.IsothermalCompressibility
                                       kappa_const "Isothermal compressibility";
  constant Modelica.SIunits.Temperature
                         reference_T
    "Reference Temperature: often the linearization point";
  constant Modelica.SIunits.AbsolutePressure
                              reference_p
    "Reference Pressure: often the linearization point";
  constant Modelica.SIunits.Density
                     reference_d "Density in reference conditions";
  constant Modelica.SIunits.SpecificEnthalpy
                              reference_h
    "Specific enthalpy in reference conditions";
  constant Modelica.SIunits.SpecificEntropy
                             reference_s
    "Specific enthalpy in reference conditions";
  constant Modelica.SIunits.MolarMass
                       MM "Molar mass";
end LinearFluid;
