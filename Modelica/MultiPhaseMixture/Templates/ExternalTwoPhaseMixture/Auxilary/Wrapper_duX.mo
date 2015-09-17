within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary;
package Wrapper_duX
  "Functions with a special structure and annotations so caching works in Dymola"

  function density_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real d_out;
  algorithm
     d_out:=d;
      annotation(Inline = false,
               LateInline = true,smoothOrder=5);
  end density_duX;

  function temperature_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real T_out;
  algorithm
     T_out:=state.T_overall;
      annotation(Inline = false,
               LateInline = true);
  end temperature_duX;

  function specificEntropy_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real s;
  algorithm
     s:=state.s_overall;
      annotation(Inline = false,
               LateInline = true);
  end specificEntropy_duX;

  function specificInternalEnergy_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real u_out;
  algorithm
     u_out:=u;
      annotation(Inline = false,
               LateInline = true);
  end specificInternalEnergy_duX;

  function specificHeatCapacityCp_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real cp;
  algorithm
     cp:=Wrapper.specificHeatCapacityCp(state);
      annotation(Inline = false,
               LateInline = true);
  end specificHeatCapacityCp_duX;

  function specificHeatCapacityCv_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
    input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
      "External object";
    output Real cv;

  algorithm
    cv:=Wrapper.specificHeatCapacityCv_X(X,state,eo);
      annotation(Inline = false,
               LateInline = true);
  end specificHeatCapacityCv_duX;

  function velocityOfSound_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
    input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
      "External object";
     output Real a;

  algorithm
    a:=Wrapper.velocityOfSound_X(X=X,state=state,eo=eo);
      annotation(Inline = false,
               LateInline = true);
  end velocityOfSound_duX;

  function thermalConductivity_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real lambda;
  algorithm
     lambda:=Wrapper.thermalConductivity(state);
      annotation(Inline = false,
               LateInline = true);
  end thermalConductivity_duX;

  function kinematicViscosity_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real nu;
  algorithm
   nu:=Wrapper.kinematicViscosity(state);
      annotation(Inline = false,
               LateInline = true);
  end kinematicViscosity_duX;

  function dynamicViscosity_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real eta;
  algorithm
     eta:=Wrapper.dynamicViscosity(state);
      annotation(Inline = false,
               LateInline = true);
  end dynamicViscosity_duX;

  function pressure_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real p_out;
  algorithm
     p_out:=state.p_overall;
      annotation(Inline = false,
               LateInline = true);
  end pressure_duX;

  function specificEnthalpy_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real h_out;
  algorithm
     h_out:=state.h_overall;
      annotation(Inline = false,
               LateInline = true);
  end specificEnthalpy_duX;

  function phaseComposition_duX
  input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
  input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
  input Integer phaseIndex "Phase index";
    input Properties state;
  output Real Y[nC];
  algorithm

   Y:=Wrapper.phaseComposition(phaseIndex,state);

    annotation (Inline=false, LateInline=true);
  end phaseComposition_duX;

  function equilibrium_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
    output FlashProperties flash;

  //  Modelica.SIunits.AmountOfSubstance[nC]
  //     Z;
  //  Modelica.SIunits.AmountOfSubstance sum_Z=sum(Z);
  //  Modelica.SIunits.MoleFraction[nP,
  //     nC] x "Mole fractions in each phase";
  //  Modelica.SIunits.AmountOfSubstance[nP]
  //     Z_phase "Amount of substance in each phase";
  algorithm
    flash:=Wrapper.equilibrium_X(X,state);
     annotation (Inline=true);
  end equilibrium_duX;

  function isothermalCompressibility_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
    output Real kappa;
  algorithm
     kappa:=Wrapper.isothermalCompressibility(state);
   annotation (   Inline = false,LateInline=true);
  end isothermalCompressibility_duX;

  function volumetricExpansionCoefficient_duX

    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
    output Real beta;

  algorithm
   beta:=Wrapper.volumetricExpansionCoefficient(state);
   annotation(Inline = false,LateInline=true);
  end volumetricExpansionCoefficient_duX;

  function prandtl_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
     output Real Pr;
  algorithm
     Pr:=Wrapper.prandtl(state);
      annotation(Inline = false,
               LateInline = true);
  end prandtl_duX;

  function density_derh_p_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
    input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
      "External object";
    output Real ddhp "Density derivative wrt h at constant pressure";

  algorithm
    ddhp:=Wrapper.density_derh_p_X(X=X,state=state,eo=eo);

   annotation(Inline = false,LateInline=true);
  end density_derh_p_duX;

  function density_derp_h_duX
    input Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificInternalEnergy u "Specific internal energy";
    input Modelica.SIunits.MassFraction X[nC]=
       reference_X "Mass fraction";
    input Properties state;
    input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
      "External object";
    output Real ddph "Density derivative wrt p at constant enthalpy";

  algorithm
   ddph:=Wrapper.density_derp_h_X(X=X,state=state,eo=eo);

   annotation(Inline = false,LateInline=true);
  end density_derp_h_duX;
end Wrapper_duX;
