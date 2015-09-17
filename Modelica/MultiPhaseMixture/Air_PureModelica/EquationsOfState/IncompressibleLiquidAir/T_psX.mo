within MultiPhaseMixture.Air_PureModelica.EquationsOfState.IncompressibleLiquidAir;
function T_psX
  "Return temperature as a function of pressure p, specific entropy s and composition X"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.SpecificEntropy
                                s "Specific entropy";
    input Modelica.SIunits.MassFraction[
                             :] X "Mass fractions of composition";
    output Modelica.SIunits.Temperature
                             T "Temperature";
algorithm

    T := data.reference_T * Modelica.Math.exp((s - data.reference_s) /data.cp_const);
end T_psX;
