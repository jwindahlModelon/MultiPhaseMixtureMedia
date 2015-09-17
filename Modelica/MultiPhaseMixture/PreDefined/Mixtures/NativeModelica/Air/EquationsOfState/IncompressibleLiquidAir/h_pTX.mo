within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.IncompressibleLiquidAir;
function h_pTX
  "Return specific enthalpy  as a function of pressure p, temperature T and composition X"

   input Modelica.SIunits.AbsolutePressure
                                p "Pressure";
   input Modelica.SIunits.Temperature
                           T "Temperature";
   input Modelica.SIunits.MassFraction
                            X[:] "Mass fractions ";
   output Modelica.SIunits.SpecificEnthalpy
                                 h "Specific enthalpy";
algorithm
   h := data.reference_h + (T-data.reference_T)*data.cp_const + (p-data.reference_p)/data.reference_d;
  annotation(smoothOrder = 2);
end h_pTX;
