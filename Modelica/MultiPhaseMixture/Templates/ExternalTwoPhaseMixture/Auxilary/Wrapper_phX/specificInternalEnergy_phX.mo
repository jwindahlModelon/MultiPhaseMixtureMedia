within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function specificInternalEnergy_phX
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
   output Real u;
algorithm
   u:=state.h_overall-state.p_overall/state.d_overall;
    annotation(derivative(noDerivative=state,noDerivative=eo) = specificInternalEnergy_phX_der,Inline = false,
             LateInline = true);
end specificInternalEnergy_phX;
