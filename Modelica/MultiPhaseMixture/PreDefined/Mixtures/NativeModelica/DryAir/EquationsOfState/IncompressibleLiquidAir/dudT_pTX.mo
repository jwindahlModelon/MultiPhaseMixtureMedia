within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.IncompressibleLiquidAir;
function dudT_pTX "Compute specific energy derivative wrt. temperature"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction
                             X[:] "Mass fractions";
    output Real dudT(unit="J/(kg.K)");
algorithm
    dudT := data.cp_const;
end dudT_pTX;
