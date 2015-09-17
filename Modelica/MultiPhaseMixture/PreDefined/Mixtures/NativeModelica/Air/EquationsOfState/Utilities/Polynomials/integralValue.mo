within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.Utilities.Polynomials;
function integralValue "Integral of polynomial p(u) from u_low to u_high"

  input Real p[:] "Polynomial coefficients";
  input Real u_high "High integrand value";
  input Real u_low=0 "Low integrand value, default 0";
  output Real integral=0.0 "Integral of polynomial p from u_low to u_high";
protected
  Integer n=size(p, 1) "degree of integrated polynomial";
  Real y_low=0 "value at lower integrand";
algorithm
  for j in 1:n loop
    integral := u_high*(p[j]/(n - j + 1) + integral);
    y_low := u_low*(p[j]/(n - j + 1) + y_low);
  end for;
  integral := integral - y_low;
  annotation (derivative(zeroDerivative=p) = integralValue_der,
      Documentation(revisions="<html></html>"));
end integralValue;
