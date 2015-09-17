within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function pressure_phX
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real p_out;
algorithm
   p_out:=state.p_overall;
    annotation(Inline = false,
             LateInline = true);
end pressure_phX;
