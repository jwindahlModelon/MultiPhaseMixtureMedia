within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function specificHeatCapacityCp_phX
   input Modelica.SIunits.AbsolutePressure p "pressure";
   input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real cp;
algorithm
  cp:=Wrapper.specificHeatCapacityCp(state);

    annotation(Inline = false,
             LateInline = true);
end specificHeatCapacityCp_phX;
