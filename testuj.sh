#!/bin/bash

function MenuWiad
{
   echo "  1. Wyślij automatyczną wiadomość"
   echo "  2. Stwórz nową wiadomość"
   echo "  3. Wróć do poprzedniego menu"
   read "z"
   if [ $z = 1 ]
   then
	while read line
	do
	   cat tekst.txt | sendmail $line 
	done <$1

   fi

   if [ $z = 2 ]
   then
	touch tmp.txt
	echo "  Podaj tekst swojej wiadomości. Jeśli chcesz zakończyć podawanie wiadomości wpisz koniec-1 w nowym wierszu i naciśnij enter"
	tresc="przyklad"
	while [ $tresc != "koniec-1" ]
	do
	   tresc=$(cat)
	   if [ $tresc != "koniec-1" ]
	   then
		echo tresc>>tmp.txt
	   fi
	done
	   
	while read line
	do
	   cat tmp.txt | sendmail $line 
	done <$1
   rm tmp.txt
   fi
}
MenuWiad adresy.txt
