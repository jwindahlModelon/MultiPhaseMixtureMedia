within MultiPhaseMixture.Interfaces;
function createPhaseFractionVector
  "Create a phase fraction vector, unset phase element are distributed evenly so sum(phaseVector) = 1"
  input String[:] phaseId={"Liquid","Vapor"} "Phase id vector";
  input Real[size(phaseId,1)] phaseValues={0.5,0.5}
    "Values for each phaseId element";
  output Real[nP] phaseVector;

protected
  Integer index;
  Boolean isSet[nP];
  Real remainingUnsetAccPhaseValue;
  Integer sizePhaseID=size(phaseId,1);
  Boolean checkSum;
algorithm
  for i in 1:sizePhaseID loop
    index:=getPhaseIndex(phaseId[i]);
    assert(index > 0,phaseId[i]+" is not supported by the media");
    phaseVector[index]:=phaseValues[i];
    isSet[index]:=true;
  end for;

  // set remaining phase elements not specified by phaseId input so sum(phaseVector)==1
  remainingUnsetAccPhaseValue:=1 - sum(phaseValues);
  for j in 1:nP loop
    if (isSet[j] == false) then
      phaseVector[j]:=remainingUnsetAccPhaseValue/(nP - sizePhaseID);
    end if;
  end for;

  // Check that phaseVector sums upp to 1.
  checkSum:=sum(phaseVector) < (1 + 1e-8) and sum(phaseVector) > (1 - 1e-8);
  assert(checkSum,"phaseVector does not sum up to 1");

end createPhaseFractionVector;
