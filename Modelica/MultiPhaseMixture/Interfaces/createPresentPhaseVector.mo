within MultiPhaseMixture.Interfaces;
function createPresentPhaseVector
  "Create a present phase vector, a vector with phase index corresponding to phaseId"
  input String[:] phaseId={"Liquid","Vapor"} "Phase id vector";
  output Integer[size(phaseId,1)] presentPhaseVector
    "Integer vector containing index for corresponding phaseId";

protected
  Integer index;
  Integer sizePhaseID=size(phaseId,1);

algorithm
  for i in 1:sizePhaseID loop
    index:=getPhaseIndex(phaseId[i]);
    assert(index > 0,phaseId[i]+" is not supported by the media");
    presentPhaseVector[i]:=index;
  end for;

end createPresentPhaseVector;
