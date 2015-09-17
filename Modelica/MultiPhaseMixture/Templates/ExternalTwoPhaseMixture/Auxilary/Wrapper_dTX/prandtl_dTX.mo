within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function prandtl_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real Pr;
algorithm
   Pr:=Wrapper.prandtl(state);
    annotation(Inline = false,
             LateInline = true);
end prandtl_dTX;
