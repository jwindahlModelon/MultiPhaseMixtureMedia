within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
function fugacity_pTN
   extends MultiPhaseMixture.Icons.ExternalFunction;
   input Modelica.SIunits.Pressure p "Pressure";
   input Modelica.SIunits.Temperature T "Modelica.SIunits.Temperature";
   input Modelica.SIunits.AmountOfSubstance[nC] N_1ph
    "Molar substance for the specified phase";
   input Integer phaseLabel=PhaseLabelLiquid "Phase label";
   output Modelica.SIunits.Pressure f[nC] "Fugacity";

 external "C" MultiPhaseMultiComponent_fugacity_pTN_C_impl(p,T,N_1ph,phaseLabel,mediumName,setupInfo.libraryName, setupInfo.compounds,setupInfo,f);
     annotation(Include="#include \"externalmedialib.h\"", Library="ExternalMediaLib");

end fugacity_pTN;
