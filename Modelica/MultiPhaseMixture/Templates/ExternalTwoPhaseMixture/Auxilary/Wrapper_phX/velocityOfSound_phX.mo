within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function velocityOfSound_phX
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
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
end velocityOfSound_phX;
