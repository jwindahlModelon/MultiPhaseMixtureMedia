within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function density_derp_T_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real ddpT "Density derivative wrt p at constant temperature";
algorithm
  if (state.nbrOfPresentPhases == 1) then
    ddpT:=state.kappa_1ph[integer(state.presentPhaseIndex[1])]*state.d_1ph[integer(state.presentPhaseIndex[1])];
  else
    assert(false,"not implemented");
  end if;

 annotation(Inline = false,LateInline=true);
end density_derp_T_phX;
