within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function density_derh_p_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real ddhp "Density derivative wrt h at constant pressure";

algorithm
  ddhp:=Wrapper.density_derh_p_X(X=X,state=state,eo=eo);

 annotation(Inline = false,LateInline=true);
end density_derh_p_psX;
