within MultiPhaseMixture.Visualizers;
model Ph_WaterIF95_0to400bar
  "WaterIF95 Ph-diagram, p(0-400 bar), h(0-4000 kJ/k)"
  extends MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
    final imageName="modelica://MultiPhaseMixture/Resources/Images/water_ph_0to400bar.png",
    final point_1={0,0},
    final point_2={4000e3,400e5},
    final point_1_imagePixelCoord={104,760},
    final point_2_imagePixelCoord={1393,30},
    final imagePixelWidth=1483,
    final imagePixelHeight=843);

    annotation (Documentation(info="<html>
<p>This model provides a dynamic display for ph-diagrams of water as medium, using water triple point as reference state.</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics));
end Ph_WaterIF95_0to400bar;
