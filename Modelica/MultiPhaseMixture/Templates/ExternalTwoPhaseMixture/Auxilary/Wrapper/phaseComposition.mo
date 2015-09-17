within MultiPhaseMixture.Templates.ExternalTwoPhaseMixture.Auxilary.Wrapper;
function phaseComposition

  input Integer phaseIndex "Phase index";
  input Properties state;
  output Real Y[nC];
protected
  Integer startIndex;
algorithm
   startIndex:=(phaseIndex - 1)*nC;
   for i in 1:nC loop
     Y[i]:=state.phaseComposition[startIndex+i];
   end for;
 //  Y:=state.phaseComposition[(phaseIndex-1)*nC+1:phaseIndex*nC];

end phaseComposition;
