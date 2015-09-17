within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function isothermalCompressibility_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output Real kappa;
algorithm
   kappa:=Wrapper.isothermalCompressibility(state);
 annotation(Inline = false,LateInline=true);
end isothermalCompressibility_pTX;
