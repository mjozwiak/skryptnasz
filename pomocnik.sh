function add {
spr=1
while read line
do
if line == $1
spr=0
break
fi
done  
if spr == 1
$1 >> adresy.txt
}
add "grosik164@wp.pl" adresy.txt
add "mjozwiak@sigma.ug.edu.pl" adresy.txt
