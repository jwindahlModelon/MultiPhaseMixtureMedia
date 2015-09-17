within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.Tests;
model Enthalpies
    extends Modelica.Icons.Example;
  package Medium = MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
  package Gas =
      MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
parameter Modelica.SIunits.Temperature T_min=70;
parameter Modelica.SIunits.Temperature T_max=140;
Modelica.SIunits.Temperature T(start=T_min);
parameter Modelica.SIunits.Pressure p=2e5;
//parameter Modelica.SIunits.MassFraction[Medium.nS] X={0.755,0.232,0.013};
parameter Modelica.SIunits.MassFraction[Medium.nC,Medium.nC] X=identity(Medium.nC);

Modelica.SIunits.Enthalpy H_liq[Medium.nC];
Modelica.SIunits.Enthalpy H_vap[Medium.nC];
Modelica.SIunits.SpecificEnthalpy h_vap[Medium.nC];
constant
    MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.Data.FastGasData[
    :] data=Gas.data;
equation
  der(T)=(T_max-T_min)*1;
  for i in 1:Medium.nC loop
  H_liq[i] = Medium.enthalpy_pTM(p,T,X[i,:],Medium.PhaseLabelLiquid);
  H_vap[i] = Medium.enthalpy_pTM(p,T,X[i,:],Medium.PhaseLabelVapor);
  //h_vap[i] = Gas.h_TX(T,X[i,:]);
  h_vap[i] = Gas.h_T(T,i);
  end for;
end Enthalpies;
