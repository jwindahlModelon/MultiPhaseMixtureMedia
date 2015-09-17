within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper_phX;
function density_phX_der
   input Modelica.SIunits.AbsolutePressure p "Pressure";
   input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
   input Modelica.SIunits.MassFraction X[nC]=
     reference_X "Mass fraction";
   input Properties state;
   input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject eo
    "External object";
   input Real p_der "Pressure total derivative wrt to time";
   input Real h_der "Specific enthalpy total derivative wrt to time";
   input Modelica.SIunits.MassFraction X_der[nC] "Mass fraction";
   output Real d_der "Density total derivative wrt to time";
protected
  Real dddX_ph[nC];
  Real ddph;
  Real ddhp;
  String printMe;
  Boolean p_der_is_zero;
  Boolean h_der_is_zero;
  Boolean X_der_is_zero;

algorithm
 if (printExternalFunctionCall) then
    Modelica.Utilities.Streams.print("density_phX_der - start");
 end if;
  if (printExternalFunctionCall) then
   printMe:="density_phX_der(p=" + String(p, significantDigits=8, minimumLength=0, leftJustified=true) + ",h="
   + String(h, significantDigits=8, minimumLength=0, leftJustified=true)+",X={";
  for i in 1:nC loop
    if
      (i == 1) then
      printMe:=printMe +String(X[i]);
    else
      printMe:=printMe + ","+String(X[i]);
    end if;
  end for;
    printMe:=printMe + "},";
    printMe:=printMe + "p_der=" + String(p_der) + ",h_der=" + String(h_der)+",X_der={";
   for i in 1:nC loop
    if
      (i == 1) then
      printMe:=printMe +String(X_der[i]);
    else
      printMe:=printMe + ","+String(X_der[i]);
    end if;
   end for;
   printMe:=printMe + "}";
    Modelica.Utilities.Streams.print(printMe+")");
  end if;

  // Using zeroDerivative does not work in Dymola so try to test for if
  X_der_is_zero:=true;
  for i in 1:nC loop
    if (X_der[i] == 0) then
    else
      X_der_is_zero:=false;
      dddX_ph:=density_derX_ph_phX(p=p,h=h,X=X,state=state,eo=eo);
      break;
    end if;
  end for;
   if (p_der == 0) then
     p_der_is_zero:=true;
   else
     p_der_is_zero:=false;
     ddph:=density_derp_h_phX(p=p,h=h,X=X,state=state,eo=eo);
   end if;

   if (h_der == 0) then
    h_der_is_zero:=true;
  else
     h_der_is_zero:=false;
     ddhp:=density_derh_p_phX(p=p,h=h,X=X,state=state,eo=eo);
   end if;

//   ddph:=density_derp_h_phX(p=p,h=h,X=X,state=state,eo=eo);
//   ddhp:=density_derh_p_phX(p=p,h=h,X=X,state=state,eo=eo);
//   dddX_ph:=density_derX_ph_phX(p=p,h=h,X=X,state=state,eo=eo);
  d_der:=ddph*p_der+ddhp*h_der+dddX_ph*X_der;
 if (printExternalFunctionCall) then
    Modelica.Utilities.Streams.print("density_phX_der - end");
 end if;
end density_phX_der;
