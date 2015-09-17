within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_dTX;
function equilibrium_dTX
  input Modelica.SIunits.Density d "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output FlashProperties flash;

//  Modelica.SIunits.AmountOfSubstance[nC]
//     Z;
//  Modelica.SIunits.AmountOfSubstance sum_Z=sum(Z);
//  Modelica.SIunits.MoleFraction[nP,
//     nC] x "Mole fractions in each phase";
//  Modelica.SIunits.AmountOfSubstance[nP]
//     Z_phase "Amount of substance in each phase";
algorithm
  flash:=Wrapper.equilibrium_X(X,state);
   annotation (Inline=true);
end equilibrium_dTX;
