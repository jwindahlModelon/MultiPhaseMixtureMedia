within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function liquidComposition
  input Properties state;
  output Real Y[nC];
protected
  Integer liq_index;
algorithm
  liq_index :=PhaseLabelLiquid;
  for i in 1:nC loop
     Y[i]:=state.phaseComposition[nC*(liq_index-1)+i];
   end for;
end liquidComposition;
