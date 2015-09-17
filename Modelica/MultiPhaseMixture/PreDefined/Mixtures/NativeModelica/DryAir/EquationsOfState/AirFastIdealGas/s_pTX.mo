within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
function s_pTX
  "Temperature dependent part of the entropy, expects full mass fraction vectorCompute entropy, expects full mass fraction vector"
input Modelica.SIunits.AbsolutePressure
                             p "Pressure";
input Modelica.SIunits.Temperature
                        T "Temperature";
input Modelica.SIunits.MassFraction[
                         nS] X "Mass fraction";
output Modelica.SIunits.SpecificEntropy
                             s "Specific entropy";
protected
  Real[nS] Y(unit="mol/mol") = Utilities.massToMoleFractions(X, MMX)
    "Molar fractions";

algorithm
s :=X*{s0_T(T,i) for i in 1:nS} - sum(X[i]*Modelica.Constants.R/MMX[i]*
   (if X[i]<Modelica.Constants.eps then Y[i] else
   Modelica.Math.log(Y[i]*p/reference_p)) for i in 1:nS);
annotation(smoothOrder=2);
end s_pTX;
