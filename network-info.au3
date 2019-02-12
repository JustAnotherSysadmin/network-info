#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         John Lucas

 Script Function:
	Show Network information

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Constants.au3>
#include <MsgBoxConstants.au3>
;#include <EditConstants.au3>
;#include <GUIConstantsEx.au3>
;#include <StaticConstants.au3>
;#include <WindowsConstants.au3>

Func _GetDOSOutput($sCommand)
    Local $iPID, $sOutput = ""

    $iPID = Run('"' & @ComSpec & '" /c ' & $sCommand, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
    While 1
        $sOutput &= StdoutRead($iPID, False, False)
        If @error Then
            ExitLoop
        EndIf
        Sleep(10)
    WEnd
    Return $sOutput
 EndFunc   ;==>_GetDOSOutput

Global $gListOfStuff = ""

;$gListOfStuff &= ("NETWORK INFORMATION"  & @CRLF)
;$gListOfStuff &= ("--------------------------------------------------------"  & @CRLF)

;$gListOfStuff &= 'Results from "wmic bios get serialnumber":  '

$gListOfStuff &= "Network Computer name is:   "
$gListOfStuff &= (_GetDOSOutput("echo %ComputerName%") )

$gListOfStuff &= "Logged in as:   "
$gListOfStuff &= (_GetDOSOutput("echo %USERDOMAIN%\%UserName%") )

$gListOfStuff &= 'Machine Serial Number:  '
$gListOfStuff &= (_GetDOSOutput('wmic bios get serialnumber | findstr /v "^$" | findstr /v "SerialNumber"'))

$gListOfStuff &= 'BIOS Version:  '
$gListOfStuff &= (_GetDOSOutput('wmic bios get smbiosbiosversion | findstr /v "^$" | findstr /v "SMBIOSBIOS"'))

;$gListOfStuff &= 'OS Build:  '
$gListOfStuff &= (_GetDOSOutput('systeminfo | find "OS Version" | find "Build"') & @CRLF)

; see https://marcusoh.blogspot.com/2008/04/how-to-retrieve-your-ip-address-with.html
;$gListOfStuff &= "Computer's IP address is:     "
;$gListOfStuff &= (_GetDOSOutput('((ipconfig | findstr [0-9].\.[0]).split()[-1]') & @CRLF)

$gListOfStuff &= ("IP settings are: " & @CRLF)
;$gListOfStuff &= ("IP settings are: ")

;deal with escaping quote marks: https://www.autoitscript.com/forum/topic/6728-run-command-escape-quote-marks/
;$gListOfStuff &= (_GetDOSOutput('ipconfig | find "." | find /i /v "suffix"') & @CRLF)
$gListOfStuff &= (_GetDOSOutput('ipconfig /all| findstr [0-9].\. | find /v "Description"') & @CRLF)

;$gListOfStuff &= ("Re-verify our range to the targets...one ping only. "  & @CRLF)
;$gListOfStuff &= ("google.com: " & @CRLF)
;$gListOfStuff &= (_GetDOSOutput('ping -n 1 google.com | find "loss"'))

$gListOfStuff &= ('AutoIt Script:   network-info_2018-02-08.au3'& @CRLF)
$gListOfStuff &= 'Written by John Lucas'


;$gListOfStuff &= (_GetDOSOutput("ping -n 1 127.0.0.1") & @CRLF)
;$gListOfStuff &= ("Red October?"  & @CRLF)

;MsgBox($MB_ICONWARNING, "Network Config", $gListOfStuff)
MsgBox($MB_ICONINFORMATION, "Network Config", $gListOfStuff)

