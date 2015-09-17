within MultiPhaseMixture.Information;
package ExternalPropertyPackages "External Property packages"

  class RefProp "RefProp"
      extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>RefProp (NIST Reference Fluid Thermodynamic and Transport Properties Database&nbsp;) is a commerical program for calculation of thermodynamic and transport properties. It&apos;s developed and maintained by the <a href=\"http://www.nist.gov/srd/nist23.cfm\">National Institute of Standards and Technology</a>. RefProp contains high accuracy models of industrially-important fluids (the equations are the most accurate equations available worldwide [2]). The high accuracy is achieved by using high order polynominals which also makes them more computational demanding than a cubic equation of state as e.g. Redlich-Kwong or Peng Robinson.</p>
<h4>Tool Requirements</h4>
<ul>
<li>Compiler: Visual studio 2010 or later</li>
<li>Dymola 2015 or later </li>
</ul>
<h4>Refprop version</h4>
<p>The newest version of RefProp 9.1.1 should be used.</p>
<p>RefProp 9.1 can be updated from <a href=\"http://www.boulder.nist.gov/div838/theory/refprop/911-1/REFPROP.HTM\">http://www.boulder.nist.gov/div838/theory/refprop/911-1/REFPROP.HTM</a></p>
<p><br>NOTE: Using RefProp 9.1 instead of RefProp 9.1.1 can lead to non-deterministic behaviour wrt to when a flash calculation can be solved or not.</p>
<h4>Modelica Settings</h4>
<p>Settings in MultiPhaseMixture.Templates.ExternalTwoPhaseMixture that should be used when creating a new Fluid.</p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">nP=2, the n</span>umber of supported phases by RefProp is always 2</li>
<li>libraryName=&QUOT;RefProp&QUOT;</li>
</ul>
<p>Specific RefProp setup information is set in the setupInfo string. Different options are separated by the | delimiter.</p>
<p>Supported options in setupInfo:</p>
<ul>
<li>path= path to RefProp installation, e.g. <code><span style=\"font-family: Courier New,courier;\">path=C:/Program&nbsp;Files&nbsp;(x86)/REFPROP/</span></code></li>
<li>mixture=name of mixture file, e.g. mixture=air.mix , if no mixture file is specified it&apos;s assumed that the fluid is pure and that the compound is specified in compounds</li>
<li>eos= equation of state, supported options default or PengRobinson, e.g. eos=PengRobinson or eos=default</li>
</ul>
<h4>Example - DryAir mixture medium</h4>
<p>See <a href=\"modelica://MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir\">MultiPhaseMixture.PreDefined.Mixtures.RefProp.DryAir</a> </p>
<h4>Limitations</h4>
<ul>
<li>For the general flash routines there is no possibility to provide start values. I.e the caching is not implemented for the RefProp backend.</li>
<li>RefProp does not seem to be suited to be used for larger system simulations for mixtures due to the disadvantages mentioned in chapter 4.4 (Windahl, 2015) and that it by default use highly precise multi-parameter equation of state which is rarely used for mixtures due to the computational effort (Schultze, 2014). To overcome these limitations further analysis is needed. </li>
</ul>
<h4>References</h4>
<ol>
<li>Lemmon, E.W., Huber, M.L., McLinden, M.O.&nbsp;&nbsp;NIST Standard Reference Database 23:&nbsp; Reference Fluid Thermodynamic and Transport Properties-REFPROP, Version 9.1, National Institute of Standards and Technology, Standard Reference Data Program, Gaithersburg, 2013.</li>
<li>http://www.boulder.nist.gov/div838/theory/refprop/Frequently_asked_questions.html</li>
<li>C. Schultze, A Contribution to Numerically Efficient Modelling of Thermodynamic Systems, PhD thesis, Technische Universit&auml;t Braunschweig, Fakult&auml;t f&uuml;r Maschinenbau.,&nbsp;(2014) </li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Johan Windahl, Katrin Pr&ouml;lss, Maarten Bosmans, Hubertus Tummescheit, Eli van Es, Awin Sewgobind: <i>MultiComponentMultiPhase - a framework for thermodynamic properties in Modelica</i> Modelica 2015 Conference, Palais des Congr&egrave;s Versailles, France, Sep. 21-23, 2015. </span></li>
</ol>
</html>"));
  end RefProp;

  class CapeOpen "CapeOpen"
      extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The only currently widely adopted standard for thermodynamic property packages is the CAPE-OPEN Thermodynamic and Physical Properties. </span><i>&ldquo;CAPE-Open standards are the uniform standards for interfacing process modelling software components developed specifically for the design and operation of chemical processes&rdquo;</i> (Colan, 2015). </p>
