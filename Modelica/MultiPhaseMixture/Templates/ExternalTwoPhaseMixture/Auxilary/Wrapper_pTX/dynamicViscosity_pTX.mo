within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function dynamicViscosity_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real eta;
algorithm
  eta:=Wrapper.dynamicViscosity(state);
    annotation(Inline = false,
             LateInline = true);
end dynamicViscosity_pTX;
