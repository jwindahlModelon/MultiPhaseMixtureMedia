within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function prandtl_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real Pr;
algorithm
   Pr:=Wrapper.prandtl(state);
    annotation(Inline = false,
             LateInline = true);
end prandtl_phX;
