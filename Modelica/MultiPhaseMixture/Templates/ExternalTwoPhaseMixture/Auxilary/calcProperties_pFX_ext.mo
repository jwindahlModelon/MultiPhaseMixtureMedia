within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
function calcProperties_pFX_ext
  "Return thermodynamic state record from p, F and X"
  // Wrapper function- needed due to not allowed to have arrays in record for external functions

  // Similar functionality as before with calcProperties but difference is that overall properties is not calculated for most properties,
  // if they are needed by simulation environment they should

  extends MultiPhaseMixture.Icons.ExternalFunction;
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.MassFraction F[nP] "Mass fractions";
  input Integer F_unit=UnitBasis.MassFraction;
  input Modelica.SIunits.MassFraction X[nC] "Mass fractions";
  input Integer X_unit=UnitBasis.MassFraction;
  input Integer solutionType "Solution type";
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject  eo;

  // phaseState
 //-----------overAllProperties--------------//
  output Modelica.SIunits.AbsolutePressure p_overall_ "pressure";
  output Modelica.SIunits.Temperature T_overall_ "temperature";
  output Modelica.SIunits.Density d_overall_ "density";
  output Modelica.SIunits.SpecificEnthalpy h_overall_ "specific enthalpy";
  output Modelica.SIunits.SpecificEntropy s_overall_ "specific entropy";

 // ----------singlePhaseThermoProperties--------------//
  output Modelica.SIunits.Density d_1ph_[nP] "density";
  output Modelica.SIunits.SpecificEnthalpy h_1ph_[nP] "specific enthalpy";
  output Modelica.SIunits.SpecificEntropy s_1ph_[nP] "specific entropy";
  output Modelica.SIunits.PrandtlNumber Pr_1ph_[nP] "prandtl number";
  output Modelica.SIunits.VelocityOfSound a_1ph_[nP] "velocity of sound";
  output Modelica.SIunits.CubicExpansionCoefficient beta_1ph_[
    nP] "isobaric expansion coefficient";
  output Modelica.SIunits.SpecificHeatCapacity cp_1ph_[nP]
    "specific heat capacity cp";
  output Modelica.SIunits.SpecificHeatCapacity cv_1ph_[nP]
    "specific heat capacity cv";
  output Modelica.SIunits.Compressibility kappa_1ph_[nP] "compressibility";

 // ----------singlePhaseTransportProperties--------------//
  output Modelica.SIunits.ThermalConductivity lambda_1ph_[
    nP] "thermal conductivity";
  output Modelica.SIunits.DynamicViscosity eta_1ph_[nP] "dynamic viscosity";

 // ----------singlePhaseDerivatives--------------//
  output Modelica.SIunits.DerPressureByTemperature dpdT_dN_1ph_[
    nP] "Derivative of pressure w.r.t. temperature";
  output Modelica.SIunits.DerPressureByDensity dpdd_TN_1ph_[
    nP] "Derivative of pressure w.r.t. density";

 //-----------Phase properties--------------//
  output Integer nbrOfPresentPhases_(min=0, max=nP)
    "Number of present phases, 0= unknown,1=single phase";
  output Integer presentPhaseIndex_[nP];
                                         //stop search when presentPhaseIndex[i] < 0 or i==nP
  output Modelica.SIunits.MassFraction phaseCompositions_[
    nP*
    nC] "matrix with composition for each phase";
  output Modelica.SIunits.MoleFraction phaseFractions_[nP]
    "molar fraction of the fluid that is in the specified phase";

external"C" MultiPhaseMixtureMedium_calcThermoProperties_pFX_C_impl(
      p,
      F,
      F_unit,
      X,
      size(X, 1),
      X_unit,
      eo,
      p_overall_,
      T_overall_,
      d_overall_,
      h_overall_,
      s_overall_,
      d_1ph_,
      h_1ph_,
      s_1ph_,
      Pr_1ph_,
      a_1ph_,
      beta_1ph_,
      cp_1ph_,
      cv_1ph_,
      kappa_1ph_,
      lambda_1ph_,
      eta_1ph_,
      dpdT_dN_1ph_,
      dpdd_TN_1ph_,
      nbrOfPresentPhases_,
      presentPhaseIndex_,
      phaseCompositions_,
      phaseFractions_) annotation (Include="#include \"externalmixturemedialib.h\"",
      Library="ExternalMultiPhaseMixtureLib");

end calcProperties_pFX_ext;
