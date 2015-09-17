within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function kinematicViscosity_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output Real nu;
algorithm
 nu:=Wrapper.kinematicViscosity(state);

    annotation(Inline = false,
             LateInline = true);
end kinematicViscosity_phX;
