within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function specificHeatCapacityCv_X
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real cv;
protected
  Modelica.Media.Common.PhaseBoundaryProperties liq
    "Properties on the boiling curve";
  Modelica.Media.Common.PhaseBoundaryProperties vap
    "Properties on the condensation curve";
  SI.MassFraction x[2] "Vapour mass fraction";
  Real delta=1e-2;
  Modelica.SIunits.SpecificInternalEnergy u;
  Modelica.SIunits.SpecificInternalEnergy u1;

  Integer liq_index;
  Integer vap_index;
  Real MM;

algorithm
  if (state.nbrOfPresentPhases == 1) then
    Modelica.Utilities.Streams.print("state.nbrOfPresentPhases == 1");
    cv:=state.cv_1ph[integer(state.presentPhaseIndex[1])];
  elseif (nC == 1 and nP
       == 2) then
   // Modelica.Utilities.Streams.print("Inside nC == 1 and nP == 2 ");
    //twophase-zone for a pure medium
    // defined in "Partial derivatives of thermodynamic state propertie for dynamic simulation"
    liq_index :=PhaseLabelLiquid;
    //  getPhaseIndex("Liquid");
    vap_index :=PhaseLabelVapor;
  //    getPhaseIndex("Vapor");
 //   Modelica.Utilities.Streams.print("state.phaseFraction[vap_index]="+String(state.phaseFraction[vap_index]));
    MM := getAverageMolarMass(X=X,X_unit=1,eo=eo);
    x :=moleToMassFractions({state.phaseFraction[liq_index],state.phaseFraction[
      vap_index]}, {MM,MM});
    liq.d:=state.d_1ph[liq_index];
    liq.h:=state.h_1ph[liq_index];
    liq.s:=state.s_1ph[liq_index];
    liq.cp:=state.cp_1ph[liq_index];
    liq.cv:=state.cv_1ph[liq_index];
    liq.pt:=state.dpdT_dN_1ph[liq_index];
    liq.pd:=state.dpdd_TN_1ph[liq_index];
    liq.u:=liq.h-state.p_overall/liq.d;

    vap.d:=state.d_1ph[vap_index];
    vap.h:=state.h_1ph[vap_index];
    vap.s:=state.s_1ph[vap_index];
    vap.cp:=state.cp_1ph[vap_index];
    vap.cv:=state.cv_1ph[vap_index];
    vap.pt:=state.dpdT_dN_1ph[vap_index];
    vap.pd:=state.dpdd_TN_1ph[vap_index];
    vap.u:=vap.h-state.p_overall/vap.d;
 //  Modelica.Utilities.Streams.print("x="+String(x[2]));
    cv:=Modelica.Media.Common.cv2Phase(liq=liq,vap=vap,x=x[2],T=state.T_overall,p=state.p_overall);
  else
   // Modelica.Utilities.Streams.print("state.nbrOfPresentPhases == many");
   //multiphase-zone
   // numerical derivative
   // cv=du/dT at const v, source: "Partial derivatives of thermodynamic state properties for simulation"
    u:=state.h_overall-state.p_overall/state.d_overall;
  //  u1:=specificInternalEnergy(setState_dTX(state.d_overall,state.T_overall+delta,X));
    u1 := Wrapper_dTX.specificInternalEnergy_dTX(
            d=state.d_overall,
            T=state.T_overall + delta,
            X=X,
            state=
        calcProperties_dTX(
              d=state.d_overall,
              T=state.T_overall + delta,
              X=X,
              eo=eo));
    cv:=(u1-u)/delta;
  end if;
end specificHeatCapacityCv_X;
