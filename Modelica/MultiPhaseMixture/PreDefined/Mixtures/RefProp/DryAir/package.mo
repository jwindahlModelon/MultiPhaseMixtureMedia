within MultiPhaseMixture.PreDefined.Mixtures.RefProp;
package DryAir "RefProp dry air mixture (N2,O2,Ar)"
  extends MultiPhaseMixture.Templates.ExternalTwoPhaseMixture(
  nP=2,
  setupInfo(
    compounds="",
    libraryName = "RefProp",
    setupInfo="mixture=air.mix|path=C:/Program Files (x86)/REFPROP/|eos=default"),
  substanceNames={"Nitrogen","Argon","Oxygen"},
  reference_X={0.7557,0.0127,0.2316},
  mediumName="AirDry");


  extends MultiPhaseMixture.Icons.Media;


  redeclare model extends ThermoProperties
  end ThermoProperties;


 redeclare model extends Properties
 end Properties;


 redeclare model extends MultiPhaseProperties
 end MultiPhaseProperties;


  annotation (Icon(graphics={
      Polygon(
        points={{62,-72},{54,-76},{6,-76},{50,-72},{50,-70},{34,-36},{62,-72}},
        lineColor={255,255,255},
        smooth=Smooth.None,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}));
end DryAir;
