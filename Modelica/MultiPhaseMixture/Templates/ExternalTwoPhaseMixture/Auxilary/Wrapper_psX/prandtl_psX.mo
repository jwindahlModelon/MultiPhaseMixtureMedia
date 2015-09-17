within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function prandtl_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real Pr;
algorithm
   Pr:=Wrapper.prandtl(state);
    annotation(Inline = false,
             LateInline = true);
end prandtl_psX;
