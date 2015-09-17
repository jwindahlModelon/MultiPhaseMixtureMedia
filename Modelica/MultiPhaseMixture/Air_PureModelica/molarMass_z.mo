within MultiPhaseMixture.Air_PureModelica;
function molarMass_z "Molar weight of mixture"
input Modelica.SIunits.MoleFraction[nC]
    z;
output Modelica.SIunits.MolarMass MM;
algorithm
  MM:=z*MMX;
  annotation(smoothOrder=5);
end molarMass_z;
