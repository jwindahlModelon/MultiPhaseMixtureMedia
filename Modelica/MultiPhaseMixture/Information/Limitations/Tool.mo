within MultiPhaseMixture.Information.Limitations;
class Tool "Tools"
    extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Tool issues</h4>
<p>Following limitations have been observed for different tools: </p>
<h5>Not possible to calculate iteration start values from a property model. (Dymola 2016)</h5>
<p><span style=\"font-family: MS Shell Dlg 2;\">This limitation is severe if a model contains iteration variables that are not equal to a model&rsquo;s start value parameters. If the specific enthalpy is an iteration variable it should be calculated from the given start value parameters as illustrated in the code below:</span> </p>
<pre><span style=\"font-family: Courier New,courier;\">parameter  SpecificEnthalpy h_start (fixed=false)  annotation(Evaluate=true);</span>
<span style=\"font-family: Courier New,courier;\">SpecificEnthalpy h(start=h_start);</span>
<span style=\"font-family: Courier New,courier;\">Medium.MultiPhaseProperties</span>
<span style=\"font-family: Courier New,courier;\">    flash_init(Z=Z_start,p=p_start,T=T_start,</span>
<span style=\"font-family: Courier New,courier;\">    presentPhases=presentPhases,</span>
<span style=\"font-family: Courier New,courier;\">   presentPhasesStatus=presentPhasesStatus,</span>
<span style=\"font-family: Courier New,courier;\">    init(p=p_start, x=fill(Z_start, Medium.nP)),</span>
<span style=\"font-family: Courier New,courier;\">    inputs=MultiPhaseMixture.Interfaces.Inputs.pTX)</span>
<span style=\"font-family: Courier New,courier;\">initial equation </span>
<span style=\"font-family: Courier New,courier;\">  h_start=flash.h;</span></pre>
<h5>Not possible to calculate structural parameters from a function using an external object. (Dymola 2016)</h5>
<p><span style=\"font-family: MS Shell Dlg 2;\">This limitation requires that the user manually specify the number of phases and compounds in the property declaration. </span></p>
<h5>presentPhaseIndex can&apos;t be an Integer (Dymola 2016)</h5>
<p>presentPhaseIndex in MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Properties was changed to a real variable <span style=\"font-family: Verdana,Arial,Bitstream Vera Sans,Helvetica,sans-serif;\">due to Dymola has currently an limitation of tearing with&nbsp;integers. I.e. before it did not work to calculate a property by iteration due to it choosed to use presentPhaseIndex as an iteration variable which was an integer = translation error in Dymola.</span></p>
</html>"));
end Tool;
