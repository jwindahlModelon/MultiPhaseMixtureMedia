within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function specificHeatCapacityCv_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real cv;

algorithm
  cv:=Wrapper.specificHeatCapacityCv_X(X,state,eo);
    annotation(Inline = false,
             LateInline = true);
end specificHeatCapacityCv_dTX;
