within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function density_derh_p_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real ddhp "Density derivative wrt h at constant pressure";

algorithm
  ddhp:=Wrapper.density_derh_p_X(X=X,state=state,eo=eo);

 annotation(Inline = false,LateInline=true);
end density_derh_p_phX;
