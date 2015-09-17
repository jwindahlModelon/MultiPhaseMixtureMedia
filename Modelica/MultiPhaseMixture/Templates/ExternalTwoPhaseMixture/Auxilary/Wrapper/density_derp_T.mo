within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function density_derp_T
  input Properties state;
   output Real ddpT "Density derivative wrt p at constant temperature";
algorithm
  if (state.nbrOfPresentPhases == 1) then
    ddpT:=state.kappa_1ph[integer(state.presentPhaseIndex[1])]*state.d_1ph[integer(state.presentPhaseIndex[1])];
  else
    assert(false,"not implemented");
  end if;

end density_derp_T;
