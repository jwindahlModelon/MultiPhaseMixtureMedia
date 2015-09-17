within MultiPhaseMixture.Templates;
package ExternalTwoPhaseMixture 

  constant PropertySetupInformation setupInfo;
  constant Boolean printExternalFunctionCall=false
  "Print function calls to log if true";
  constant MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo=
     MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject(setupInfo);

  extends Interfaces(
     externalEquilibriumSolver=true,
     MMX=Auxilary.getMolarWeights(eo),
     reference_Y=massToMoleFractions(reference_X, MMX),
     phases=getPhases(eo));





redeclare replaceable model extends ThermoProperties

protected
  Auxilary.Properties properties;
  final parameter
    MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject   eo=
                                                                        MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject(setupInfo);

equation
   /*
   The reason why all properties is calculated in each branch is due to it should be possible to differentiate them.      
     */

  if (inputs == Inputs.pTX or inputs == Inputs.pTY or inputs == Inputs.pTN) then
      properties =Auxilary.calcProperties_pTX(
        p=p,
        T=T,
        X=Z,
        eo=eo);
      d =Auxilary.Wrapper_pTX.density_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      h =Auxilary.Wrapper_pTX.specificEnthalpy_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      u =h-p/d;
//       u =Auxilary.Wrapper_pTX.specificInternalEnergy_pTX(
//         p=p,
//         T=T,
//         X=Z,
//         state=properties);

  elseif (inputs == Inputs.dTX or inputs == Inputs.dTY or inputs == Inputs.dTN) then
      properties =Auxilary.calcProperties_dTX(
        d=d,
        T=T,
        X=Z,
        eo=eo);
      p =Auxilary.Wrapper_dTX.pressure_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      h =Auxilary.Wrapper_dTX.specificEnthalpy_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
//       u =Auxilary.Wrapper_dTX.specificInternalEnergy_dTX(
//         d=d,
//         T=T,
//         X=Z,
//         state=properties);
      u =h-p/d;
  elseif (inputs == Inputs.phX or inputs == Inputs.phY or inputs == Inputs.phN) then
      properties =Auxilary.calcProperties_phX(
        p=p,
        h=h,
        X=Z,
        eo=eo);
      d =Auxilary.Wrapper_phX.density_phX(
        p=p,
        h=h,
        X=Z,
        state=properties,
        eo=eo);
      T =Auxilary.Wrapper_phX.temperature_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
//       u =Auxilary.Wrapper_phX.specificInternalEnergy_phX(
//         p=p,
//         h=h,
//         X=Z,
//         state=properties,
//         eo=eo);
     u =h-p/d;
  elseif (inputs == Inputs.duX or inputs == Inputs.duY or inputs == Inputs.duN) then
      properties =Auxilary.calcProperties_duX(
        d=d,
        u=u,
        X=Z,
        eo=eo);
      p =Auxilary.Wrapper_duX.pressure_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      T =Auxilary.Wrapper_duX.temperature_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
//       h =Auxilary.Wrapper_duX.specificEnthalpy_duX(
//         d=d,
//         u=u,
//         X=Z,
//         state=properties);
      h=u+p/d;
  else
    assert(false,"Non supported input combination");
  end if;

