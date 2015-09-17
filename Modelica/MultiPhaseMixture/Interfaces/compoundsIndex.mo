within MultiPhaseMixture.Interfaces;
function compoundsIndex
  "returns position of compound in X array, -1 if not present"
  input String name;
  input Boolean caseSensitive=false;
  output Integer index "position of substance in i X array, -1 if not present";

protected
  Boolean found;
  Integer i;
algorithm
  index:=-1;
  found:=false;
  i:=1;
  while (found == false and i <= nC) loop
    found := Modelica.Utilities.Strings.isEqual(name, substanceNames[i],caseSensitive=caseSensitive);
      if
        (found) then
        index:=i;
      else
        i:=i+1;
      end if;
  end while;

end compoundsIndex;
