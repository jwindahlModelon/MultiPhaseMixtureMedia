within MultiPhaseMixture.Information;
package UsersGuide "Users Guide"

  class OverallProperties "Overall properties"
      extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Overall Thermodymamic properties</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">To calculate overall properties one of following models can be used:</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">Properties</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">ThermoProperties</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">MultiPhaseProperties</span></li>
</ul>
<p>ThermoProperties is the most basic model which only calculate the most basic properties (similar to BaseProperties in Modelica.Media). Properties adds additional overall properties (an average calculation is used for properties which are not defined when multiple phases exist). The disadvantage of using Properties instead of ThermoProperties is that these extra properties may be more computational demanding, especially when several phases exists.</p>
<p>MultiPhaseProperties also calculate overall properties for the most basic properties. To distinguish overall from one phase properties, overall properties ends with _overall in MultiPhaseProperties.</p>
<h5>Example: calculation of density using ThermoProperties model</h5>
<p><span style=\"font-family: MS Shell Dlg 2;\">To calculate properties specify 2 properties and the overall composistion according to the inputs parameter. An advantage with the model based approach is that this can be done graphically.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><img src=\"modelica://MultiPhaseMixture/Resources/Images/properties_example.png\"/> </span></p>
</html>"));
  end OverallProperties;

  class SaturationProperties "Saturation properties"
      extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Saturation properties</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Caulculations of saturation properties is done with model SatPhaseEquilibriumProperties. Dew and bubble properties for a vapor-liquid equilibrium can be calculated by setting the phase fraction to 1 for the vapor or liquid phase:</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; font-size: 8pt;\">Example: calculation of bubble density using SatPhaseEquilibriumProperties model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><img src=\"modelica://MultiPhaseMixture/Resources/Images/satproperties_example.png\"/></span></p>
<h5>Efficient calculations</h5>
<p><span style=\"font-family: MS Shell Dlg 2;\">If a model is assumed to always be in the multiphase zone. Then MultiPhaseProperties can be used instead of SatPhaseEquilibriumProperties. This decrease the number of models and thereby gives better simulation performance. To get the properties of a specific phase:</span></p>
<ol>
<li><span style=\"font-family: MS Shell Dlg 2;\">Find the index of the specified phase. This is defined by Medium.phases. Example: <code><span style=\"font-family: Courier New,courier; color: #0000ff;\">final&nbsp;parameter&nbsp;</span><span style=\"color: #ff0000;\">Integer</span>&nbsp;LIQUID_INDEX=<span style=\"font-family: Courier New,courier; color: #ff0000;\">Medium.getPhaseIndex</span>(&QUOT;Liquid&QUOT;)&nbsp;<span style=\"font-family: Courier New,courier; color: #006400;\">&QUOT;Index&nbsp;of&nbsp;phase&nbsp;LIQUID&QUOT;</span>&nbsp;&nbsp;<span style=\"font-family: Courier New,courier; color: #0000ff;\">annotation</span>(Evaluate=true); // Note index for Liquid and vapor is also precalculated and available as Medium.PhaseLabelLiquid and Medium.PhaseLabelVapor</code></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Check so this phase is available in the used Medium. Example: </span></li>
<pre><span style=\"font-family: Courier New,courier; color: #0000ff;\">initial&nbsp;equation&nbsp;</span></pre>
<p><span style=\"font-family: MS Shell Dlg 2;\">&nbsp;&nbsp; <code><span style=\"font-family: Courier New,courier; color: #ff0000;\">assert</span></code></span><span style=\"font-family: MS Shell Dlg 2;\">(LIQUID_INDEX&GT;0,&QUOT;Liquid&nbsp;is&nbsp;not&nbsp;an&nbsp;available&nbsp;phase&QUOT;);</p>
<li><pre><span style=\"font-family: Courier New,courier;\">Reference the one-phase property of interest. Example: d_liq=multiPhaseProperties.d_1ph[LIQUID_INDEX];</pre></span></li>
</ol>
</html>"));
  end SaturationProperties;

  class PhaseEquilibrium "Phase equilibrium (flash)"
      extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Overview phase equilibrium (flash)</span></b></p>
