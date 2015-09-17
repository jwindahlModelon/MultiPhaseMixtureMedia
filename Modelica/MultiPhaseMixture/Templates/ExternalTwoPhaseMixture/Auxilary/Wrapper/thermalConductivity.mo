within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function thermalConductivity
  input Properties state;
   output Real lambda;
algorithm

  if (state.nbrOfPresentPhases == 1) then
    lambda:=state.lambda_1ph[integer(state.presentPhaseIndex[1])];
  else
   // lambda not defined for multiple phases but creating a smooth transition
    lambda:=0;
    for i in 1:state.nbrOfPresentPhases loop
      lambda:=lambda+state.lambda_1ph[integer(state.presentPhaseIndex[i])]*state.phaseFraction[integer(state.presentPhaseIndex[i])];
    end for;
  end if;

end thermalConductivity;
