within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.IncompressibleLiquidAir;
function dudp_pTX "Compute specific energy derivative wrt. pressure"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction
                             X[:] "Mass fractions";
    output Real dudp(unit="J/(kg.Pa)");
algorithm
    dudp := 0;
end dudp_pTX;
