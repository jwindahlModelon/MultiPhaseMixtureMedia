within MultiPhaseMixture;
package Test "Tests of media calculations"
  package Internal "Internal package"
    extends Modelica.Icons.InternalPackage;
    record OperatingPoint "Operating point test record"
      extends Modelica.Icons.Record;
       Modelica.SIunits.AbsolutePressure p1=25e5 annotation(Dialog);
       Modelica.SIunits.SpecificEnthalpy h1=400e3 annotation(Dialog);
       Modelica.SIunits.Temperature T1=368  annotation(Dialog);
       Modelica.SIunits.Density d1=962 annotation(Dialog);
       Modelica.SIunits.SpecificEntropy s1=1248 annotation(Dialog);
       Modelica.SIunits.MassFraction X1[:]={1}                       annotation(Dialog);
    end OperatingPoint;

    record OperatingPointSat "Saturating operating point test record"
      extends Modelica.Icons.Record;
       Modelica.SIunits.AbsolutePressure p1=25e5 annotation(Dialog);
       Modelica.SIunits.Temperature T1=368  annotation(Dialog);
       Modelica.SIunits.MassFraction X1[:]={1}                       annotation(Dialog);
    end OperatingPointSat;
  end Internal;

  package Templates "Templates"
    extends MultiPhaseMixture.Icons.TemplatesPackage;

    partial model BaseTest "Base test model"
     import SI = Modelica.SIunits;
      replaceable package Medium =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;

      MultiPhaseMixture.Test.Internal.OperatingPoint point_start(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

      MultiPhaseMixture.Test.Internal.OperatingPoint point_end(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-62,78},{-42,98}})));

       replaceable MultiPhaseMixture.Visualizers.Ph_WaterIF95_0to400bar
                                                             phDiagram(x={h}, y=
            {p}) constrainedby
        MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
          x={h}, y={p})
        annotation (Placement(transformation(extent={{-100,-60},{98,60}})));

     // Variables
       // Medium properties
      SI.AbsolutePressure p;
      SI.AbsolutePressure p_ref;
      SI.SpecificEnthalpy h;
      SI.SpecificEnthalpy h_ref;
      SI.SpecificEnthalpy h_is "Isentropic enthalpy";
      SI.SpecificEnthalpy h_is_ref "Isentropic enthalpy";

      SI.Temperature T;
      SI.Temperature T_ref;
      SI.Density d;
      SI.Density d_ref;
      SI.SpecificEntropy s;
      SI.SpecificEntropy s_ref;

      SI.SpecificHeatCapacity cp;
      SI.SpecificHeatCapacity cp_ref;
      SI.SpecificHeatCapacity cv;
      SI.SpecificHeatCapacity cv_ref;

      SI.SpecificInternalEnergy u;
      SI.SpecificInternalEnergy u_ref;

      SI.VelocityOfSound a;
      SI.VelocityOfSound a_ref;

    // Derivatives
      SI.DerDensityByPressure ddph;
      SI.DerDensityByPressure ddph_ref;
      SI.DerDensityByEnthalpy ddhp;
      SI.DerDensityByEnthalpy ddhp_ref;

      SI.IsothermalCompressibility kappa "Isothermal compressibility";
      SI.IsothermalCompressibility kappa_ref "Isothermal compressibility";

      MultiPhaseMixture.Types.VolumetricExpansionCoefficient beta
        "Volumetric expansion coefficient";
      MultiPhaseMixture.Types.VolumetricExpansionCoefficient beta_ref
        "Volumetric expansion coefficient";

     // isothermalCompressibility

      // Transport properties
      SI.DynamicViscosity eta;
      SI.DynamicViscosity eta_ref;
      SI.ThermalConductivity lambda;
      SI.ThermalConductivity lambda_ref;
      SI.KinematicViscosity nu;
      SI.KinematicViscosity nu_ref;
      SI.Pressure p_input;
      SI.SpecificEnthalpy h_input;
      SI.Temperature T_input;
      SI.Density d_input;
      SI.SpecificEntropy s_input;
      SI.MassFraction[Medium.nC] X_input;

    equation
        p_input=point_start.p1+(point_end.p1-point_start.p1)*time/1;
        h_input=point_start.h1+(point_end.h1-point_start.h1)*time/1;
        T_input=point_start.T1+(point_end.T1-point_start.T1)*time/1;
        d_input=point_start.d1+(point_end.d1-point_start.d1)*time/1;
        s_input=point_start.s1+(point_end.s1-point_start.s1)*time/1;
        X_input=point_start.X1+(point_end.X1-point_start.X1)*time/1;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end BaseTest;

    partial model BaseSatTest "Base saturation test model"
     import SI = Modelica.SIunits;
      replaceable package Medium =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;
      replaceable package Medium_ref =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;

      MultiPhaseMixture.Test.Internal.OperatingPointSat point_start(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

      MultiPhaseMixture.Test.Internal.OperatingPointSat point_end(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-62,78},{-42,98}})));

     // Variables
       // Medium properties

      SI.Pressure p_input;
      SI.Temperature T_input;
      SI.MassFraction[Medium.nC] X_input;

        // pFZ "p,F,Z",
        // TFZ "T,F,Z",
        // pFZ_mole "p,Fm,Zm",
        // TFZ_mole "T,Fm,Zm",
        // pFN "p,FN,N",
        // TFN "T,FN,N") "Input type";

    equation
        p_input=point_start.p1+(point_end.p1-point_start.p1)*time/1;
        T_input=point_start.T1+(point_end.T1-point_start.T1)*time/1;
        X_input=point_start.X1+(point_end.X1-point_start.X1)*time/1;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end BaseSatTest;

    partial model MultiPhaseProperties_noRef
      "Base test model without a reference medium model"
     import SI = Modelica.SIunits;
      replaceable package Medium =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;

      MultiPhaseMixture.Test.Internal.OperatingPoint point_start(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

      MultiPhaseMixture.Test.Internal.OperatingPoint point_end(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-62,78},{-42,98}})));

       replaceable MultiPhaseMixture.Visualizers.Ph_WaterIF95_0to400bar
                                                             phDiagram(x={h}, y=
            {p}) constrainedby
        MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
          x={h}, y={p})
        annotation (Placement(transformation(extent={{-100,-60},{98,60}})));

     // Variables
       // Medium properties
      SI.AbsolutePressure p;
      SI.SpecificEnthalpy h;
      SI.SpecificEnthalpy h_is "Isentropic enthalpy";

      SI.Temperature T;
      SI.Density d;
      SI.SpecificEntropy s;

      SI.SpecificHeatCapacity cp;
      SI.SpecificHeatCapacity cv;

      SI.SpecificInternalEnergy u;

      SI.VelocityOfSound a;

    // Derivatives
      SI.DerDensityByPressure ddph;
      SI.DerDensityByEnthalpy ddhp;

      SI.IsothermalCompressibility kappa "Isothermal compressibility";

      MultiPhaseMixture.Types.VolumetricExpansionCoefficient beta
        "Volumetric expansion coefficient";

     // isothermalCompressibility

      // Transport properties
      SI.DynamicViscosity eta;
      SI.ThermalConductivity lambda;
      SI.KinematicViscosity nu;

      SI.Pressure p_input;
      SI.SpecificEnthalpy h_input;
      SI.Temperature T_input;
      SI.Density d_input;
      SI.SpecificEntropy s_input;
      SI.MassFraction[Medium.nC] X_input;

        Medium.MultiPhaseProperties
                        multiPhaseProperties
        annotation (Placement(transformation(extent={{60,80},{80,100}})));

    equation
        p_input=point_start.p1+(point_end.p1-point_start.p1)*time/1;
        h_input=point_start.h1+(point_end.h1-point_start.h1)*time/1;
        T_input=point_start.T1+(point_end.T1-point_start.T1)*time/1;
        d_input=point_start.d1+(point_end.d1-point_start.d1)*time/1;
        s_input=point_start.s1+(point_end.s1-point_start.s1)*time/1;
        X_input=point_start.X1+(point_end.X1-point_start.X1)*time/1;

       // Medium properties
      p=multiPhaseProperties.p_overall;

      h=multiPhaseProperties.h_overall;
      h_is=0; // Not supported

      T=multiPhaseProperties.T_overall;
      d=multiPhaseProperties.d_overall;
      s=multiPhaseProperties.s_overall;
      u=multiPhaseProperties.u;
      cp=0;
      cv=0;

      kappa=0;
      beta=0;
      a=0;

        // Transport properties
      eta=0;
      nu=0;
      lambda=0;

      // Derivatives
      ddph=0;
      ddhp=0;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end MultiPhaseProperties_noRef;

    partial model MultiPhaseProperties2_noRef
      "Base test model without a reference medium model"
     import SI = Modelica.SIunits;
      replaceable package Medium =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;

      MultiPhaseMixture.Test.Internal.OperatingPoint point_start(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

      MultiPhaseMixture.Test.Internal.OperatingPoint point_end(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-62,78},{-42,98}})));

       replaceable MultiPhaseMixture.Visualizers.Ph_WaterIF95_0to400bar
                                                             phDiagram(x={h_input}, y=
            {p_input}) constrainedby
        MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
          x={h_input}, y={p_input})
        annotation (Placement(transformation(extent={{-100,-60},{98,60}})));

      SI.Pressure p_input;
      SI.SpecificEnthalpy h_input;
      SI.Temperature T_input;
      SI.Density d_input;
      SI.SpecificEntropy s_input;
      SI.MassFraction[Medium.nC] X_input;

      Medium.MultiPhaseProperties multiPhaseProperties_phX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
        p=p_input,
        h=h_input,
        Z=X_input) annotation (Placement(transformation(extent={{-28,-94},{-8,-74}})));
      Medium.MultiPhaseProperties multiPhaseProperties_pTX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
        p=p_input,
        T=T_input,
        Z=X_input) annotation (Placement(transformation(extent={{-68,-94},{-48,-74}})));
      Medium.MultiPhaseProperties multiPhaseProperties_dTX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
        d=d_input,
        T=T_input,
        Z=X_input)
        annotation (Placement(transformation(extent={{12,-94},{32,-74}})));
      Medium.MultiPhaseProperties multiPhaseProperties_duX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.duX,
        d=d_input,
        u=multiPhaseProperties_dTX.u,
        Z=X_input) annotation (Placement(transformation(extent={{52,-94},{72,-74}})));
    equation
        p_input=point_start.p1+(point_end.p1-point_start.p1)*time/1;
        h_input=point_start.h1+(point_end.h1-point_start.h1)*time/1;
        T_input=point_start.T1+(point_end.T1-point_start.T1)*time/1;
        d_input=point_start.d1+(point_end.d1-point_start.d1)*time/1;
        s_input=point_start.s1+(point_end.s1-point_start.s1)*time/1;
        X_input=point_start.X1+(point_end.X1-point_start.X1)*time/1;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end MultiPhaseProperties2_noRef;

    partial model Properties_RefModelicaMedia
      "Base test model with refererence medium from Modelica.Media"
      extends MultiPhaseMixture.Test.Templates.BaseTest;

      replaceable package Medium_ref=Modelica.Media.Water.WaterIF97_ph constrainedby
        Modelica.Media.Interfaces.PartialTwoPhaseMedium;

      Medium_ref.ThermodynamicState state_ref;

    //  SI.MolarMass MM=Medium.molarMass(state);

    //  SI.MolarMass MM_ref=Medium_ref.molarMass(state_ref);

    // Include sat properties to see how it behave in twophase region
    //     Real x "Vapor Fraction";
    //     Real hl_sat "Liquid enthalpy";
    //     Real hv_sat "Vapor enthalpy";
    //   Real p_red=p/Medium.criticalPressure_X( state.X);

      Medium.Properties properties
        annotation (Placement(transformation(extent={{60,80},{80,100}})));
    equation
    //     hl_sat=Medium.bubbleEnthalpy_pX(p,X_input);
    //     hv_sat=Medium.dewEnthalpy_pX(p,X_input);
    //     x = noEvent(if p_red < 1.0 then (h - hl_sat)/max(hv_sat - hl_sat, 1e-6) else 1.0);

      // Medium properties
      p=properties.p;
      p_ref=Medium_ref.pressure(state_ref);
      h=properties.h;
      h_ref=Medium_ref.specificEnthalpy(state_ref);
      h_is=0; // Not supported
      h_is_ref=Medium_ref.isentropicEnthalpy(p_downstream=p_input,refState=state_ref);

      T=properties.T;
      T_ref=Medium_ref.temperature(state_ref);
      d=properties.d;
      d_ref=Medium_ref.density(state_ref);
      s=properties.s;
      s_ref=Medium_ref.specificEntropy(state_ref);
      u=properties.u;
      u_ref=Medium_ref.specificInternalEnergy(state_ref);

      cp=properties.cp;
      cp_ref=Medium_ref.specificHeatCapacityCp(state_ref);
      cv=properties.cv;
      cv_ref=Medium_ref.specificHeatCapacityCv(state_ref);

      kappa=properties.kappa;
      kappa_ref=Medium_ref.isothermalCompressibility(state_ref);

      beta=properties.beta;
      beta_ref=Medium_ref.beta(state_ref);

      a=properties.a;
      a_ref=Medium_ref.velocityOfSound(state_ref);
        // Transport properties
      eta=properties.eta;
      eta_ref=Medium_ref.dynamicViscosity(state_ref);
      nu=eta/d;
      nu_ref=Medium_ref.dynamicViscosity(state_ref)/Medium_ref.density(state_ref);
      lambda=properties.lambda;
      lambda_ref=Medium_ref.thermalConductivity(state_ref);

      // Derivatives
      ddph=properties.ddph;
      ddph_ref=Medium_ref.density_derp_h(state_ref);
      ddhp=properties.ddhp;
      ddhp_ref=Medium_ref.density_derh_p(state_ref);

    end Properties_RefModelicaMedia;

    partial model Properties_Properties "Base test model "
      extends MultiPhaseMixture.Test.Templates.BaseTest;

      replaceable package Medium_ref =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;

    //  SI.MolarMass MM=Medium.molarMass(state);

    //  SI.MolarMass MM_ref=Medium_ref.molarMass(state_ref);

    // Include sat properties to see how it behave in twophase region
    //     Real x "Vapor Fraction";
    //     Real hl_sat "Liquid enthalpy";
    //     Real hv_sat "Vapor enthalpy";
    //   Real p_red=p/Medium.criticalPressure_X( state.X);

      Medium.Properties properties
        annotation (Placement(transformation(extent={{20,80},{40,100}})));
      Medium_ref.Properties properties_ref
        annotation (Placement(transformation(extent={{60,80},{80,100}})));
    equation
    //     hl_sat=Medium.bubbleEnthalpy_pX(p,X_input);
    //     hv_sat=Medium.dewEnthalpy_pX(p,X_input);
    //     x = noEvent(if p_red < 1.0 then (h - hl_sat)/max(hv_sat - hl_sat, 1e-6) else 1.0);

      // Medium properties
      p=properties.p;
      p_ref=properties_ref.p;
      h=properties.h;
      h_ref=properties_ref.h;
      h_is=0; // Not supported
      h_is_ref=0; // Not supported

      T=properties.T;
      T_ref=properties_ref.T;
      d=properties.d;
      d_ref=properties_ref.d;
      s=properties.s;
      s_ref=properties_ref.s;
      u=properties.u;
      u_ref=properties_ref.u;

      cp=properties.cp;
      cp_ref=properties_ref.cp;
      cv=properties.cv;
      cv_ref=properties_ref.cv;

      kappa=properties.kappa;
      kappa_ref=properties_ref.kappa;

      beta=properties.beta;
      beta_ref=properties_ref.beta;

      a=properties.a;
      a_ref=properties_ref.a;
        // Transport properties
      eta=properties.eta;
      eta_ref=properties_ref.eta;
      nu=eta/d;
      nu_ref=eta_ref/d_ref;
      lambda=properties.lambda;
      lambda_ref=properties_ref.lambda;

      // Derivatives
      ddph=properties.ddph;
      ddph_ref=properties_ref.ddph;
      ddhp=properties.ddhp;
      ddhp_ref=properties_ref.ddhp;

    end Properties_Properties;

    partial model ThermoProperties_noRef
      "Base test model without a reference medium model"
     import SI = Modelica.SIunits;
      replaceable package Medium =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;

      MultiPhaseMixture.Test.Internal.OperatingPoint point_start(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

      MultiPhaseMixture.Test.Internal.OperatingPoint point_end(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-62,78},{-42,98}})));

       replaceable MultiPhaseMixture.Visualizers.Ph_WaterIF95_0to400bar
                                                             phDiagram(x={h}, y=
            {p}) constrainedby
        MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
          x={h}, y={p})
        annotation (Placement(transformation(extent={{-100,-60},{98,60}})));

     // Variables
       // Medium properties
      SI.AbsolutePressure p;
      SI.SpecificEnthalpy h;
      SI.Temperature T;
      SI.Density d;
     // SI.SpecificEntropy s;
      SI.SpecificInternalEnergy u;

      SI.Pressure p_input;
      SI.SpecificEnthalpy h_input;
      SI.Temperature T_input;
      SI.Density d_input;
      SI.SpecificEntropy s_input;
      SI.MassFraction[Medium.nC] X_input;

      Medium.ThermoProperties
                        properties
        annotation (Placement(transformation(extent={{60,80},{80,100}})));

    equation
        p_input=point_start.p1+(point_end.p1-point_start.p1)*time/1;
        h_input=point_start.h1+(point_end.h1-point_start.h1)*time/1;
        T_input=point_start.T1+(point_end.T1-point_start.T1)*time/1;
        d_input=point_start.d1+(point_end.d1-point_start.d1)*time/1;
        s_input=point_start.s1+(point_end.s1-point_start.s1)*time/1;
        X_input=point_start.X1+(point_end.X1-point_start.X1)*time/1;

       // Medium properties
      p=properties.p;
      h=properties.h;
      T=properties.T;
      d=properties.d;
     // s=properties.s;
      u=properties.u;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end ThermoProperties_noRef;

    partial model ThermoProperties2_noRef
      "Base test model without a reference medium model"
     import SI = Modelica.SIunits;
      replaceable package Medium =
          MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95
        constrainedby MultiPhaseMixture.Interfaces;

      MultiPhaseMixture.Test.Internal.OperatingPoint point_start(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

      MultiPhaseMixture.Test.Internal.OperatingPoint point_end(X1=Medium.reference_X)
        annotation (choicesAllMatching, Placement(transformation(extent={{-62,78},{-42,98}})));

       replaceable MultiPhaseMixture.Visualizers.Ph_WaterIF95_0to400bar
                                                             phDiagram(x={properties_phX.h}, y=
            {properties_phX.p}) constrainedby
        MultiPhaseMixture.Visualizers.Internal.XYPlotWithImage(
          x={properties_phX.h}, y={properties_phX.p})
        annotation (Placement(transformation(extent={{-100,-60},{98,60}})));

      SI.Pressure p_input;
      SI.SpecificEnthalpy h_input;
      SI.Temperature T_input;
      SI.Density d_input;
      SI.SpecificEntropy s_input;
      SI.MassFraction[Medium.nC] X_input;

      Medium.ThermoProperties properties_phX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
        p=p_input,
        h=h_input,
        Z=X_input) annotation (Placement(transformation(extent={{-32,-94},{-12,-74}})));
      Medium.ThermoProperties properties_pTX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
        p=p_input,
        T=T_input,
        Z=X_input) annotation (Placement(transformation(extent={{-72,-94},{-52,-74}})));

       Medium.ThermoProperties  properties_dTX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
        d=d_input,
        T=T_input,
        Z=X_input)
        annotation (Placement(transformation(extent={{8,-94},{28,-74}})));

       Medium.ThermoProperties  properties_duX(
        inputs=MultiPhaseMixture.Interfaces.Inputs.duX,
        d=d_input,
        u=properties_dTX.u,
        Z=X_input) annotation (Placement(transformation(extent={{48,-94},{68,-74}})));
    equation
        p_input=point_start.p1+(point_end.p1-point_start.p1)*time/1;
        h_input=point_start.h1+(point_end.h1-point_start.h1)*time/1;
        T_input=point_start.T1+(point_end.T1-point_start.T1)*time/1;
        d_input=point_start.d1+(point_end.d1-point_start.d1)*time/1;
        s_input=point_start.s1+(point_end.s1-point_start.s1)*time/1;
        X_input=point_start.X1+(point_end.X1-point_start.X1)*time/1;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end ThermoProperties2_noRef;
  end Templates;
  extends Modelica.Icons.ExamplesPackage;
  package CompareMedia "Comparision with a reference medium"
    package RefPropR134a_vs_ModelicaMediaR134a
      package OperatingPointData
         constant Modelica.SIunits.AbsolutePressure p_liquid=25e5;
         constant Modelica.SIunits.SpecificEnthalpy h_liquid=200e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_liquid=272.753  annotation(Dialog);
         constant Modelica.SIunits.Density d_liquid=1304.48 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_liquid=993.778 annotation(Dialog);

         constant Modelica.SIunits.AbsolutePressure p_vapor=25e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor=450e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor=363.894  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor=121.85 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor=1746.88 annotation(Dialog);

      end OperatingPointData;

      package Template
        extends MultiPhaseMixture.Icons.TemplatesPackage;
        partial model RefProp_R134a
          extends MultiPhaseMixture.Test.Templates.Properties_RefModelicaMedia(
            redeclare package Medium =
                MultiPhaseMixture.PreDefined.Pure.RefProp.R134a,
            redeclare package Medium_ref=Modelica.Media.R134a.R134a_ph,
            redeclare MultiPhaseMixture.Visualizers.Ph_R134a_0to50bar phDiagram,
            point_start(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_liquid,
              h1=OperatingPointData.h_liquid,
              T1(displayUnit="K") = OperatingPointData.T_liquid,
              d1=OperatingPointData.d_liquid,
              s1=OperatingPointData.s_liquid),
            point_end(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_vapor,
              h1=OperatingPointData.h_vapor,
              T1(displayUnit="K") = OperatingPointData.T_vapor,
              d1=OperatingPointData.d_vapor,
              s1=OperatingPointData.s_vapor));

        end RefProp_R134a;
      end Template;

      model RefProp_R134a_dTX
        // Modelica.Media.R134a.R134a_ph does not seems valid with dT as input in 2-phase region
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropR134a_vs_ModelicaMediaR134a.Template.RefProp_R134a(
            properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
            d=d_input,
            T=T_input,
            Z=X_input));
      equation
        state_ref=Medium_ref.setState_dTX(d_input,T_input,X_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end RefProp_R134a_dTX;

      model RefProp_R134a_phX
        // Transport properties eta, lambda, nu differs a little bit. Probably is a different transport model used.
        //  Modelica.Media.R134a.R134a_ph don't calculate velocity and some other props in 2-phase region
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropR134a_vs_ModelicaMediaR134a.Template.RefProp_R134a(
            properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
            p=p_input,
            h=h_input,
            Z=X_input));
      equation
        state_ref=Medium_ref.setState_phX(p_input,h_input,X_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end RefProp_R134a_phX;

      model RefProp_R134a_pTX
        // Modelica.Media.R134a.R134a_ph does not support setState_pTX
        extends MultiPhaseMixture.Icons.Failure;
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropR134a_vs_ModelicaMediaR134a.Template.RefProp_R134a(
            properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
            p=p_input,
            T=T_input,
            Z=X_input));
      equation
        state_ref=Medium_ref.setState_pTX(p_input,T_input,X_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end RefProp_R134a_pTX;
    end RefPropR134a_vs_ModelicaMediaR134a;

    package RefPropWaterIF95_vs_ModelicaMediaWaterIF97
      package OperatingPointData
         constant Modelica.SIunits.AbsolutePressure p_liquid=100e5;
         constant Modelica.SIunits.SpecificEnthalpy h_liquid=400e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_liquid=366.798  annotation(Dialog);
         constant Modelica.SIunits.Density d_liquid=967.335 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_liquid=1227.62 annotation(Dialog);

         constant Modelica.SIunits.AbsolutePressure p_vapor=100e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor=3400e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor=782.819  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor=967.335 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor=1227.62 annotation(Dialog);

      end OperatingPointData;

      package Template
        extends MultiPhaseMixture.Icons.TemplatesPackage;
        partial model WaterIF95
          extends MultiPhaseMixture.Test.Templates.Properties_RefModelicaMedia(
            redeclare package Medium =
                MultiPhaseMixture.PreDefined.Pure.RefProp.WaterIF95,
            redeclare package Medium_ref=Modelica.Media.Water.WaterIF97_ph,
            redeclare MultiPhaseMixture.Visualizers.Ph_WaterIF95_0to400bar phDiagram,
            point_start(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_liquid,
              h1=OperatingPointData.h_liquid,
              T1(displayUnit="K") = OperatingPointData.T_liquid,
              d1=OperatingPointData.d_liquid,
              s1=OperatingPointData.s_liquid),
            point_end(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_vapor,
              h1=OperatingPointData.h_vapor,
              T1(displayUnit="K") = OperatingPointData.T_vapor,
              d1=OperatingPointData.d_vapor,
              s1=OperatingPointData.s_vapor));

        end WaterIF95;
      end Template;

      model WaterIF95_dTX
        // Iteration failure for Modelica.Media.Water.IF97_Utilities.BaseIF97.Inverses.pofdt125
        extends MultiPhaseMixture.Icons.Failure;
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropWaterIF95_vs_ModelicaMediaWaterIF97.Template.WaterIF95
          (properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
            d=d_input,
            T=T_input,
            Z=X_input));
      equation
        state_ref=Medium_ref.setState_dTX(d_input,T_input,X_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end WaterIF95_dTX;

      model WaterIF95_phX
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropWaterIF95_vs_ModelicaMediaWaterIF97.Template.WaterIF95
          (properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
            p=p_input,
            h=h_input,
            Z=X_input));
      equation
        state_ref=Medium_ref.setState_phX(p_input,h_input,X_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end WaterIF95_phX;

      model WaterIF95_pTX
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropWaterIF95_vs_ModelicaMediaWaterIF97.Template.WaterIF95
          (properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
            p=p_input,
            T=T_input,
            Z=X_input));
      equation
        state_ref=Medium_ref.setState_pTX(p_input,T_input,X_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end WaterIF95_pTX;
    end RefPropWaterIF95_vs_ModelicaMediaWaterIF97;

    package RefPropDryAir_vs_ModelicaMediaReferenceAir

      package OperatingPointData
         constant Modelica.SIunits.AbsolutePressure p_liquid=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_liquid=-100e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_liquid=92.092  annotation(Dialog);
         constant Modelica.SIunits.Density d_liquid=813.793 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_liquid=3278.59 annotation(Dialog);

         constant Modelica.SIunits.AbsolutePressure p_vapor=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor=4.35812 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

      end OperatingPointData;

      package OperatingPointDataVapor
         constant Modelica.SIunits.AbsolutePressure p_vapor1=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor1=135332 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor1=140  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor1=12.937 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor1=5621.79 annotation(Dialog);

         constant Modelica.SIunits.AbsolutePressure p_vapor=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor=4.35812 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

      end OperatingPointDataVapor;

      package Template
        extends MultiPhaseMixture.Icons.TemplatesPackage;
        partial model DryAir
          extends MultiPhaseMixture.Test.Templates.Properties_RefModelicaMedia(
            redeclare package Medium =
                MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir,
            redeclare package Medium_ref=Modelica.Media.Air.ReferenceAir.Air_ph,
            redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
            point_start(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_liquid,
              h1=OperatingPointData.h_liquid,
              T1(displayUnit="K") = OperatingPointData.T_liquid,
              d1=OperatingPointData.d_liquid,
              s1=OperatingPointData.s_liquid),
            point_end(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_vapor,
              h1=OperatingPointData.h_vapor,
              T1(displayUnit="K") = OperatingPointData.T_vapor,
              d1=OperatingPointData.d_vapor,
              s1=OperatingPointData.s_vapor));

        end DryAir;
      end Template;

      model DryAir_phX_vapor "Compare in vapor region"
        // There is a difference in reference conditions, thereof use of h_offset
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropDryAir_vs_ModelicaMediaReferenceAir.Template.DryAir(
          properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
            p=p_input,
            h=h_input,
            Z=X_input),
          point_start(
            p1=OperatingPointDataVapor.p_vapor1,
            h1=OperatingPointDataVapor.h_vapor1,
            T1=OperatingPointDataVapor.T_vapor1,
            d1=OperatingPointDataVapor.d_vapor1,
            s1=OperatingPointDataVapor.s_vapor1),
          point_end(
            p1=OperatingPointDataVapor.p_vapor,
            h1=OperatingPointDataVapor.h_vapor,
            T1=OperatingPointDataVapor.T_vapor,
            d1=OperatingPointDataVapor.d_vapor,
            s1=OperatingPointDataVapor.s_vapor));
         parameter Modelica.SIunits.SpecificEnthalpy h_offset=273291;
      equation
        state_ref=Medium_ref.setState_ph(p_input,h_input-h_offset);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end DryAir_phX_vapor;

      model DryAir_pTX_vapor "Compare in vapor region"
        // There is a difference in reference conditions, thereof use of h_offset
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropDryAir_vs_ModelicaMediaReferenceAir.Template.DryAir(
          properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
            p=p_input,
            T=T_input,
            Z=X_input),
          point_start(
            p1=OperatingPointDataVapor.p_vapor1,
            h1=OperatingPointDataVapor.h_vapor1,
            T1=OperatingPointDataVapor.T_vapor1,
            d1=OperatingPointDataVapor.d_vapor1,
            s1=OperatingPointDataVapor.s_vapor1),
          point_end(
            p1=OperatingPointDataVapor.p_vapor,
            h1=OperatingPointDataVapor.h_vapor,
            T1=OperatingPointDataVapor.T_vapor,
            d1=OperatingPointDataVapor.d_vapor,
            s1=OperatingPointDataVapor.s_vapor));
         parameter Modelica.SIunits.SpecificEnthalpy h_offset=273291;
      equation
        state_ref=Medium_ref.setState_pT(p_input,T_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end DryAir_pTX_vapor;

      model DryAir_dTX_vapor "Compare in vapor region"
        // There is a difference in reference conditions, thereof use of h_offset
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropDryAir_vs_ModelicaMediaReferenceAir.Template.DryAir(
          properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
            d=d_input,
            T=T_input,
            Z=X_input),
          point_start(
            p1=OperatingPointDataVapor.p_vapor1,
            h1=OperatingPointDataVapor.h_vapor1,
            T1=OperatingPointDataVapor.T_vapor1,
            d1=OperatingPointDataVapor.d_vapor1,
            s1=OperatingPointDataVapor.s_vapor1),
          point_end(
            p1=OperatingPointDataVapor.p_vapor,
            h1=OperatingPointDataVapor.h_vapor,
            T1=OperatingPointDataVapor.T_vapor,
            d1=OperatingPointDataVapor.d_vapor,
            s1=OperatingPointDataVapor.s_vapor));
         parameter Modelica.SIunits.SpecificEnthalpy h_offset=273291;
      equation
        state_ref=Medium_ref.setState_dT(d_input,T_input);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end DryAir_dTX_vapor;
    end RefPropDryAir_vs_ModelicaMediaReferenceAir;

    package RefPropDryAir_vs_NativeModelicaDryAir

      package OperatingPointDataSat
         constant Modelica.SIunits.AbsolutePressure p1=1e5;
         constant Modelica.SIunits.Temperature T1=80  annotation(Dialog);

         constant Modelica.SIunits.AbsolutePressure p2=5e5;
         constant Modelica.SIunits.Temperature T2=125  annotation(Dialog);

      end OperatingPointDataSat;

      package Template
        extends MultiPhaseMixture.Icons.TemplatesPackage;
        partial model DryAirSaturation
          extends MultiPhaseMixture.Test.Templates.BaseSatTest(
            redeclare package Medium =
                MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir,
            redeclare package Medium_ref =
                MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir,
            point_start(p1=OperatingPointDataSat.p1, T1=OperatingPointDataSat.T1),
            point_end(p1=OperatingPointDataSat.p2, T1=OperatingPointDataSat.T2));

        end DryAirSaturation;
      end Template;

      model Saturation "Compare in vapor region"
        // Big difference between p_dew and p_dew_ref
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropDryAir_vs_NativeModelicaDryAir.Template.DryAirSaturation;
         parameter Modelica.SIunits.SpecificEnthalpy h_offset=273291;
        Medium.SatPhaseEquilibriumProperties bubblePoint_pX(
          F={1,0},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
          p=p_input,
          Z=X_input)
                    annotation (Placement(transformation(extent={{-32,66},{-12,86}})));
        Medium.SatPhaseEquilibriumProperties bubblePoint_TX(
          F={1,0},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T_input,
          Z=X_input)          annotation (Placement(transformation(extent={{0,66},{20,
                  86}})));
        Medium_ref.SatPhaseEquilibriumProperties bubblePoint_pX_ref(
          F={1,0},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
          p=p_input,
          Z=X_input) annotation (Placement(transformation(extent={{48,66},{68,86}})));
        Medium_ref.SatPhaseEquilibriumProperties bubblePoint_TX_ref(
          F={1,0},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T_input,
          Z=X_input) annotation (Placement(transformation(extent={{80,66},{100,86}})));

        Medium.SatPhaseEquilibriumProperties dewPoint_pX(
          F={0,1},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
          p=p_input,
          Z=X_input)
                    annotation (Placement(transformation(extent={{-32,28},{-12,48}})));
        Medium.SatPhaseEquilibriumProperties dewPoint_TX(
          F={0,1},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T_input,
          Z=X_input)          annotation (Placement(transformation(extent={{0,28},{20,
                  48}})));
        Medium_ref.SatPhaseEquilibriumProperties dewPoint_pX_ref(
          F={0,1},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
          p=p_input,
          Z=X_input) annotation (Placement(transformation(extent={{48,28},{68,48}})));
        Medium_ref.SatPhaseEquilibriumProperties dewPoint_TX_ref(
          F={0,1},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T_input,
          Z=X_input) annotation (Placement(transformation(extent={{80,28},{100,48}})));

          Modelica.SIunits.Pressure p_bubble=bubblePoint_TX.p;
          Modelica.SIunits.Pressure p_bubble_ref=bubblePoint_TX_ref.p;
          Modelica.SIunits.Temperature T_bubble=bubblePoint_pX.T;
          Modelica.SIunits.Temperature T_bubble_ref=bubblePoint_pX_ref.T;
          Modelica.SIunits.SpecificEnthalpy h_bubble=bubblePoint_pX.h_overall;
          Modelica.SIunits.SpecificEnthalpy h_bubble_ref=bubblePoint_pX_ref.h_overall;
          Modelica.SIunits.Density d_bubble=bubblePoint_pX.d_overall;
          Modelica.SIunits.Density d_bubble_ref=bubblePoint_pX_ref.d_overall;

          Modelica.SIunits.Pressure p_dew=dewPoint_TX.p;
          Modelica.SIunits.Pressure p_dew_ref=dewPoint_TX_ref.p;
          Modelica.SIunits.Temperature T_dew=dewPoint_pX.T;
          Modelica.SIunits.Temperature T_dew_ref=dewPoint_pX_ref.T;
          Modelica.SIunits.SpecificEnthalpy h_dew=dewPoint_pX.h_overall;
          Modelica.SIunits.SpecificEnthalpy h_dew_ref=dewPoint_pX_ref.h_overall;
          Modelica.SIunits.Density d_dew=dewPoint_pX.d_overall;
          Modelica.SIunits.Density d_dew_ref=dewPoint_pX_ref.d_overall;

      equation
       // state_ref=Medium_ref.setState_ph(p_input,h_input-h_offset);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Bitmap(extent={{-100,20},{100,-100}},
                  fileName="modelica://MultiPhaseMixture/Resources/Images/dryAir_phDiagram.png")}));
      end Saturation;

    end RefPropDryAir_vs_NativeModelicaDryAir;

    package RefPropDryAir_vs_CapeOpenFluidPropDryAir

      package OperatingPointData
         constant Modelica.SIunits.AbsolutePressure p_liquid=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_liquid=-100e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_liquid=92.092  annotation(Dialog);
         constant Modelica.SIunits.Density d_liquid=813.793 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_liquid=3278.59 annotation(Dialog);

         constant Modelica.SIunits.AbsolutePressure p_vapor=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor=4.35812 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

      end OperatingPointData;

      package OperatingPointDataVapor
         constant Modelica.SIunits.AbsolutePressure p_vapor1=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor1=135332 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor1=140  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor1=12.937 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor1=5621.79 annotation(Dialog);

         constant Modelica.SIunits.AbsolutePressure p_vapor=5e5;
         constant Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
         constant Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
         constant Modelica.SIunits.Density d_vapor=4.35812 annotation(Dialog);
         constant Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

      end OperatingPointDataVapor;

      package Template
        extends MultiPhaseMixture.Icons.TemplatesPackage;
        partial model DryAir
          extends MultiPhaseMixture.Test.Templates.Properties_Properties(
            redeclare package Medium =
                MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir,
            redeclare package Medium_ref =
                MultiPhaseMixture.PreDefined.Mixtures.CapeOpen.FluidProp.DryAir,
            redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
            point_start(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_liquid,
              h1=OperatingPointData.h_liquid,
              T1(displayUnit="K") = OperatingPointData.T_liquid,
              d1=OperatingPointData.d_liquid,
              s1=OperatingPointData.s_liquid),
            point_end(
            X1=Medium.reference_X,
              p1=OperatingPointData.p_vapor,
              h1=OperatingPointData.h_vapor,
              T1(displayUnit="K") = OperatingPointData.T_vapor,
              d1=OperatingPointData.d_vapor,
              s1=OperatingPointData.s_vapor));

        end DryAir;
      end Template;

      model DryAir_phX_vapor "Compare in vapor region"
        // There is a difference in reference conditions, thereof use of h_offset
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropDryAir_vs_CapeOpenFluidPropDryAir.Template.DryAir(
          properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
            p=p_input,
            h=h_input,
            Z=X_input),
          properties_ref(
            inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
            p=p_input,
            h=h_input-h_offset,
            Z=X_input),
          point_start(
            p1=OperatingPointDataVapor.p_vapor1,
            h1=OperatingPointDataVapor.h_vapor1,
            T1=OperatingPointDataVapor.T_vapor1,
            d1=OperatingPointDataVapor.d_vapor1,
            s1=OperatingPointDataVapor.s_vapor1),
          point_end(
            p1=OperatingPointDataVapor.p_vapor,
            h1=OperatingPointDataVapor.h_vapor,
            T1=OperatingPointDataVapor.T_vapor,
            d1=OperatingPointDataVapor.d_vapor,
            s1=OperatingPointDataVapor.s_vapor));

         parameter Modelica.SIunits.SpecificEnthalpy h_offset=288000;
      equation

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end DryAir_phX_vapor;

      model DryAir_pTX_vapor "Compare in vapor region"
        // There is a difference in reference conditions, thereof use of h_offset
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropDryAir_vs_CapeOpenFluidPropDryAir.Template.DryAir(
          properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
            p=p_input,
            T=T_input,
            Z=X_input),
          properties_ref(
            inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
            p=p_input,
            T=T_input,
            Z=X_input),
          point_start(
            p1=OperatingPointDataVapor.p_vapor1,
            h1=OperatingPointDataVapor.h_vapor1,
            T1=OperatingPointDataVapor.T_vapor1,
            d1=OperatingPointDataVapor.d_vapor1,
            s1=OperatingPointDataVapor.s_vapor1),
          point_end(
            p1=OperatingPointDataVapor.p_vapor,
            h1=OperatingPointDataVapor.h_vapor,
            T1=OperatingPointDataVapor.T_vapor,
            d1=OperatingPointDataVapor.d_vapor,
            s1=OperatingPointDataVapor.s_vapor));
         parameter Modelica.SIunits.SpecificEnthalpy h_offset=273291;
      equation

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end DryAir_pTX_vapor;

      model DryAir_dTX_vapor "Compare in vapor region"
        // There is a difference in reference conditions, thereof use of h_offset
        extends
          MultiPhaseMixture.Test.CompareMedia.RefPropDryAir_vs_CapeOpenFluidPropDryAir.Template.DryAir(
          properties(
            inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
            d=d_input,
            T=T_input,
            Z=X_input),
          properties_ref(
            inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
            d=d_input,
            T=T_input,
            Z=X_input),
          point_start(
            p1=OperatingPointDataVapor.p_vapor1,
            h1=OperatingPointDataVapor.h_vapor1,
            T1=OperatingPointDataVapor.T_vapor1,
            d1=OperatingPointDataVapor.d_vapor1,
            s1=OperatingPointDataVapor.s_vapor1),
          point_end(
            p1=OperatingPointDataVapor.p_vapor,
            h1=OperatingPointDataVapor.h_vapor,
            T1=OperatingPointDataVapor.T_vapor,
            d1=OperatingPointDataVapor.d_vapor,
            s1=OperatingPointDataVapor.s_vapor));

         parameter Modelica.SIunits.SpecificEnthalpy h_offset=273291;
      equation

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})));
      end DryAir_dTX_vapor;
    end RefPropDryAir_vs_CapeOpenFluidPropDryAir;
  end CompareMedia;

  package NativeModelicaDryAir
    "Tests for MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir"
    extends MultiPhaseMixture.Icons.FailureTestPackage;
    // many test models does not work and there seems to be some strange with enthalpy at OperatingPointData.p_vapor,OperatingPointData.T_vapor
    // as it is lower than corresponding liquid operating point

    package OperatingPointData
       constant Modelica.SIunits.AbsolutePressure p_liquid=5e5;
       constant Modelica.SIunits.SpecificEnthalpy h_liquid=-110662 annotation(Dialog);
       constant Modelica.SIunits.Temperature T_liquid=92.092  annotation(Dialog);
       constant Modelica.SIunits.Density d_liquid=682.66 annotation(Dialog);
       constant Modelica.SIunits.SpecificEntropy s_liquid=0 annotation(Dialog);

       constant Modelica.SIunits.AbsolutePressure p_vapor=5e5;
       // h_vapor=-330427 sp,etjomg strange as < h_liquid
       constant Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
       constant Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
       constant Modelica.SIunits.Density d_vapor=9.2317 annotation(Dialog);
       constant Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

    end OperatingPointData;

    package TestMedium =
        MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

    package Templates
        extends MultiPhaseMixture.Icons.TemplatesPackage;

      partial model MultiPhaseProperties
        extends MultiPhaseMixture.Test.Templates.MultiPhaseProperties_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end MultiPhaseProperties;

      partial model MultiPhaseProperties2
        extends MultiPhaseMixture.Test.Templates.MultiPhaseProperties2_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end MultiPhaseProperties2;

      partial model ThermoProperties
        extends MultiPhaseMixture.Test.Templates.ThermoProperties_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end ThermoProperties;

      partial model ThermoProperties2
        extends MultiPhaseMixture.Test.Templates.ThermoProperties2_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end ThermoProperties2;
    end Templates;

    model MultiPhaseProperties
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.MultiPhaseProperties2;
       extends Modelica.Icons.Example;
       extends MultiPhaseMixture.Icons.Failure;
       /*
   The model is not well posed
   */

    end MultiPhaseProperties;

    model ThermoProperties
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.ThermoProperties2;
       extends Modelica.Icons.Example;
       extends MultiPhaseMixture.Icons.Failure;
        /*
   The model is not well posed
   */
    end ThermoProperties;

    model MultiPhaseProperties_dTX
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.MultiPhaseProperties(
         multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
          d=d_input,
          T=T_input,
          Z=X_input));
      extends Modelica.Icons.Example;
      extends MultiPhaseMixture.Icons.Failure;
      // Solution to systems of equations not found at time = 0.108
    end MultiPhaseProperties_dTX;

    model ThermoProperties_dTX
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.ThermoProperties(
          properties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
          d=d_input,
          T=T_input,
          Z=X_input));
      extends Modelica.Icons.Example;
      extends MultiPhaseMixture.Icons.Failure;
      // Solution to systems of equations not found at time = 0.108
    end ThermoProperties_dTX;

    model MultiPhaseProperties_phX
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.MultiPhaseProperties(
         multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
          p=p_input,
          h=h_input,
          Z=X_input));
       extends Modelica.Icons.Example;
      extends MultiPhaseMixture.Icons.Failure;
       // Solution to systems of equations not found at time = 0.388833
    end MultiPhaseProperties_phX;

    model ThermoProperties_phX
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.ThermoProperties(
          properties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
          p=p_input,
          h=h_input,
          Z=X_input));
       extends Modelica.Icons.Example;
      extends MultiPhaseMixture.Icons.Failure;
       // Solution to systems of equations not found at time = 0.388833
    end ThermoProperties_phX;

    model MultiPhaseProperties_pTX
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.MultiPhaseProperties(
         multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
          p=p_input,
          T=T_input,
          Z=X_input));
       extends Modelica.Icons.Example;
       extends MultiPhaseMixture.Icons.Failure;
       // Solution to systems of equations not found at time = 0.108
    end MultiPhaseProperties_pTX;

    model ThermoProperties_pTX
      extends
        MultiPhaseMixture.Test.NativeModelicaDryAir.Templates.ThermoProperties(
          properties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
          p=p_input,
          T=T_input,
          Z=X_input));
       extends Modelica.Icons.Example;
      extends MultiPhaseMixture.Icons.Failure;
       // Solution to systems of equations not found at time = 0.108
    end ThermoProperties_pTX;

    model SatPhaseEquilibriumProperties
        extends Modelica.Icons.Example;
       package Medium=TestMedium;

     // parameter Modelica.SIunits.Temperature T=108;
      parameter Modelica.SIunits.MassFraction X[Medium.nC]=Medium.reference_X
        "Mass fraction in liquid phase";
      parameter Modelica.SIunits.MassFraction Y[Medium.nC]=Medium.reference_X
        "Mass fraction in vapor phase";
      parameter Modelica.SIunits.Pressure p= 250000;
      Medium.SatPhaseEquilibriumProperties bubblePoint_pX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_pY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

      Medium.SatPhaseEquilibriumProperties bubblePoint_TX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=bubblePoint_pX.T) annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_TY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=bubblePoint_TX.T) annotation (Placement(transformation(extent={{-38,-40},{-18,-20}})));
    end SatPhaseEquilibriumProperties;

    model SatPhaseEquilibriumProperties_pFZ
        extends Modelica.Icons.Example;
       package Medium=TestMedium;

     // parameter Modelica.SIunits.Temperature T=108;
      parameter Modelica.SIunits.MassFraction X[Medium.nC]=Medium.reference_X
        "Mass fraction in liquid phase";
      parameter Modelica.SIunits.MassFraction Y[Medium.nC]=Medium.reference_X
        "Mass fraction in vapor phase";
      parameter Modelica.SIunits.Pressure p= 250000;
      Medium.SatPhaseEquilibriumProperties bubblePoint_pX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_pY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

      // dew -  Z_start={0.763,0.235,0.002},
      // bubble - Z_start={0.763,0.235,0.002},

    end SatPhaseEquilibriumProperties_pFZ;

    model SatPhaseEquilibriumProperties_TFZ
        extends Modelica.Icons.Example;
       package Medium=TestMedium;

     // parameter Modelica.SIunits.Temperature T=108;
      parameter Modelica.SIunits.MassFraction X[Medium.nC]=Medium.reference_X
        "Mass fraction in liquid phase";
      parameter Modelica.SIunits.MassFraction Y[Medium.nC]=Medium.reference_X
        "Mass fraction in vapor phase";
      parameter Modelica.SIunits.Pressure p= 250000;
      Medium.SatPhaseEquilibriumProperties bubblePoint_TX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=108) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_TY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=108) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

      // dew -  Z_start={0.763,0.235,0.002},
      // bubble - Z_start={0.763,0.235,0.002},

    end SatPhaseEquilibriumProperties_TFZ;

    package AdditionalTests
      extends Modelica.Icons.ExamplesPackage;

      model ThermoProperties
        extends Modelica.Icons.Example;
         package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

      //  parameter Boolean checkPhase=Medium.checkPhases({"Vapor5"});
        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.Pressure p=11e5;
        parameter Modelica.SIunits.MassFraction Z[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction feed";

        Medium.ThermoProperties thermoProperties(
          init(p=1000000), inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
          p=100000,
          T=573.15,
          Z=Medium.reference_X)
          annotation (Placement(transformation(extent={{-64,38},{-44,58}})));
      equation

      end ThermoProperties;

      model SaturationPressure
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
        Medium.SatPhaseEquilibriumProperties bubblePoint_TX(
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T,
          Z=X,
          Z_start={0.763,0.235,0.002},
          F=Medium.createPhaseFractionVector({"Liquid"}, {1}))
          annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
        Medium.SatPhaseEquilibriumProperties dewPoint_TY(
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T,
          Z_start={0.763,0.235,0.002},
          Z=Y,
          F=Medium.createPhaseFractionVector({"Liquid"}, {0}))
          annotation (Placement(transformation(extent={{-36,0},{-16,20}})));
      end SaturationPressure;

      model SaturationPressure_bubble_TFZ
          extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
        Medium.SatPhaseEquilibriumProperties bubblePoint_TY(
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T,
          Z_start={0.763,0.235,0.002},
          Z=X,
          F=Medium.createPhaseFractionVector({"Liquid"}, {1}))
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-56,56},{52,18}},
                lineColor={28,108,200},
                textString="Creates a system of 4 unknowns, ideal is 1=pressure")}));
      end SaturationPressure_bubble_TFZ;

      model SaturationPressure_dew_TFZ
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
        Medium.SatPhaseEquilibriumProperties dewPoint_TY(
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T,
          Z_start={0.763,0.235,0.002},
          Z=Y,
          F=Medium.createPhaseFractionVector({"Vapor"}, {1}))
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-56,56},{52,18}},
                lineColor={28,108,200},
                textString="Creates a system of 4 unknowns, ideal is 1=pressure")}));
      end SaturationPressure_dew_TFZ;

      model SaturationPressure_bubble_TFN
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
        parameter Modelica.SIunits.AmountOfSubstance N[Medium.nC]={887.892,239.406,1.63206};
        Medium.SatPhaseEquilibriumProperties bubblePoint_T(
          T=T,
          Z_start={0.763,0.235,0.002},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFN,
          FN=Medium.createPhaseSubstanceVector({"Liquid"}, {1128.93}),
          N=N) annotation (Placement(transformation(extent={{14,10},{34,30}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-70,88},{38,50}},
                lineColor={28,108,200},
                textString="Creates a system of 1 unknowns, ideal is 1=pressure")}));
      end SaturationPressure_bubble_TFN;

      model SaturationPressure_dew_TFN
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
       parameter Modelica.SIunits.AmountOfSubstance N[Medium.nC]={887.892,239.406,1.63206};
        Medium.SatPhaseEquilibriumProperties dewPoint_T(
          T=T,
          Z_start={0.763,0.235,0.002},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFN,
          FN=Medium.createPhaseSubstanceVector({"Vapor"}, {1128.93}),
          N=N) annotation (Placement(transformation(extent={{14,10},{34,30}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-70,88},{38,50}},
                lineColor={28,108,200},
                textString="Creates a system of 4 unknowns, ideal is 1=pressure")}));
      end SaturationPressure_dew_TFN;

      model SaturationPressure_bubble_TFZ_mole
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MoleFraction Xm[Medium.nC]=Medium.massToMoleFractions(X,Medium.MMX);
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
       parameter Modelica.SIunits.MoleFraction Ym[Medium.nC]=Medium.massToMoleFractions(Y,Medium.MMX);

        Medium.SatPhaseEquilibriumProperties bubblePoint_T(
          T=T,
          Z_start={0.763,0.235,0.002},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ_mole,
          Fm=Medium.createPhaseFractionVector({"Liquid"}, {1}),
          Zm=Xm) annotation (Placement(transformation(extent={{14,10},{34,30}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-70,88},{38,50}},
                lineColor={28,108,200},
                textString="Creates a system of 1 unknowns, ideal is 1=pressure")}));
      end SaturationPressure_bubble_TFZ_mole;

      model SaturationPressure_dew_TFZ_mole
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MoleFraction Xm[Medium.nC]=Medium.massToMoleFractions(X,Medium.MMX);
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
       parameter Modelica.SIunits.MoleFraction Ym[Medium.nC]=Medium.massToMoleFractions(Y,Medium.MMX);
        Medium.SatPhaseEquilibriumProperties bubblePoint_T(
          T=T,
          Z_start={0.763,0.235,0.002},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ_mole,
          Zm=Ym,
          Fm=Medium.createPhaseFractionVector({"Vapor"}, {1}))
          annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-70,88},{38,50}},
                lineColor={28,108,200},
                textString="Creates a system of 4 unknowns, ideal is 1=pressure")}));
      end SaturationPressure_dew_TFZ_mole;

      model Flash
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
        parameter Integer phaseIndex=Medium.getPhaseIndex("Vapor");
      //  parameter Boolean checkPhase=Medium.checkPhases({"Vapor5"});
        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.Pressure p=11e5;
        parameter Modelica.SIunits.MassFraction Z[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction feed";

        Medium.MultiPhaseProperties flash_pTZ(
          p=p,
          T=T,
          Z=Z,
          Z_start=Z,
          presentPhases=Medium.createPresentPhaseVector({"Liquid"}),
          init(p=1000000))
          annotation (Placement(transformation(extent={{-62,38},{-42,58}})));
      end Flash;

      model Enthalpies
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
        package Gas =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir.EquationsOfState.AirFastIdealGas;
      parameter Modelica.SIunits.Temperature T_min=70;
      parameter Modelica.SIunits.Temperature T_max=140;
      Modelica.SIunits.Temperature T(start=T_min);
      parameter Modelica.SIunits.Pressure p=2e5;
      //parameter Modelica.SIunits.MassFraction[Medium.nS] X={0.755,0.232,0.013};
      parameter Modelica.SIunits.MassFraction[Medium.nC,Medium.nC] X=identity(Medium.nC);

      Modelica.SIunits.Enthalpy H_liq[Medium.nC];
      Modelica.SIunits.Enthalpy H_vap[Medium.nC];
      Modelica.SIunits.SpecificEnthalpy h_vap[Medium.nC];
      constant Medium.EquationsOfState.Data.FastGasData[
          :] data=Gas.data;
      equation
        der(T)=(T_max-T_min)*1;
        for i in 1:Medium.nC loop
        H_liq[i] = Medium.enthalpy_pTM(p,T,X[i,:],Medium.PhaseLabelLiquid);
        H_vap[i] = Medium.enthalpy_pTM(p,T,X[i,:],Medium.PhaseLabelVapor);
        //h_vap[i] = Gas.h_TX(T,X[i,:]);
        h_vap[i] = Gas.h_T(T,i);
        end for;
      end Enthalpies;

      model SaturationTemperature
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
       // parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
        Medium.SatPhaseEquilibriumProperties bubblePoint_pX(
          F={1,0},
          Z=X,
          Z_start={0.763,0.235,0.002},
          inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
          p=250000) annotation (Placement(transformation(extent={{-80,2},{-60,22}})));
        Medium.SatPhaseEquilibriumProperties dewPoint_pY(
          Z_start={0.763,0.235,0.002},
          F={0,1},
          Z=Y,
          inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
          p=250000) annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
      end SaturationTemperature;

      model CreatePhaseVector "Create phase vector"
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
        parameter Real vec[Medium.nP]=Medium.createPhaseFractionVector({"Liquid",
            "Vapor"}, {0.3,0.7});
        parameter Real vec2[Medium.nP]=Medium.createPhaseFractionVector({"Liquid"},
            {0.3});
        parameter Real vec3[Medium.nP]=Medium.createPhaseFractionVector({"Vapor"},
            {0.7});
        parameter Integer Liquid_index=Medium.getPhaseIndex("Liquid");
        parameter Integer Vapor_index=Medium.getPhaseIndex("Vapor");
      equation

      end CreatePhaseVector;

      model CreatePhaseVectorFailureWithPurpouse
        "Failure with purpose -sum of phase fraction exceeds 1"
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
        parameter Real vec[Medium.nP]=Medium.createPhaseFractionVector({"Liquid",
            "Vapor"}, {0.3,0.8});

      end CreatePhaseVectorFailureWithPurpouse;

      model PhaseLabel
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;
        Integer labelVapor=Medium.PhaseLabelVapor;
        Integer labelLiquid=Medium.PhaseLabelLiquid;
        Integer labelOverall=Medium.PhaseLabelOverall;
      equation

      end PhaseLabel;

      model SaturationPressure_bubble_TFZ_test
        extends Modelica.Icons.Example;
        package Medium =
            MultiPhaseMixture.PreDefined.Mixtures.NativeModelica.DryAir;

        parameter Modelica.SIunits.Temperature T=108;
        parameter Modelica.SIunits.MassFraction X[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in liquid phase";
        parameter Modelica.SIunits.MassFraction Y[Medium.nC]={0.763,0.235,0.002}
          "Mass fraction in vapor phase";
        Medium.SatPhaseEquilibriumProperties bubblePoint_TY(
          inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
          T=T,
          Z_start={0.763,0.235,0.002},
          Z=X,
          F=Medium.createPhaseFractionVector({"Liquid"}, {1}))
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
       Modelica.SIunits.Density d_bubble;
       Modelica.SIunits.Density d_bubble_alt;
       final parameter Integer LIQUID=Medium.getPhaseIndex("Liquid");
      equation
        d_bubble= bubblePoint_TY.d_overall;
        //alternative
        d_bubble_alt= bubblePoint_TY.d_1ph[LIQUID];
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})));
      end SaturationPressure_bubble_TFZ_test;
    end AdditionalTests;
  end NativeModelicaDryAir;

  package RefPropDryAir
    "Tests of MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir"
    package OperatingPointData
       constant Modelica.SIunits.AbsolutePressure p_liquid=5e5;
       constant Modelica.SIunits.SpecificEnthalpy h_liquid=-100e3 annotation(Dialog);
       constant Modelica.SIunits.Temperature T_liquid=92.092  annotation(Dialog);
       constant Modelica.SIunits.Density d_liquid=813.793 annotation(Dialog);
       constant Modelica.SIunits.SpecificEntropy s_liquid=3278.59 annotation(Dialog);

       constant Modelica.SIunits.AbsolutePressure p_vapor=5e5;
       constant Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
       constant Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
       constant Modelica.SIunits.Density d_vapor=4.35812 annotation(Dialog);
       constant Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

    end OperatingPointData;

    package TestMedium=MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir;

    package Templates
        extends MultiPhaseMixture.Icons.TemplatesPackage;

      partial model MultiPhaseProperties
        extends MultiPhaseMixture.Test.Templates.MultiPhaseProperties_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end MultiPhaseProperties;

      partial model MultiPhaseProperties2
        extends MultiPhaseMixture.Test.Templates.MultiPhaseProperties2_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end MultiPhaseProperties2;

      partial model ThermoProperties
        extends MultiPhaseMixture.Test.Templates.ThermoProperties_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end ThermoProperties;

      partial model ThermoProperties2
        extends MultiPhaseMixture.Test.Templates.ThermoProperties2_noRef(
          redeclare package Medium =
              TestMedium,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_liquid,
            h1=OperatingPointData.h_liquid,
            T1(displayUnit="K") = OperatingPointData.T_liquid,
            d1=OperatingPointData.d_liquid,
            s1=OperatingPointData.s_liquid),
          point_end(
          X1=Medium.reference_X,
            p1=OperatingPointData.p_vapor,
            h1=OperatingPointData.h_vapor,
            T1(displayUnit="K") = OperatingPointData.T_vapor,
            d1=OperatingPointData.d_vapor,
            s1=OperatingPointData.s_vapor));

      end ThermoProperties2;
    end Templates;

    model MultiPhaseProperties
      extends
        MultiPhaseMixture.Test.RefPropDryAir.Templates.MultiPhaseProperties2;
       extends Modelica.Icons.Example;

    end MultiPhaseProperties;

    model ThermoProperties
      extends MultiPhaseMixture.Test.RefPropDryAir.Templates.ThermoProperties2;
       extends Modelica.Icons.Example;

    end ThermoProperties;

    model MultiPhaseProperties_dTX
      extends
        MultiPhaseMixture.Test.RefPropDryAir.Templates.MultiPhaseProperties(multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
          d=d_input,
          T=T_input,
          Z=X_input));
      extends Modelica.Icons.Example;

    end MultiPhaseProperties_dTX;

    model ThermoProperties_dTX
      extends MultiPhaseMixture.Test.RefPropDryAir.Templates.ThermoProperties(
                                                                            properties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
          d=d_input,
          T=T_input,
          Z=X_input));
      extends Modelica.Icons.Example;

    end ThermoProperties_dTX;

    model MultiPhaseProperties_phX
      extends
        MultiPhaseMixture.Test.RefPropDryAir.Templates.MultiPhaseProperties(multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
          p=p_input,
          h=h_input,
          Z=X_input));
       extends Modelica.Icons.Example;

    end MultiPhaseProperties_phX;

    model ThermoProperties_phX
      extends MultiPhaseMixture.Test.RefPropDryAir.Templates.ThermoProperties(
                                                                            properties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
          p=p_input,
          h=h_input,
          Z=X_input));
       extends Modelica.Icons.Example;

    end ThermoProperties_phX;

    model MultiPhaseProperties_pTX
      extends
        MultiPhaseMixture.Test.RefPropDryAir.Templates.MultiPhaseProperties(multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
          p=p_input,
          T=T_input,
          Z=X_input));
       extends Modelica.Icons.Example;

    end MultiPhaseProperties_pTX;

    model ThermoProperties_pTX
      extends MultiPhaseMixture.Test.RefPropDryAir.Templates.ThermoProperties(
                                                                            properties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
          p=p_input,
          T=T_input,
          Z=X_input));
       extends Modelica.Icons.Example;

    end ThermoProperties_pTX;

    model GetAverageMolarMass
      extends Modelica.Icons.Example;
      package Medium=PreDefined.Mixtures.RefProp.DryAir;
      Real X[Medium.nC]=Medium.reference_X;
      Real MMX[Medium.nC]=Medium.MMX;
      Real MM;
    equation
     MM= Medium.Auxilary.getAverageMolarMass(X_unit=1,eo=Medium.eo);

    end GetAverageMolarMass;

    model GetNumberOfPhases
      extends Modelica.Icons.Example;
      package ExternalMedium =
          TestMedium;
      parameter Integer nP=ExternalMedium.getNumberOfPhases(ExternalMedium.eo);
      parameter Integer nS=ExternalMedium.getNumberOfCompounds(ExternalMedium.eo);
      parameter Integer presentPhases[:]=ExternalMedium.createPresentPhaseVector({"Vapor","Liquid"});

      //  parameter Real[nP] sdf=ones(nP); // not working for structural parameters in Dymola

    end GetNumberOfPhases;

    model EventGeneration
      // Plot nbrOfPresentPhases- is 2 at time 4-7s
      extends Modelica.Icons.Example;
      package Medium=TestMedium;
        Real T_input;
        Real T;

      Medium.ThermoProperties properties_pTX(
        Z=Medium.reference_X,
        p=100000,
        T=T_input)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Integer phases;
    equation
        der(T)=T_input-T;
     if (properties_pTX.properties.nbrOfPresentPhases == 1) then
       phases=1;
     elseif (properties_pTX.properties.nbrOfPresentPhases==2) then
       phases=2;
     else
       phases=0;
     end if;

     //   T_input=75+time;
     T_input=175-time;

    initial equation
        der(T)=0;
      annotation (experiment(StopTime=100), __Dymola_experimentSetupOutput);
    end EventGeneration;

    model SatPhaseEquilibriumProperties
        extends Modelica.Icons.Example;
       package Medium=TestMedium;

     // parameter Modelica.SIunits.Temperature T=108;
      parameter Modelica.SIunits.MassFraction X[Medium.nC]=Medium.reference_X
        "Mass fraction in liquid phase";
      parameter Modelica.SIunits.MassFraction Y[Medium.nC]=Medium.reference_X
        "Mass fraction in vapor phase";
      parameter Modelica.SIunits.Pressure p= 250000;
      Medium.SatPhaseEquilibriumProperties bubblePoint_pX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_pY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

      Medium.SatPhaseEquilibriumProperties bubblePoint_TX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=bubblePoint_pX.T) annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_TY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=bubblePoint_TX.T) annotation (Placement(transformation(extent={{-38,-40},{-18,-20}})));
    end SatPhaseEquilibriumProperties;

    model SatPhaseEquilibriumProperties_pFZ
        extends Modelica.Icons.Example;
       package Medium=TestMedium;

     // parameter Modelica.SIunits.Temperature T=108;
      parameter Modelica.SIunits.MassFraction X[Medium.nC]=Medium.reference_X
        "Mass fraction in liquid phase";
      parameter Modelica.SIunits.MassFraction Y[Medium.nC]=Medium.reference_X
        "Mass fraction in vapor phase";
      parameter Modelica.SIunits.Pressure p= 250000;
      Medium.SatPhaseEquilibriumProperties bubblePoint_pX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_pY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.pFZ,
        p=250000) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

      // dew -  Z_start={0.763,0.235,0.002},
      // bubble - Z_start={0.763,0.235,0.002},

    end SatPhaseEquilibriumProperties_pFZ;

    model SatPhaseEquilibriumProperties_TFZ
        extends Modelica.Icons.Example;
       package Medium=TestMedium;

     // parameter Modelica.SIunits.Temperature T=108;
      parameter Modelica.SIunits.MassFraction X[Medium.nC]=Medium.reference_X
        "Mass fraction in liquid phase";
      parameter Modelica.SIunits.MassFraction Y[Medium.nC]=Medium.reference_X
        "Mass fraction in vapor phase";
      parameter Modelica.SIunits.Pressure p= 250000;
      Medium.SatPhaseEquilibriumProperties bubblePoint_TX(
        F={1,0},
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=108) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Medium.SatPhaseEquilibriumProperties dewPoint_TY(
        F={0,1},
        Z=Y,
        inputs=MultiPhaseMixture.Interfaces.SatInputs.TFZ,
        T=108) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

      // dew -  Z_start={0.763,0.235,0.002},
      // bubble - Z_start={0.763,0.235,0.002},

    end SatPhaseEquilibriumProperties_TFZ;

    model GetPhaseInformation
      import MultiPhaseMixture;
      extends Modelica.Icons.Example;
      package Medium =
          TestMedium;
      constant Integer nP=Medium.nP;
       String phaseLabel[Medium.nP] "Supported phases";
       String stateOfAggregation[Medium.nP] "State of aggregation";
    equation
       (phaseLabel,stateOfAggregation)=
        MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.getPhaseInformation(
        Medium.eo);
       when (terminal()) then
         for i in 1:nP loop
           Modelica.Utilities.Streams.print("phaseLabel["+String(i)+"]="+phaseLabel[i]);
           Modelica.Utilities.Streams.print("stateOfAggregation["+String(i)+"]="+stateOfAggregation[i]);
         end for;

      end when;
    end GetPhaseInformation;

    model GetPhases
      import MultiPhaseMixture;
      extends Modelica.Icons.Example;
      package Medium = TestMedium;
      constant Integer nP=Medium.nP;
      Medium.Phases phases;
    equation
        phases=Medium.getPhases(Medium.eo);

    //    when (terminal()) then
    //      for i in 1:nP loop
    //        Modelica.Utilities.Streams.print("phaseLabel["+String(i)+"]="+phaseLabel[i]);
    //        Modelica.Utilities.Streams.print("stateOfAggregation["+String(i)+"]="+stateOfAggregation[i]);
    //      end for;
    //   end when;
    end GetPhases;
  end RefPropDryAir;

  package CapeOpenFluidPropDryAir
    "Tests for MultiPhaseMixture.PreDefined.Mixtures.CapeOpen.FluidProp.DryAir"
    extends MultiPhaseMixture.Icons.FailureTestPackage;
    // Currently some problem with the external lib files
    package Templates
        extends MultiPhaseMixture.Icons.TemplatesPackage;

      partial model RefProp_DryAir
        extends MultiPhaseMixture.Test.Templates.MultiPhaseProperties_noRef(
          redeclare package Medium =
              MultiPhaseMixture.PreDefined.Mixtures.CapeOpen.FluidProp.DryAir,
          redeclare MultiPhaseMixture.Visualizers.Ph_DryAir_0to60bar phDiagram,
          point_start( h1=-100e3,
          p1=5e5,
          T1(displayUnit="K") = 202.22,
          d1=8.7,
          s1=6.0044e3,
          X1=Medium.reference_X),
          point_end(
          h1=400e3,
          p1=5e5,
          T1(displayUnit="K") = 399.17,
          d1=4.3581,
          s1=6695.2,
          X1=Medium.reference_X));

      end RefProp_DryAir;
    end Templates;

    model DryAir_dTX
      extends
        MultiPhaseMixture.Test.CapeOpenFluidPropDryAir.Templates.RefProp_DryAir(
          multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.dTX,
          d=d_input,
          T=T_input,
          Z=X_input));
     extends MultiPhaseMixture.Icons.Failure; // dymosim.exe crash

    end DryAir_dTX;

    model DryAir_phX
      extends
        MultiPhaseMixture.Test.CapeOpenFluidPropDryAir.Templates.RefProp_DryAir(
          multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.phX,
          p=p_input,
          h=h_input,
          Z=X_input),
        point_start(h1=-2618.95),
        point_end(h1=2423.5));

    end DryAir_phX;

    model DryAir_pTX
      extends
        MultiPhaseMixture.Test.CapeOpenFluidPropDryAir.Templates.RefProp_DryAir(
          multiPhaseProperties(
          inputs=MultiPhaseMixture.Interfaces.Inputs.pTX,
          p=p_input,
          T=T_input,
          Z=X_input));

    end DryAir_pTX;

    model CompareAgainstRefProp
      import MultiPhaseMixture;
      extends Modelica.Icons.Example;
      package Medium =
          MultiPhaseMixture.PreDefined.Mixtures.CapeOpen.FluidProp.DryAir;
      package Medium_ref=MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir;
      parameter Modelica.SIunits.Temperature T=300;
      parameter Modelica.SIunits.Pressure p=1e5;

      Real X[Medium.nC]=Medium.reference_X;
        Medium.MultiPhaseProperties multiPhaseProperties(
        p=p,
        T=T,
        Z=Medium.reference_X)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        Medium_ref.MultiPhaseProperties multiPhaseProperties_ref(
        p=p,
        T=T,
        Z=Medium.reference_X)
        annotation (Placement(transformation(extent={{-18,60},{2,80}})));
    equation

    end CompareAgainstRefProp;

    model SingleCalc
        extends Modelica.Icons.Example;

      PreDefined.Mixtures.CapeOpen.FluidProp.DryAir.MultiPhaseProperties
        multiPhaseProperties(
        Z={0.763,0.235,0.002},
        p=250000,
        T(displayUnit="K") = 108)
        annotation (Placement(transformation(extent={{-80,42},{-60,62}})));
    end SingleCalc;

    model GetPhaseInformation
      import MultiPhaseMixture;
      extends Modelica.Icons.Example;
      package Medium =
          MultiPhaseMixture.PreDefined.Mixtures.CapeOpen.FluidProp.DryAir;
      constant Integer nP=Medium.nP;
       String phaseLabel[Medium.nP] "Supported phases";
       String stateOfAggregation[Medium.nP] "State of aggregation";
    equation
       (phaseLabel,stateOfAggregation)=
        MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.getPhaseInformation(
        Medium.eo);
       when (terminal()) then
         for i in 1:nP loop
           Modelica.Utilities.Streams.print("phaseLabel["+String(i)+"]="+phaseLabel[i]);
           Modelica.Utilities.Streams.print("stateOfAggregation["+String(i)+"]="+stateOfAggregation[i]);
         end for;

      end when;
    end GetPhaseInformation;
  end CapeOpenFluidPropDryAir;

  package VerifyDerivatives
    extends MultiPhaseMixture.Icons.TestPackage;
    model VerifyDensityDerivatives_DryAir "Verify derivatives numerically"
        /*
    This model test derivatives numerically
  */

      package Medium=MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir;

       MultiPhaseMixture.Test.Internal.OperatingPoint point_start(X1=Medium.reference_X,
        p1=p_liquid,
        h1=h_liquid,
        T1=T_liquid,
        d1=d_liquid,
        s1=s_liquid)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

      MultiPhaseMixture.Test.Internal.OperatingPoint point_end(X1={0.7,0.1,0.2},
        p1=p_vapor,
        h1=h_vapor,
        T1=T_vapor,
        d1=d_vapor,
        s1=s_vapor)
        annotation (choicesAllMatching, Placement(transformation(extent={{-62,78},{-42,98}})));

      // Defining two operating points to sweep between
       parameter Modelica.SIunits.AbsolutePressure p_liquid=5e5;
       parameter Modelica.SIunits.SpecificEnthalpy h_liquid=-110662 annotation(Dialog);
       parameter Modelica.SIunits.Temperature T_liquid=92.092  annotation(Dialog);
       parameter Modelica.SIunits.Density d_liquid=682.66 annotation(Dialog);
       parameter Modelica.SIunits.SpecificEntropy s_liquid=0 annotation(Dialog);

       parameter Modelica.SIunits.AbsolutePressure p_vapor=5e5;
       parameter Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
       parameter Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
       parameter Modelica.SIunits.Density d_vapor=9.2317 annotation(Dialog);
       parameter Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

       // Inputs to functions
       Modelica.SIunits.Pressure p_input;
       Modelica.SIunits.SpecificEnthalpy h_input;
       Modelica.SIunits.Temperature T_input;
       Modelica.SIunits.Density d_input;
       Modelica.SIunits.SpecificEntropy s_input;
       Modelica.SIunits.MassFraction[Medium.nC] X_input;

      // Result variables
       Medium.Auxilary.Properties properties;
       Modelica.SIunits.SpecificInternalEnergy u;
       Modelica.SIunits.SpecificInternalEnergy u_integrated;
       Modelica.SIunits.Density d;
       Modelica.SIunits.Density d_integrated;
       Modelica.SIunits.Density d_integrated2;
       Real ddph;
       Real ddhp;
       Real dddX[Medium.nC];

    equation
        p_input=point_start.p1+(point_end.p1-point_start.p1)*time/1;
        h_input=point_start.h1+(point_end.h1-point_start.h1)*time/1;
        T_input=point_start.T1+(point_end.T1-point_start.T1)*time/1;
        d_input=point_start.d1+(point_end.d1-point_start.d1)*time/1;
        s_input=point_start.s1+(point_end.s1-point_start.s1)*time/1;
        X_input=point_start.X1+(point_end.X1-point_start.X1)*time/1;

        properties=Medium.Auxilary.calcProperties_phX(p=p_input,h=h_input,X=X_input,X_unit=1,phase=0,eo=Medium.eo);

        // Test of specificInternalEnergy_phX_der: u and u_integrated should be equal if specificInternalEnergy_phX_der is correct
        u=Medium.Auxilary.Wrapper_phX.specificInternalEnergy_phX(p=p_input,h=h_input,X=X_input,state=properties,eo=Medium.eo);
        der(u_integrated)=Medium.Auxilary.Wrapper_phX.specificInternalEnergy_phX_der(p=p_input,h=h_input,X=X_input,state=properties,eo=Medium.eo,
          p_der=der(p_input),h_der=der(h_input),X_der=der(X_input));

        // Test of density_phX_der: d and d_integrated should be equal if density_phX_der is correct
        d=Medium.Auxilary.Wrapper_phX.density_phX(p=p_input,h=h_input,X=X_input,state=properties,eo=Medium.eo);
        der(d_integrated)=Medium.Auxilary.Wrapper_phX.density_phX_der(p=p_input,h=h_input,X=X_input,state=properties,eo=Medium.eo,
          p_der=der(p_input),h_der=der(h_input),X_der=der(X_input));

        // Test of density_derh_p_phX, density_derp_h_phX and density_derX_ph_phX: d and d_integrated2 should be equal
        ddph=Medium.Auxilary.Wrapper_phX.density_derp_h_phX(p=p_input,h=h_input,X=X_input,state=properties,eo=Medium.eo);
        ddhp=Medium.Auxilary.Wrapper_phX.density_derh_p_phX(p=p_input,h=h_input,X=X_input,state=properties,eo=Medium.eo);
        dddX=Medium.Auxilary.Wrapper_phX.density_derX_ph_phX(p=p_input,h=h_input,X=X_input,state=properties,eo=Medium.eo);
        der(d_integrated2)=ddph*der(p_input)+ddhp*der(h_input)+dddX*der(X_input);

    initial equation
        u_integrated=u;
        d_integrated=d;
        d_integrated2=d;

    end VerifyDensityDerivatives_DryAir;

    model VerifyPartialDerivativesVapor_DryAir "Verify derivatives numerically"
        /*
    This model test derivatives numerically
  */

      package Medium=MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir;

       MultiPhaseMixture.Test.Internal.OperatingPoint point(X1=Medium.reference_X,
        p1=p_vapor,
        h1=h_vapor,
        T1=T_vapor,
        d1=d_vapor,
        s1=s_vapor)
        annotation (choicesAllMatching, Placement(transformation(extent={{-98,78},{-78,98}})));

       constant Modelica.SIunits.AbsolutePressure p_vapor=5e5;
       constant Modelica.SIunits.SpecificEnthalpy h_vapor=400e3 annotation(Dialog);
       constant Modelica.SIunits.Temperature T_vapor=399.172  annotation(Dialog);
       constant Modelica.SIunits.Density d_vapor=9.2317 annotation(Dialog);
       constant Modelica.SIunits.SpecificEntropy s_vapor=6695.22 annotation(Dialog);

       // Inputs to functions
       Modelica.SIunits.Pressure p_input;
       Modelica.SIunits.SpecificEnthalpy h_input;
       Modelica.SIunits.Temperature T_input;
       Modelica.SIunits.Density d_input;
       Modelica.SIunits.SpecificEntropy s_input;
       Modelica.SIunits.MassFraction[Medium.nC] X_input;

         // Result variables
       Medium.Auxilary.Properties properties;
       Medium.Auxilary.Properties properties_dT;
       Medium.Auxilary.Properties properties_dd;
       Real dpdT;
       Real dpdT_numerical;
       Real dpdd;
       Real dpdd_numerical;

       // Numerical
       Real T_eps=0.01;
       Real d_eps=0.001;

    equation
            assert(properties.nbrOfPresentPhases == 1, "Number of phases is not 1");
        p_input=point.p1;
        h_input=point.h1;
        T_input=point.T1;
        d_input=point.d1;
        s_input=point.s1;
        X_input=point.X1;

        properties=Medium.Auxilary.calcProperties_dTX(d=d_input,T=T_input,X=X_input,X_unit=Medium.UnitBasis.MassFraction,phase=0,eo=Medium.eo);
        properties_dT=Medium.Auxilary.calcProperties_dTX(d=d_input,T=T_input+T_eps,X=X_input,X_unit=Medium.UnitBasis.MassFraction,phase=0,eo=Medium.eo);
        properties_dd=Medium.Auxilary.calcProperties_dTX(d=d_input+d_eps,T=T_input,X=X_input,X_unit=Medium.UnitBasis.MassFraction,phase=0,eo=Medium.eo);

        dpdT=properties.dpdT_dN_1ph[integer(properties.presentPhaseIndex[1])];
        dpdT_numerical=(properties_dT.p_overall-properties.p_overall)/T_eps;
        dpdd=properties.dpdd_TN_1ph[integer(properties.presentPhaseIndex[1])];
        dpdd_numerical=(properties_dd.p_overall-properties.p_overall)/d_eps;
    end VerifyPartialDerivativesVapor_DryAir;
  end VerifyDerivatives;

  package ImplicitEquationSystem
      extends MultiPhaseMixture.Icons.TestPackage;

    model TestNonlinear "Test of implicit media calculation"
      extends Modelica.Icons.Example;
      replaceable package Medium =
          MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir                                            constrainedby
        MultiPhaseMixture.Interfaces                        annotation(choicesAllMatching=true);
      Medium.Properties medium(
        p=p,
        T=T,
        Z=X,
        inputs=MultiPhaseMixture.Interfaces.Inputs.pTX)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

     Modelica.SIunits.Pressure p;
     Modelica.SIunits.Temperature T;
     Modelica.SIunits.MassFraction X[Medium.nC];
     Modelica.SIunits.Density d;
    equation
      // Test to create a non-linear system and solving for T implicit due to
      // d is known
      // This is something that's possible to do with Modelica.Media
      // Dymola creates 1 mixed real/discrete equation
      p=1e5;
    //T=300;
      X=Medium.reference_X;
      d=1.1613+time/1000;
      d=medium.d;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-94,86},{94,72}},
              lineColor={0,0,255},
              textString="Dymola creates 1 mixed real/discrete equation")}));
    end TestNonlinear;
  end ImplicitEquationSystem;
  annotation (Documentation(info="<html>
<p>Test package for Medium models.</p>
</html>"));
end Test;