<h4>Tool Requirements</h4>
<ul>
<li>Compiler: Visual studio 2010 or later</li>
<li>Dymola 2015 or later </li>
<li>Supported only for Windows (although CAPE-OPEN was intended as a cross-platform specification, in practice CAPE-OPEN is only supported on Windows)</li>
</ul>
<h4>CAPE-OPEN version</h4>
<p><span style=\"font-family: MS Shell Dlg 2;\">The CAPE-OPEN backend that has been developed supports both the 1.0 and 1.1 version of the specification. </span></p>
<h4>Modelica Settings</h4>
<p>Settings in MultiPhaseMixture.Templates.ExternalTwoPhaseMixture that should be used when creating a new Fluid.</p>
<ul>
<li>nP= the number of supported phases, <span style=\"font-family: MS Shell Dlg 2;\">currently all phase specification (which phases that are supported and their order) needs to be specified by the user) </span></li>
<li>libraryName = &QUOT;CapeOpen&QUOT; followed by the property package that is used. E.g. libraryName&nbsp;=&nbsp;&QUOT;CapeOpen.FluidProp&nbsp;Thermo&nbsp;System//PCP-SAFT&QUOT;</li>
<li>setupInfo=&QUOT;UnitBasis=2;<code><span style=\"font-family: Courier New,courier;\">CodeLogging=true</span></code>&QUOT;), UnitBasis=2 equals mass based units. CodeLogging enables logging to the specified log file</li>
</ul>
<h4>Example - DryAir mixture medium</h4>
<p>See <a href=\"modelica://MultiPhaseMixture.PreDefined.Mixtures.CapeOpen.FluidProp.DryAir\">MultiPhaseMixture.PreDefined.Mixtures.CapeOpen.FluidProp.DryAir</a> </p>
<h4>Limitations</h4>
<p>Following disadvantages with the CAPE-OPEN thermo interface should be considered (Szczepanski, 2013):</p>
<ul>
<li>Missing calculations of: critical properties, phase boundaries, phase stability test. &nbsp; </li>
<li>No support of flash derivatives (derivatives of flash outputs w.r.t flash specifications with phases in equilibrium) </li>
<li>Single calculation, in some circumstances it would be useful to calculate properties for an array of inputs </li>
</ul>
<p>Another disadvantage is that it contains several internal function calls which create an overhead in computation time. And although it was intended as a cross-platform specification, in practice CAPE-OPEN is only supported on Windows. </p>
<h4>References</h4>
<ol>
<li>CAPE OPEN, Thermodynamic and Physical Properties v1.1, May 2011, Downloaded from http://www.colan.org </li>
</ol>
</html>"));
  end CapeOpen;

  class Derivatives "Derivatives"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>Neither CAPE-OPEN nor RefProp supports total overall properties derivatives, which may be needed for dynamic simulation, especially for state variable transformation. It was therefore decided that these types of calculations should be implemented on the Modelica side and not in the C-interface. For a pure fluid, the calculations are straight-forward and there are publications available (Thorade et al, 2013). For mixtures they are more complicated (Li, 1955). The difficult part is when several phases coexist. In that case they are currently calculated numerically.</p>
