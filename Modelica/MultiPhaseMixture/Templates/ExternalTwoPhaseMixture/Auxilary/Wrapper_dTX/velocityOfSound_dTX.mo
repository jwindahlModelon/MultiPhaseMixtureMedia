within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function velocityOfSound_dTX
  input Modelica.SIunits.Density d "Density";
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
end velocityOfSound_dTX;
