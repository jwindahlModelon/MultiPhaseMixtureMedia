within MultiPhaseMixture;
package Interfaces "Multi-phase multi-component interface"
  extends Modelica.Icons.InterfacesPackage;
  constant String mediumName="unusablePartialMedium" "Name of the medium";
  constant String substanceNames[:]={mediumName} "Array of substance names";

  final constant Integer nC=size(substanceNames, 1) "Number of compounds"
    annotation (Evaluate=true);
    //  constant Compound compounds[nC]; // TODO
  constant Modelica.SIunits.MolarMass[nC] MMX
  "Array of molar mass for each compound";
  constant Integer nP=2 "Number of potential phases";
  constant Phases phases "List of supported phases with additional information";
  constant Modelica.SIunits.MassFraction[nC] reference_X=fill(1/nC,nC)
  "Reference mass fractions";
  constant Modelica.SIunits.MoleFraction[nC] reference_Y=fill(1/nC,nC)
  "Reference molar fraction";

  constant Modelica.SIunits.AbsolutePressure p_default=101325
  "Default value for pressure of medium (for initialization)";
  constant Modelica.SIunits.Temperature T_default=300
  "Default value for temperature of medium (for initialization)";

  constant Boolean excludeEnthalpyOfFormation=true
  "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant Boolean externalEquilibriumSolver
  "External equilibrium solver provided, may be used to have a different application implementation";
  constant Integer PhaseLabelLiquid= getPhaseIndex("Liquid")
  "Index of phase Liquid";
  constant Integer PhaseLabelOverall=0 "Overall phase label";
  constant Integer PhaseLabelVapor= getPhaseIndex("Vapor")
  "Index of phase Vapor";













  replaceable partial model ActivityCoefficient "Activity coefficient"
    input Modelica.SIunits.Pressure p "Pressure" annotation (Dialog(group="Inputs"));
    input Modelica.SIunits.Temperature T "Temperature" annotation (Dialog(group="Inputs"));
    input Modelica.SIunits.Density d "Density" annotation (Dialog(group="Inputs"));
    input Modelica.SIunits.AmountOfSubstance[nC] N_1ph
    "Molar substance for the specified phase"   annotation (Dialog(group="Inputs"));
    input Integer phaseLabel=PhaseLabelLiquid "Phase label" annotation (Dialog(group="Inputs"));
    output Real gamma[nC](each unit="1")
    "Activity coefficients for specified phase";
  equation

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),
                     graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={85,170,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=20), Text(
            extent={{-64,74},{66,-68}},
            lineColor={28,108,200},
            textString="A")}),
                        Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model that calculates the activity coefficient for each phase. To avoid an extra iteration (the activity coefficient may be a function of p,T or d,T) the inputs are p,T,d and overall molar substance for the specified phase.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p><b>Overview</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">In a solution the activity coefficent is a measure of how much the mixture differs from an ideal solution. For an ideal solution the activity coefficent gamma=1.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; font-size: 7pt;\">Definition</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">gamma_i=f_i/(xi*f0_i)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">where</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">f_i= fugacity of component i in mixture</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">xi=mole fraction of species i in vapor phase</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">f0_i= standard fugacity of pure component i</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; font-size: 7pt;\">Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The acitivity coefficient is used as an alternative to an equation of state method to derive properties for calculation of phase equilibrium. It&apos;s typically used for highly-nonlinear liquids at low pressure such as alcohol-water mixtures where equation of states methods such as Redlich-Kwong-Soave don&apos;t give satisfactory result.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p><b>References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">[1] Chemical Engineering Therodynamics, Pradeep Ahuja, 2009,</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">[2] Aspen Physical Property System, Physical Property Methods and Models 11.1</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p>Note</span></p>
