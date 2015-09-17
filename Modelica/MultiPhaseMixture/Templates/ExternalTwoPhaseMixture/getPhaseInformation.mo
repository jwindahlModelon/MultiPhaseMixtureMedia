within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture;
function getPhaseInformation
  extends MultiPhaseMixture.Icons.ExternalFunction;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo;
  output String phaseLabel[nP] "List of supported phases";
  output String stateOfAggregation[nP]
    "State of aggregation. Supported values Liquid,Vapor,Solid,Unknown";
//   output String keyCompoundId[nP]
//     "The identifier of the Compound that is expected to be present in highest concentration in the phase";
//   output String excludedCompoundId[nP]
//     "The identifier of the Compound that is expected to be present in low or zero concentration in the phase";
//   output String densityDescription[nP]={"High","Low"}
//     "Desciption that indicates the density range expected for the phase. Supported values: Heavy, Light, Undefined";
//   output String userDescription[nP]={"Liquid phase","Vapor phase"}
//     "Desciption that helps the user of tool to identify the phase";
//   output String typeOfSolid[nP]={"Undefined","Undefined"}
//     "A description that provides more inofrmation about a solid phase. Supported values: PureSoldid,SolidSolution,HydrateI,HydrateII,HydrateH,Undefined";

//    external "C" MultiPhaseMixtureMedium_getPhaseInformation_C_impl(phaseLabel,stateOfAggregation,keyCompoundId,excludedCompoundId,densityDescription,userDescription,typeOfSolid,eo)
//     annotation (Include="#include \"externalmixturemedialib.h\"",
//       Library="ExternalMultiPhaseMixtureLib");
   external "C" MultiPhaseMixtureMedium_getPhaseProperties_C_impl(eo,phaseLabel, stateOfAggregation,nP)  annotation (Include="#include \"externalmixturemedialib.h\"",
      Library="ExternalMultiPhaseMixtureLib");

end getPhaseInformation;
