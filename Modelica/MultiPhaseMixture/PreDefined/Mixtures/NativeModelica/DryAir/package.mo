within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica;
package DryAir "Dry air (N2,O2,Ar)"
  extends MultiPhaseMixture.Interfaces(
    externalEquilibriumSolver=false,
    MMX= {0.0280134, 0.0319988, 0.039948},
    nP=2,
    phases(label={"Liquid","Vapor"},stateOfAggregation={"Liquid","Vapor"}),
    substanceNames={"Nitrogen","Oxygen","Argon"},
    mediumName="Dry Air");


  extends MultiPhaseMixture.Icons.Media;


    redeclare model extends ThermoProperties

    // Using check for phaseLabel == PhaseLabel.Overall to avoid doing expensive /non-robust calculations when phase is specified
    // Unfortunatley with the model approach its not easy to conditionally declare a model, would require defining connector interface ...

       MultiPhaseProperties
        flash(
        Z=if not singlePhaseCalculation then Z else reference_X,
        p=if not singlePhaseCalculation then p else p_default,
        T=if not singlePhaseCalculation then T else T_default,
        init=init,
        inputs=inputs,
        presentPhases=presentPhases,
        presentPhasesStatus=presentPhasesStatus)
        annotation (Placement(transformation(extent={{-38,0},{-18,20}})));
        //  init(p=init.p, x=init.x),
protected
      Real one(unit="1/kg")=1.0;
      Modelica.SIunits.SpecificVolume v;
      parameter Boolean singlePhaseCalculation=size(presentPhases,1)==1;

    equation
      u=h-p/d;
      if not singlePhaseCalculation then
        h = flash.h_overall;
        v= 1/flash.d_overall;
      else
        // Single phase calculation
        h = enthalpy_pTM(p,T,Z, presentPhases[1])*one;
        v = volume_pTM(p,T,Z, presentPhases[1])*one;
      end if;
      d=1/v;

    //   // Assignment of inputs to variables
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

      if (inputs== Inputs.pTN or inputs== Inputs.phN or inputs== Inputs.dTN) then
        Zm=N/sum(N);
        Z =moleToMassFractions(Zm, MMX);
      elseif (inputs== Inputs.pTY or inputs== Inputs.phY or inputs== Inputs.dTY) then
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

    end ThermoProperties;


redeclare model extends Properties
equation
  assert(false,"Properties is not implemented");
end Properties;


redeclare model extends ActivityCoefficient
protected
    final parameter Integer Ar=compoundsIndex("Argon");
    final parameter Integer N2=compoundsIndex("Nitrogen");
    final parameter Integer O2=compoundsIndex("Oxygen");
  Real log_gamma[nC](each unit="1")
    "Logarithmic activity coefficients for specified phase";
 Modelica.SIunits.MoleFraction[nC] x "Mole fractions";

equation
  x=N_1ph/sum(N_1ph);

  log_gamma[N2]=(7.0*x[Ar]^2 + 8.3*x[O2]^2 + 7.8*x[Ar]*x[O2])/T;
  log_gamma[Ar]=(7.5*x[O2]^2 + 7.0*x[N2]^2 + 6.2*x[O2]*x[N2])/T;
  log_gamma[O2]=(8.3*x[N2]^2 + 7.5*x[Ar]^2 + 8.8*x[N2]*x[Ar])/T;

  gamma[N2] = Modelica.Math.exp(log_gamma[N2]);
  gamma[Ar] = Modelica.Math.exp(log_gamma[Ar]);
  gamma[O2] = Modelica.Math.exp(log_gamma[O2]);
initial equation
  assert(Ar > 0,"Substance index for Ar not found");
  assert(N2 > 0,"Substance index for N2 not found");
  assert(O2 > 0,"Substance index for O2 not found");

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Text(
            extent={{-70,76},{74,-80}},
            lineColor={28,108,200},
            textString="A")}));
end ActivityCoefficient;


redeclare model extends Fugacity
  import Modelica.Fluid.Utilities.regRoot;
    final parameter Integer Ar=compoundsIndex("Argon");
    final parameter Integer N2=compoundsIndex("Nitrogen");
    final parameter Integer O2=compoundsIndex("Oxygen");
  // output Modelica.SIunits.Pressure f[ns] "Fugacity";
  // output Real phi[ns](each unit="1") "Fugacity coefficients";
  // output Real log_phi[ns] "Natural logarithm of fugacity coefficients";

