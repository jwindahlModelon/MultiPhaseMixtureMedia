within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function equilibrium_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output FlashProperties flash;

algorithm
  flash:=Wrapper.equilibrium_X(X,state);
    annotation(Inline = false,LateInline=true);
end equilibrium_psX;
