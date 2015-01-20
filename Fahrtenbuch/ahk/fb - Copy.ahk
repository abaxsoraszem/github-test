#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include stdio.ahk

log(msg)
{
	printf(msg "`n")
	;MsgBox Step Done
}

;; activate or start the calculator
activateProg()
{
	log("Activating the program")
	if WinExist("KFZ-Fahrtenbuch 3")
	{
		WinActivate
	}
	else
	{
		log("Program is not running")
		ExitApp
	}
}

fillText(value, xpos, ypos)
{
	log("Filling the info " value " on position " xpos " and " ypos)
	Click %xpos%, %ypos%
	Loop, 30
	{
		Send {Delete}
	}
	Loop, 30
	{
		Send {Backspace}
	}
	Send %value%
	Send {Enter}
	Sleep 400
}

fillDatums(Startdatum)
{
	log("Filling the Startdatum " Startdatum)
	activateProg()
	StringSplit fields, Startdatum, .
	
	day 	:= fields1
	month	:= fields2
	year	:= fields3
	
	fillText(day, 	109, 372)
	fillText(month, 126, 372)
	fillText(year, 	150, 372)

	fillText(day, 	450, 372)
	fillText(month, 467, 372)
	fillText(year, 	497, 372)

}

qualityCheck(Startdatum, Startort, StartStrasse, Zielort, ZielStrasse, StartKm, EndKm, Strecke, Grund, PersonFirma, Zweck)
{
	;TODO
}


fill(Startdatum, Startort, StartStrasse, Zielort, ZielStrasse, StartKm, EndKm, Strecke, Grund, PersonFirma, Zweck)
{
	Fahrer := "Csaba Meszaros"

	log("Processing " Grund " Fahrt von " StartStrasse " nach " ZielStrasse " Strecke:" Strecke) 
	qualityCheck(Startdatum, Startort, StartStrasse, Zielort, ZielStrasse, StartKm, EndKm, Strecke, Grund, PersonFirma, Zweck)
	
	; clear prefilled values
	Click 73, 438
	Sleep 400
	Send Y
	activateProg()
	
	; left column
	fillText(Fahrer, 		218, 169)
	fillText(Startort, 		120, 306)
	fillText(StartStrasse, 	139, 333)
	fillDatums(Startdatum)
	fillText(StartKm, 		161, 397)

	; private or business
	if(Grund = "Privat")
	{
		Click 620, 229
		Sleep 400
	}
	else 
	{
		Click 450, 228
		Sleep 400
		fillText(PersonFirma, 	480, 253)
		fillText(Zweck, 		464, 275)
	}

	;right column
	fillText(Zielort, 			464, 306)
	fillText(ZielStrasse, 		465, 332)
	fillText(Strecke, 			613, 397)

}

save()
{
	Click 635, 441
	Sleep 1000
}

;MsgBox Starting the FB program
StdioInitialize()
log(Log initialised)
activateProg()

LineNo = 1
Loop, read, c:\Dropbox\CSABA\Fahrtenbuch\ahk\Menetkonyv2011.txt
{
	if(LineNo > 1)
	{
		StringSplit columns, A_LoopReadLine,%A_Tab%
		Startdatum 		:= columns2
		Startort 		:= columns3
		StartStrasse 	:= columns4
		Zielort			:= columns5
		ZielStrasse		:= columns6
		StartKm			:= columns7
		EndKm			:= columns8
		Strecke			:= columns9
		Grund			:= columns10
		PersonFirma		:= columns11
		Zweck			:= columns12

		fill(Startdatum, Startort, StartStrasse, Zielort, ZielStrasse, StartKm, EndKm, Strecke, Grund, PersonFirma, Zweck)
		save()
		if(LineNo > 550)
		{
			ExitApp
		}
	}
	LineNo += 1
}
MsgBox Finished