</html>"));
  end ActivityCoefficient;



    partial model BaseProperties

      parameter Inputs inputs=Inputs.pTX
        annotation (Dialog(group="Inputs"), Evaluate);

    //   input Modelica.SIunits.AbsolutePressure p_input(start=init.p)=p_default
    //     "Absolute pressure" annotation (Dialog(group="Inputs",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
    //     inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.phY
    //     or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
    //   input Modelica.SIunits.Temperature T_input( start=init.T)=T_default
    //     "Temperature"  annotation (Dialog(group="Inputs",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
    //     inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
    //     or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
    //   input Modelica.SIunits.Density d_input=0 "Density" annotation (Dialog(group="Inputs - mass based",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
    //   inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
    //   input Modelica.SIunits.SpecificEnthalpy h_input=0 "Specific enthalpy"
    //                         annotation (Dialog(group="Inputs - mass based",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
    //                         inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
    //   input Modelica.SIunits.MassFraction[nS] Z_input=reference_X
    //     "Overall mass fractions (= (component mass)/total mass  m_i/m)" annotation (Dialog(group="Inputs - mass based",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or
    //     inputs==MultiPhaseMixture.Interfaces.Inputs.phX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
    //
    //   input Modelica.SIunits.MolarDensity dm_input=0 "Molar density" annotation (Dialog(group="Inputs - mole based",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
    //   or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
    //   input Modelica.SIunits.MolarEnthalpy hm_input=0 "Molar enthalpy of medium"
    //                                annotation (Dialog(group="Inputs - mole based",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phY or
    //                     inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
    //   input Modelica.SIunits.MoleFraction[nS] Zm_input=reference_Y
    //     "Overall mole fractions (= (component mole)/total mole  mole_i/moles)"  annotation(Dialog(group="Inputs - mole based",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or
    //     inputs==Inputs.phY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY));
    //   input Modelica.SIunits.AmountOfSubstance[nS] N_input=reference_Y*1
    //     "Overall molar substance (= component mole)" annotation (Dialog(group="Inputs - mole based",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or
    //     inputs==MultiPhaseMixture.Interfaces.Inputs.phN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
    //   Modelica.SIunits.Density d "Density";
    //   Modelica.SIunits.MassFraction[nS] Z
    //     "Overall mass fractions (= (component mass)/total mass  m_i/m)";
    //
    //   // Molar-based properties
    //   Modelica.SIunits.MolarEnthalpy hm "Molar enthalpy";
    //   Modelica.SIunits.AbsolutePressure p(start=init.p)
    //     "Absolute pressure of medium";
    //   Modelica.SIunits.Temperature T(start=init.T) "Temperature";
    //
    //     Modelica.SIunits.MolarDensity dm "Molar density";
    //   Modelica.SIunits.MoleFraction[nS] Zm
    //     "Overall mole fractions (= (component mole)/total mole  m_i/m)";
    //   Modelica.SIunits.SpecificEnthalpy  h "Specific enthalpy";

      InputAbsolutePressure p(start=init.p) "Absolute pressure"
                            annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
        inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.phY
        or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
      Modelica.SIunits.Temperature T( start=init.T) "Temperature"
                       annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
        inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
        or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
      Modelica.SIunits.Density d "Density" annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
      inputs==MultiPhaseMixture.Interfaces.Inputs.dhX or inputs==MultiPhaseMixture.Interfaces.Inputs.duX));
      InputSpecificEnthalpy h "Specific enthalpy"
                            annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
                            inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
      InputMassFraction[nC] Z
    "Overall mass fractions (= (component mass)/total mass  m_i/m)"     annotation (Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or
        inputs==MultiPhaseMixture.Interfaces.Inputs.phX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX
        or inputs==MultiPhaseMixture.Interfaces.Inputs.dhX or inputs==MultiPhaseMixture.Interfaces.Inputs.duX));

      Modelica.SIunits.MolarDensity dm "Molar density" annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
      or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN or inputs==MultiPhaseMixture.Interfaces.Inputs.duY or  inputs==MultiPhaseMixture.Interfaces.Inputs.duN));
      Modelica.SIunits.MolarEnthalpy hm "Molar enthalpy of medium"
                                   annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phY or
                        inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
      Modelica.SIunits.MoleFraction[nC] Zm
    "Overall mole fractions (= (component mole)/total mole  mole_i/moles)"      annotation(Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or
        inputs==Inputs.phY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY or inputs==MultiPhaseMixture.Interfaces.Inputs.duY));
      Modelica.SIunits.AmountOfSubstance[nC] N
    "Overall molar substance (= component mole)"     annotation (Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or
        inputs==MultiPhaseMixture.Interfaces.Inputs.phN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN or inputs==MultiPhaseMixture.Interfaces.Inputs.duN));

    //  // Mass-based properties

       Modelica.SIunits.SpecificInternalEnergy u
    "Specific internal energy of medium"      annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.duX));
       Modelica.SIunits.MolarInternalEnergy um
    "Molar internal energy of medium"                                                                           annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.duY or
                        inputs==MultiPhaseMixture.Interfaces.Inputs.duN));

      Modelica.SIunits.MolarMass MM "Molar mass";

      parameter Boolean checkValidity=true "Check validity limits" annotation(Dialog(group="Validity check"));
      parameter FlashProperties init(p=p_default,T=T_default,x=fill(reference_Y,nP),Z=fill(1/nP,nP)) annotation(Dialog(tab="Guess values"));

    // protected
    //       final parameter Boolean presentPhasesCheck=checkPhaseNames(init.presentPhases)
    //     "Check of present phases";
    // initial equation
    //    assert(presentPhasesCheck,"Check of present phases failed");

        // Local connector definition, used for equation balancing check
        connector InputAbsolutePressure = input
      Modelica.SIunits.AbsolutePressure "Pressure as input signal connector";
        connector InputSpecificEnthalpy = input
      Modelica.SIunits.SpecificEnthalpy
    "Specific enthalpy as input signal connector";
        connector InputMassFraction = input Modelica.SIunits.MassFraction
    "Mass fraction as input signal connector";
        connector InputDensity = input Modelica.SIunits.Density
    "Density as input signal connector";
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={85,170,255},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            radius=20),
          Polygon(
            points={{-58,-94},{62,-94},{82,-84},{22,6},{22,82},{28,82},{28,88},{-24,88},
                  {-24,82},{-18,82},{-18,6},{-78,-84},{-58,-94}},
            lineColor={85,170,255},
            smooth=Smooth.None,
            lineThickness=0.5),
          Polygon(
            points={{-64,-80},{-56,-84},{62,-84},{68,-80},{20,-6},{-16,-6},{-64,-80}},
            lineColor={28,62,255},
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={37,51,255},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{60,-76},{52,-80},{4,-80},{48,-76},{48,-74},{32,-40},{60,-76}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,-106},{100,-126}},
            lineColor={51,105,155},
            lineThickness=0.5,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="%name")}),    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Partial base model. This model should not be used by a user.</span></p>
