within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function equilibrium_phX
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.SpecificEnthalpy h;
  input Real X[nC]=reference_X;
  input Properties state;
  output FlashProperties eq;

algorithm
  eq:=Wrapper.equilibrium_X(X,state);
    annotation(Inline = false,LateInline=true);
end equilibrium_phX;
