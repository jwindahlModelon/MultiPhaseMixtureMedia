within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function kinematicViscosity_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real nu;
algorithm
  nu:=Wrapper.kinematicViscosity(state);
    annotation(Inline = false,
             LateInline = true);
end kinematicViscosity_psX;
