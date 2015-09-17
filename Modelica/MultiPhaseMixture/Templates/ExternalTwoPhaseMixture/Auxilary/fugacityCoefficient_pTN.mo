within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
function fugacityCoefficient_pTN
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Modelica.SIunits.Temperature";
  input Modelica.SIunits.AmountOfSubstance[nC] N_1ph
    "Molar substance for the specified phase";
  input Integer phaseLabel=PhaseLabelLiquid "Phase label";
  output Real phi[nC](each unit="1") "Fugacity coefficients";
protected
  Modelica.SIunits.Pressure p_min=1e-8;
algorithm
  phi:=fugacity_pTN(p,T,N_1ph,phaseLabel)/max(p,p_min);
   annotation(smoothOrder=5);
end fugacityCoefficient_pTN;
