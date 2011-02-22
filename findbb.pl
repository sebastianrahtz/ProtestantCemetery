$maxx=-99999;
$maxy=-99999;
$minx=99999;
$miny=99999;
while (<>) {
  if (/^[0-9]/) {
    ($x,$y)= /(.*) (.*) .*/;
    if ($x > $maxx) { $maxx = $x ; } 
    if ($y > $maxy) { $maxy = $y ; } 
    if ($x < $minx) { $minx = $x ; } 
    if ($y < $miny) { $miny = $y ; } 
  }
}
$width=$maxx-$minx;
$height=$maxy-$miny;
print "{$minx}{$miny}{$width}{$height}\n";
