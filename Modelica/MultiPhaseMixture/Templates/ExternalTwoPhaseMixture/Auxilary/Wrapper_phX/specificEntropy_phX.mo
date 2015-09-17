within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function specificEntropy_phX
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real s;
algorithm
   s:=state.s_overall;
    annotation(Inline = false,
             LateInline = true);
end specificEntropy_phX;
