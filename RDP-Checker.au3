#cs ------------------------------------------------------------

		 Au3 Exe : RDP Scanner , ( checks only 3389 port ) ...
	  Author : 9aylas
   Twitter : @9aylas - Stoner Life
 Made in [213]

E0F at 03/09/2017

#ce ------------------------------------------------------------


#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include <Array.au3>

$suck = GUICreate("RDP Checker - 9aylas", 290, 195, 205, 118)
$go = GUICtrlCreateButton("Check", 85, 160, 51, 25)
$load = GUICtrlCreateButton("Load", 9, 160, 51, 25)
$saveas = GUICtrlCreateButton("Save", 152, 160, 51, 25)
$CLEAN = GUICtrlCreateButton("CLS", 230, 160, 51, 25)
$ips = GUICtrlCreateEdit("", 8, 16, 129, 137, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
$goods = GUICtrlCreateEdit("", 141, 16, 142, 137, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
GUISetState(@SW_SHOW)

$port1 = "3389"

While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 Exit
	  Case $go
		 _scan()

	  CASE $clean
		 GUICtrlSetData($goods,"")
		 GUICtrlSetData($ips,"")

	  case $load
		 $here = FileOpenDialog("Load the fucking ip list ", @scriptdir , "(*.*)")
         $here0 = FileRead($here)
		 if @error = false then
         GUICtrlSetData($ips,$here0)
	     Else
		 MsgBox(16,"-_- "," WTF ? ")
	  endif

		 case $saveas
		 $ass = GUICtrlRead($goods)
		 $asss = FileSaveDialog("Save ips",@scriptdir,"file (*.txt)")
		 FileWrite($asss,$ass & @CRLF)
	EndSwitch
WEnd

Func _scan()
   TCPStartup()
   $timerstart = TimerInit()

   $arrIP = StringSplit(GUICtrlRead($ips), @CRLF, 3) ; parse ips to array

   For $IP In $arrIP ; foreach ip in array ips

	  Sleep(500)
	  $test = TCPConnect($IP, $port1)

	  If $test <> -1 Then GUICtrlSetData($goods, $IP & "  #Good" & @CRLF, "newline")

	  Sleep(200)
   Next

   TCPShutdown()
   $timerend = TimerDiff($timerstart)
   TrayTip("9AYLASCANNER", "Finished :)", 7, 1)
EndFunc
