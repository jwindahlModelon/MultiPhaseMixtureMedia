within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function equilibrium_X
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  output FlashProperties flash;

protected
 Modelica.SIunits.AmountOfSubstance[nC]
    Z;
 Modelica.SIunits.AmountOfSubstance sum_Z;
 Modelica.SIunits.MoleFraction[nP,
    nC] x "Mole fractions in each phase";
 Modelica.SIunits.AmountOfSubstance[nP]
    Z_phase "Amount of substance in each phase";
algorithm
  Z :=massToMoleFractions(X, MMX);
   sum_Z:=sum(Z);
  for i in 1:nP loop
   Z_phase[i]:=sum_Z*state.phaseFraction[i];
    for j in 1:nC loop
     x[i,j]:=state.phaseComposition[j + nC*(i-1)];
   end for;
 end for;
  flash := FlashProperties(
          p=state.p_overall,
          T=state.T_overall,
          x=x,
          Z=Z_phase);
end equilibrium_X;
