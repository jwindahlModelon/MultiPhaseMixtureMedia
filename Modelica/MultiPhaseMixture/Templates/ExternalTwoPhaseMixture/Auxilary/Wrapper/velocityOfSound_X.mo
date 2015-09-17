within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function velocityOfSound_X
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
   output Real a;
protected
  Real cv;
  Real dpT;
  Integer liq_index;
  Integer vap_index;
  Real liq_d;
  Real liq_s;
  Real vap_d;
  Real vap_s;
  Real eps=1e-8;
algorithm
  if (state.nbrOfPresentPhases == 1) then
    a:=state.a_1ph[integer(state.presentPhaseIndex[1])];
  elseif (nC == 1 and nP == 2) then
    //twophase-zone for a pure medium

    cv:=specificHeatCapacityCv_X(
      X=X,
      state=state,eo=eo);
    dpT:=0;
    liq_index :=PhaseLabelLiquid;
    vap_index :=PhaseLabelVapor;

    liq_d:=state.d_1ph[liq_index];
    liq_s:=state.s_1ph[liq_index];

    vap_d:=state.d_1ph[vap_index];
    vap_s:=state.s_1ph[vap_index];
    // Formula from Modelica.Media.Water.IF97_Utilities.waterBaseProp_ph
    dpT :=  (vap_s - liq_s)*liq_d*vap_d/(max(liq_d -vap_d,eps));

    // Equation from Modelica.Media.Water.IF97_Utilities.velocityOfSound_props_ph
    a:=sqrt(max(0, 1/((state.d_overall*(state.d_overall*cv/dpT + 1.0)/(dpT*state.T_overall))
         - 1/state.d_overall*state.d_overall*state.d_overall/(dpT*state.T_overall))));
  else
   //multiphase-zone
    a:=0;
  //  assert(false,"Not implemented");
  end if;

end velocityOfSound_X;
