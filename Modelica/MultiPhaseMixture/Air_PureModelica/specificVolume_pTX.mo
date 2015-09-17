within MultiPhaseMixture.Air_PureModelica;
function specificVolume_pTX
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.Temperature T;
  input Real X[nC]=reference_X;
  input Integer phaseLabel=PhaseLabelOverall "Phase label";
  output Modelica.SIunits.SpecificVolume v_out;

algorithm
  if phaseLabel==PhaseLabelOverall then
    assert(false,"Mixed phases not supported");
  elseif phaseLabel==PhaseLabelVapor then //gas
    v_out := GasEoS.v_pTX(p,T,X);
  elseif phaseLabel==PhaseLabelLiquid then //liquid
    v_out := LiquidEoS.v_pTX(p,T,X);
  else
    assert(false,"Phase not supported");
  end if;
  annotation(smoothOrder=2);
end specificVolume_pTX;