<p>A phase equilibrium calculation determines subject to specified constraint, e.g. fixed pressure and temperature, present phases and the composition and fraction of each present phase. It is an iterative calculation which often use specialized algorithms; see (Parekh <i>et al</i>, 1998; Gernert <i>et al</i>, 2014). </p>
<p>Phase equilibrium calculations are time consuming and will dominate the total CPU usage, up to 95&percnt; according to (Trapp, 2014). Similar numbers have also been observed in this work. </p>
<p>To achieve competitive performance: </p>
<ul>
<li>The number of phase equilibrium calculations should be minimized. This can be achieved by designing fluid and application library interfaces so that calculation result can be shared between components. This may require expanding the connector class with additional variables to avoid redundant calculations. </li>
<li>For each phase equilibrium calculation, the number of iterations inside these algorithms needs to be minimized. This can be achieved by providing good iteration guess values. </li>
</ul>
<h4>Calculation</h4>
<p>The flash calculation is an integrated part of following models:</p>
<ul>
<li>Properties</li>
<li>MultiPhasePropeties</li>
<li><span style=\"font-family: MS Shell Dlg 2;\">SatPhaseEquilibriumProperties</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">ThermoProperties</span></li>
</ul>
<p><span style=\"font-family: MS Shell Dlg 2;\">But it&apos;s only in </span>MultiPhaseProperties and SatPhaseEquilibriumProperties that contain variables that specfiy which phases that are available and the amount and composition of each phase. This information is available in the record eqProperties.</p>
<h4>Start values</h4>
<p>The phase equilibrium calculation can in the general case be computed faster and be robuster if good start values can be provided (note: when using external medium not all property packages support this functionality). Start values can be set by modyfing the init record.</p>
<p><br><b><span style=\"font-family: MS Shell Dlg 2;\">Faster calculations</span></b></p>
<p>For a fluid with many supported phases, the calculation will be faster if this set of potential phases can be minimized. This is supported by <code><span style=\"font-family: Courier New,courier;\">presentPhases</span></code> that specifies which possible phases the equilibrium calculation should be searching for, it needs to be a sub-set of the phases defined in the phases and <code><span style=\"font-family: Courier New,courier;\">presentPhasesStatus</span></code> that specify the status of the possible present phases.</p>
<p><b><span style=\"font-size: 8pt;\">Example 1:</b> A pipe simulation that use complex fluids that has many supported phases, e.g. vapor, liquid1, liquid2 etc. But at a downstream position in the simulation model we know in advance that the only possible phases are vapor,liquid. It is then possible to specify that the only possible phases (<code></span><span style=\"font-family: Courier New,courier;\">presentPhases</span></code>) are vapor and liquid (but we don&apos;t know if both always exist) which makes the equilibrium calculation faster.</p>
<p>The equilibrium calculation can be even faster if we have more information, e.g. we know that the vapor and liquid always exist, i.e. we can assume that we are always in the two-phase zone. This extra information can be provided by specifying <code><span style=\"font-family: Courier New,courier;\">presentPhasesStatus=alwaysPresent</span></code>.</p>
<p><b>Example 2:</b> If we don&apos;t have information about the phases, general flash calculations are used in RefProp. But it&apos;s possible to use the faster flash calculations flash2ph or flash1ph if we know in advance the region it&apos;s operate in.</p>
<p><b>Example 3:</b> The equilibrium phase calculations can be skipped if we know in advance that only one phase is present, i.e. size(presentPhase,1) ==1 . In this special case the value of presentPhasesStatus can be ignored as there are no other possible phase combinations (i.e. the phase is always present)</p>
<p><br><h4>References</h4></p>
<p>[1] Vipul Parekh and Paul Mathias, Efficient flash calculations for chemical process design &ndash; extension to the Boston-Britt Inside-Out flash algorithm to extreme conditions and new flash types, <i>Computers and chemical engineering</i>, vol 22 pp 1371-1380 (1998) </p>
<p>[2] Johannes Gernert, Andreas J&auml;ger and Roland Span. Calculation of phase equilibria for multi-component mixtures using highly accurate Helmholtz energy equations of state, Fluid Phase Equilibria 375 (2014) 209&ndash;218.</p>
<p>[3] C. Trapp, F.Casella, T. Stelt, P. Colonna. Use of External Fluid property Code in Modelica of a Pre-combustion Co2 Capture Process Involving Multi-Component, Two-Phase Fluids, <i>Proceedings of the 10th International Modelica 2014 Conference</i>,&nbsp; Lund, Sweden, March 10-12 2014. </p>
</html>"));
  end PhaseEquilibrium;

  class ComparisonModelicaMedia "Comparison Modelica Media"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h4>Modelica.Media properties not currently available in MultiPhaseMixture</h4>
