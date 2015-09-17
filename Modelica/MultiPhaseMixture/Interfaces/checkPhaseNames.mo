within MultiPhaseMixture.Interfaces;
function checkPhaseNames "Check phaseNames so they are included in phaseList"
  input String[:] phaseNames;
  output Boolean checkOk;
protected
  Integer nbrOfPhasesToCheck,i,index;
algorithm
  nbrOfPhasesToCheck:=size(phaseNames, 1);
  checkOk:=true;
  i:=1;
  while checkOk and i<= nbrOfPhasesToCheck loop
    index := getPhaseIndex(phaseNames[i]);
    if (index < 0) then
      checkOk:=false;
      assert(false,"Check of phase names failed. Phase "+phaseNames[i]+ " is not present in phases.label");
    else
      i:=i + 1;
    end if;
  end while;

end checkPhaseNames;
