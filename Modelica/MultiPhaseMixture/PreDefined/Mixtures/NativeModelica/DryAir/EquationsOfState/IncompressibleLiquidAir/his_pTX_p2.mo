within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.IncompressibleLiquidAir;
function his_pTX_p2
  "Compute isentropic enthalpy from upstream conditions and downstream pressure"

    input Modelica.SIunits.AbsolutePressure
                                 p "Pressure";
    input Modelica.SIunits.Temperature
                            T "Temperature";
    input Modelica.SIunits.MassFraction[
                             :] X "Mass fraction";
    input Modelica.SIunits.AbsolutePressure
                                 p2 "Pressure";
    output Modelica.SIunits.SpecificEnthalpy
                                  his "Specific enthalpy";
protected
    Modelica.SIunits.SpecificEntropy                  s "Upstream entropy";
    Modelica.SIunits.Temperature                  T2 "Downstream temperature";
algorithm
    s := s_pTX(p,T,X);
    T2 := T_psX(p2,s,X);
    his := h_pTX(p2,T2,X);
end his_pTX_p2;
