within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function dynamicViscosity_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real eta;
algorithm
 eta:=Wrapper.dynamicViscosity(state);
    annotation(Inline = false,
             LateInline = true);
end dynamicViscosity_psX;
