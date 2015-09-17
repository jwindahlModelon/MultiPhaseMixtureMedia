within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function kinematicViscosity_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real nu;
algorithm
 nu:=Wrapper.kinematicViscosity(state);
    annotation(Inline = false,
             LateInline = true);
end kinematicViscosity_dTX;