//     // Assignment of inputs to variables
//   if (inputs== Inputs.pTX) then
//     p=p_input;
//     T=T_input;
//     Z=Z_input;
//     Zm =massToMoleFractions(Z, MMX);
//   elseif (inputs== Inputs.phX) then
//     p=p_input;
//     h=h_input;
//     Z=Z_input;
//     Zm =massToMoleFractions(Z, MMX);
//   elseif (inputs== Inputs.dTX) then
//     d=d_input;
//     T=T_input;
//     Z=Z_input;
//     Zm =massToMoleFractions(Z, MMX);
//   elseif (inputs== Inputs.pTY) then
//     p=p_input;
//     T=T_input;
//     Zm=Zm_input;
//     Z =moleToMassFractions(Zm, MMX);
//   elseif (inputs== Inputs.phY) then
//     p=p_input;
//     hm=hm_input;
//     Zm=Zm_input;
//     Z =moleToMassFractions(Zm, MMX);
//   elseif (inputs== Inputs.dTY) then
//     dm=dm_input;
//     T=T_input;
//     Zm=Zm_input;
//     Z =moleToMassFractions(Zm, MMX);
//   elseif (inputs== Inputs.pTN) then
//     p=p_input;
//     T=T_input;
//     Zm=N_input/sum(N_input);
//     Z =moleToMassFractions(Zm, MMX);
//   elseif (inputs== Inputs.phN) then
//     p=p_input;
//     hm=hm_input;
//     Zm=N_input/sum(N_input);
//     Z =moleToMassFractions(Zm, MMX);
//   elseif (inputs== Inputs.dTN) then
//     dm=dm_input;
//     T=T_input;
//     Zm=N_input/sum(N_input);
//     Z =moleToMassFractions(Zm, MMX);
//   end if;

  if (inputs== Inputs.pTN or inputs== Inputs.phN or inputs== Inputs.dTN or inputs== Inputs.duN) then
    Zm=N/sum(N);
    Z =moleToMassFractions(Zm, MMX);
  elseif (inputs== Inputs.pTY or inputs== Inputs.phY or inputs== Inputs.dTY or inputs== Inputs.duY) then
    Z =moleToMassFractions(Zm, MMX);
    // calculate N -assuming vol=1m^3
    N=dm*1*Zm;
  elseif (inputs== Inputs.pTX or inputs== Inputs.phX or inputs== Inputs.dTX or inputs== Inputs.duX) then
    Zm =massToMoleFractions(Z, MMX);
    // calculate N -assuming vol=1m^3 -> N_sum=dm*Vol
    // calculate N -assuming vol=1m^3
    N=dm*1*Zm;
  else
    assert(false,"Non-supported inputs");
  end if;

  // Relation between mass and mole based properties
  MM=MMX*Z;
  hm=h*MM;
  um=u*MM;
  d=dm*MM;

//    if (checkValidity) then
//     for i in 1:ns loop
//       assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "Mass fraction X[" +
//         String(i) + "] = " + String(X[i]) + "of substance " +
//         substanceNames[i] + "\nof medium " + mediumName +
//         " is not in the range 0..1");
//     end for;
//     assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" +mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
//    end if;

    annotation (defaultComponentName="medium",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                           graphics));
end ThermoProperties;


redeclare replaceable model extends Properties
 extends ThermoProperties;
