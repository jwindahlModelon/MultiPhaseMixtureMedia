within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function specificHeatCapacityCv_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
   output Real cv;

algorithm
 cv:=Wrapper.specificHeatCapacityCv_X(X=X,state=state,eo=eo);
    annotation(Inline = false,
             LateInline = true);
end specificHeatCapacityCv_pTX;
