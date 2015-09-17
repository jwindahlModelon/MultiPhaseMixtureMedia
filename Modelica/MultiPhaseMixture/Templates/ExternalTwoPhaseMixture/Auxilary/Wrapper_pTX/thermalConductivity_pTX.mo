within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_pTX;
function thermalConductivity_pTX
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real lambda;
algorithm
  lambda:=Wrapper.thermalConductivity(state);
    annotation(Inline = false,
             LateInline = true);
end thermalConductivity_pTX;
