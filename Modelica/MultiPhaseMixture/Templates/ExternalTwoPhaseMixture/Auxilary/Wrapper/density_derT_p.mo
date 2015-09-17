within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function density_derT_p
  input Properties state;
   output Real ddTp "Density derivative wrt T at constant pressure";
algorithm
  if (state.nbrOfPresentPhases == 1) then
    ddTp:=-state.beta_1ph[integer(state.presentPhaseIndex[1])]*state.d_1ph[integer(state.presentPhaseIndex[1])];
  else
    assert(false,"Not implemented");
  end if;

end density_derT_p;
