within MultiPhaseMixture.Interfaces;
function getPhaseIndex
  "returns position of phase in phaseList array, -1 if not present"
  input String phaseName;
  input Boolean caseSensitive=false;
  output Integer index
    "position of phase in phaseList array, -1 if not present";
protected
  Boolean found;
  Integer i;
algorithm
  index:=-1;
  found:=false;
  i:=1;
  while (found == false and i <= nP) loop
      found:=Modelica.Utilities.Strings.isEqual(phaseName,phases.label[i],caseSensitive=caseSensitive);
      if (found) then
        index:=i;
      else
        i:=i+1;
      end if;
  end while;

end getPhaseIndex;