</html>"));
    end BaseProperties;


  replaceable partial model CriticalProperties "Critical properties"
    input Modelica.SIunits.AmountOfSubstance[nC] N "Overall molar substance"
                        annotation (Dialog(group="Inputs"));
    output Modelica.SIunits.Pressure pc "Critical Absolute pressure of medium";
    output Modelica.SIunits.SpecificEnthalpy hc
    "Critical specific enthalpy of medium";
    output Modelica.SIunits.Density dc "Critical density of medium";
    output Modelica.SIunits.Temperature Tc "Critical temperature of medium";

    annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={85,170,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=20), Text(
            extent={{-64,68},{66,-74}},
            lineColor={28,108,200},
            textString="C")}),
                        Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model that calculates properties at the critical point as a function of overall molar substance.</span></p>
<h4>Critical properties for a mixture</h4>
<p>The definition of a critical point for a mixture differs slightly from a pure fluid. For mixtures the critical point is the highest temperature at which total liquid phase can exist. The highest temperature at which two phases can coexist is called the cricondentherm and the highest pressure that two phases can coexist is called cricondenbar, see image below.</p>
<p>A process that operate at a higher temperature then the cricondentherm will never condense liquid and a process that operate at a higher pressure then the cricondenbar will never be in the twophase zone.</p>
<p><br><br><img src=\"modelica://MultiPhaseMixture/Resources/Images/phaseDiagram.png\"/></p>
<h4>References</h4>
<p><span style=\"font-family: MS Shell Dlg 2;\">[1] Chemical Engineering Therodynamics, Pradeep Ahuja, 2009,</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">[2] http://www.jmcampbell.com/tip-of-the-month/2005/07/areas-of-risk-in-the-operation-or-design/</span></p>
</html>"));
  end CriticalProperties;


  replaceable partial model Fugacity
    input Modelica.SIunits.Pressure p "Pressure" annotation (Dialog(group="Inputs"));
    input Modelica.SIunits.Temperature T "Temperature" annotation (Dialog(group="Inputs"));
    input Modelica.SIunits.Density d "Density" annotation (Dialog(group="Inputs"));
    input Modelica.SIunits.AmountOfSubstance[nC] N_1ph
    "Molar substance for the specified phase"   annotation (Dialog(group="Inputs"));
    input Integer phaseLabel=PhaseLabelVapor "Phase label" annotation (Dialog(group="Inputs"));
    output Modelica.SIunits.Pressure f[nC] "Fugacity";
    output Real phi[nC](each unit="1") "Fugacity coefficients";
    output Real log_phi[nC] "Natural logarithm of fugacity coefficients";
  equation

    annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={85,170,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=20), Text(
            extent={{-64,68},{66,-74}},
            lineColor={28,108,200},
            textString="F")}),
                        Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model that calculates the fugacity coefficient for each phase. To avoid an extra iteration (the fugacitymay be a function of p,T or d,T) the inputs are p,T,d and overall molar substance for the specified phase.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p><b>Background information</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p>Fugacity is the effective pressure which replaces the true mechanical pressure in accurate chemical equilibrium calculations.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; font-size: 7pt;\">Definition</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The fugacity of species i in a mixture, is defined with reference to the ideal gas mixture as follows:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p>f_i(T,P,x)=x_i*P*exp*(1/(RT)*integral_0_to_P(V_i-V_i_IGM)dp)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p>Fugacities can be determined from an equation of state or determined experimentally. When the pressure goes to zero all mixtures become ideal gas mixtures. </span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Fugacities or more often the logFugacityCoefficient arises often in thermodynamic models due to it&apos;s part of one of rthe criteria for phase equilibrium:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">f_i_V=f_i_L (fugacity of component i in all present phases should be equal)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p>The logarithmic fugacity coefficient is the natural quantity that arises from most thermodynamic models of mixtues . Unlike the fugacity itself this quantity is also well-concentration of a compound and the logarithmic form allows a wider range of numerical values to be represented [2]</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">[1] Chemical and engineering thermodynamics, third edition, Stanley I. Sandler</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">[2] CAPE-OPEN, Thermodynamic and Physical Properties v1.1</span></p>