// protected
//   Modelica.SIunits.Pressure p_min=1e-8;
// algorithm
//   log_phi:=log(fugacity_pTN(p,T,N_1ph,phaseLabel)/max(p,p_min));

equation
  log_phi[Ar]=(6.16295 + 0.72630/regRoot(x=0.00001*p) - 0.19040*regRoot(x=0.00001*p) - 0.002395*(0.00001*p)) - (468.77 + 1.472*(0.00001*p) - 0.1289*(0.00001*p)^2)/T - 0.015*T;
  log_phi[N2]=(4.76024 + 0.13354/regRoot(x=0.00001*p) - 1.03237*regRoot(x=0.00001*p) + 0.094895*(0.00001*p)) - (303.97 - 9.310*(0.00001*p) + 0.2574*(0.00001*p)^2)/T - 0.002*T;
  log_phi[O2]=(5.55597 + 0.82676/regRoot(x=0.00001*p) + 0.01797*regRoot(x=0.00001*p) - 0.037247*(0.00001*p)) - (465.25 + 3.049*(0.00001*p) - 0.2236*(0.00001*p)^2)/T - 0.013*T;

  phi[N2] = Modelica.Math.exp(log_phi[N2]);
  phi[Ar] = Modelica.Math.exp(log_phi[Ar]);
  phi[O2] = Modelica.Math.exp(log_phi[O2]);

  f[N2]=log_phi[N2]*p;
  f[Ar]=log_phi[Ar]*p;
  f[O2]=log_phi[O2]*p;
initial equation
  assert(Ar > 0,"Substance index for Ar not found");
  assert(N2 > 0,"Substance index for N2 not found");
  assert(O2 > 0,"Substance index for O2 not found");

    annotation (Icon(graphics={Text(
            extent={{-76,80},{68,-76}},
            lineColor={28,108,200},
            textString="F")}));
end Fugacity;


redeclare model extends MultiPhaseProperties(
  init(p=p_default,T=108))

 parameter Modelica.SIunits.MassFraction[nC] Z_start={sum(init.x[:,i])/sum(init.x) for i in 1:nC}
    "Initial feed mass fractions"   annotation(Dialog(group="Start/Guess values"));

//  parameter String[:] presentPhases=phases.label
//     "Phases to search for. They must be available in phaseList" annotation(Dialog(group="Optimization"));

    final parameter Modelica.SIunits.MoleFraction[nC] z_start=
        massToMoleFractions(Z_start, MMX) "Initial feed mole fractions";

 output Modelica.SIunits.MassFraction[nC] Y "Mass fractions vapor phase";
 output Modelica.SIunits.MassFraction[nC] X "Mass fraction in liquid phase";
 output Modelica.SIunits.MoleFraction[nC] x(start=z_start)
    "Mole fractions liquid phase";
 output Modelica.SIunits.MoleFraction[nC] z(start=z_start)
    "Mole fractions bulk";
 output Modelica.SIunits.MoleFraction[nC] y(start=z_start)
    "Mole fractions vapor phase";

//  output FlashProperties eqProperties(p(start=init),T(start=T_default),x(start=fill(z_start,nP)))
//     "equilibrium properties"
//       annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

 Real VF(min=0.0,max = 1.0, start=0.5) "Molar liquid vapor split V/F, F=V+L";
 Real VFw(min=0.0,max = 1.0, start=0.5)
    "Mass based liquid vapor split V/F, F=V+L";

 Real[nC] K;

//   final parameter Boolean presentPhasesCheck=checkPhaseNames(presentPhases)
//     "Check of present phases";

