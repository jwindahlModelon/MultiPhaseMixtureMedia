within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function vaporComposition
  input Properties state;
  output Real Y[nC];
protected
  Integer vap_index;
algorithm
  vap_index :=PhaseLabelVapor;
  for i in 1:nC loop
     Y[i]:=state.phaseComposition[nC*(vap_index-1)+i];
   end for;
end vaporComposition;
