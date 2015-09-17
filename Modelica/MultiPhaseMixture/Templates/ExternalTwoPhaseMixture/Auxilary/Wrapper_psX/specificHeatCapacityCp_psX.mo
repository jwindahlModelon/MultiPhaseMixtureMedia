within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_psX;
function specificHeatCapacityCp_psX
  input SI.Pressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real cp;
algorithm
  cp:=Wrapper.specificHeatCapacityCp(state);
    annotation(Inline = false,
             LateInline = true);
end specificHeatCapacityCp_psX;