protected
  Real sum_y = sum(y);
  Real sum_x = sum(x);
  Real sum_X=sum(X);
  Real sum_Y = sum(Y);
  Real sum_Z=sum(Z);
  Real sum_z=sum(z);

  Real aux[nC];

  SatPhaseEquilibriumProperties dew(
    inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ_mole,
    T=T,
    Zm=Zm,
    Fm=createPhaseFractionVector({"Vapor"}, {1}),
    init(
      p=init.p,
      T=init.T,
      x=init.x,
      Z=init.Z))
    annotation (Placement(transformation(extent={{-38,0},{-18,20}})));

  SatPhaseEquilibriumProperties bubble(
    inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ_mole,
    T=T,
    init(
      p=init.p,
      T=init.T,
      x=init.x,
      Z=init.Z),
    Fm=createPhaseFractionVector({"Liquid"}, {1}),
    Zm=Zm) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

     Fugacity fugacity_vapor(p=p,T=T,d=d_1ph[VAPOR_INDEX],N_1ph=y,phaseLabel=PhaseLabelVapor);
     ActivityCoefficient activityCoefficient(p=p,T=T,d=d_1ph[LIQUID_INDEX],N_1ph=x,phaseLabel=PhaseLabelLiquid);

protected
   final parameter Integer VAPOR_INDEX=getPhaseIndex("Vapor")
    "Index of phase VAPOR" annotation(Evaluate=true);
   final parameter Integer LIQUID_INDEX=getPhaseIndex("Liquid")
    "Index of phase LIQUID"  annotation(Evaluate=true);
    final parameter Integer Ar=compoundsIndex("Argon");
    final parameter Integer N2=compoundsIndex("Nitrogen");
    final parameter Integer O2=compoundsIndex("Oxygen");
equation
  eqProperties.p=p;
  eqProperties.T=T;
  eqProperties.x={x,y};
  eqProperties.Z[VAPOR_INDEX]=VF;
  eqProperties.Z[LIQUID_INDEX]=1-VF;

  // Equilibrium calculations -solving for x,y,VF

  //Rachford-Rice equation
  //gas AND liquid assumed to be present, limits?
  for i in 1:3 loop
    K[i] = activityCoefficient.gamma[i]*fugacity_vapor.phi[i];
    aux[i] = z[i]*(K[i]-1)/(1+VF*(K[i]-1));
    x[i] = z[i]/(1+VF*(K[i]-1));
    y[i] = x[i]*K[i];
  end for;
   if p<dew.p then
     VF = 1.0;
     nbrOfPresentPhases=1;
     presentPhaseIndex={VAPOR_INDEX,-1};
   elseif p>bubble.p then
     VF = 0.00;
     nbrOfPresentPhases=1;
     presentPhaseIndex={LIQUID_INDEX,-1};
   else
     sum(aux)=0;
     nbrOfPresentPhases=2;
     presentPhaseIndex={VAPOR_INDEX,LIQUID_INDEX};
   end if;

  Y =moleToMassFractions(y, MMX);
  X =moleToMassFractions(x, MMX);
  VFw =VF*molarMass_z(y)/molarMass_z(z);

  z =massToMoleFractions(Z, MMX);

  u=h-p/d;
  h = VFw*h_1ph[VAPOR_INDEX]+(1-VFw)*h_1ph[LIQUID_INDEX];
  1/d= VFw*1/d_1ph[VAPOR_INDEX]+(1-VFw)*1/d_1ph[LIQUID_INDEX];

   //-----------Phase properties--------------//
  // TODO: HOW to do this programatically, i.e. how do we know the order of the phase
   phaseComposition=cat(1,X,Y) "matrix with composition for each phase";
   phaseFraction={VF,1-VF}
    "molar fraction of the fluid that is in the specified phase";

