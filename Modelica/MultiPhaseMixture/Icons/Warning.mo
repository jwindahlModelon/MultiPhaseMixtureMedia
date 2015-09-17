within MultiPhaseMixture.Icons;
model Warning

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                    graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-6,82},{8,-46}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Ellipse(
          extent={{-8,-72},{8,-88}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
end Warning;
