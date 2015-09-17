within MultiPhaseMixture.Information.Limitations;
class ModelicaSpecification "Modelica Specification"
    extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Following issues have been observed that is related to the Modelica specification:</span></p>
<p><br><b>Inconvenient to calculate parameters</b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Currently it is inconvenient to use a model or block based structure to calculate parameters as illustrated below. It would be more user friendly if a model or block could be used in a similar way as a function to calculate parameters. </span></p>
<pre><span style=\"font-family: Courier New,courier;\">parameter  SpecificEnthalpy h_start (fixed=false)  annotation(Evaluate=true);</span>
<span style=\"font-family: Courier New,courier;\">SpecificEnthalpy h(start=h_start);</span>


<span style=\"font-family: Courier New,courier;\">Medium.MultiPhaseProperties</span>
<span style=\"font-family: Courier New,courier;\">    flash_init(Z=Z_start,p=p_start,T=T_start,</span>
<span style=\"font-family: Courier New,courier;\">    presentPhases=presentPhases,</span>
<span style=\"font-family: Courier New,courier;\">    presentPhasesStatus=presentPhasesStatus,</span>
<span style=\"font-family: Courier New,courier;\">    init(p=p_start, x=fill(Z_start, Medium.nP)),</span>
<span style=\"font-family: Courier New,courier;\">    inputs=MultiPhaseMixture.Interfaces.Inputs.pTX)</span>
<span style=\"font-family: Courier New,courier;\">initial equation </span>
<span style=\"font-family: Courier New,courier;\">  h_start=flash.h;</span></pre>
<h4>Solver callback interface </h4>
<p><span style=\"font-family: MS Shell Dlg 2;\">The external interface ExternalMixtureMedia has been designed with a structure that supports caching. The idea is to cache result from a calculation and use it as start values in a next coming calculation to decrease the number of internal iterations and increase robustness. A problem with this approach is that it is not possible to distinguish a function call during normal continuous simulation from one where the steady-state solver desperately tries to find a solution. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">During continous simulation a good strategy would be to use values from the last accepted step. &nbsp;For the steady-state case it might be an idea to let the non-linear solver update the starting values of the iteration variables hidden in these algorithms, when the solver makes good progress. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">A solution would be to have the possibility to register a solver callback interface, which could be used to update iteration start values in a controlled way. </span></p>
<h5>A suggestion </h5>
<p><span style=\"font-family: Arial,sans-serif;\">&bull;<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span><span style=\"font-family: MS Shell Dlg 2;\">onSolverAcceptedStep() - called by solver/simulation environment when an accepted step has occurred. Place to implement updates of iteration start variables. </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">&bull;<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp; </span><span style=\"font-family: Arial,sans-serif;\">onSolverSteadyStateProgress() - called by solver/simulation environment when progress in steady-state solver. Place to update iteration start values variables. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Advantages with introducing callback methods are that the iteration start values can be updated in a controlled way and thereby avoiding the risk of an update during a bad steady-state iteration step. </span></p>
</html>"));
end ModelicaSpecification;
