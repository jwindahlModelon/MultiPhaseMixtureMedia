within MultiPhaseMixture.Air_PureModelica.EquationsOfState.Utilities.Polynomials;
function derivativeValue_der "time derivative of derivative of polynomial"

  input Real p[:]
    "Polynomial coefficients (p[1] is coefficient of highest power)";
  input Real u "Abscissa value";
  input Real du "delta of abscissa value";
  output Real dy
    "time-derivative of derivative of polynomial w.r.t. input variable at u";
protected
  Integer n=size(p, 1);
algorithm
  dy := secondDerivativeValue(p, u)*du;
end derivativeValue_der;
