within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function dynamicViscosity
  input Properties state;
   output Real eta;
algorithm
   if (state.nbrOfPresentPhases == 1) then
    eta:=state.eta_1ph[integer(state.presentPhaseIndex[1])];
   else
   // eta not defined for multiple phases but creating a smooth transition
    eta:=0;
    for i in 1:state.nbrOfPresentPhases loop
      eta:=eta+state.eta_1ph[integer(state.presentPhaseIndex[i])]*state.phaseFraction[integer(state.presentPhaseIndex[i])];
    end for;
  end if;

end dynamicViscosity;
