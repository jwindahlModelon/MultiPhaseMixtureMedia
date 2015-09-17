within MultiPhaseMixture.Air_PureModelica.EquationsOfState.IncompressibleLiquidAir;
function dudX_pTX "Compute specific energy derivative wrt. mass fraction"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction
                             X[:] "Mass fractions";
    output Real[size(X,1)] dudX;
algorithm
    dudX := fill(0.0,size(X,1));
end dudX_pTX;