</html>"));
  end Fugacity;


  replaceable partial model Properties
   extends BaseProperties;
   input Integer phaseLabel=PhaseLabelOverall "Phase label" annotation (Dialog(group="Inputs"));
   Modelica.SIunits.SpecificEntropy s "Specific entropy";
   Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity cp";
   Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity cv";

   Modelica.SIunits.PrandtlNumber Pr "Prandtl number";
   Modelica.SIunits.VelocityOfSound a "Velocity of sound";
   Modelica.SIunits.CubicExpansionCoefficient beta
    "Isobaric expansion coefficient";

   Modelica.SIunits.DerDensityByEnthalpy ddhp
    "Derivative of density wrt enthalpy at constant pressure";
   Modelica.SIunits.DerDensityByPressure ddph
    "Derivative of density wrt pressure at constant enthalpy";
   Modelica.SIunits.DynamicViscosity eta "Dynamic viscosity";
   Modelica.SIunits.Compressibility kappa "Compressibility";
   Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
   FlashProperties flashProps "Flash properties";

   // Molar properties
   Modelica.SIunits.MolarEntropy sm "Molar entropy";
   Modelica.SIunits.MolarHeatCapacity cpm "Molar heat capacity cp";
   Modelica.SIunits.MolarHeatCapacity cvm "Molar heat capacity cv";
    annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model that calculates overall properties. For example of usage see <a href=\"modelica://MultiPhaseMixture.Information.UsersGuide.OverallProperties\">MultiPhaseMixture.Information.UsersGuide.OverallProperties</a>.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Balancing equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">In order for a model to be valid the user need to specify the value for 2 inputs + one composition vector. The input connector qualifier applied to p, h, and Z indirectly declares the number of missing equations, permitting advanced equation balance checking by a Modelica tool. For further information, see Section 4.7 (Balanced Models) of the Modelica 3.0 specification.</span></p>
