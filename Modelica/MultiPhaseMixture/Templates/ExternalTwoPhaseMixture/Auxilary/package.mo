within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture;
package Auxilary 


  replaceable function getAverageMolarMass
   extends MultiPhaseMixture.Icons.ExternalFunction;
    input Modelica.SIunits.MassFraction X[nC]=reference_X "Mass fraction";
    input Integer X_unit=UnitBasis.MassFraction;
    input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject   eo;
    output Modelica.SIunits.MolarMass MM "molar mass";
    external "C" MM=  MultiPhaseMixtureMedium_averageMolarMass_X_C_impl(X,size(X,1),X_unit,eo)
      annotation (Include="#include \"externalmixturemedialib.h\"",
        Library="ExternalMultiPhaseMixtureLib");

  end getAverageMolarMass;


  replaceable function getMolarWeights
    input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject   eo;
    output Modelica.SIunits.MolarMass MMX[nC] "molar masses";
protected
   Real X[nC,nC]=identity(nC);
  algorithm
   for i in 1:nC loop
     MMX[i]:=getAverageMolarMass(X[i, :],1,eo);
   end for;
  end getMolarWeights;


  replaceable function getCriticalTemperature
   extends MultiPhaseMixture.Icons.ExternalFunction;
    input Modelica.SIunits.MassFraction X[nC]=reference_X "Mass fraction";
    output Modelica.SIunits.Temperature Tc "Critical temperature";

    external "C" Tc=  TwoPhaseMedium_criticalPressure_X_C_impl(X,mediumName, setupInfo.libraryName, setupInfo.compounds, setupInfo)
      annotation(Include="#include \"externalmedialib.h\"", Library="ExternalMediaLib");
  end getCriticalTemperature;


  replaceable function getCriticalPressure
   extends MultiPhaseMixture.Icons.ExternalFunction;
    input Modelica.SIunits.MassFraction X[nC]=reference_X "Mass fraction";
    output Modelica.SIunits.AbsolutePressure pc "Critical temperature";

    external "C" pc=  TwoPhaseMedium_criticalPressure_X_C_impl(X,mediumName, setupInfo.libraryName, setupInfo.compounds, setupInfo)
      annotation(Include="#include \"externalmedialib.h\"", Library="ExternalMediaLib");
  end getCriticalPressure;


  replaceable function getCriticalMolarVolume
    extends MultiPhaseMixture.Icons.ExternalFunction;
    input Modelica.SIunits.MassFraction X[nC]=reference_X "Mass fraction";
    input MultiPhaseMixture.Templates.ExternalObjects.ExternalMediaObject   eo;
    output Modelica.SIunits.MolarVolume vc "Critical molar volume";
  algorithm
    vc:=getAverageMolarMass(X=X,X_unit=UnitBasis.MassFraction,eo=eo)/getCriticalDensity(X);

  //  external "C" vc = TwoPhaseMedium_getCriticalMolarVolume_C_impl(mediumName, libraryName, substanceName, setupInfo)
   //   annotation(Include="#include \"externalmedialib.h\"", Library="ExternalMediaLib");
  end getCriticalMolarVolume;

//   replaceable partial function setSat_p_state
//     "Return saturation properties from the state"
//     extends Modelica.Icons.Function;
//     input ThermodynamicState state;
//     output SaturationProperties sat "saturation property record";
//     // Standard definition
//   algorithm
//     sat:=setSat_p(state.p);
//     //Redeclare this function for more efficient implementations avoiding the repeated computation of saturation properties
//   /*  // If special definition in "C"
//   external "C" TwoPhaseMedium_setSat_p_state_C_impl(state, sat)
//     annotation(Include="#include \"externalmedialib.h\"", Library="ExternalMediaLib");
// */
//     annotation(Inline = true);
//   end setSat_p_state;


  replaceable function getCriticalDensity
   extends MultiPhaseMixture.Icons.ExternalFunction;
    input Modelica.SIunits.MassFraction X[nC]=reference_X "Mass fraction";
    output Modelica.SIunits.Density dc "Critical density";
    external "C" dc=  TwoPhaseMedium_criticalDensity_X_C_impl(X,mediumName, setupInfo.libraryName, setupInfo.compounds, setupInfo)
      annotation(Include="#include \"externalmedialib.h\"", Library="ExternalMediaLib");
  end getCriticalDensity;

end Auxilary;
