within MultiPhaseMixture.Visualizers;
model Ph_DryAir_0to60bar "Dry air Ph-diagram, p(0-60 bar), h(-200-500 kJ/k)"
    extends MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
    final imageName="modelica://MultiPhaseMixture/Resources/Images/dryAir_phDiagram.png",
    final point_1={-200e3,1.0e5},
    final point_2={1.0e5,60e5},
    final point_1_imagePixelCoord={75,850},
    final point_2_imagePixelCoord={1535,26},
    final imagePixelWidth=1551,
    final imagePixelHeight=923);

    annotation (Documentation(info="<html>
<p>This model provides a dynamic display for ph-diagrams of dry-air as medium with a fixed mass-composition of <code><span style=\"font-family: Courier New,courier;\">{0.7557,0.0127,0.2316} (</span></code>Nitrogen,Argon,Oxygen).</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics));
end Ph_DryAir_0to60bar;
