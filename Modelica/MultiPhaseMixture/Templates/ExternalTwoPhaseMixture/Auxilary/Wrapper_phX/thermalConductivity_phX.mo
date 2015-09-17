within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function thermalConductivity_phX
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real lambda;
algorithm
   lambda:=Wrapper.thermalConductivity(state);

    annotation(Inline = false,
             LateInline = true);
end thermalConductivity_phX;
