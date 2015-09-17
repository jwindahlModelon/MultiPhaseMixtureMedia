within MultiPhaseMixture.Interfaces;
record Phases "Definition and additional information of supported phases"
   String label[nP] "List of supported phases";
   String stateOfAggregation[nP]
    "State of aggregation. Supported values Liquid,Vapor,Solid,Unknown";
  // TODO: add these later when there is a use case for them + helper functions
  //      String keyCompoundId[nP]={"Undefined","Undefined"}
  //       "The identifier of the Compound that is expected to be present in highest concentration in the phase";
  //      String excludedCompoundId[nP]={"Undefined","Undefined"}
  //       "The identifier of the Compound that is expected to be present in low or zero concentration in the phase";
  //      String densityDescription[nP]={"High","Low"}
  //       "Desciption that indicates the density range expected for the phase. Supported values: Heavy, Light, Undefined";
  //      String userDescription[nP]={"Liquid phase","Vapor phase"}
  //       "Desciption that helps the user of tool to identify the phase";
  //      String typeOfSolid[nP]={"Undefined","Undefined"}
  //       "A description that provides more inofrmation about a solid phase. Supported values: PureSoldid,SolidSolution,HydrateI,HydrateII,HydrateH,Undefined";
end Phases;
