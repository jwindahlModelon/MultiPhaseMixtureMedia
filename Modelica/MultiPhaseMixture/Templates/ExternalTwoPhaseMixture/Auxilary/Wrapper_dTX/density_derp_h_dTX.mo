within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function density_derp_h_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real ddph "Density derivative wrt p at constant enthalpy";

algorithm
 ddph:=Wrapper.density_derp_h_X(X=X,state=state,eo=eo);

 annotation(Inline = false,LateInline=true);
end density_derp_h_dTX;
