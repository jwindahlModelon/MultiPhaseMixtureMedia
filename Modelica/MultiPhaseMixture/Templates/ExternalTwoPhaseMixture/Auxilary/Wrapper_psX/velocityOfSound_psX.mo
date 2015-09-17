within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function velocityOfSound_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
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
end velocityOfSound_psX;
