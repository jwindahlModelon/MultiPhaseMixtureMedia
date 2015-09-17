within MultiPhaseMixture.PreDefined.Pure.RefProp;
package R134a "R134a"
  extends MultiPhaseMixture.Templates.ExternalTwoPhaseMixture(
  nP=2,
  setupInfo(
    compounds="r134a.fld",
    libraryName = "RefProp",
    setupInfo="path=C:/Program Files (x86)/REFPROP/|eos=default"),
  substanceNames={"R134a"},
  reference_X={1.0},
  mediumName="R134a");


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
end R134a;
