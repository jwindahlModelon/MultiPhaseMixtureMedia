within MultiPhaseMixture.PreDefined.Mixtures;
package CapeOpen "Pre-defined mixturefluids using the Cape-Open interface"
extends MultiPhaseMixture.Icons.MediaPackage;
  class Information
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>See <a href=\"modelica://MultiPhaseMixture.Information.ExternalPropertyPackages.CapeOpen\">MultiPhaseMixture.Information.ExternalPropertyPackages.CapeOpen</a></p>
</html>"));
  end Information;

  package FluidProp
     extends MultiPhaseMixture.Icons.MediaPackage;
    package DryAir "CapeOpen.FluidProp dry air mixture (N2,O2,Ar)"
      extends MultiPhaseMixture.Templates.ExternalTwoPhaseMixture(
      nP=3,
         setupInfo(compounds="nitrogen/argon/oxygen",
         libraryName = "CapeOpen.FluidProp Thermo System//PCP-SAFT",
         setupInfo="UnitBasis=2;CodeLogging=false"),
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
  end FluidProp;
end CapeOpen;
