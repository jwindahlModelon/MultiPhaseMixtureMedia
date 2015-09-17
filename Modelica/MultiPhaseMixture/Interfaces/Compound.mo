within MultiPhaseMixture.Interfaces;
record Compound "Compund , data that may be used to identify a compound"
  // for example in a model where we need the index of a fraction vecor for a specific compound. E.g. Integer index_H2O=Medium.getCompoundIndexByIupacName("water") or similar
  extends Modelica.Icons.Record;
  String iupacName "Complete IUPAC name (or common name, if non-existent)";
  String casRegistryNumber
    "Chemical abstracts sequencing number (if it exists)";
  String chemicalFormula
    "Chemical formula, (brutto, nomenclature according to Hill";
  String structureFormula "Chemical structure formula";
  Modelica.SIunits.MolarMass molecularWeight "Molecular weight";
  // compound id, for communicating with external tools,
  Modelica.SIunits.Temperature normalBoilingTemperature
    "Normal boiling point (at 101325 Pa)";
  String id "Unique compound identifier";
end Compound;
