within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function volumetricExpansionCoefficient
  input Properties state;
  output Real beta;

algorithm
  if (state.nbrOfPresentPhases == 1) then
    beta:=state.beta_1ph[integer(state.presentPhaseIndex[1])];
  else
   // beta not defined (=infinite) for multiple phases but creating a smooth transition
   // see definition of beta in "Partial derivatives of thermodynamic state propertie for dynamic simulation"
   beta:=0;
    for i in 1:state.nbrOfPresentPhases loop
      beta:=beta+state.beta_1ph[integer(state.presentPhaseIndex[i])]*state.phaseFraction[integer(state.presentPhaseIndex[i])];
    end for;
  end if;
end volumetricExpansionCoefficient;
