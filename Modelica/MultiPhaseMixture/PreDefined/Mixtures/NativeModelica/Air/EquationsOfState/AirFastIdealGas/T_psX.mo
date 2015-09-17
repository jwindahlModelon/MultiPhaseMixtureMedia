within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.AirFastIdealGas;
function T_psX
  "Compute temperature from pressure, specific entropy and mass fraction"
  input Modelica.SIunits.AbsolutePressure
                               p "pressure";
  input Modelica.SIunits.SpecificEntropy
                              s "specific entropy";
  input Modelica.SIunits.MassFraction[
                           nS] X "mass fractions of composition";
  output Modelica.SIunits.Temperature
                           T "temperature";

  package Internal
    "Solve s(data,T) for T with given s (use only indirectly via temperature_psX)"
    extends Modelica.Media.Common.OneNonLinearEquation;
    redeclare record extends f_nonlinear_Data
      "Data to be passed to non-linear function"
      extends Modelica.Media.IdealGases.Common.DataRecord;
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear
      "note that this function always sees the complete mass fraction vector"
    algorithm
      y := s_pTX(p=p,T=x,X=X);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

algorithm
  T := Internal.solve(s, limits.TMIN, limits.TMAX, p, X, NASAData[1]);

end T_psX;
