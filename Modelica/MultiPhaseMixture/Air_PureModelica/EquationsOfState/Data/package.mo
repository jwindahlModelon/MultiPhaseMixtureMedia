within MultiPhaseMixture.Air_PureModelica.EquationsOfState;
package Data 

   constant LinearFluid Coldwaterdata(
    reference_p=101325,
    reference_T=278.15,
    reference_d=997.05,
    reference_h=104929,
    reference_s=100.0,
    cp_const=4181.9,
    beta_const=2.5713e-4,
    kappa_const=4.5154e-10,
    MM=0.01801528);

    constant LinearFluid Liquidairdata(
    reference_p=15.032e5,
    reference_T=113.15,
    reference_d=682.66,
    reference_h=-66314,
    reference_s=-3180.8,
    cp_const=2036.2,
    MM=0.0289583);
    //reference_h=-351790,
    //cp_const=2125.15 "?",
    //beta_const=2.5713e-4,
    //kappa_const=4.5154e-10,//-165430//103.15//821390

  constant MultiPhaseMixture.Air_PureModelica.EquationsOfState.Data.FastGasData
  Ar_(
  H0=-456618.5,
  cp_coeff={-30,3230.9},
  s_coeff={-6378.44260255427,1173.47465428536,-1.28454872059056},
  npol_Cp=1,
  TMIN=70,
  TMAX=120);

 constant MultiPhaseMixture.Air_PureModelica.EquationsOfState.Data.FastGasData N2_(
  H0=-456618.5,
  cp_coeff={-30,3230.9},
  s_coeff={-6378.44260255427,1173.47465428536,-1.28454872059056},
  npol_Cp=1,
  TMIN=70,
  TMAX=120);

 constant MultiPhaseMixture.Air_PureModelica.EquationsOfState.Data.FastGasData O2_(
  H0=-456618.5,
  cp_coeff={-30,3230.9},
  s_coeff={-6378.44260255427,1173.47465428536,-1.28454872059056},
  npol_Cp=1,
  TMIN=70,
  TMAX=120);


replaceable record ValidityLimits
  "Limits of validity, also used in inverse iterations"
  Modelica.SIunits.Temperature
              TMIN "Minimum Temperature";
  Modelica.SIunits.Temperature
              TMAX "Maximum Temperature";
  Modelica.SIunits.Density
          DMIN "Minimum Density";
  Modelica.SIunits.Density
          DMAX "Maximum Density";
  Modelica.SIunits.AbsolutePressure
                   PMIN "Minimum Pressure";
  Modelica.SIunits.AbsolutePressure
                   PMAX "Maximim Pressure";
  Modelica.SIunits.SpecificEnthalpy HMIN "Minimum specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy HMAX "Maximum specific enthalpy";
  Modelica.SIunits.SpecificEntropy SMIN "Minimum specific entropy";
  Modelica.SIunits.SpecificEntropy SMAX "Maximum specific entropy";
end ValidityLimits;
end Data;