<p><br>For an example of how derivativs are calculated see <a href=\"modelica://MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper.density_derh_p_X\">MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper.density_derh_p_X</a></p>
<h4>References</h4>
<p>[1] James C. M. Li, Clapeyron Equation for MultiComponent Systems, <i>The Journal of Chemical Physics volume 25. number 3 september</i>. 1956. </p>
<p>[2] Mathis Thorade and Ali Saadat, Partial derivatives of thermodynamic state properties for dynamic simulation, <i>Environ Earth Sci</i> <span style=\"font-family: AdvPTimes,serif; font-size: 9pt;\">70:3497&ndash;3503.</span> 2013 </p>
</html>"));
  end Derivatives;

  class Debugging "Debugging"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>Some additional debugging features has been added to make it easier to find the root-cause if a simulation does not function as it is supposed to.</p>
<p><br><b>Print to simulation log</b></p>
<p>A boolean constant <code><span style=\"font-family: Courier New,courier;\">printExternalFunctionCall </span></code>has been added to MultiPhaseMixture.Templates.ExternalTwoPhaseMixture<span style=\"font-family: MS Shell Dlg 2;\">. Setting this constant to true in your medium declaration will print property calls from Modelica to the simulation log.</span></p>
<p><br><b><span style=\"font-family: MS Shell Dlg 2;\">Print to external log</span></b></p>
<p>Also logging on the external C-interface can be enabled by setting <code><span style=\"font-family: Courier New,courier;\">CodeLogging=true </span></code>in the setup information, see <a href=\"modelica://MultiPhaseMixture.Information.ExternalPropertyPackages.CapeOpen\">MultiPhaseMixture.Information.ExternalPropertyPackages.CapeOpen</a> for example. If enabled, the C-function call will be logged into a file named testcode.log in your current directory. </p>
</html>"));
  end Debugging;
  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">MultiPhaseMixture has an interface to the C-interface ExternalMultiPhaseMixture which makes it possible to use fluids from an external property package. The overall structure of the framework can be seen below.</span></p>
<p><img src=\"modelica://MultiPhaseMixture/Resources/Images/externalFrameworkOverview.png\"/></p>
<h4>Using a external fluid in Modelica</h4>
<p>To use a fluid from an external property package:</p>
<ul>
<li>Create a new fluid in Modelica be extending the Modelica package <span style=\"font-family: MS Shell Dlg 2;\">MultiPhaseMixture.Templates.ExternalTwoPhaseMixture and specify required settings (different fluid property packages as e.g. RefProp, FluidProp and Cape-Open may require different settings. A recommended way is to duplicate a predefined media and modify it.</span></li>
</ul>
<h4>Challenges with external property code</h4>
<p>Most of the available external property packages have not been designed to be used for dynamic simulations. General problems are: </p>
<ul>
<li><span style=\"font-family: Arial,sans-serif;\">Error handling when calling properties outside their validity region. </span></li>
<li><span style=\"font-family: Arial,sans-serif;\">Limited support for partial derivatives. </span></li>
<li><span style=\"font-family: Arial,sans-serif;\">Lack of support to speed up iterative calculation by providing good start values. </span></li>
<li><span style=\"font-family: Arial,sans-serif;\">No access to the used tolerances, which may cause numerical problems when creating numerical derivatives. </span></li>
<li><span style=\"font-family: Arial,sans-serif;\">Non converging regions. </span></li>
</ul>
<p>We have seen in this project that without any additional handling of the validity region issue, simulation will often crash during initialization or simulation. An explanation is that even if a simulation model is set-up to operate within the validity region, the solver might call property routines with invalid inputs when it tries to find a solution for a system of non-linear equations or when it test a large step-size. </p>
<p>In the external interface we decided that it should be the property calculator responsibility to handle this as different property types such as e.g. transport and equation of state based properties may have different validity regions and might be a function of composition. </p>
</html>"));
end ExternalPropertyPackages;
