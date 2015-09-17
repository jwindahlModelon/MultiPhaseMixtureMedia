within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture;
function getNumberOfCompounds
  extends MultiPhaseMixture.Icons.ExternalFunction;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo;
  output Integer nbrOfCompounds "Number of compounds";
  external "C" nbrOfCompounds=MultiPhaseMixtureMedium_getNumberOfCompounds_C_impl(eo)
    annotation (Include="#include \"externalmixturemedialib.h\"",
      Library="ExternalMultiPhaseMixtureLib");
end getNumberOfCompounds;
