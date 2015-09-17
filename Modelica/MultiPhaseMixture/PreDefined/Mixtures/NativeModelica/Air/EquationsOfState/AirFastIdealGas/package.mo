within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState;
package AirFastIdealGas 

  import NASA = Modelica.Media.IdealGases.Common.SingleGasesData;

  constant Boolean analyticInverseTfromh = true
  "If true, an analytic inverse is available to compute temperature, given specific enthalpy";
  constant Boolean excludeEnthalpyOfFormation=true
  "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant Modelica.Media.Interfaces.Choices.ReferenceEnthalpy referenceChoice= Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined
  "Choice of reference enthalpy";
  constant Modelica.SIunits.SpecificEnthalpy[
                                  nS] h_offset= {-456618.5,-456618.5,-456618.5}
  "User defined offset for reference enthalpy at reference temperature T0, if referenceChoice = UserDefined";
  constant Modelica.SIunits.Temperature T0 = 298.15
  "Reference temperature for h_offset, if referenceChoice = UserDefined";
  constant Modelica.SIunits.AbsolutePressure
                                  reference_p=1.01325e5 "Reference pressure";

  constant Integer nS(min=1, max=100)=3 "Number of substances";
  constant Modelica.SIunits.SpecificHeatCapacity[
                                      nS] R=NASAData[:].R
  "gas constants of components";
  constant Modelica.SIunits.MolarMass[
                           nS] MMX=NASAData[:].MM "molar masses of components";

  constant Modelica.Media.IdealGases.Common.DataRecord[3] NASAData= {NASA.N2,NASA.O2,NASA.Ar}
  "Medium data record";
  constant
  MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.Data.FastGasData[
  3] data={Data.N2_,Data.O2_,Data.Ar_} "Coefficient for fast state equations";

  constant
  MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.Data.ValidityLimits
  limits(
  TMIN=200.0,
  TMAX=6000.0,
  PMIN=0.001,
  PMAX=100.0e6,
  DMIN=1e-6,
  DMAX=1000.0,
  HMIN=-1e7,
  HMAX=1e7,
  SMIN=-1e5,
  SMAX=1e5)
  "Validity limits: several are arbitrarily chosen to provide good iteration bounds";

//end CaloricMassBaseTX_po1;

end AirFastIdealGas;