//-----------overAllProperties - bulk properties--------------//
    T_overall=T "temperature";
    d_overall=d "density";
    s_overall=1 "specific entropy";
    p_overall=p "pressure";
    h_overall=h "specific enthalpy";

   // ----------singlePhaseThermoProperties--------------//
   for i in 1:nP loop
     if (i == VAPOR_INDEX) then
       d_1ph[i]=1/specificVolume_pTX(p,T,Y,PhaseLabelVapor);
       h_1ph[i]=specificEnthalpy_pTX(p,T,Y,PhaseLabelVapor);
     elseif (i == LIQUID_INDEX) then
       d_1ph[i]=1/specificVolume_pTX(p,T,X,PhaseLabelLiquid);
       h_1ph[i]=specificEnthalpy_pTX(p,T,X,PhaseLabelLiquid);
     else
       d_1ph[i]=1;
       h_1ph[i]=1;
     end if;
     // Dummy assignments
     s_1ph[i]=1 "specific entropy";
     lambda_1ph[i]=1 "thermal conductivity";
     eta_1ph[i]=1 "dynamic viscosity";
     Pr_1ph[i]=1 "prandtl number";
     a_1ph[i]=1 "velocity of sound";
     beta_1ph[i]=1 "isobaric expansion coefficient";
     cp_1ph[i]=1 "specific heat capacity cp";
     cv_1ph[i]=1 "specific heat capacity cv";
     kappa_1ph[i]=1 "compressibility";
     // ----------singlePhaseDerivatives--------------//
     dpdT_dN_1ph[i]=1
      "Derivative of pressure w.r.t. temperature at constant density and N";
     dpdd_TN_1ph[i]=1
      "Derivative of pressure w.r.t. density at constant temperatre and molar substance";
   end for;
  if (inputs== Inputs.pTN or inputs== Inputs.phN or inputs== Inputs.dTN) then
    Zm=N/sum(N);
    Z =moleToMassFractions(Zm, MMX);
  elseif (inputs== Inputs.pTY or inputs== Inputs.phY or inputs== Inputs.dTY) then
    Z =moleToMassFractions(Zm, MMX);
    // calculate N -assuming vol=1m^3
    N=dm*1*Zm;
  elseif (inputs== Inputs.pTX or inputs== Inputs.phX or inputs== Inputs.dTX) then
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
initial equation
 //   presentPhasesCheck =checkPhaseNames(presentPhases);
//  assert(presentPhasesCheck,"Check of present phases failed");
  assert(VAPOR_INDEX>0,"Vapor is not an available phase");
  assert(LIQUID_INDEX>0,"Liquid is not an available phase");
end MultiPhaseProperties;


redeclare model extends SatPhaseEquilibriumProperties(
  init(p=p_default,T=108))

 parameter Modelica.SIunits.MassFraction[nC] Z_start={sum(init.x[:,i])/sum(init.x) for i in 1:nC}
    "Initial feed mass fractions"   annotation(Dialog(group="Start/Guess values"));

 parameter String[:] presentPhases=phases.label
    "Phases to search for. They must be available in phaseList" annotation(Dialog(group="Optimization"));

    final parameter Modelica.SIunits.MoleFraction[nC] z_start=
        massToMoleFractions(Z_start, MMX) "Initial feed mole fractions";

 output Modelica.SIunits.MassFraction[nC] Y "Mass fractions vapor phase";
 output Modelica.SIunits.MassFraction[nC] X "Mass fraction in liquid phase";
 output Modelica.SIunits.MoleFraction[nC] x(start=z_start)
    "Mole fractions liquid phase";
 output Modelica.SIunits.MoleFraction[nC] z(start=z_start)
    "Mole fractions bulk";
 output Modelica.SIunits.MoleFraction[nC] y(start=z_start)
    "Mole fractions vapor phase";

 Real VF(min=0.0,max = 1.0, start=0.5) "Molar liquid vapor split V/F, F=V+L";
 Real VFw(min=0.0,max = 1.0, start=0.5)
    "Mass based liquid vapor split V/F, F=V+L";

Real[nC] K;

protected
  final parameter Boolean presentPhasesCheck=checkPhaseNames(presentPhases)
    "Check of present phases";

  Real sum_y = sum(y);
  Real sum_x = sum(x);
  Real sum_X=sum(X);
  Real sum_Y = sum(Y);
  Real sum_Z=sum(Z);
  Real sum_z=sum(z);
  Modelica.SIunits.MolarMass MM_LIQUID "Average molar mass, liquid phase";
  Modelica.SIunits.MolarMass MM_VAPOR "Average molar mass, vapor phase";
  Modelica.SIunits.MolarMass[nP] MMX_phase "Molar mass per phase";

  Real aux[nC];
  Fugacity fugacity_vapor(p=p,T=T,d=d_1ph[VAPOR_INDEX],N_1ph=y,phaseLabel=PhaseLabelVapor);
  ActivityCoefficient activityCoefficient(p=p,T=T,d=d_1ph[LIQUID_INDEX],N_1ph=x,phaseLabel=PhaseLabelLiquid);
