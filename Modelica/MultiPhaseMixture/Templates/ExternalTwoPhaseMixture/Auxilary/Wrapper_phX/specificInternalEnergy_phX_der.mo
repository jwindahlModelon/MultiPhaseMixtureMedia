within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function specificInternalEnergy_phX_der
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
   input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
   input Real p_der "Pressure total derivative wrt to time";
   input Real h_der "Specific enthalpy total derivative wrt to time";
   input Modelica.SIunits.MassFraction X_der[nC] "Mass fraction";
   output Real u_der "Specific internal energy total derivative wrt to time";

algorithm
  // u=h-p/d(p,h) -> der(u)=der(h)-der(p)/d+p/d^2*der(d)

   u_der:=h_der-p_der/state.d_overall+state.p_overall/state.d_overall^2*density_phX_der(p=p,h=h,X=X,state=state,p_der=p_der,h_der=h_der,X_der=X_der,eo=eo);
    annotation(Inline = false,
             LateInline = true);
end specificInternalEnergy_phX_der;
