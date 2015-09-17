within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function density_derp_h_X
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real ddph "Density derivative wrt p at constant enthalpy";
protected
  Real cv;
  Real pt;
  Real pd;
  Real dpT;
  Integer liq_index;
  Integer vap_index;
  Real liq_d;
  Real liq_s;
  Real vap_d;
  Real vap_s;
  Real eps=1e-8;
  Real deltap=1;
  Real d_deltap;
algorithm
  if (state.nbrOfPresentPhases == 1) then
    cv:=state.cv_1ph[integer(state.presentPhaseIndex[1])];
    pt:=state.dpdT_dN_1ph[integer(state.presentPhaseIndex[1])];
    pd:=state.dpdd_TN_1ph[integer(state.presentPhaseIndex[1])];
    // formula from Modelica.Media.Water.IF97_Utilities.ddph_props
    ddph:=   ((state.d_overall*(cv*state.d_overall + pt))
               /(state.d_overall*state.d_overall*pd*cv + state.T_overall*pt*pt));

  elseif (nC == 1 and nP
       == 2) then
    cv := specificHeatCapacityCv_X(
      X=X,
      state=state,
      eo=eo);
    dpT:=0;
    liq_index :=PhaseLabelLiquid;
    vap_index :=PhaseLabelVapor;

    liq_d:=state.d_1ph[liq_index];
    liq_s:=state.s_1ph[liq_index];

    vap_d:=state.d_1ph[vap_index];
    vap_s:=state.s_1ph[vap_index];
    // Formula from Modelica.Media.Water.IF97_Utilities.waterBaseProp_ph
    dpT :=  (vap_s - liq_s)*liq_d*vap_d/(max(liq_d -vap_d,eps));
    ddph:=(state.d_overall*(state.d_overall*cv/dpT + 1.0)/(dpT*state.T_overall));
  else
    // multiple phases - calculate ddhp numerically
   // d_deltap:=density(setState_phX(state.p_overall+deltap,state.h_overall,X));
    d_deltap:= Wrapper_phX.density_phX(p=state.p_overall+deltap, h=state.h_overall,X=X,state=calcProperties_phX(p=state.p_overall+deltap,h=state.h_overall,X=X,eo=eo),eo=eo);

    ddph:=(d_deltap-state.d_overall)/deltap;
  end if;

end density_derp_h_X;
