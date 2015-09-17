within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function density_derX_ph_phX
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
  input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
  input Properties state;
  input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
  output Real dddX_ph[nC]
    "Density derivative wrt X at constant pressure and enthalpy";

protected
  Real delta=1e-5;
  Real d_deltaX[nC] "Density at p,h,deltaX";
  Real X_delta[nC];

algorithm
  if (nC == 1) then
    dddX_ph[1]:=0;
  else
  //calculate dddX_ph numerically
    for i in 1:nC loop
    // Creating a new X_delta for every i
      for j in 1:nC loop
      if
        (i == j) then
        X_delta[j]:=X[j]+ delta;
      else
        X_delta[j]:=X[j];
      end if;
    end for;
 //  d_deltaX[i]:=density(setState_phX(p,h,X_delta));
   d_deltaX[i]:=Wrapper_phX.density_phX(p=p, h=h,X=X_delta,state=calcProperties_phX(p=p, h=h,X=X_delta,eo=eo),eo=eo);
   dddX_ph[i]:=(d_deltaX[i]-state.d_overall)/delta;
  end for;
  end if;
 annotation(Inline = false,LateInline=true);
end density_derX_ph_phX;
