within MultiPhaseMixture.Interfaces;
function createPhaseSubstanceVector
  "Create a phase substance vector, unset phase element are set to 0"
  input String[:] phaseId={"Liquid","Vapor"} "Phase id vector";
  input Real[size(phaseId,1)] phaseValues={50,50}
    "Values for each phaseId element";
  output Real[nP] phaseVector;

protected
  Integer index;
  Integer sizePhaseID=size(phaseId,1);

algorithm
  for i in 1:sizePhaseID loop
    index:=getPhaseIndex(phaseId[i]);
    assert(index > 0,phaseId[i]+" is not supported by the media");
    phaseVector[index]:=phaseValues[i];
 end for;

end createPhaseSubstanceVector;
