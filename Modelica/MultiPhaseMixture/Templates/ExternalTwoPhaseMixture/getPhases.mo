within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture;
function getPhases "Returns a preconfigured Phases record"
   input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo;
   output Phases phases;
// protected
//    String phaseLabel[nP] "Supported phases";
//    String stateOfAggregation[nP] "State of aggregation";
algorithm
   (phases.label,phases.stateOfAggregation):=getPhaseInformation(eo);
//    (phaseLabel,stateOfAggregation):=getPhaseInformation(eo);
//     phases.label:=phaseLabel;
//     phases.stateOfAggregation:=stateOfAggregation;
end getPhases;
