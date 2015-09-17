within MultiPhaseMixture.Air_PureModelica.EquationsOfState.IncompressibleLiquidAir;
function dddX_pTX "Compute partial derivative of density wrt. mass fraction"

   input Modelica.SIunits.AbsolutePressure
                                p "Pressure";
   input Modelica.SIunits.Temperature
                           T "Temperature";
   input Modelica.SIunits.MassFraction
                            X[:] "Mass fractions";
   output Real[                         size(X,1)] dddX(unit="kg/m3");
algorithm
   dddX := fill(0.0,size(X,1));
end dddX_pTX;
