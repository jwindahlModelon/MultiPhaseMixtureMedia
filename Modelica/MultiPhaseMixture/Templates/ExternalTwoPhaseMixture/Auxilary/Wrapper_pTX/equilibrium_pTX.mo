within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function equilibrium_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output FlashProperties eq;

algorithm
  eq:=Wrapper.equilibrium_X(X,state);
    annotation(Inline = false,LateInline=true);
end equilibrium_pTX;