</html>"));
  end Properties;


  replaceable partial model MultiPhaseProperties
   extends BaseMultiPhaseProperties;
    import MultiPhaseMixture.Types.PresentPhasesStatus;
    parameter Integer presentPhases[:]=createPresentPhaseVector(phases.label)
    "Possible present phases"   annotation(Dialog(tab="Optimization",
          group="Equilibrium calculation"));
    parameter PresentPhasesStatus presentPhasesStatus=PresentPhasesStatus.Unknown
    "Status of possible present phases"   annotation(Dialog(tab="Optimization",
          group="Equilibrium calculation"));
    parameter Inputs inputs=Inputs.pTX
        annotation (Dialog(group="Inputs"), Evaluate);
  //     InputAbsolutePressure p(start=init.p) "Absolute pressure of medium" annotation (Dialog(group="Inputs",enable=inputs==1 or inputs==2 or inputs==4));
  //     InputSpecificEnthalpy h "Specific enthalpy of medium" annotation (Dialog(group="Inputs",enable=inputs==2));
  //     Modelica.SIunits.Density d "Density of medium" annotation (Dialog(group="Inputs",enable=inputs==3));
  //     Modelica.SIunits.Temperature T(start=init.T) "Temperature of medium" annotation (Dialog(group="Inputs",enable=inputs==1 or inputs==3));
  //     input Modelica.SIunits.MassFraction[nS] Z=reference_X
  //     "Overall mass fractions (= (component mass)/total mass  m_i/m)"   annotation (Dialog(group="Inputs"));
  //     Modelica.SIunits.SpecificInternalEnergy u
  //     "Specific internal energy of medium";

    InputAbsolutePressure p(start=init.p) "Absolute pressure"
                          annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
      inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.phY
      or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
    Modelica.SIunits.Temperature T( start=init.T) "Temperature"
                     annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
      inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
      or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
    Modelica.SIunits.Density d "Density" annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
    inputs==MultiPhaseMixture.Interfaces.Inputs.dhX or inputs==MultiPhaseMixture.Interfaces.Inputs.duX));
    InputSpecificEnthalpy h "Specific enthalpy"
                          annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
                          inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
    InputMassFraction[nC] Z
    "Overall mass fractions (= (component mass)/total mass  m_i/m)"   annotation (Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or
      inputs==MultiPhaseMixture.Interfaces.Inputs.phX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX
      or inputs==MultiPhaseMixture.Interfaces.Inputs.dhX or inputs==MultiPhaseMixture.Interfaces.Inputs.duX));

    Modelica.SIunits.MolarDensity dm "Molar density" annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
    or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN or inputs==MultiPhaseMixture.Interfaces.Inputs.duY or  inputs==MultiPhaseMixture.Interfaces.Inputs.duN));
    Modelica.SIunits.MolarEnthalpy hm "Molar enthalpy of medium"
                                 annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phY or
                      inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
    Modelica.SIunits.MoleFraction[nC] Zm
    "Overall mole fractions (= (component mole)/total mole  mole_i/moles)"    annotation(Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or
      inputs==Inputs.phY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY or inputs==MultiPhaseMixture.Interfaces.Inputs.duY));
    Modelica.SIunits.AmountOfSubstance[nC] N
    "Overall molar substance (= component mole)"   annotation (Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or
      inputs==MultiPhaseMixture.Interfaces.Inputs.phN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN or inputs==MultiPhaseMixture.Interfaces.Inputs.duN));

  //  // Mass-based properties

     Modelica.SIunits.SpecificInternalEnergy u
    "Specific internal energy of medium"    annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.duX));
     Modelica.SIunits.MolarInternalEnergy um "Molar internal energy of medium"                                annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.duY or
                      inputs==MultiPhaseMixture.Interfaces.Inputs.duN));

  //    InputAbsolutePressure p(start=init.p) "Absolute pressure"
  //                         annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
  //     inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.phY
  //     or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
  //   Modelica.SIunits.Temperature T( start=init.T) "Temperature"
  //                    annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
  //     inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
  //     or inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
  //   Modelica.SIunits.Density d "Density" annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or
  //   inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
  //   InputSpecificEnthalpy h "Specific enthalpy"
  //                         annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phX or
  //                         inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
  //   InputMassFraction[nC] Z
  //     "Overall mass fractions (= (component mass)/total mass  m_i/m)" annotation (Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTX or
  //     inputs==MultiPhaseMixture.Interfaces.Inputs.phX or inputs==MultiPhaseMixture.Interfaces.Inputs.dTX or inputs==MultiPhaseMixture.Interfaces.Inputs.dhX));
  //
  //   Modelica.SIunits.MolarDensity dm "Molar density" annotation (Dialog(group="Inputs - mass/mole related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.dTY
  //   or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
  //   Modelica.SIunits.MolarEnthalpy hm "Molar enthalpy of medium"
  //                                annotation (Dialog(group="Inputs - energy related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.phY or
  //                     inputs==MultiPhaseMixture.Interfaces.Inputs.phN));
  //   Modelica.SIunits.MoleFraction[nC] Zm
  //     "Overall mole fractions (= (component mole)/total mole  mole_i/moles)"  annotation(Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTY or
  //     inputs==Inputs.phY or inputs==MultiPhaseMixture.Interfaces.Inputs.dTY));
  //   Modelica.SIunits.AmountOfSubstance[nC] N
  //     "Overall molar substance (= component mole)" annotation (Dialog(group="Inputs - composition related",enable=inputs==MultiPhaseMixture.Interfaces.Inputs.pTN or
  //     inputs==MultiPhaseMixture.Interfaces.Inputs.phN or inputs==MultiPhaseMixture.Interfaces.Inputs.dTN));
  //
  //   Modelica.SIunits.AbsolutePressure p(start=init.p)
  //     "Absolute pressure of medium";
  //   Modelica.SIunits.Temperature T(start=init.T) "Temperature";
  //
  //  // Mass-based properties
  //   Modelica.SIunits.SpecificEnthalpy  h "Specific enthalpy";
  //    Modelica.SIunits.SpecificInternalEnergy u
  //     "Specific internal energy of medium";
  //   Modelica.SIunits.Density d "Density";
  //   Modelica.SIunits.MassFraction[nS] Z
  //     "Overall mass fractions (= (component mass)/total mass  m_i/m)";
  //
  //   // Molar-based properties
  //   Modelica.SIunits.MolarEnthalpy hm "Molar enthalpy";
  //    Modelica.SIunits.MolarInternalEnergy um "Molar internal energy of medium";
  //     Modelica.SIunits.MolarDensity dm "Molar density";
  //   Modelica.SIunits.MoleFraction[nS] Zm
  //     "Overall mole fractions (= (component mole)/total mole  m_i/m)";

    Modelica.SIunits.MolarMass MM "Molar mass";

   // outputs
      FlashProperties
      eqProperties(p(start=init.p),
       T(start=init.T),
       x(start=init.x)) "equilibrium properties"
                               annotation (
        Placement(transformation(extent={{-80,40},{-60,
              60}})));
      // Local connector definition, used for equation balancing check
      connector InputAbsolutePressure = input Modelica.SIunits.AbsolutePressure
    "Pressure as input signal connector";
      connector InputSpecificEnthalpy = input Modelica.SIunits.SpecificEnthalpy
    "Specific enthalpy as input signal connector";
      connector InputMassFraction = input Modelica.SIunits.MassFraction
    "Mass fraction as input signal connector";
      connector InputDensity = input Modelica.SIunits.Density
    "Density as input signal connector";
         annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={85,170,255},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            radius=20),
          Polygon(
            points={{-58,-94},{62,-94},{82,-84},{22,6},{22,82},{28,82},{28,88},{-24,88},
                  {-24,82},{-18,82},{-18,6},{-78,-84},{-58,-94}},
            lineColor={85,170,255},
            smooth=Smooth.None,
            lineThickness=0.5),
          Polygon(
            points={{60,-76},{52,-80},{4,-80},{48,-76},{48,-74},{32,-40},{60,-76}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,-104},{100,-124}},
            lineColor={51,105,155},
            lineThickness=0.5,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Polygon(
            points={{-64,-82},{-16,-8},{8,-8},{0,-28},{-4,-52},{-22,-58},{-38,-68},{-48,
                  -86},{-56,-86},{-64,-82}},
            lineColor={255,81,23},
            smooth=Smooth.None,
            fillColor={255,81,23},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{8,-8},{0,-28},{-4,-52},{44,-48},{20,-8},{8,-8}},
            lineColor={51,105,155},
            smooth=Smooth.None,
            fillColor={51,105,155},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-48,-86},{-38,-68},{-22,-58},{-4,-52},{44,-48},{68,-82},{64,-86},
                  {-48,-86}},
            lineColor={0,127,127},
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={0,127,127},
            fillPattern=FillPattern.Solid)}),
                                      Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model that calculates properties. For example of usage see <a href=\"modelica://MultiPhaseMixture.Information.UsersGuide.OverallProperties\">MultiPhaseMixture.Information.UsersGuide.OverallProperties</a>.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Balancing equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">In order for a model to be valid the user need to specify the value for 2 inputs + one composition vector. The input connector qualifier applied to p, h, and Z indirectly declares the number of missing equations, permitting advanced equation balance checking by a Modelica tool. For further information, see Section 4.7 (Balanced Models) of the Modelica 3.0 specification.</span></p>
