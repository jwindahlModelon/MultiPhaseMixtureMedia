within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture;
function getNumberOfPhases
  extends MultiPhaseMixture.Icons.ExternalFunction;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo;
  output Integer nbrOfPhases "Number of phases";
  external "C" nbrOfPhases=MultiPhaseMixtureMedium_getNumberOfPhases_C_impl(eo)
    annotation (Include="#include \"externalmixturemedialib.h\"",
      Library="ExternalMultiPhaseMixtureLib");
end getNumberOfPhases;
