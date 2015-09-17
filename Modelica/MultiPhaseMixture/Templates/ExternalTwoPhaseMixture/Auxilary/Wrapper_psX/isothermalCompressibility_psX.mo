within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function isothermalCompressibility_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output Real kappa;
algorithm
   kappa:=Wrapper.isothermalCompressibility(state);
 annotation(Inline = false,LateInline=true);
end isothermalCompressibility_psX;