<p>Following properties are currently not supported in MultiPhaseMixture:</p>
<ul>
<li>Two-phase properties: </li>
<li><ul>
<li>Surface tension</li>
</ul></li>
<li>Phase boundary derivatives: </li>
<li><ul>
<li>Modelica.Media.Interfaces.PartialTwoPhaseMedium.saturationTemperature_derp</li>
<li>Modelica.Media.Interfaces.PartialTwoPhaseMedium.dBubbleDensity_dPressure</li>
<li>Modelica.Media.Interfaces.PartialTwoPhaseMedium.dDewDensity_dPressure</li>
<li>Modelica.Media.Interfaces.PartialTwoPhaseMedium.dBubbleEnthalpy_dPressure</li>
<li>Modelica.Media.Interfaces.PartialTwoPhaseMedium.dDewEnthalpy_dPressure </li>
</ul></li>
<li>Overall properties for (MultiPhaseMixture supports only single phase for these properties):</li>
<li><ul>
<li>Prandtl number Pr</li>
<li>Velocity Of sound a</li>
<li>Isobaric expansion coefficient beta </li>
<li>Specific heat capacity cp</li>
<li>Specific heat capacity cv</li>
<li>Compressibility kappa</li>
<li>Derivative of pressure w.r.t. temperature at constant density and molar substance</li>
<li>Derivative of pressure w.r.t. density at constant temperature and molar substance</li>
<li>Derivative of density wrt enthalpy at constant pressure ddhp</li>
<li>Derivative of density wrt pressure at constant enthalpy ddph</li>
<li>Thermal conductivity lambda</li>
<li>Dynamic viscosity eta </li>
</ul></li>
<li>Explicit derivatives</li>
<li><ul>
<li>Modelica.Media.Interfaces.PartialPureSubstance.density_derp_h</li>
<li>Modelica.Media.Interfaces.PartialPureSubstance.density_derh_p</li>
<li>Modelica.Media.Interfaces.PartialPureSubstance.density_derp_T</li>
<li>Modelica.Media.Interfaces.PartialPureSubstance.density_derT_p</li>
<li>Modelica.Media.Interfaces.PartialPureSubstance.density_derX</li>
</ul></li>
<li>Auxilary properties</li>
<li><ul>
<li>Modelica.Media.Interfaces.PartialMedium.specificGibbsEnergy</li>
<li>Modelica.Media.Interfaces.PartialMedium.specificHelmholtzEnergy</li>
<li>Modelica.Media.Interfaces.PartialMedium.isentropicEnthalpy </li>
</ul></li>
</ul>
<h4>New functionality</h4>
<ul>
<li>Fugacity</li>
<li>ActivityCoefficient</li>
<li>getPhaseIndex</li>
<li>...</li>
<li></li>
</ul>
<p><br><h4>Different definitions</h4></p>
<p>The number of compounds is specified by the constant nC. This corresponds to nS in Modelica.Media.</p>
</html>"));
  end ComparisonModelicaMedia;

  class PhaseIdentification "Phase identification"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h4>Identification of phases</h4>
<p>This library has not added any constraints on the number of phases or in which order they appear. This makes it possible to use the library in more use cases.</p>
<p>The phase specification is determined by the Phases record phases and the number of phases constant nP. For an external C-medium the phases record is automatically set in MultiPhaseMixture.Templates.ExternalTwoPhaseMixture while for a native Modelica implementaiton this has to be specifyed manually. But the number of phases has to be set manually, see restrictions <a href=\"modelica://MultiPhaseMixture.Information.Limitations.Tool\">MultiPhaseMixture.Information.Limitations.Tool</a>.</p>
<h4>Generic models</h4>
<p>In order to write generic models where the order of the phases does not change following helper functions has been added to the library</p>
<ul>
<li>getPhaseIndex() </li>
<li>createPhaseSubstanceVector() </li>
<li>checkPhaseNames()</li>
</ul>
<h4>Convention</h4>
<ul>
<li>Name the first liquid phase to Liquid, first vapor phase to Vapor and first solid phase to Solid. Most of the use cases only contain one liquid and vapor phase and in order to simplify the usage PhaseLabelLiquid and PhaseLabelVapor has been added to the interface. They assume these naming conventions. </li>
</ul>
<h4>Note</h4>
<p>When using this medium library in a model application library, it could be an id&eacute;a to take decisions based on density instead of a label. Example: At the bottom of an separator set properties in the connector based on the present phase with the highest density instead of using the liquid label.</p>
</html>"));
  end PhaseIdentification;
  annotation (Documentation(info="<html>
<p>The MultiphaseMixture library has a different stucture than Modelica.Media. The interface is also based on models instead of functions which makes the usage different.</p>
</html>"));
end UsersGuide;
