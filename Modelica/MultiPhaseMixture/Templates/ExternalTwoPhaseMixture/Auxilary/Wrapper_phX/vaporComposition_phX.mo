within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function vaporComposition_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output Real Y[nC];
algorithm
   Y:=Wrapper.vaporComposition(state);

 annotation(Inline = false,LateInline=true);
end vaporComposition_phX;
