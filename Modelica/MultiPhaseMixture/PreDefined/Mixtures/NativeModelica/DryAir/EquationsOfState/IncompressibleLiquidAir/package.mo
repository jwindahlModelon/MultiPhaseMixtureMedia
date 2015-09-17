within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState;
package IncompressibleLiquidAir "Incompressible model of liquid air"

  constant Boolean analyticInverseTfromh = true
  "If true, an analytic inverse is available to compute temperature, given specific enthalpy";

   constant
  MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.Data.LinearFluid
  data=Data.Liquidairdata;
  constant
  MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.Data.ValidityLimits
  limits(
  DMIN=960,
  DMAX=1010,
  TMIN=275,
  TMAX=370,
  PMIN=0.1e5,
  PMAX=50e5,
  HMIN=0.0,
  HMAX=200.0e3,
  SMIN=0.0,
  SMAX=1.0e3)
  "Validity limits: several are arbitrarily chosen to provide good iteration bounds";

end IncompressibleLiquidAir;
