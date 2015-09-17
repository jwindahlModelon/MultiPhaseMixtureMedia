within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function dynamicViscosity_phX
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real eta;
algorithm
   eta:=Wrapper.dynamicViscosity(state);

    annotation(Inline = false,
             LateInline = true);
end dynamicViscosity_phX;
