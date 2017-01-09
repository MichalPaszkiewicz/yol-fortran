set datafile separator ","
set autoscale
set terminal pngcairo size 1000,1000 enhanced font 'Verdana,10'
set output "printme.png"
plot[0:365] './fictionbooksreadbyday.csv' title 'fiction' pointtype 6 lc rgb 'blue', './fictionbooksreadbyday.csv' notitle smooth bezier lc rgb 'blue', './nonfictionbooksreadbyday.csv' title 'non-fiction' pointtype 6 lc rgb 'red', './nonfictionbooksreadbyday.csv' notitle smooth bezier lc rgb 'red', './technicalbooksreadbyday.csv' title 'technical' pointtype 6 lc rgb 'black', './technicalbooksreadbyday.csv' notitle smooth bezier lc rgb 'black'