equation
  if (inputs == Inputs.pTX or inputs == Inputs.pTY or inputs == Inputs.pTN) then
      s =Auxilary.Wrapper_pTX.specificEntropy_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      a =Auxilary.Wrapper_pTX.velocityOfSound_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      beta =Auxilary.Wrapper_pTX.volumetricExpansionCoefficient_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      cp =Auxilary.Wrapper_pTX.specificHeatCapacityCp_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      cv =Auxilary.Wrapper_pTX.specificHeatCapacityCv_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      ddhp =Auxilary.Wrapper_pTX.density_derh_p_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      ddph =Auxilary.Wrapper_pTX.density_derp_h_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      eta =Auxilary.Wrapper_pTX.dynamicViscosity_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      kappa =Auxilary.Wrapper_pTX.isothermalCompressibility_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      lambda =Auxilary.Wrapper_pTX.thermalConductivity_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);

      Pr =Auxilary.Wrapper_pTX.prandtl_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      flashProps =Auxilary.Wrapper_pTX.equilibrium_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);

  elseif (inputs == Inputs.dTX or inputs == Inputs.dTY or inputs == Inputs.dTN) then
       s =Auxilary.Wrapper_dTX.specificEntropy_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      a =Auxilary.Wrapper_dTX.velocityOfSound_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      beta =Auxilary.Wrapper_dTX.volumetricExpansionCoefficient_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      cp =Auxilary.Wrapper_dTX.specificHeatCapacityCp_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      cv =Auxilary.Wrapper_dTX.specificHeatCapacityCv_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      ddhp =Auxilary.Wrapper_dTX.density_derh_p_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      ddph =Auxilary.Wrapper_dTX.density_derp_h_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties,
        eo=eo);
      eta =Auxilary.Wrapper_dTX.dynamicViscosity_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      kappa =Auxilary.Wrapper_dTX.isothermalCompressibility_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      lambda =Auxilary.Wrapper_dTX.thermalConductivity_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      Pr =Auxilary.Wrapper_dTX.prandtl_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      flashProps =Auxilary.Wrapper_dTX.equilibrium_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
  elseif (inputs == Inputs.phX or inputs == Inputs.phY or inputs == Inputs.phN) then
      s =Auxilary.Wrapper_phX.specificEntropy_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      a =Auxilary.Wrapper_phX.velocityOfSound_phX(
        p=p,
        h=h,
        X=Z,
        state=properties,
        eo=eo);
      beta =Auxilary.Wrapper_phX.volumetricExpansionCoefficient_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      cp =Auxilary.Wrapper_phX.specificHeatCapacityCp_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      cv =Auxilary.Wrapper_phX.specificHeatCapacityCv_phX(
        p=p,
        h=h,
        X=Z,
        state=properties,
        eo=eo);
      ddhp =Auxilary.Wrapper_phX.density_derh_p_phX(
        p=p,
        h=h,
        X=Z,
        state=properties,
        eo=eo);
      ddph =Auxilary.Wrapper_phX.density_derp_h_phX(
        p=p,
        h=h,
        X=Z,
        state=properties,
        eo=eo);
      eta =Auxilary.Wrapper_phX.dynamicViscosity_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      kappa =Auxilary.Wrapper_phX.isothermalCompressibility_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      lambda =Auxilary.Wrapper_phX.thermalConductivity_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      Pr =Auxilary.Wrapper_phX.prandtl_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      flashProps =Auxilary.Wrapper_phX.equilibrium_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
  elseif (inputs == Inputs.duX or inputs == Inputs.duY or inputs == Inputs.duN) then
       s =Auxilary.Wrapper_duX.specificEntropy_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      a =Auxilary.Wrapper_duX.velocityOfSound_duX(
        d=d,
        u=u,
        X=Z,
        state=properties,
        eo=eo);
      beta =Auxilary.Wrapper_duX.volumetricExpansionCoefficient_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      cp =Auxilary.Wrapper_duX.specificHeatCapacityCp_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      cv =Auxilary.Wrapper_duX.specificHeatCapacityCv_duX(
        d=d,
        u=u,
        X=Z,
        state=properties,
        eo=eo);
      ddhp =Auxilary.Wrapper_duX.density_derh_p_duX(
        d=d,
        u=u,
        X=Z,
        state=properties,
        eo=eo);
      ddph =Auxilary.Wrapper_duX.density_derp_h_duX(
        d=d,
        u=u,
        X=Z,
        state=properties,
        eo=eo);
      eta =Auxilary.Wrapper_duX.dynamicViscosity_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      kappa =Auxilary.Wrapper_duX.isothermalCompressibility_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      lambda =Auxilary.Wrapper_duX.thermalConductivity_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      Pr =Auxilary.Wrapper_duX.prandtl_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      flashProps =Auxilary.Wrapper_duX.equilibrium_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);

  else
    assert(false,"Non supported input combination of inputs");
  end if;
 sm=s*MM;
 cpm=cp*MM;
 cvm=cv*MM;
end Properties;


redeclare replaceable model extends MultiPhaseProperties
 extends MultiPhaseMixture.Interfaces.MultiPhaseProperties;
//protected
  Auxilary.Properties properties;
  final parameter
    MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo=MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject(setupInfo);