</html>"));
  end MultiPhaseProperties;


  replaceable partial model SatPhaseEquilibriumProperties
   extends BaseMultiPhaseProperties;
     import MultiPhaseMixture.Types.PresentPhasesStatus;
      parameter SatInputs inputs=SatInputs.pFZ_mole
        annotation (Dialog(group="Inputs"), Evaluate);
      InputAbsolutePressure p "Absolute pressure of medium" annotation (Dialog(group="Inputs",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.pFZ or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.pFZ_mole or inputs==MultiPhaseMixture.Interfaces.SatInputs.pFN));
      Modelica.SIunits.Temperature T "Temperature of medium" annotation (Dialog(group="Inputs",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.TFZ or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.TFZ_mole or inputs==MultiPhaseMixture.Interfaces.SatInputs.TFN));
      InputMassFraction[nP] F "Mass Phase fractions e.g. {1,0}" annotation (Dialog(group="Inputs - phase composition",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.pFZ or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.TFZ));
      Modelica.SIunits.MoleFraction[nP] Fm "Mole Phase fractions e.g. {1,0}" annotation (Dialog(group="Inputs - phase composition",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.pFZ_mole or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.TFZ_mole));
      Modelica.SIunits.AmountOfSubstance[nP] FN
    "Phase molar substance e.g. {128,72}"                                             annotation (Dialog(group="Inputs - phase composition",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.pFN or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.TFN));
      InputMassFraction[nC] Z(start=reference_X)
    "Total mass fractions (= (component mass)/total mass  m_i/m)"   annotation (Dialog(group="Inputs - overall compositions",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.pFZ or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.TFZ));
      parameter MultiPhaseMixture.Types.SolutionType solutionType=MultiPhaseMixture.Types.SolutionType.Normal
    "Define solution if multiple solutions exist"
        annotation (Dialog(group="Multiple solutions"));
      Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy of medium";
      Modelica.SIunits.Density d "Density of medium";
      Modelica.SIunits.SpecificInternalEnergy u
    "Specific internal energy of medium";

      Modelica.SIunits.MolarDensity dm "Molar density";
       Modelica.SIunits.MolarEnthalpy hm "Molar enthalpy of medium";
      Modelica.SIunits.MolarInternalEnergy um "Molar internal energy of medium";
      Modelica.SIunits.MolarMass MM "Molar mass";
    // outputs
      FlashProperties
      eqProperties(p(start=init.p),
       T(start=init.T),
       x(start=init.x)) "equilibrium properties"
                               annotation (
        Placement(transformation(extent={{-80,40},{-60,
              60}})));

      Modelica.SIunits.MoleFraction[nC] Zm
    "Overall mole fractions (= (component mole)/total mole  mole_i/moles)"   annotation (Dialog(group="Inputs - overall compositions",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.pFZ_mole or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.TFZ_mole));

      Modelica.SIunits.AmountOfSubstance[nC] N
    "Overall molar substance (= component mole)"   annotation (Dialog(group="Inputs - overall compositions",enable=inputs==MultiPhaseMixture.Interfaces.SatInputs.pFN or
         inputs==MultiPhaseMixture.Interfaces.SatInputs.TFN));

      // Local connector definition, used for equation balancing check
      connector InputAbsolutePressure = input Modelica.SIunits.AbsolutePressure
    "Pressure as input signal connector";
      connector InputMassFraction = input Modelica.SIunits.MassFraction
    "Fraction as input signal connector";

      connector InputTemperature = input Modelica.SIunits.Temperature
    "Temperature as input signal connector";

      //     pFZ "p,Phase fractions (mass),Z",
      // TFZ "T,Phase fractions (mass),Z",
      // pFZ_mole "p,Phase fractions (mole),Z",
      // TFZ_mole "T,Phase fractions (mole),Z",
      // pFN_mole "p,Phase substance (mole),N",
      // TFN_mole "T,Phase substance (mole),N") "Input type";

         annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={85,170,255},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            radius=20),
          Polygon(
            points={{-58,-94},{62,-94},{82,-84},{22,6},{22,82},{28,82},{28,88},{-24,88},
                  {-24,82},{-18,82},{-18,6},{-78,-84},{-58,-94}},
            lineColor={85,170,255},
            smooth=Smooth.None,
            lineThickness=0.5),
          Polygon(
            points={{60,-76},{52,-80},{4,-80},{48,-76},{48,-74},{32,-40},{60,-76}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,-104},{100,-124}},
            lineColor={51,105,155},
            lineThickness=0.5,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Polygon(
            points={{-64,-82},{-16,-8},{8,-8},{0,-28},{-4,-52},{-22,-58},{-38,-68},{-48,
                  -86},{-56,-86},{-64,-82}},
            lineColor={255,81,23},
            smooth=Smooth.None,
            fillColor={255,81,23},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{8,-8},{0,-28},{-4,-52},{44,-48},{20,-8},{8,-8}},
            lineColor={51,105,155},
            smooth=Smooth.None,
            fillColor={51,105,155},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-48,-86},{-38,-68},{-22,-58},{-4,-52},{44,-48},{68,-82},{64,-86},
                  {-48,-86}},
            lineColor={0,127,127},
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={0,127,127},
            fillPattern=FillPattern.Solid)}),
                                      Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model that calculates saturation properties. For example of usage see <a href=\"modelica://MultiPhaseMixture.Information.UsersGuide.PhaseEquilibrium\">MultiPhaseMixture.Information.UsersGuide.PhaseEquilibrium</a>.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Balancing equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">In order for a model to be valid the user need to specify the value for 2 inputs + one composition vector. The input connector qualifier applied to p, h, and Z indirectly declares the number of missing equations, permitting advanced equation balance checking by a Modelica tool. For further information, see Section 4.7 (Balanced Models) of the Modelica 3.0 specification.</span></p>
