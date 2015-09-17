within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model CreatePhaseVectorFailureWithPurpouse
  package Medium=MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
  parameter Real vec[Medium.nP]=Interfaces.createPhaseFractionVector({"Liquid",
      "Vapor"}, {0.3,0.8});

end CreatePhaseVectorFailureWithPurpouse;