equation
  if (inputs == Inputs.pTX or inputs == Inputs.pTY or inputs == Inputs.pTN) then
      properties =Auxilary.calcProperties_pTX(
        p=p,
        T=T,
        X=Z,
        eo=eo);
      d =Auxilary.Wrapper_pTX.density_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      h =Auxilary.Wrapper_pTX.specificEnthalpy_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);
      u =Auxilary.Wrapper_pTX.specificInternalEnergy_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);

       eqProperties =Auxilary.Wrapper_pTX.equilibrium_pTX(
        p=p,
        T=T,
        X=Z,
        state=properties);

  elseif (inputs == Inputs.dTX or inputs == Inputs.dTY or inputs == Inputs.dTN) then
      properties =Auxilary.calcProperties_dTX(
        d=d,
        T=T,
        X=Z,
        eo=eo);
      p =Auxilary.Wrapper_dTX.pressure_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      h =Auxilary.Wrapper_dTX.specificEnthalpy_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      u =Auxilary.Wrapper_dTX.specificInternalEnergy_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
      eqProperties =Auxilary.Wrapper_dTX.equilibrium_dTX(
        d=d,
        T=T,
        X=Z,
        state=properties);
  elseif (inputs == Inputs.phX or inputs == Inputs.phY or inputs == Inputs.phN) then
      properties =Auxilary.calcProperties_phX(
        p=p,
        h=h,
        X=Z,
        eo=eo);
      d =Auxilary.Wrapper_phX.density_phX(
        p=p,
        h=h,
        X=Z,
        state=properties,
        eo=eo);
      T =Auxilary.Wrapper_phX.temperature_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
      u =Auxilary.Wrapper_phX.specificInternalEnergy_phX(
        p=p,
        h=h,
        X=Z,
        state=properties,
        eo=eo);
      eqProperties =Auxilary.Wrapper_phX.equilibrium_phX(
        p=p,
        h=h,
        X=Z,
        state=properties);
    elseif (inputs == Inputs.duX or inputs == Inputs.duY or inputs == Inputs.duN) then
      properties =Auxilary.calcProperties_duX(
        d=d,
        u=u,
        X=Z,
        eo=eo);
      p =Auxilary.Wrapper_duX.pressure_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      T =Auxilary.Wrapper_duX.temperature_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      h =Auxilary.Wrapper_duX.specificEnthalpy_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);
      eqProperties =Auxilary.Wrapper_duX.equilibrium_duX(
        d=d,
        u=u,
        X=Z,
        state=properties);

  else
    assert(false,"Non supported input combination");
  end if;

 //-----------Phase properties--------------//
   nbrOfPresentPhases=properties.nbrOfPresentPhases
    "Number of present phases, 0= unknown";
   presentPhaseIndex=properties.presentPhaseIndex
    "stop search when presentPhaseIndex[i] < 0 or i==nP";
   phaseComposition=properties.phaseComposition
    "matrix with composition for each phase";
   phaseFraction=properties.phaseFraction
    "molar fraction of the fluid that is in the specified phase";

//-----------overAllProperties - bulk properties--------------//
    T_overall=properties.T_overall "temperature";
    d_overall=properties.d_overall "density";
    s_overall=properties.s_overall "specific entropy";
    p_overall=properties.p_overall "pressure";
    h_overall=properties.h_overall "specific enthalpy";

   // ----------singlePhaseThermoProperties--------------//
   d_1ph=properties.d_1ph "density";
   s_1ph=properties.s_1ph "specific entropy";
   h_1ph=properties.h_1ph "specific enthalpy";
   Pr_1ph=properties.Pr_1ph "prandtl number";
   a_1ph=properties.a_1ph "velocity of sound";
   beta_1ph=properties.beta_1ph "isobaric expansion coefficient";
   cp_1ph=properties.cp_1ph "specific heat capacity cp";
   cv_1ph=properties.cv_1ph "specific heat capacity cv";
   kappa_1ph=properties.kappa_1ph "compressibility";
