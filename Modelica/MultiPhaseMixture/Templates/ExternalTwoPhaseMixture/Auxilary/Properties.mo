within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
record Properties

  //-----------Phase properties--------------//
  Integer nbrOfPresentPhases(min=0, max=nP)
    "Number of present phases, 0= unknown";
//  Integer presentPhaseIndex[nP]; //stop search when presentPhaseIndex[i] < 0 or i==nP
  Real presentPhaseIndex[nP];
                              //stop search when presentPhaseIndex[i] < 0 or i==nP
  Modelica.SIunits.MassFraction phaseComposition[nP
    *nC] "matrix with composition for each phase";
  Modelica.SIunits.MoleFraction phaseFraction[nP]
    "molar fraction of the fluid that is in the specified phase";

 //-----------overAllProperties - bulk properties--------------//
  Modelica.SIunits.Temperature T_overall "temperature";
  Modelica.SIunits.Density d_overall "density";
  Modelica.SIunits.SpecificEntropy s_overall "specific entropy";
  Modelica.SIunits.AbsolutePressure p_overall "pressure";
  Modelica.SIunits.SpecificEnthalpy h_overall "specific enthalpy";
//  Modelica.SIunits.MoleFraction Z_overall "molar fractions";

 // ----------singlePhaseThermoProperties--------------//

  Modelica.SIunits.Density d_1ph[nP] "density";
  Modelica.SIunits.SpecificEntropy s_1ph[nP] "specific entropy";
  Modelica.SIunits.SpecificEnthalpy h_1ph[nP] "specific enthalpy";

  Modelica.SIunits.PrandtlNumber Pr_1ph[nP] "prandtl number";
  Modelica.SIunits.VelocityOfSound a_1ph[nP] "velocity of sound";
  Modelica.SIunits.CubicExpansionCoefficient beta_1ph[nP]
    "isobaric expansion coefficient";
  Modelica.SIunits.SpecificHeatCapacity cp_1ph[nP] "specific heat capacity cp";
  Modelica.SIunits.SpecificHeatCapacity cv_1ph[nP] "specific heat capacity cv";

  Modelica.SIunits.Compressibility kappa_1ph[nP] "compressibility";

 // ----------singlePhaseDerivatives--------------//
  Modelica.SIunits.DerPressureByTemperature dpdT_dN_1ph[nP]
    "Derivative of pressure w.r.t. temperature at constant density and N";
  Modelica.SIunits.DerPressureByDensity dpdd_TN_1ph[nP]
    "Derivative of pressure w.r.t. density at constant temperatre and molar substance";

 // Derivatives needed for state transformation etc
//   Modelica.SIunits.DerDensityByEnthalpy ddhp_1ph[nP]
//     "derivative of density wrt enthalpy at constant pressure";
//   Modelica.SIunits.DerDensityByPressure ddph_1ph[nP]
//     "derivative of density wrt pressure at constant enthalpy";

 // ----------singlePhaseTransportProperties--------------//
  Modelica.SIunits.ThermalConductivity lambda_1ph[nP] "thermal conductivity";
  Modelica.SIunits.DynamicViscosity eta_1ph[nP] "dynamic viscosity";

end Properties;
