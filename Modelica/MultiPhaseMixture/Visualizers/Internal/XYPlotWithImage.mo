within MultiPhaseMixture.Visualizers.Internal;
model XYPlotWithImage "XY-plot with background image"

  input Real x[:]={(point_1[1]+point_2[1])/2} "x-axis values"   annotation (Dialog(group="Inputs"));
  input Real y[size(x, 1)]={(point_1[2]+point_2[2])/2} "y-axis values"   annotation (Dialog(group="Inputs"));

  parameter String imageName="" "Image name" annotation(Dialog(group="Image"));

  parameter Real point_1[2]={0,0} "x,y value of point 1" annotation (Dialog(group="Coordinate transformation"));
  parameter Real point_2[2]={1,1} "x,y value of point 2" annotation (Dialog(group="Coordinate transformation"));
  parameter Real point_1_imagePixelCoord[2]={0,500}
    "Image pixel coordinate at point 1" annotation (Dialog(group="Coordinate transformation"));
  parameter Real point_2_imagePixelCoord[2]={1000,0}
    "Image pixel coordinate at point 2" annotation (Dialog(group="Coordinate transformation"));
  parameter Real imagePixelWidth=1000 "Image pixel width" annotation (Dialog(group="Coordinate transformation"));
  parameter Real imagePixelHeight=500 "Image pixel height" annotation (Dialog(group="Coordinate transformation"));
   parameter Integer[3] color={0,0,255} "Color (RGB) for line 1"
                             annotation(Dialog(group="Diagram attributes"));
  Real[size(x, 1), 2] points_line;
  Real[2, 2] points_circle;
  final parameter Boolean circle_1_visible=if size(x, 1) == 1 then true else false;
protected
  final parameter Integer X=1 "Coordinate index of x";
  final parameter Integer Y=2 "Coordinate index of y";
  final parameter Real relPos_Xmin=point_1_imagePixelCoord[X]/imagePixelWidth;
  final parameter Real relPos_Xmax=point_2_imagePixelCoord[X]/imagePixelWidth;
  final parameter Real relPos_Ymin=(imagePixelHeight-point_1_imagePixelCoord[Y])/imagePixelHeight;
  final parameter Real relPos_Ymax=(imagePixelHeight-point_2_imagePixelCoord[Y])/imagePixelHeight;

  final parameter Integer lowerLeftCornerCoord[2]={-100,-100};
  final parameter Integer upperRightCornerCoord[2]={100,100};
  final parameter Integer ellipseRadius=3;

  Real x_rel_coord[size(x,1)];
  Real y_rel_coord[size(x,1)];
  Real x_coord[size(x,1)];
  Real y_coord[size(x,1)];
equation

  // Line
  for i in 1:size(x,1) loop
    x_rel_coord[i]=((x[i]-point_1[X])/(point_2[X]-point_1[X]))*(relPos_Xmax-relPos_Xmin)+relPos_Xmin;
    y_rel_coord[i]=((y[i]-point_1[Y])/(point_2[Y]-point_1[Y]))*(relPos_Ymax-relPos_Ymin)+relPos_Ymin;
    x_coord[i]=lowerLeftCornerCoord[1]+x_rel_coord[i]*(upperRightCornerCoord[1]-lowerLeftCornerCoord[1]);
    y_coord[i]=lowerLeftCornerCoord[2]+y_rel_coord[i]*(upperRightCornerCoord[2]-lowerLeftCornerCoord[2]);
  end for;
  points_line=transpose({x_coord,y_coord});

  // Circle - for the special case when size(x)=1(one data data point)
  points_circle=[x_coord[1]-ellipseRadius,y_coord[1]-ellipseRadius;x_coord[1]+ellipseRadius,y_coord[1]+ellipseRadius];

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),
                   graphics={Bitmap(preserveAspectRatio=false,extent={{-100,100},{100,-100}},
            fileName=imageName),Line(
          points=DynamicSelect({{-100,-100},{-20,40},{20,-20},{100,100}}, points_line),
          color=color,
          pattern=LinePattern.Solid),Ellipse(extent=DynamicSelect({{-1,1},{1,-1}},points_circle), lineColor=color,visible=DynamicSelect(true,circle_1_visible))}),
              Protection(access=Access.hide),Diagram,
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">XY-plot with an image as background. The plot is visualized in the tools diagram view.</span></p>
<h4>Special case</h4>
<p><span style=\"font-family: MS Shell Dlg 2;\"> If the x and y vector contains only one data point a circle will be visualized instead of the polyline.</span></p>
<h4>Coordinate transformation</h4>
<p>The coordinate system of the diagram is built up by defining (x,y) values at two positions in the image, point_1 and point_2. For point_1 and point_2 the corresponding image pixel coordinates, point_1_imagePixelCoord and point_2_imagePixelCoord needs to be defined.</p>
<p><br><img src=\"modelica://MultiPhaseMixture/Resources/Images/pixelCoordinateSystem.png\"/></p>
<p>Image pixel dimension and coordinates of the specified image can be found by using an image program such as Paint.</p>
</html>", revisions="<html>
</html>"));
end XYPlotWithImage;
