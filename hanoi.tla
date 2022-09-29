---- MODULE hanoi ----
EXTENDS TLC, Sequences, Integers

CONSTANTS TSIZE, TSPACES

FullTower[n \in 1..TSIZE] == n \* <<1, 2, 3, ...>>
Board[n \in 1..TSPACES] == IF n = 1 THEN FullTower ELSE <<>>

(* --algorithm hanoi
variables tower = Board;

define 
  D == DOMAIN tower
end define;

begin
while TRUE do
  assert tower[TSPACES] /= FullTower;  with from \in {x \in D : tower[x] /= <<>>},
       to \in {
                y \in D : 
                  \/ tower[y] = <<>>
                  \/ Head(tower[from]) < Head(tower[y])
              } 
  do
    tower[from] := Tail(tower[from]) ||
    tower[to] := <<Head(tower[from])>> \o tower[to];
  end with;
end while;
end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "cd924c73" /\ chksum(tla) = "6008117f")
VARIABLE tower

(* define statement *)
D == DOMAIN tower


vars == << tower >>

Init == (* Global variables *)
        /\ tower = Board

Next == /\ Assert(tower[TSPACES] /= FullTower, 
                  "Failure of assertion at line 18, column 3.")
        /\ \E from \in {x \in D : tower[x] /= <<>>}:
             \E to \in {
                         y \in D :
                           \/ tower[y] = <<>>
                           \/ Head(tower[from]) < Head(tower[y])
                       }:
               tower' = [tower EXCEPT ![from] = Tail(tower[from]),
                                      ![to] = <<Head(tower[from])>> \o tower[to]]

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 
====