protected
   final parameter Integer VAPOR_INDEX=getPhaseIndex("Vapor")
    "Index of phase VAPOR" annotation(Evaluate=true);
   final parameter Integer LIQUID_INDEX=getPhaseIndex("Liquid")
    "Index of phase LIQUID"  annotation(Evaluate=true);
    final parameter Integer Ar=compoundsIndex("Argon");
    final parameter Integer N2=compoundsIndex("Nitrogen");
    final parameter Integer O2=compoundsIndex("Oxygen");
equation

  eqProperties.p=p;
  eqProperties.T=T;
  eqProperties.x={x,y};
  eqProperties.Z[VAPOR_INDEX]=N[VAPOR_INDEX];
  eqProperties.Z[LIQUID_INDEX]=N[LIQUID_INDEX];

  // Equilibrium calculations -solving for x,y,VF

  //Rachford-Rice equation
  //gas AND liquid assumed to be present, limits?
  for i in 1:3 loop
    K[i] = activityCoefficient.gamma[i] * fugacity_vapor.phi[i];
    aux[i] = z[i]*(K[i]-1)/(1+VF*(K[i]-1));
    x[i] = z[i]/(1+VF*(K[i]-1));
    y[i] = x[i]*K[i];
  end for;

      VF=Fm[VAPOR_INDEX];
      sum(aux)=0; // TODO :fnd out what this equation is doing
      nbrOfPresentPhases=2;
      presentPhaseIndex={VAPOR_INDEX,LIQUID_INDEX};

//    if p<dew.p then
//      VF = 1.0;
//      nbrOfPresentPhases=1;
//      presentPhaseIndex={VAPOR_INDEX,-1};
//    elseif p>bubble.p then
//      VF = 0.00;
//      nbrOfPresentPhases=1;
//      presentPhaseIndex={LIQUID_INDEX,-1};
//    else
//      sum(aux)=0;
//      nbrOfPresentPhases=2;
//      presentPhaseIndex={VAPOR_INDEX,LIQUID_INDEX};
//    end if;

    Y =moleToMassFractions(y, MMX);
    X =moleToMassFractions(x, MMX);
  VFw =VF*molarMass_z(y)/molarMass_z(z);

  z =massToMoleFractions(Z, MMX);

    u=h-p/d;
    h = VFw*h_1ph[VAPOR_INDEX]+(1-VFw)*h_1ph[LIQUID_INDEX];
    1/d= VFw*1/d_1ph[VAPOR_INDEX]+(1-VFw)*1/d_1ph[LIQUID_INDEX];

   //-----------Phase properties--------------//
  // TODO: HOW to do this programatically, i.e. how do we know the order of the phase
   phaseComposition=cat(1,X,Y) "matrix with composition for each phase";
   phaseFraction={VF,1-VF}
    "molar fraction of the fluid that is in the specified phase";

//-----------overAllProperties - bulk properties--------------//
    T_overall=T "temperature";
    d_overall=d "density";
    s_overall=1 "specific entropy";
    p_overall=p "pressure";
    h_overall=d "specific enthalpy";

   // ----------singlePhaseThermoProperties--------------//
   for i in 1:nP loop
     if (i == VAPOR_INDEX) then
       d_1ph[i]=1/specificVolume_pTX(p,T,Y,PhaseLabelVapor);
       h_1ph[i]=specificEnthalpy_pTX(p,T,Y,PhaseLabelVapor);
     elseif (i == LIQUID_INDEX) then
       d_1ph[i]=1/specificVolume_pTX(p,T,X,PhaseLabelLiquid);
       h_1ph[i]=specificEnthalpy_pTX(p,T,X,PhaseLabelLiquid);
     else
       d_1ph[i]=1;
       h_1ph[i]=1;
     end if;
     // Dummy assignments
     s_1ph[i]=1 "specific entropy";
     lambda_1ph[i]=1 "thermal conductivity";
     eta_1ph[i]=1 "dynamic viscosity";
     Pr_1ph[i]=1 "prandtl number";
     a_1ph[i]=1 "velocity of sound";
     beta_1ph[i]=1 "isobaric expansion coefficient";
     cp_1ph[i]=1 "specific heat capacity cp";
     cv_1ph[i]=1 "specific heat capacity cv";
     kappa_1ph[i]=1 "compressibility";
     // ----------singlePhaseDerivatives--------------//
     dpdT_dN_1ph[i]=1
      "Derivative of pressure w.r.t. temperature at constant density and N";
     dpdd_TN_1ph[i]=1
      "Derivative of pressure w.r.t. density at constant temperature and molar substance";
   end for;

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
 // Relation between mass and mole based properties

 MM_VAPOR=MMX*Y;
 MM_LIQUID=MMX*X;
 MMX_phase[VAPOR_INDEX]=MM_VAPOR;
 MMX_phase[LIQUID_INDEX]=MM_LIQUID;
 MM=MMX*Z;
 um=u*MM;
 d=dm*MM;
 hm=h*MM;