</html>"));
  end SatPhaseEquilibriumProperties;


    replaceable partial model ThermoProperties
  "Base properties (p, d, T, h, u, X) of a medium"

      import MultiPhaseMixture.Types.PresentPhasesStatus;
      extends BaseProperties;
      parameter Integer presentPhases[:]=createPresentPhaseVector(phases.label)
    "Possible present phases"     annotation(Dialog(tab="Optimization",
            group="Equilibrium calculation"));
      parameter PresentPhasesStatus presentPhasesStatus=PresentPhasesStatus.Unknown
    "Status of possible present phases"     annotation(Dialog(tab="Optimization",
            group="Equilibrium calculation"));

    annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model that calculates overall common properties. For example of usage see <a href=\"modelica://MultiPhaseMixture.Information.UsersGuide.OverallProperties\">MultiPhaseMixture.Information.UsersGuide.OverallProperties</a>.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Balancing equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">In order for a model to be valid the user need to specify the value for 2 inputs + one composition vector. The input connector qualifier applied to p, h, and Z indirectly declares the number of missing equations, permitting advanced equation balance checking by a Modelica tool. For further information, see Section 4.7 (Balanced Models) of the Modelica 3.0 specification.</span></p>
</html>"));
    end ThermoProperties;

end Interfaces;
