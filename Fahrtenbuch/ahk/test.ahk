#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include h:\progs\AutoHotkey\Lib\stdio.ahk

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

fillInfo(value, xpos, ypos)
{
	log("Filling the info " value " on position " xpos " and " ypos)
	Click %xpos%, %ypos%
	Send %value%
	Sleep 1000
}

fillField(value, fieldName)
{
	log("Filling the field " value)
	ControlSetText fieldName, value, "KFZ-Fahrtenbuch 3"
	Sleep 1000
}

fillStartdatum(Startdatum)
{
	log("Filling the Startdatum " Startdatum)
	activateProg()
	StringSplit fields, Startdatum, .
	
	day 	:= fields1
	month	:= fields2
	year	:= fields3
	
	fillInfo(day, 	109, 372)
	fillInfo(month, 126, 371)
	fillInfo(year, 	150, 373)

}

qualityCheck(Startdatum, Startort, StartStrasse, Zielort, ZielStrasse, StartKm, EndKm, Strecke, Grund, PersonFirma, Zweck)
{
	;TODO
}


runOperation(Startdatum, Startort, StartStrasse, Zielort, ZielStrasse, StartKm, EndKm, Strecke, Grund, PersonFirma, Zweck)
{
	Fahrer := "Csaba Meszaros"

	log("Processing " Grund " Fahrt von " StartStrasse " nach " ZielStrasse " Strecke:" Strecke) 
	qualityCheck(Startdatum, Startort, StartStrasse, Zielort, ZielStrasse, StartKm, EndKm, Strecke, Grund, PersonFirma, Zweck)
	
	; clear prefilled values
	;Click 73, 438
	
	; left column
	fillInfo(Fahrer, 		218, 169)
	fillInfo(Startort, 		120, 306)
	fillInfo(StartStrasse, 	139, 333)
	fillStartdatum(Startdatum)
	fillField(StartKm, 		"WindowsForms10.EDIT.app.0.378734a9")
	;fillInfo(StartKm		161, 397) ; TODO clear field

	; private or business
	if(Grund = "Privat")
	{
		Click 620, 229
		Sleep 200
	}
	else 
	{
		Click 450, 228
		Sleep 200
		fillInfo(PersonFirma, 	480, 253)
		fillInfo(Zweck, 		464, 275)
	}

	;right column
	fillInfo(Zielort, 			464, 306)
	fillInfo(ZielStrasse, 		465, 332)
	fillField(Strecke, 			"WindowsForms10.EDIT.app.0.378734a6")
	;fillInfo(Strecke,			613, 397)	; TODO clear field	
}

;MsgBox Starting the FB program
StdioInitialize()
log(Log initialised)
activateProg()

fillInfo("aaaa", 218, 169)
