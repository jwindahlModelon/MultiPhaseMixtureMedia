within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function velocityOfSound_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
   output Real a;

algorithm
 a:=Wrapper.velocityOfSound_X(X=X,state=state,eo=eo);
    annotation(Inline = false,
             LateInline = true);
end velocityOfSound_pTX;
