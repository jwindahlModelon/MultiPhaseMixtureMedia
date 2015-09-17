within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model CreatePhaseVector
  package Medium=MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
  parameter Real vec[Medium.nP]=Interfaces.createPhaseFractionVector({"Liquid",
      "Vapor"}, {0.3,0.7});
  parameter Real vec2[Medium.nP]=Interfaces.createPhaseFractionVector({"Liquid"},
      {0.3});
  parameter Real vec3[Medium.nP]=Interfaces.createPhaseFractionVector({"Vapor"},
      {0.7});
  parameter Integer Liquid_index=Medium.getPhaseIndex("Liquid");
  parameter Integer Vapor_index=Medium.getPhaseIndex("Vapor");
equation

end CreatePhaseVector;