initial equation
 //   presentPhasesCheck =checkPhaseNames(presentPhases);
  assert(presentPhasesCheck,"Check of present phases failed");
  assert(VAPOR_INDEX>0,"Vapor is not an available phase");
  assert(LIQUID_INDEX>0,"Liquid is not an available phase");
end SatPhaseEquilibriumProperties;





replaceable partial function enthalpy_pTM
input Modelica.SIunits.Pressure p "Pressure";
input Modelica.SIunits.Temperature T "Temperature";
input Modelica.SIunits.Mass[nC] M "Masses";
input Integer phaseLabel=PhaseLabelOverall "Phase label";
output Modelica.SIunits.Enthalpy H "Enthalpy";

protected
  Modelica.SIunits.MassFraction[nC] X=M/sum(M);
algorithm
  if phaseLabel==PhaseLabelOverall then
    assert(false,"Mixed phases not supported");
  elseif phaseLabel==PhaseLabelVapor then //gas
    H := GasEoS.h_TX(T,X)*sum(M);
  elseif phaseLabel==PhaseLabelLiquid then //liquid
    H := LiquidEoS.h_pTX(p,T,X)*sum(M);
  else
    assert(false,"Phase not supported");

  end if;
annotation(smoothOrder=2);
end enthalpy_pTM;


replaceable partial function volume_pTM
input Modelica.SIunits.Pressure p "Pressure";
input Modelica.SIunits.Temperature T "Temperature";
input Modelica.SIunits.Mass[nC] M "Masses";
input Integer phaseLabel=PhaseLabelOverall "Phase label";
output Modelica.SIunits.Volume V "Volume";
protected
  Modelica.SIunits.MassFraction[nC] X=M/sum(M);
algorithm
  if phaseLabel==PhaseLabelOverall then
    assert(false,"Mixed phases not supported");
  elseif phaseLabel==PhaseLabelVapor then //gas
    V := GasEoS.v_pTX(p,T,X)*sum(M);
  elseif phaseLabel==PhaseLabelLiquid then //liquid
    V := LiquidEoS.v_pTX(p,T,X)*sum(M);
  else
    assert(false,"Phase not supported");
  end if;
  annotation(smoothOrder=2);
end volume_pTM;


annotation (Documentation(info="<html>
<p>Dry air mixture model consisting of nitrogen, oxygen and argon. This model is based on work by [1] but has been rewritten to the new media structure.</p>
<h4>Implementation</h4>
<p>It is a three component model (nitrogen,oxygen,argon) were the phase equilibria conditions are described by the Rachford-Rice equation (L&auml;m&aring;s, 2012) using a declarative approach. &nbsp;The equations are solved by the tool&rsquo;s non-linear solver.</p>
<p>The vapor phase is described by an ideal gas volumetric equation of state, a linear polynomial for the heat capacity and polynomials adapted to experiment data of the fugacities. The liquid phase uses an incompressible assumption where density and specific heat capacity are constant and activity coefficients have been adapted to experimental data. </p>
<h4>References</h4>
<p>[1] Yasaman Mirsadraee. Dynamic modeling and simulation of a cryogenic air separation plant, <i>Msc Thesis</i>, Link&ouml;ping, Sweden, 2012 </p>
<p>[2] Hans L&auml;m&aring;s, Algorithms for Multi-component Phase Equilibrium Models in Modelica, <i>MSc Thesis</i>, Chalmers University of Technology, Gothenburg, Sweden, 2012. </p>
</html>"));
end DryAir;
