within MultiPhaseMixture.Interfaces;
record FlashProperties
   extends Modelica.Icons.Record;
    Modelica.SIunits.Pressure p annotation(Dialog);
    Modelica.SIunits.Temperature T annotation(Dialog);
    Modelica.SIunits.MoleFraction[nP,nC] x "Mole fractions in each phase"                      annotation(Dialog);
     Modelica.SIunits.AmountOfSubstance[nP] Z
    "Amount of substance in each phase"  annotation(Dialog);
//     String[:] presentPhases=phases.label
//     "Phases to search for. They must be available in phaseList"
//                                                                 annotation(Dialog(group="Optimization"));
end FlashProperties;
