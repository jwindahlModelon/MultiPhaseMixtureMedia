within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function kinematicViscosity
  input Properties state;
  output Real nu;
algorithm
  if (state.nbrOfPresentPhases == 1) then
    nu:=state.eta_1ph[integer(state.presentPhaseIndex[1])]/state.d_1ph[integer(state.presentPhaseIndex[1])];
  else
    // eta not defined for multiple phases but creating a smooth transition
    nu:=0;
    for i in 1:state.nbrOfPresentPhases loop
      nu:=nu+state.eta_1ph[integer(state.presentPhaseIndex[i])]/state.d_1ph[integer(state.presentPhaseIndex[i])]*state.phaseFraction[integer(state.presentPhaseIndex[i])];
    end for;
  end if;

end kinematicViscosity;
