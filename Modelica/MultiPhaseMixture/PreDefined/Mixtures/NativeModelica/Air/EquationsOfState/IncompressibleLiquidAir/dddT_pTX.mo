within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.IncompressibleLiquidAir;
function dddT_pTX "Compute partial derivative of density wrt. temperature"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction
                             X[:] "Mass fractions";
    output Real dddT(unit="kg/(m3.K)");

algorithm
     dddT := 0;
end dddT_pTX;
