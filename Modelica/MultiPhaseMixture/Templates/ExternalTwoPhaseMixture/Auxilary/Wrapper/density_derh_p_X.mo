within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function density_derh_p_X
  input Modelica.Media.Interfaces.Types.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real ddhp "Density derivative wrt h at constant pressure";
protected
  Real dpT;
  Integer liq_index;
  Integer vap_index;
  Real liq_d;
  Real liq_s;
  Real vap_d;
  Real vap_s;
  Real eps=1e-8;
  Real pd;
  Real pt;
  Real cv;
  Real deltah=1e-3;
  Real d_deltah;
algorithm
  if (state.nbrOfPresentPhases == 1) then
   // ddhp:=state.ddhp_1ph[state.presentPhaseIndex[1]];
    pd:=state.dpdd_TN_1ph[integer(state.presentPhaseIndex[1])];
    pt:=state.dpdT_dN_1ph[integer(state.presentPhaseIndex[1])];
    cv:=state.cv_1ph[integer(state.presentPhaseIndex[1])];
    // ddhp formula from Modelica.Media.Water.IF97_Utilities.ddhp_props
    ddhp:= -state.d_overall*state.d_overall*pt/(state.d_overall*state.d_overall*pd*cv + state.T_overall*pt*pt);
  elseif (nC == 1 and nP
       == 2) then
    liq_index :=PhaseLabelLiquid;
    vap_index :=PhaseLabelVapor;

    liq_d:=state.d_1ph[liq_index];
    liq_s:=state.s_1ph[liq_index];

    vap_d:=state.d_1ph[vap_index];
    vap_s:=state.s_1ph[vap_index];
    // dpT Formula from Modelica.Media.Water.IF97_Utilities.waterBaseProp_ph
    dpT :=  (vap_s - liq_s)*liq_d*vap_d/(max(liq_d -vap_d,eps));
    // ddhp formula from Modelica.Media.Water.IF97_Utilities.ddhp_props
    ddhp:=-state.d_overall*state.d_overall/(dpT*state.T_overall);
  else
    // multiple phases - calculate ddhp numerically
 //   d_deltah:=density(setState_phX(state.p_overall,state.h_overall+deltah,X));
    d_deltah:= Wrapper_phX.density_phX(p=state.p_overall, h=state.h_overall+deltah,X=X,state=calcProperties_phX(p=state.p_overall,h=state.h_overall+deltah,X=X,eo=eo),eo=eo);
    ddhp:=(d_deltah-state.d_overall)/deltah;

  end if;

end density_derh_p_X;
