within MultiPhaseMixture.Air_PureModelica.Tests;
model CreatePhaseVectorFailureWithPurpouse
  package Medium=MultiPhaseMixture.Air_PureModelica;
  parameter Real vec[Medium.nP]=Interfaces.createPhaseFractionVector({"Liquid",
      "Vapor"}, {0.3,0.8});

end CreatePhaseVectorFailureWithPurpouse;
