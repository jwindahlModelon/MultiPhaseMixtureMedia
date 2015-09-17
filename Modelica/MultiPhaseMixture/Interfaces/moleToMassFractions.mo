within MultiPhaseMixture.Interfaces;
function moleToMassFractions
  "Compute mass fractions vector from mole fractions and molar masses"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.MoleFraction moleFractions[:]
    "Mole fractions of mixture";
  input Modelica.SIunits.MolarMass[size(
  moleFractions, 1)] MMX "Molar masses of components";
  output Modelica.SIunits.MassFraction X[size(
  moleFractions, 1)] "Mass fractions of gas mixture";
protected
  Modelica.SIunits.MolarMass Mmix=moleFractions*MMX "molar mass of mixture";
algorithm
  for i in 1:size(moleFractions, 1) loop
    X[i] := moleFractions[i]*MMX[i] /Mmix;
  end for;
 annotation(smoothOrder=5);
end moleToMassFractions;
