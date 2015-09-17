within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.IncompressibleLiquidAir;
function s_pTX "Compute specifc entropy (gas parts only!) of moist gases"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction
                             X[:] "Mass fractions ";
    output Modelica.SIunits.SpecificEntropy
                                 s "Specific entropy";
algorithm
    s := data.reference_s + data.cp_const * Modelica.Math.log(T/data.reference_T);
   annotation(smoothOrder = 2.0);
end s_pTX;
