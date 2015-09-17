within MultiPhaseMixture.Air_PureModelica;
function specificEnthalpy_pTX
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.Temperature T;
  input Real X[nC]=reference_X;
  input Integer phaseLabel=PhaseLabelOverall "Phase label";
  output Modelica.SIunits.SpecificEnthalpy h_out;

  // named 2 due to specificEnthalpy already defined in partialMedium interface

algorithm
  if phaseLabel==PhaseLabelOverall then
    assert(false,"Mixed phases not supported");
  elseif phaseLabel==PhaseLabelVapor then //gas
    h_out := GasEoS.h_TX(T,X);
  elseif phaseLabel==PhaseLabelLiquid then //liquid
    h_out := LiquidEoS.h_pTX(p,T,X);
  else
    assert(false,"Phase not supported");

  end if;
annotation(smoothOrder=2);
end specificEnthalpy_pTX;
