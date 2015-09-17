within MultiPhaseMixture.Templates;
package ExternalObjects
  extends Modelica.Icons.Package;
  class ExternalMediaObject "External object of 1-dim. table defined by matrix"
    extends ExternalObject;

    function constructor "Initialize 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input
        MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.PropertySetupInformation
                                                                                         setup
        "Medium name";
      output ExternalMediaObject eo;
    external"C" eo = getMaterial(setup.libraryName,setup.compounds,setup.setupInfo) annotation (Library={"ExternalMultiPhaseMixtureLib"});
    end constructor;

    function destructor "Terminate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input ExternalMediaObject eo;
    external"C" closeMaterial(eo)
        annotation (Library={"ExternalMultiPhaseMixtureLib"});
    end destructor;

    annotation (Icon(graphics={
          Polygon(
            points={{-100,100},{-100,-100},{100,-100},{100,40},{40,40},{40,100},
                {-100,100}},
            lineColor={215,215,215},
            smooth=Smooth.None,
            fillPattern=FillPattern.Forward,
            fillColor={250,235,23}),
          Rectangle(
            extent={{-58,34},{50,10}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{40,100},{40,40},{100,40},{40,100}},
            lineColor={215,215,215},
            smooth=Smooth.None,
            fillColor={212,212,70},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-58,-12},{50,-36}},
            lineColor={175,175,175},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-58,-56},{50,-80}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}));
  end ExternalMediaObject;
  annotation (Icon(graphics={
        Polygon(
          points={{-64,62},{-64,-64},{72,-62},{72,14},{30,14},{30,62},{-64,62}},
          lineColor={215,215,215},
          smooth=Smooth.None,
          fillPattern=FillPattern.Forward,
          fillColor={250,235,23}),
        Polygon(
          points={{30,62},{30,14},{72,14},{30,62}},
          lineColor={215,215,215},
          smooth=Smooth.None,
          fillColor={212,212,70},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,8},{36,-8}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,-20},{36,-36}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}));

end ExternalObjects;
