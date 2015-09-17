within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function isothermalCompressibility
  input Properties state;
  output Real kappa;
algorithm
   if (state.nbrOfPresentPhases == 1) then
    kappa:=state.kappa_1ph[integer(state.presentPhaseIndex[1])];
  else
   // kappa not defined (=infinite) for multiple phases but creating a smooth transition
   // see definition in "Partial derivatives of thermodynamic state properties for dynamic simulation"
   kappa:=0;
    for i in 1:state.nbrOfPresentPhases loop
      kappa:=kappa+state.kappa_1ph[integer(state.presentPhaseIndex[i])]*state.phaseFraction[integer(state.presentPhaseIndex[i])];
    end for;
  end if;

end isothermalCompressibility;
