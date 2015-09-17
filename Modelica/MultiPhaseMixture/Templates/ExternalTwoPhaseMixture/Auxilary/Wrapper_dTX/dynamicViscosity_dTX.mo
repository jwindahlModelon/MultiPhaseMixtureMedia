within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function dynamicViscosity_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real eta;
algorithm
   eta:=Wrapper.dynamicViscosity(state);
    annotation(Inline = false,
             LateInline = true);
end dynamicViscosity_dTX;
