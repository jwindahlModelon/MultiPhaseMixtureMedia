within MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.Tests;
model Enthalpies
    extends Modelica.Icons.Example;
  package Medium = MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air;
  package Gas =
      MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.AirFastIdealGas;
parameter Modelica.SIunits.Temperature T_min=70;
parameter Modelica.SIunits.Temperature T_max=140;
Modelica.SIunits.Temperature T(start=T_min);
parameter Modelica.SIunits.Pressure p=2e5;
//parameter Modelica.SIunits.MassFraction[Medium.nS] X={0.755,0.232,0.013};
parameter Modelica.SIunits.MassFraction[Medium.nS,Medium.nS] X=identity(Medium.nS);
Modelica.SIunits.Enthalpy H_liq[Medium.nS];
Modelica.SIunits.Enthalpy H_vap[Medium.nS];
Modelica.SIunits.SpecificEnthalpy h_vap[Medium.nS];
constant
    MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.Air.EquationsOfState.Data.FastGasData[
    :] data=Gas.data;
equation
  der(T)=(T_max-T_min)*1;
  for i in 1:Medium.nS loop
  H_liq[i] = Medium.enthalpy_pTM(p,T,X[i,:],Medium.PhaseLabelLiquid);
  H_vap[i] = Medium.enthalpy_pTM(p,T,X[i,:],Medium.PhaseLabelVapor);
  //h_vap[i] = Gas.h_TX(T,X[i,:]);
  h_vap[i] = Gas.h_T(T,i);
  end for;
end Enthalpies;
