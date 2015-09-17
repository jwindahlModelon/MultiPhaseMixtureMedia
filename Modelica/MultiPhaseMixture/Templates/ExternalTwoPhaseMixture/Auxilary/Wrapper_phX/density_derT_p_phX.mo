within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function density_derT_p_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
   output Real ddTp "Density derivative wrt T at constant pressure";
algorithm
  if (state.nbrOfPresentPhases == 1) then
    ddTp:=-state.beta_1ph[integer(state.presentPhaseIndex[1])]*state.d_1ph[integer(state.presentPhaseIndex[1])];
  else
    assert(false,"Not implemented");
  end if;

 annotation(Inline = false,LateInline=true);
end density_derT_p_phX;
