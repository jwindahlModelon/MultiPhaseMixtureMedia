within MultiPhaseMixture.Visualizers;
model Ph_R134a_0to50bar "R134a Ph-diagram, p(0-50 bar), h(160-500 kJ/k)"
    extends MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
    final imageName="modelica://MultiPhaseMixture/Resources/Images/phR134a.png",
    final point_1={160e3,1.4e5},
    final point_2={500e3,50e5},
    final point_1_imagePixelCoord={156,801},
    final point_2_imagePixelCoord={1086,67},
    final imagePixelWidth=1201,
    final imagePixelHeight=901);

    annotation (Documentation(info="<html>
<p><b>Model description</b> </p>
<p>This model provides a dynamic display for ph-diagrams of R134a as medium. </p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics));
end Ph_R134a_0to50bar;