// ----------singlePhaseDerivatives--------------//
   dpdT_dN_1ph=properties.dpdT_dN_1ph
    "Derivative of pressure w.r.t. temperature at constant density and N";
   dpdd_TN_1ph=properties.dpdd_TN_1ph
    "Derivative of pressure w.r.t. density at constant temperatre and molar substance";

// Derivatives needed for state transformation etc
//    ddhp_1ph=properties.ddhp_1ph
//     "derivative of density wrt enthalpy at constant pressure";
//    ddph_1ph=properties.ddph_1ph
//     "derivative of density wrt pressure at constant enthalpy";

// ----------singlePhaseTransportProperties--------------//
   lambda_1ph=properties.lambda_1ph "thermal conductivity";
   eta_1ph= properties.eta_1ph "dynamic viscosity";

  if (inputs== Inputs.pTN or inputs== Inputs.phN or inputs== Inputs.dTN or inputs== Inputs.duN) then
    Zm=N/sum(N);
    Z =moleToMassFractions(Zm, MMX);
  elseif (inputs== Inputs.pTY or inputs== Inputs.phY or inputs== Inputs.dTY or inputs== Inputs.duY) then
    Z =moleToMassFractions(Zm, MMX);
    // calculate N -assuming vol=1m^3
    N=dm*1*Zm;
  elseif (inputs== Inputs.pTX or inputs== Inputs.phX or inputs== Inputs.dTX or inputs== Inputs.duX) then
    Zm =massToMoleFractions(Z, MMX);
    // calculate N -assuming vol=1m^3 -> N_sum=dm*Vol
    // calculate N -assuming vol=1m^3
    N=dm*1*Zm;
  else
    assert(false,"Non-supported inputs");
  end if;
  // Relation between mass and mole based properties
  MM=MMX*Z;
  hm=h*MM;
  um=u*MM;
  d=dm*MM;
end MultiPhaseProperties;



redeclare replaceable model extends SatPhaseEquilibriumProperties
 //extends MultiPhaseMixture.Interfaces.SatPhaseEquilibriumProperties;
//   Modelica.SIunits.MolarMass MM_LIQUID "Average molar mass, liquid phase";
//   Modelica.SIunits.MolarMass MM_VAPOR "Average molar mass, vapor phase";
//   Modelica.SIunits.MolarMass[nP] MMX_phase "Molar mass per phase";

protected
  Auxilary.Properties properties;
  final parameter
    MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo=MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject(setupInfo);
   Modelica.SIunits.MolarMass[nP] MMX_phase "Molar mass per phase";
equation
  if (inputs == SatInputs.pFZ or inputs == SatInputs.pFZ_mole or inputs == SatInputs.pFN) then
      properties =Auxilary.calcProperties_pFX(
        p=p,
        F=F,
        X=Z,
        eo=eo);
      d =properties.d_overall;
      h =properties.h_overall;
      u =properties.h_overall-properties.p_overall/properties.d_overall;
      eqProperties =Auxilary.Wrapper.equilibrium_X(Z,properties);
      T =properties.T_overall;
  elseif (inputs == SatInputs.TFZ_mole or inputs == SatInputs.TFZ or inputs == SatInputs.TFN) then
      properties =Auxilary.calcProperties_TFX(
        T=T,
        F=F,
        X=Z,
        eo=eo);
      d =properties.d_overall;
      h =properties.h_overall;
      u =properties.h_overall-properties.p_overall/properties.d_overall;
      eqProperties =Auxilary.Wrapper.equilibrium_X(Z,properties);
      p =properties.p_overall;
  else
    assert(false,"Non supported input combination");
  end if;

 //-----------Phase properties--------------//
   nbrOfPresentPhases=properties.nbrOfPresentPhases
    "Number of present phases, 0= unknown";
   presentPhaseIndex=properties.presentPhaseIndex
    "stop search when presentPhaseIndex[i] < 0 or i==nP";
   phaseComposition=properties.phaseComposition
    "matrix with composition for each phase";
   phaseFraction=properties.phaseFraction
    "molar fraction of the fluid that is in the specified phase";

