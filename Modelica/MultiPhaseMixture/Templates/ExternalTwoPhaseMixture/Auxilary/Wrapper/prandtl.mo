within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function prandtl
  input Properties state;
  output Real Pr;
algorithm
  if (state.nbrOfPresentPhases == 1) then
    Pr:=state.Pr_1ph[integer(state.presentPhaseIndex[1])];
  else
   // Pr not defined?  for multiple phases but creating a smooth transition
    for i in 1:state.nbrOfPresentPhases loop
      Pr:=Pr+state.Pr_1ph[integer(state.presentPhaseIndex[i])]*state.phaseFraction[integer(state.presentPhaseIndex[i])];
    end for;
  end if;

end prandtl;
