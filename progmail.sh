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
	   read tresc
	   if [ $tresc != "koniec-1" ]
	   then
		echo $tresc>>tmp.txt
	   fi
	done
	   
	while read line
	do
	   cat tmp.txt | sendmail $line 
	done <$1
   rm tmp.txt
   fi
   echo "Pomyślnie wysłano wszystkie wiadomości"
}

function MenuWybor
{
   wybor=0
   while [ $wybor != 3 ] 
	do
	echo "  1. Wybór po nazwie użytkownika"
	echo "  2. Wybór po nazwie poczty"
	echo "  3. Cofnij do poprzedniego menu"
	read "d"
	if [ $d = 1 ]
	then
	   echo "  Podaj całość lub część nazwy użytkownika"
	   read "nazwa"
	   echo "  Znalezione adresy:"
	   #grep $nazwa adresy.txt>>nowe.txt
	   grep .*$nazwa.*@.* adresy.txt >>nowe.txt #lepsze
	   cat nowe.txt
	   echo "  Wysyłać do znalezionych adresów?"
	   echo "  1.Tak        2.Nie"
	   read "e"
		if [ $e = 1 ]
		then
		   MenuWiad nowe.txt
		fi
	   rm nowe.txt  
	fi

	if [ $d = 2 ]
	then
	   echo "  Podaj całość lub część nazwy poczty"
	   read "poczta"
	   #grep $poczta adresy
	   grep .*@.*$poczta.* adresy.txt>>nowe.txt #lepiej
	   echo "  Znalezione adresy:"
	   cat nowe.txt
	   echo "  Wysyłać do znalezionych adresów?"
	   echo "  1.Tak        2.Nie"
	   read "f"
		if [ $f = 1 ]
		then
		   MenuWiad nowe.txt
		fi
	   rm nowe.txt

	fi

	if [ $d = 3 ]
	then
		wybor=3

	fi

   done
}

function MenuWys
{
   wys=0
   while [ $wys != 3 ] 
   do
	echo "  1. Wyślij wiadomość do wszystkich zapisanych adresów"
	echo "  2. Wyślij wiadomość do wybranych adresów"
	echo "  3. Cofnij menu głównego"
	read "c"
	   if [ $c = 1 ]
	   then
		MenuWiad adresy.txt
	   fi

	   if [ $c = 2 ]
	   then
	   	MenuWybor
	   fi

	   if [ $c = 3 ]
	   then
	  	wys=3
	   fi

   done
}

                         #Główna fukncja

echo "    Witaj w naszym programie mailowym!"
#echo "    Tworzenie pliku na maile" nie potrzebne bo mamy na początku
#touch adresy  za to możemy go zwiększyć
echo "Menu:"
glowna=0

while [ $glowna != 5 ] 
   do
   echo "  1. Wyświetl zapisane adresy mailowe"
   echo "  2. Dodaj adresy e-mail do listy"
   echo "  3. Wyślij wiadomość"
   echo "  4. Zmień automatyczną wiadomość"
   echo "  5. Wyjdź z programu"
   read "a"
   if [ $a = 1 ]
   then
	cat adresy.txt
   fi

   if [ $a = 2 ]
   then
	spr="przykladowy"
	while [ $spr != "koniec-1" ]
	do
	   echo "Podaj adres:"
	   read "adres"
	   echo $adres>>adresy.txt
	   echo "Jeśli chcesz zakończyć podawanie nowych adresów napisz koniec-1"
	   read spr
	done

   fi

   if [ $a = 3 ]
   then
	MenuWys
   fi

   if [ $a = 4 ]
   then
	echo "  To była treść starej wiadomości:"
	cat tekst.txt
	rm tekst.txt
	touch tekst.txt
	echo "Podaj treść nowej wiadomości. Jeśli chcesz zakończyć podawanie wiadomości wpisz koniec-1 w nowym wierszu i naciśnij enter"
	tresc="przykladowa"	
	while [ $tresc != "koniec-1" ]
	do
	   read tresc
	   if [ $tresc != "koniec-1" ]
	   then
		echo $tresc>>tekst.txt
	   fi
	done

   fi

   if [ $a = 5 ]
   then
	glowna=5
	echo "  Do widzenia!"
   fi
done
exit