//-----------overAllProperties - bulk properties--------------//
    T_overall=properties.T_overall "temperature";
    d_overall=properties.d_overall "density";
    s_overall=properties.s_overall "specific entropy";
    p_overall=properties.p_overall "pressure";
    h_overall=properties.h_overall "specific enthalpy";

   // ----------singlePhaseThermoProperties--------------//
   d_1ph=properties.d_1ph "density";
   s_1ph=properties.s_1ph "specific entropy";
   h_1ph=properties.h_1ph "specific enthalpy";
   Pr_1ph=properties.Pr_1ph "prandtl number";
   a_1ph=properties.a_1ph "velocity of sound";
   beta_1ph=properties.beta_1ph "isobaric expansion coefficient";
   cp_1ph=properties.cp_1ph "specific heat capacity cp";
   cv_1ph=properties.cv_1ph "specific heat capacity cv";
   kappa_1ph=properties.kappa_1ph "compressibility";
// ----------singlePhaseDerivatives--------------//
   dpdT_dN_1ph=properties.dpdT_dN_1ph
    "Derivative of pressure w.r.t. temperature at constant density and N";
   dpdd_TN_1ph=properties.dpdd_TN_1ph
    "Derivative of pressure w.r.t. density at constant temperatre and molar substance";

// Derivatives needed for state transformation etc
//    ddhp_1ph=properties.ddhp_1ph
//     "derivative of density wrt enthalpy at constant pressure";
//    ddph_1ph=properties.ddph_1ph
//     "derivative of density wrt pressure at constant enthalpy";

// ----------singlePhaseTransportProperties--------------//
   lambda_1ph=properties.lambda_1ph "thermal conductivity";
   eta_1ph= properties.eta_1ph "dynamic viscosity";

  if (inputs== SatInputs.pFN or inputs== SatInputs.TFN) then
   Zm=N/sum(N);
   Z =moleToMassFractions(Zm, MMX);
   Fm=FN/sum(FN);
   F =moleToMassFractions(Fm, MMX_phase);
  elseif (inputs== SatInputs.pFZ_mole or inputs== SatInputs.TFZ_mole) then
   Z =moleToMassFractions(Zm, MMX);
   // calculate N -assuming vol=1m^3
   N=dm*1*Zm;
   F =moleToMassFractions(Fm, MMX_phase);
   FN=sum(N)*Fm;
 elseif (inputs== SatInputs.pFZ or inputs== SatInputs.TFZ) then
   Zm =massToMoleFractions(Z, MMX);
   // calculate N -assuming vol=1m^3 -> N_sum=dm*Vol
   N=dm*1*Zm;
   Fm=massToMoleFractions(F, MMX_phase);
   FN=sum(N)*Fm;
 else
   assert(false,"Non-supported inputs");
  end if;

  for i in 1:nP loop
   MMX_phase[i]=MMX*moleToMassFractions(eqProperties.x[i,:],MMX);
  end for;

  // Relation between mass and mole based properties
  MM=MMX*Z;
  hm=h*MM;
  um=u*MM;
  d=dm*MM;
end SatPhaseEquilibriumProperties;



annotation (Documentation(info="<html>
<p>Template for using a fluid via the external C-interface, see <a href=\"modelica://MultiPhaseMixture.Information.ExternalPropertyPackages\">MultiPhaseMixture.Information.ExternalPropertyPackages</a>. For examples how to use it, take a look at pre-defined fluids at <a href=\"modelica://MultiPhaseMixture.PreDefined.Mixtures\">MultiPhaseMixture.PreDefined.Mixtures</a>.</p>
</html>"));
end ExternalTwoPhaseMixture;
