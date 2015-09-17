within MultiPhaseMixture.Icons;
model ExternalObjectIcon

  annotation (Icon(graphics={
        Polygon(
          points={{10,30},{10,20},{22,20},{10,30}},
          lineColor={215,215,215},
          smooth=Smooth.None,
          fillColor={212,212,70},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-18,30},{-18,-20},{22,-20},{22,20},{10,20},{10,30},{-18,30}},
          lineColor={215,215,215},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,85}),
        Rectangle(
          extent={{-10,12},{16,8}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,2},{16,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-10},{16,-14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end ExternalObjectIcon;
