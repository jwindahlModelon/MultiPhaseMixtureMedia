within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function density_phX
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.SpecificEnthalpy h;
  input Real X[nC]=reference_X;
  output Modelica.SIunits.Density d_out;
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";

algorithm
   d_out:=state.d_overall;
   annotation(derivative(noDerivative=state,noDerivative=eo) = density_phX_der,Inline = false,LateInline=true);
end density_phX;
