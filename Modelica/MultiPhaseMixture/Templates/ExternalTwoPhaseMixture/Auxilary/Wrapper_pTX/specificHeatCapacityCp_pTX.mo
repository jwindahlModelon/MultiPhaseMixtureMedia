within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function specificHeatCapacityCp_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real cp;
algorithm
  cp:=Wrapper.specificHeatCapacityCp(state);
    annotation(Inline = false,
             LateInline = true);
end specificHeatCapacityCp_pTX;
