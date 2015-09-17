within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
function calcProperties_psX "Return thermodynamic state record from p and h"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEntropy s "specific entropy";
  input Modelica.SIunits.MassFraction X[nC]=reference_X "Mass fractions";
  input Integer X_unit=UnitBasis.MassFraction;
  input Integer phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject  eo;
  output Properties state;

 //-----------overAllProperties--------------//
protected
  Modelica.SIunits.AbsolutePressure p_overall_ "pressure";
  Modelica.SIunits.Temperature T_overall_ "temperature";
  Modelica.SIunits.Density d_overall_ "density";
  Modelica.SIunits.SpecificEnthalpy h_overall_ "specific enthalpy";
  Modelica.SIunits.SpecificEntropy s_overall_ "specific entropy";

 // ----------singlePhaseThermoProperties--------------//
  Modelica.SIunits.Density d_1ph_[nP] "density";
  Modelica.SIunits.SpecificEnthalpy h_1ph_[nP] "specific enthalpy";
  Modelica.SIunits.SpecificEntropy s_1ph_[nP] "specific entropy";
  Modelica.SIunits.PrandtlNumber Pr_1ph_[nP] "prandtl number";
  Modelica.SIunits.VelocityOfSound a_1ph_[nP] "velocity of sound";
  Modelica.SIunits.CubicExpansionCoefficient beta_1ph_[nP]
    "isobaric expansion coefficient";
  Modelica.SIunits.SpecificHeatCapacity cp_1ph_[nP] "specific heat capacity cp";
  Modelica.SIunits.SpecificHeatCapacity cv_1ph_[nP] "specific heat capacity cv";
  Modelica.SIunits.Compressibility kappa_1ph_[nP] "compressibility";

 // ----------singlePhaseTransportProperties--------------//
  Modelica.SIunits.ThermalConductivity lambda_1ph_[nP] "thermal conductivity";
  Modelica.SIunits.DynamicViscosity eta_1ph_[nP] "dynamic viscosity";

 // ----------singlePhaseDerivatives--------------//
  Modelica.SIunits.DerPressureByTemperature dpdT_dN_1ph_[
    nP] "Derivative of pressure w.r.t. temperature";
  Modelica.SIunits.DerPressureByDensity dpdd_TN_1ph_[nP]
    "Derivative of pressure w.r.t. density";

 //-----------Phase properties--------------//
  Integer nbrOfPresentPhases_(min=0, max=nP)
    "Number of present phases, 0= unknown,1=single phase";
  Integer presentPhaseIndex_[nP];
                                  //stop search when presentPhaseIndex[i] < 0 or i==nP
  Modelica.SIunits.MassFraction phaseCompositions_[nP
    *nC] "matrix with composition for each phase";
  Modelica.SIunits.MoleFraction phaseFractions_[nP]
    "molar fraction of the fluid that is in the specified phase";

  String printMe;
algorithm
 if (printExternalFunctionCall) then
   printMe:="calcProperties_psX(p=" + String(p, significantDigits=8, minimumLength=0, leftJustified=true) + ",s=" + String(s, significantDigits=8, minimumLength=0, leftJustified=true)+",X={";
  for i in 1:nC loop
    if
      (i == 1) then
      printMe:=printMe +String(X[i]);
    else
      printMe:=printMe + ","+String(X[i]);
    end if;
   end for;
    Modelica.Utilities.Streams.print(printMe+"})");
 end if;

  (p_overall_,T_overall_,d_overall_,h_overall_,s_overall_,d_1ph_,h_1ph_,
    s_1ph_,Pr_1ph_,a_1ph_,beta_1ph_,cp_1ph_,cv_1ph_,kappa_1ph_,lambda_1ph_,
    eta_1ph_,dpdT_dN_1ph_,dpdd_TN_1ph_,nbrOfPresentPhases_,presentPhaseIndex_,
    phaseCompositions_,phaseFractions_) :=
    calcProperties_psX_ext(
      p,
      s,
      X,
      X_unit,
      phase,
      eo);

  state :=
    Properties(
      nbrOfPresentPhases=nbrOfPresentPhases_,
      presentPhaseIndex=presentPhaseIndex_,
      phaseComposition=phaseCompositions_,
      phaseFraction=phaseFractions_,
      T_overall=T_overall_,
      d_overall=d_overall_,
      s_overall=s_overall_,
      p_overall=p_overall_,
      h_overall=h_overall_,
      d_1ph=d_1ph_,
      s_1ph=s_1ph_,
      h_1ph=h_1ph_,
      Pr_1ph=Pr_1ph_,
      a_1ph=a_1ph_,
      beta_1ph=beta_1ph_,
      cp_1ph=cp_1ph_,
      cv_1ph=cv_1ph_,
      kappa_1ph=kappa_1ph_,
      dpdT_dN_1ph=dpdT_dN_1ph_,
      dpdd_TN_1ph=dpdd_TN_1ph_,
      lambda_1ph=lambda_1ph_,
      eta_1ph=eta_1ph_);

end calcProperties_psX;
