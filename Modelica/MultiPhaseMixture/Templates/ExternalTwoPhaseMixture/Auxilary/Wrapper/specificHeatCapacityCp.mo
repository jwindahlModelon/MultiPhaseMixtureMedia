within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function specificHeatCapacityCp
  input Properties state;
  output Real cp;
algorithm
  if (state.nbrOfPresentPhases == 1) then
    cp:=state.cp_1ph[integer(state.presentPhaseIndex[1])];
  else
   // Cp not defined (=infinite) for multiple phases but creating a smooth transition
    for i in 1:state.nbrOfPresentPhases loop
      cp:=cp+state.cp_1ph[integer(state.presentPhaseIndex[i])]*state.phaseFraction[integer(state.presentPhaseIndex[i])];
    end for;
  end if;

end specificHeatCapacityCp;
