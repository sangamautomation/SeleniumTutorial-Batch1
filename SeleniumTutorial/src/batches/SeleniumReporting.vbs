''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''' Description : Selenium Reporting '''''''''''''''''''''''''''''
' Global Variables Declaration
Option Explicit
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0
Const adSaveCreateNotExist = 1
Const adSaveCreateOverWrite = 2
Const adTypeBinary = 1
Const adTypeText = 2
Const cdoSuppressNone = 0
Const cdoSuppressImages = 1
Const cdoSuppressBGSounds = 2
Const cdoSuppressFrames = 4
Const cdoSuppressObjects = 8
Const cdoSuppressStyleSheets = 16
Const cdoSuppressAll = 31
Dim sharedFolderName , DashAndPDFFolderName
Dim FirstName1, LastName1, DOB1, SSN1
Dim innerTable
Dim noticeResultsLine(50)
Dim strComputerName
Dim pdffilename, DocFileOut, DocXFileOut, textfilename
Dim htmlFileLocation, mhtFileEnv, strHTMLPage, strMHTFile, strOutputMHT, directory, directoryAlias, localDir, localHTML, dailyDir, MHTFileOut
Dim objShell, objIE, objMessage
dim iFSO, oFSO, goFSO
Dim extraImageMessage, dirWithExtraImages
Dim lastPicture, lastPictureCaptured
DIM propFilePath,propFilePath2, JenkinsEmailSubject, screenshotInEmail
Dim Verdict , buildNo
Dim BuildRelease, testDuration
Dim senderEmailId
Dim screenshotArray(20), emailInd
Dim theCaptionArray(300)
Dim Originalidir, ShorterDir, removedPartOfDir
Dim messageBody, testType
Dim StartTimestampTxt, EndTimestampTxt
Dim StartTimestamp, EndTimestamp, auxTimestamp1, auxTimestamp2, auxTimestamp3
Dim TimeDiff, TimeDiff1, TimeDiff2, TimeDiff3
dim propFilePath_Captions, propFilePath_TestHeader , propFilePath_screenshots
Dim LogToAppendTo
DIM SSN
Dim indentCounter


propFilePath_Captions = "D:\Selenium_Logs\Screenshots\Captions.properties"
propFilePath_TestHeader = "D:\Selenium_Logs\Screenshots\TestHeader.properties"
propFilePath_screenshots = "D:\Selenium_Logs\Screenshots\*.png"
propFilePath = "D:\Selenium_Logs\Screenshots\TestOutputData.properties"
propFilePath2 = "D:\Selenium_Logs\Screenshots\TestInputData.properties"
LogToAppendTo = "D:\Selenium_Logs\Screenshots\AutomationReport.log"
main

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''   MAIN   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''   MAIN   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''   MAIN   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Sub main
	testDuration = "5 Min. 5 Sec."
	readInCommanlLineParameters
'	CreateDocHtmlPdfFileNames
	createhtmlFileLocationDirectory
	getPropertyFilestoCurrentWorkingDirectory
	readInThePropertyFile "D:\Selenium_Logs\Screenshots\"
''	readInThePropertyFile directory
	verdict = getPassFailFromCaptions(  )
	CreateDocHtmlPdfFileNames
	AppendScreenshotsToHTML_X directory , mhtFileEnv, removedPartOfDir, "In Progress"
	createWordFromHTML
	SSN = getSSN
	Wscript.Sleep 1000
	purgeMsWordOfemptyandSuppressedInfo
	prepareEmailAndSendIt
'	Wscript.Sleep 10000 
'	copyToSharedOnNetwork localDir, dailyDir 
'	Wscript.Sleep 3000 
'	Wscript.Sleep 3000 
End Sub   

	
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''   MAIN END  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' L I B R A R Y '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function extractedPDFFileName( byval sourceFilename)
   Dim P , LastP, beforeLast, Start 
   Dim tempString
   P = InStr(1, sourceFilename, "\")
   Do While P
      beforeLast = LastP
      LastP = P
       P = InStr(LastP + 1, sourceFilename, "\")
   Loop
	tempString = mid(sourceFilename, beforeLast+1, LastP-beforeLast-1 )
    extractedPDFFileName = tempString
End function


sub cleanupInstancesOfProcesses()
dim strComputer 
dim wmiNS 
dim wmiQuery 
dim objWMIService 
dim colItems 
dim objItem 
Dim strOUT 
Dim oShell : Set oShell = CreateObject("WScript.Shell")
oShell.Run "taskkill /im WINWORD.EXE", , True

 on error resume  next
strComputer = "." 
wmiNS = "\root\cimv2" 
wmiQuery = "Select processID from win32_process where name = 'iexplore.exe'" 
 
Set objWMIService = GetObject("winmgmts:\\" & strComputer & wmiNS) 
Set colItems = objWMIService.ExecQuery(wmiQuery) 

For Each objItem in colItems 
	objItem.terminate(1) 
Next 

wmiQuery = "Select processID from win32_process where name = 'WINWORD.EXE'" 
Set colItems = objWMIService.ExecQuery(wmiQuery) 
 
For Each objItem in colItems 
	objItem.terminate(1) 
Next 

wmiQuery = "Select processID from win32_process where name = 'EXCEL.EXE'" 
Set colItems = objWMIService.ExecQuery(wmiQuery) 
 
For Each objItem in colItems 
	objItem.terminate(1) 
Next 

dim filesys 
Set filesys = CreateObject("Scripting.FileSystemObject") 
filesys.DeleteFile  directory & "*.pdf" 
filesys.DeleteFile  directory & "*.do*"
 On Error GoTo 0
 Set oShell = nothing
end sub


sub addAllPDFasAttachment ( byval ObjSendMail )
	DIM objFSO, objFolder, colFiles, objFile
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFSO.GetFolder(directory)
	Set colFiles = objFolder.Files
    For Each objFile in colFiles
       If (instr(objFile.Name, ".PDF") > 0 or instr(objFile.Name, ".pdf")>0) and (instr(objFile.Name, "Notice") >0) Then
		  ObjSendMail.AddAttachment directory & objFile.Name
       End If
    Next
end sub


function getSSN()
	DIM StrData
	StrData = "initialvalue"
	DIM ObjFso, ObjFile
	Wscript.sleep 1000	
	Set ObjFso = CreateObject("Scripting.FileSystemObject")
	Wscript.sleep 1000	
	Set ObjFile = ObjFso.OpenTextFile( directory  & "TestOutputData.properties" )
	StrData = ObjFile.ReadLine
	Do 
		StrData = ObjFile.ReadLine
		if (instr(LCase(StrData), "ssn1") > 0 AND instr(LCase(StrData), "havessn1")<1 AND instr(LCase(StrData), "forssn1")<1 ) then
			SSN1 = right(StrData, 9)
			getSSN  = SSN1
		end if
		if (instr(LCase(StrData), "fname1") > 0  AND  instr(LCase(StrData), "dependentupon")<1) then
			FirstName1 = mid(StrData , instr(StrData,"=")+1)
		end if
	
		if (instr(LCase(StrData), "lname1") > 0 AND  instr(LCase(StrData), "full")<1 ) then
			LastName1 = mid(StrData , instr(StrData,"=")+1)
		end if
		if (instr(LCase(StrData), "dob1") > 0 ) then
			DOB1 = mid(StrData , instr(StrData,"=")+1)
		end if
			if (instr(LCase(StrData), "buildno") > 0 ) then
			buildNo = mid(StrData , instr(StrData,"=")+1)
		end if
		if (instr(LCase(StrData), "testduration") > 0 ) then
			testDuration = mid(StrData , instr(StrData,"=")+1)
		end if
	Loop Until ObjFile.AtEndOfStream
	
end function


sub WriteToLog( prefix, diiirectory  )
	Dim strSafeDate, strSafeTime, strDateTime
	Dim objFile
	Dim fso
	strSafeDate = DatePart("yyyy",Date) & "-" & Right("0" & DatePart("m",Date), 2) & "-"& Right("0" & DatePart("d",Date), 2)
	strSafeTime = "Time:"& Right("0" & Hour(Now), 2) & ":"+ Right("0" & Minute(Now), 2) & ":"+ Right("0" & Second(Now), 2)
	strDateTime = strSafeDate & "-" & strSafeTime
	Set goFSO = CreateObject("Scripting.FileSystemObject")
	if  diiirectory = ""  or  len(diiirectory) < 5  then
		LogToAppendTo = "D:\RFT\TestAutomation_AREEF_logs\AutomationReport.log" 'Declared as global
	else
		LogToAppendTo = diiirectory & "AutomationReport.log"
	end if
	'msgBox LogToAppendTo
	Set objFile = goFSO.OpenTextFile(LogToAppendTo, ForAppending, True)
	objFile.WriteLine "---------------------------------------------------------------------------------" & strDateTime
	objFile.WriteLine  "---[" & prefix & "]---"
	objFile.WriteLine "Arguments:"
	objFile.WriteLine "htmlFileLocation = " & Wscript.Arguments.Item(0)
	objFile.WriteLine "mhtFileEnv = " & mhtFileEnv & " = Wscript.Arguments.Item(1) = " & vbTab  & Wscript.Arguments.Item(1)
	objFile.WriteLine "extraImageMessage = " & extraImageMessage & vbTab & " = Wscript.Arguments.Item(2) = " & vbTab  & Wscript.Arguments.Item(2)
	objFile.WriteLine "dirWithExtraImages = " & dirWithExtraImages & vbTab & " = Wscript.Arguments.Item(3) = [" & Wscript.Arguments.Item(3) & "]"
	objFile.WriteLine "screenshotInEmail = " & screenshotInEmail & vbTab  & " = Wscript.Arguments.Item(4) = [" & Wscript.Arguments.Item(4) & "]"
	objFile.WriteLine "JenkinsEmailSubject = " & JenkinsEmailSubject & vbTab  & " = Wscript.Arguments.Item(5) = [" & Wscript.Arguments.Item(5) & "]"
	objFile.WriteLine ""
	objFile.WriteLine "Retrieved or Calculated:"
	objFile.WriteLine "SSN1_____________: " & vbTab & getSSN
	objFile.WriteLine "SOURCE DIRECTORY_: " & vbTab & directory
	objFile.WriteLine "CONTINUOUS DIR___: " & vbTab & localDir
	objFile.WriteLine "DAILY DIRECTORY__: " & vbTab & dailyDir
	objFile.WriteLine "strHTMLPage______: " & vbTab & strHTMLPage
	objFile.WriteLine "strOutputMHT_____: " & vbTab & strOutputMHT
	objFile.WriteLine "localHTML________: " & vbTab & localHTML
	objFile.WriteLine "pdffilename______: " & vbTab & pdffilename 
	objFile.WriteLine "DocFileOut_______: " & vbTab & DocFileOut
	objFile.WriteLine "textfilename_____: " & vbTab & textfilename
	objFile.WriteLine "sharedFolderName_: " & vbTab & sharedFolderName
	objFile.WriteLine "java -jar D:\jars\PdfToTxt.jar " & CHR(34) & directory & "\" & CHR(34)
	objFile.WriteLine "java -jar D:\jars\VerifyTextMeetsRequirements.jar " & CHR(34) & directory & CHR(34) & "  " & CHR(34)& directory & CHR(34)
	objFile.Close
end sub

sub AppendResultsToTesultsLog (destination , result)
	Dim objFile
	Dim logDate, LogTime, testName
	Set goFSO = CreateObject("Scripting.FileSystemObject")
	logDate = DatePart("yyyy",Date) & "-" & Right("0" & DatePart("m",Date), 2) & "-"& Right("0" & DatePart("d",Date), 2)
	LogTime = Right("0" & Hour(Now), 2) & ":"+ Right("0" & Minute(Now), 2) & ":"+ Right("0" & Second(Now), 2)
	testName = left(strHTMLPage, instr(strHTMLPage, "\rational_ft_logframe.html")-1)
	testName  = mid(testName, InStrRev(testName, "\")+1)
	on error resume next
	if instr(destination, "day") > 0 then 
		Set objFile = goFSO.OpenTextFile(dailyDir & "RFTDailyRegressionResults.csv", ForAppending, True)
		objFile.WriteLine mhtFileEnv & "," & logDate &  "," & LogTime & "," & testName &  "," & result
	else
		Set objFile = goFSO.OpenTextFile(localDir & "RFTAllTimeRegressionResults.csv", ForAppending, True)
		objFile.WriteLine mhtFileEnv & "," & logDate & "," & LogTime & "," & testName &  "," & result
	end if
	objFile.Close	
	on error goto 0
	
end sub


sub getPropertyFilestoCurrentWorkingDirectory()
	Dim command1, command2,command21, command3, command4, networkDaily 
	Dim WshShell, oExec
	DIM fso    
    Set fso = CreateObject("Scripting.FileSystemObject")
	Set objShell = CreateObject("Shell.Application")
	command2 = "/c copy " & chr(34) & propFilePath & chr(34) & " " & CHR(34) & directory & CHR(34) 
	objShell.ShellExecute "cmd.exe", command2, "", "runas", -1	
	if  NOT ( fso.FileExists(directory &"\TestOutputData.properties")) then
		command2 = "/c copy " & chr(34) & propFilePath & chr(34) & " " & CHR(34) & directory & CHR(34) 
		objShell.ShellExecute "cmd.exe", command2, "", "runas", -1
	end if
	command2 = "/c copy " & chr(34) & propFilePath & chr(34) & " " & CHR(34) & directory & CHR(34) 
	objShell.ShellExecute "cmd.exe", command2, "", "runas", -1
	if  NOT ( fso.FileExists(directory &"\Captions.properties")) then
		command2 = "/c copy " & chr(34) & propFilePath & chr(34) & " " & CHR(34) & directory & CHR(34) 
		objShell.ShellExecute "cmd.exe", command2, "", "runas", -1	
	end if
	
	command2 = "/c copy " & chr(34) & propFilePath & chr(34) & " " & CHR(34) & directory & CHR(34) 
	objShell.ShellExecute "cmd.exe", command2, "", "runas", -1	
	if  NOT ( fso.FileExists(directory &"\TestHeader.properties")) then
		command2 = "/c copy " & chr(34) & propFilePath & chr(34) & " " & CHR(34) & directory & CHR(34) 
		objShell.ShellExecute "cmd.exe", command2, "", "runas", -1
	end if
	
	if  NOT ( fso.FileExists(directory &"\TestInputData.properties")) then
		command21 = "/c copy " & chr(34) & propFilePath2 & chr(34) & " " & CHR(34) & directory & CHR(34) 
		objShell.ShellExecute "cmd.exe", command21, "", "runas", -1	
	end if
	
	localDir = "D:\RFT\TestAutomationReports\"
	networkDaily = "Z:\Team Folders\AutomationTeam\AutomationReports\"
	dailyDir = localDir & DatePart("yyyy",Date) & "-" & Right("0" & DatePart("m",Date), 2) & "-"& Right("0" & DatePart("d",Date), 2)
	command3 = "/c mkdir " & dailyDir
	objShell.ShellExecute "cmd.exe", command3, "", "runas", -1
	dailyDir = dailyDir & "\"
	command2 = "/c copy " & directory & "*.pdf   " & dailyDir
	objShell.ShellExecute "cmd.exe", command2, "", "runas", -1
	
	networkDaily = networkDaily & DatePart("yyyy",Date) & "-" & Right("0" & DatePart("m",Date), 2) & "-"& Right("0" & DatePart("d",Date), 2)
	command3 = "/c mkdir " & chr(34) & networkDaily & "\" & chr(34)
	objShell.ShellExecute "cmd.exe", command3, "", "runas", -1
	
	command2 = "/c copy " & dailyDir & "*.* " & chr(34) & networkDaily & chr(34)
	objShell.ShellExecute "cmd.exe", command2, "", "runas", -1
	
	Set objShell = Nothing
	Set fso = Nothing
end sub


sub ConvertPDFToText( concernedDirectory )
 wScript.Sleep 1000
  dim concernedDirectoryb
	Dim oShell : Set oShell = CreateObject("WScript.Shell")
	oShell.Run "java -jar D:\jars\PdfToTxt.jar " & CHR(34) & concernedDirectory & "\" & CHR(34), , True
	Set oShell = Nothing
end sub

sub VerifyPDFContent( PropertyDir, PdfDirectory)
 wScript.Sleep 1000
  dim concernedDirectoryb
	Dim oShell : Set oShell = CreateObject("WScript.Shell")
	''msgbox "java -jar D:\jars\VerifyTextMeetsRequirements.jar " & CHR(34) & PropertyDir & CHR(34) & " " & CHR(34)& PdfDirectory & CHR(34)
	oShell.Run "java -jar D:\jars\VerifyTextMeetsRequirements.jar " & CHR(34) & PropertyDir & CHR(34) & " " & CHR(34)& PdfDirectory & CHR(34), , True
	Set oShell = Nothing
end sub


sub appendNoticeEvaluation ( document )
	const numOfCols = 3
	Dim passFail
	dim myRange
	dim objTable
	Dim fso, count, src, folder, file
	Set objTable = document.Tables(1)
	Set fso = CreateObject("Scripting.FileSystemObject")
	
	src = directory
	Set folder = fso.GetFolder(src)
	count = 0
	objTable.Cell(document.Tables(1).Rows.Count, 1).Range.ListFormat.RemoveNumbers
	objTable.Rows.Add()
	if objTable.Rows(document.Tables(1).Rows.Count).cells.count  > 1 then
		objTable.Cell(document.Tables(1).Rows.Count, 1).Merge objTable.Cell(document.Tables(1).Rows.Count, objTable.Rows(document.Tables(1).Rows.Count).cells.count   )
	end if
	
	With objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font
	 .color =  RGB ( 000, 000, 191 )
	 .size = 10
	 .name = "Arial"
	 .Bold = False
	End With
	
	objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = "Notices Evaluation:"
	objTable.Rows.Add()	
	if objTable.Rows(document.Tables(1).Rows.Count).cells.count  > 1 then
		objTable.Cell(document.Tables(1).Rows.Count, 1).Merge objTable.Cell(document.Tables(1).Rows.Count, objTable.Rows(document.Tables(1).Rows.Count).cells.count   )
	end if
	For Each file In folder.files	
		If LCase(fso.GetExtensionName(file)) = "txt" and instr(file.name ,"Notice") > 0  Then
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = replace(file.name, ".txt", ".pdf")
			objTable.Rows.Add()
			count = count + 1
			passFail = isYouRightToTimelyPresent (file.name)
			objTable.Cell(document.Tables(1).Rows.Count, 1).Split 1, 5
			objTable.Cell(document.Tables(1).Rows.Count, 2).Merge objTable.Cell(document.Tables(1).Rows.Count, 5)
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = passFail
			objTable.Cell(document.Tables(1).Rows.Count, 2).Range.Text = "Verbiage: 'YOUR RIGHT TO TIMELY APPLICATION PROCESSING' is present." 
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.bold = True
			if (instr(passFail,"P") > 0 ) then 
				objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB (000,155,000) 
			else 
				objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB (155,000,000)
			end if
			objTable.Rows.Add()
			passFail = isYouRightToTimelyAbsent (file.name)
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = passFail 
			objTable.Cell(document.Tables(1).Rows.Count, 2).Range.Text = "Verbiage: 'Do you need health care coverage for the three months before your coverage began?' is absent " 
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.bold = True
			if (instr(passFail,"P") > 0 ) then 
				objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB (000,155,000) 
			else 
				objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB (155,000,000)
			end if
			objTable.Rows.Add()
			objTable.Cell(document.Tables(1).Rows.Count, 1).Merge objTable.Cell(document.Tables(1).Rows.Count, 2)
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.ListFormat.RemoveNumbers
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = file.name
		End If
	Next 
	if count > 0 then
		objTable.Cell(document.Tables(1).Rows.Count, 1).delete
	else
		objTable.Rows.Add()
		objTable.Cell(document.Tables(1).Rows.Count, 1).Split 1, 5
		objTable.Cell(document.Tables(1).Rows.Count, 2).Merge objTable.Cell(document.Tables(1).Rows.Count, 4)
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = "Note"
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB ( 000, 000, 206 )
		objTable.Cell(document.Tables(1).Rows.Count, 2).Range.Text = "Please ensure that the Notices generated meet the expectation as the automation tool does not validate them. " '"No notices found at all as I am not subscribed to EEF Notify Admin emails in this environment."
    end if	
end sub

function isYouRightToTimelyPresent ( filename )
 	Dim ffso, fii
	Dim tetxtt
   ' isYouRightToTimelyPresent = "Fail"
	isYouRightToTimelyPresent = "Note"
	Set ffso = CreateObject("Scripting.FileSystemObject")
    Set fii = ffso.OpenTextFile(directory & fileName, 1)
	tetxtt = fii.ReadAll
	if instr( tetxtt, "YOUR RIGHT TO TIMELY APPLICATION PROCESSING" ) > 0 then isYouRightToTimelyPresent = "Pass"
end function

function isYouRightToTimelyAbsent ( filename )
 	Dim ffso, fii
	Dim tetxtt
    isYouRightToTimelyAbsent = "Pass"
	Set ffso = CreateObject("Scripting.FileSystemObject")
    Set fii = ffso.OpenTextFile(directory & fileName, 1)
	tetxtt = fii.ReadAll
	'if instr( tetxtt, "Do you need health care coverage for the three months before your coverage began?" ) > 0 then isYouRightToTimelyAbsent = "Fail"
		if instr( tetxtt, "Do you need health care coverage for the three months before your coverage began?" ) > 0 then isYouRightToTimelyAbsent = "Note"
end function



sub cleanupInstancesOfCommand()
	dim strComputer 
	dim wmiNS 
	dim wmiQuery 
	dim objWMIService 
	dim colItems 
	dim objItem 
	Dim strOUT 
	Dim oShell : Set oShell = CreateObject("WScript.Shell")
	on error resume  next	
	strComputer = "." 
	wmiNS = "\root\cimv2" 
	wmiQuery = "Select processID from win32_process where name = 'cmd.exe'" 
	Set objWMIService = GetObject("winmgmts:\\" & strComputer & wmiNS) 
	Set colItems = objWMIService.ExecQuery(wmiQuery) 
	For Each objItem in colItems 
		objItem.terminate(1) 
	Next
	Set oShell = Nothing
end sub


Sub DeleteEmptyTablerows(ActiveDocument)
	Dim Tbl, cel, i , n , fEmpty
	With ActiveDocument
		For Each Tbl In .Tables
			n = Tbl.Rows.Count
			For i = n To 1 Step -1
				fEmpty = True
				For Each cel In Tbl.Rows(i).Cells
					If ((Len(cel.Range.Text) > 2) and ( instr(cel.Range.Text, "-201")=0))  Then
						fEmpty = False
						Exit For
					End If
				Next 'cel
				If fEmpty = True Then Tbl.Rows(i).Delete
			Next 'i
		Next' Tbl
	End With
	Set cel = Nothing: Set Tbl = Nothing
End Sub

Sub RemoveDateAndMergreWithFollowing(ActiveDocument)
	Dim Tbl, cel, i , n , fEmpty
	dim precedentcell, followingcell
	dim thecontent
	dim precedentSet, precedentProcessed, precedentToBeProcessed
	With ActiveDocument
		For Each Tbl In .Tables
			n = Tbl.Rows.Count
			
			For i = n To 1 Step -1
				Set precedentcell = nothing
				precedentSet = false
				For Each cel In Tbl.Rows(i).Cells
					If (( instr(cel.Range.Text, "-201")> 0))  Then
					    Set precedentcell = cel
						cel.Range.Text = ""
						precedentSet = true
						precedentToBeProcessed = false
					End If
					if ((precedentSet = true) and (precedentToBeProcessed = true)) then
                      thecontent = cel.Range.Text
					  cel.Merge precedentcell
					end if
					precedentToBeProcessed = true
				Next

			Next 'i
		Next' Tbl
	End With
	Set cel = Nothing: Set Tbl = Nothing
End Sub


sub appendExtraPictures ( document, extraImageMessage, dirWithExtraImages )
	if document = NULL then exit sub
	if dirWithExtraImages = "" then exit sub
	DIM objTable, objSelection, objShape, myRange
	DIM objFSO, objFolder, colFiles, objFile
	Set objTable = document.Tables(1)
	objTable.Cell(document.Tables(1).Rows.Count, 1).Range.ListFormat.RemoveNumbers
	objTable.Cell(document.Tables(1).Rows.Count-1, 1).Range.ListFormat.RemoveNumbers
	 objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB ( 000, 060, 190 )
	objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.size = 12
	objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.bold = False
	objTable.Rows.Add()
	if document.Tables(1).Rows(document.Tables(1).Rows.Count).cells.count  > 1 then
		document.Tables(1).Cell(document.Tables(1).Rows.Count, 1).Merge objTable.Cell(document.Tables(1).Rows.Count, objTable.Rows(document.Tables(1).Rows.Count).cells.count   )
	end if
	
	 objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB ( 000, 060, 190 )

 	objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = extraImageMessage
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFSO.GetFolder(dirWithExtraImages)
	Set colFiles = objFolder.Files
	objTable.Rows.Add()
    For Each objFile in colFiles
	    If (instr(objFile.Name, ".JPG") > 0 or instr(objFile.Name, ".jpg") > 0 or instr(objFile.Name, ".BMP") > 0 or instr(objFile.Name, ".bmp") > 0 or instr(objFile.Name, ".PNG") > 0 or instr(objFile.Name, ".png") > 0) Then
 			objTable.Rows.Add()
			objTable.Cell(document.Tables(1).Rows.Count, 1).Range.InlineShapes.AddPicture dirWithExtraImages & "\" & objFile.Name 
       End If
    Next
	objTable.Rows.Add()
end sub


sub addFinalResult ( document )
	if document = NULL then exit sub
	DIM objTable, objSelection, objShape, myRange
	DIM objFSO, objFolder, colFiles, objFile
	Dim ll
	Dim passFail
	Set objTable = document.Tables(1)
	
	objTable.Rows.Add()
	passFail = getPassFailFromCaptions(  )
	
	if (objTable.Rows(document.Tables(1).Rows.Count).cells.count < 2 ) then 
		objTable.Cell(document.Tables(1).Rows.Count, 1).Split 1, 5
		objTable.Cell(document.Tables(1).Rows.Count, 2).Merge objTable.Cell(document.Tables(1).Rows.Count, 5)
	end if
	if (passFail="Pass") then 
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB ( 000, 198, 000 )
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.size = 13
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = "SUCCESSFUL"
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Font.Bold = True
		
	Elseif (passFail="Fail") then 
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB ( 200, 000, 000 )
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.size = 14
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = "FAILED"
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Font.Bold = True
		
	else
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.color =  RGB ( 255, 122, 000 )
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.size = 14
		objTable.Cell(document.Tables(1).Rows.Count, 1).Range.Text = "ABORTED"
	end if

	objTable.Cell(document.Tables(1).Rows.Count, 2).Range.font.size = 13
	objTable.Cell(document.Tables(1).Rows.Count, 2).Range.Text = "*** Test Case Verdict ***"
	objTable.Rows.Add()
	objTable.Cell(document.Tables(1).Rows.Count, 1).Range.font.size = 12
	objTable.PreferredWidth = 100
	With document.PageSetup
		.LeftMargin = document.Application.InchesToPoints(0.5)
		.RightMargin = document.Application.InchesToPoints(0.5)
	End With 
end sub


sub addAllPDFasAttachmentX ( byval ObjSendMail )
	DIM objFSO, objFolder, colFiles, objFile
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFSO.GetFolder(directory)
	Set colFiles = objFolder.Files
    For Each objFile in colFiles
       If (instr(objFile.Name, ".PDF") > 0 or instr(objFile.Name, ".pdf")>0) and (instr(objFile.Name, "Notice") >0) Then
		  ObjSendMail.attachments.add directory & objFile.Name
       End If
    Next
end sub


sub SendMessageX ( JenkinsEmailSubject, outlookfolder , eSender, messageSubject , messageBody, pdffilename)
	Const olMailItem = 0 ' Constants for new items
	Const olAppointmentItem = 1
	Const olContactItem = 2
	Const olTaskItem = 3
	Const olJournalItem = 4
	Const olNoteItem = 5
	Const olPostItem = 6
    Dim i
    Dim olApp, rrr 
    Dim olNS 
    Dim MyFolder 
    Dim ObjMail 
	Dim MyFolders
	Dim ReleaseFolder
	dim recip
	Dim objItem 
	Dim attc 
	Dim recipientList, PDFAlalysis, CCrecipients, BCCrecipients, TOrecipients
	Dim respondDate, respondTime
	Dim emailSent
	emailSent="false"
	PDFAlalysis = directory & "PDFComparisonResult.txt"
	respondDate = DatePart("yyyy",Date) & "-" & Right("0" & DatePart("m",Date), 2) & "-"& Right("0" & DatePart("d",Date), 2)
	respondTime = Right("0" & Hour(Now), 2) & ":"+ Right("0" & Minute(Now), 2) & ":"+ Right("0" & Second(Now), 2)
'	recipientList = "<B>From: </b> Build Server<br><b>Sent: </b>" & respondDate & " " & respondTime & "<br><b>To: </b>"
	recipientList = "<B>From: </b> Jenkins App ID [mailto:jenkins@jenkinsdev.state.ar.us]<br><b>Sent: </b>" & respondDate & " " & respondTime & "<br><b>To: </b>"
	
    Set olApp = CreateObject( "Outlook.Application" )
    Set olNS = olApp.GetNamespace("MAPI")
	if (JenkinsEmailSubject <> "N/A" and (instr(messageSubject, "ABORTED") <= 0)) then
		Set MyFolders = olNS.GetDefaultFolder(6).Folders
		For i = MyFolders.Count To 1 Step -1
			if instr(MyFolders(i).name, outlookfolder ) > 0 then 
				Set ReleaseFolder = MyFolders(i) 
			end if
		next
		Set ObjMail = olApp.CreateItem (0)
		CCrecipients = "": BCCrecipients="": TOrecipients=""
		For Each objItem In ReleaseFolder.Items 
			if ( trim(objItem.Subject) = trim(JenkinsEmailSubject) ) then
				Set ObjMail = olApp.CreateItem (0)
				recipientList = recipientList & "; " & eSender & ";"
				ObjMail.To = eSender
				ObjMail.Recipients.add objItem.SenderEmailAddress
				for each recip in objItem.Recipients
					ObjMail.Recipients.add recip.address
					ObjMail.Recipients( ObjMail.Recipients.count).type = recip.type
				next 
				ObjMail.cc="d@d.com"
				BuildRelease = messageSubject
				recipientList = recipientList & "<br><b>Subject: </b>" & messageSubject & "<br><br>"
				ObjMail.Subject = mid(objItem.Subject & " - " & messageSubject, 1, 256)
				ObjMail.HTMLBody =  messageBody  & "<HR><br>" & recipientList &   objItem.HTMLBody
				'ObjMail.BodyFormat = objItem.BodyFormat

				
				ObjMail.attachments.add pdffilename
					''		msgbox "D:\RFT\TestAutomation_AREEF_logs\AutomationTest_ExecutionLog\ConsoleLogs\" & mid(removedPartOfDir, 1, InStrRev(removedPartOfDir, "_")-1 ) & ".log"
					''msgbox "D:\RFT\TestAutomation_AREEF_logs\AutomationTest_ExecutionLog\ConsoleLogs\" &removedPartOfDir & ".log"

				
				'ObjMail.attachments.add "D:\RFT\TestAutomation_AREEF_logs\AutomationTest_ExecutionLog\ConsoleLogs\"  &removedPartOfDir & ".log"
				
				addAllPDFasAttachmentX ObjMail 
				addEmbeddedScreenshotsX ObjMail 
				IF lastPictureCaptured <> "aa" Then
					On error resume next
					ObjMail.attachments.add  directory & lastPictureCaptured
					ObjMail.attachments.add  lastPictureCaptured
					on error goto 0
				END IF			
				On Error Resume Next
					wScript.Sleep 3000
				On Error Goto 0
				ObjMail.Send
				emailSent = "true"
				Exit For
			else
				
			end if
		next
		if (emailSent <> "true" and JenkinsEmailSubject <> "N/A") then
			Set ObjMail = olApp.CreateItem (0)
			CCrecipients = "": BCCrecipients="": TOrecipients=""
			JenkinsEmailSubject = replace(JenkinsEmailSubject, "$RevisionNumber", buildNo)
			Set ObjMail = olApp.CreateItem (0)
 			ObjMail.cc="selenium.automation.class@gmail.com"
			ObjMail.to = "selenium.automation.class@gmail.com"
			ObjMail.Subject = JenkinsEmailSubject & " - " & mid(messageSubject, 1, 256)
			ObjMail.HTMLBody =  messageBody
			ObjMail.attachments.add pdffilename
			on error resume next
			'ObjMail.attachments.add "D:\Selenium_Logs\Screenshots\"  &removedPartOfDir & ".log"
			on error goto 0
			addAllPDFasAttachmentX ObjMail 
			addEmbeddedScreenshotsX ObjMail 
			IF lastPictureCaptured <> "aa" Then
				On error resume next
				ObjMail.attachments.add  directory & lastPictureCaptured
				ObjMail.attachments.add  lastPictureCaptured
				on error goto 0
			END IF					
			On Error Resume Next
				wScript.Sleep 3000
			On Error Goto 0
			ObjMail.Send
			emailSent = "true"
		end if
		if emailSent <> "true" then
			Set ObjMail = olApp.CreateItem (0)
			CCrecipients = "": BCCrecipients="": TOrecipients=""
			Set ObjMail = olApp.CreateItem (0)
			ObjMail.cc="selenium.automation.class@gmail.com"
			ObjMail.to = "selenium.automation.class@gmail.com	"
			ObjMail.Subject = mid(messageSubject, 1, 256)
			ObjMail.HTMLBody =  messageBody
			ObjMail.attachments.add pdffilename
			on error resume next
			'ObjMail.attachments.add "D:\RFT\TestAutomation_AREEF_logs\AutomationTest_ExecutionLog\ConsoleLogs\"  &removedPartOfDir & ".log"
			on error goto 0
			addAllPDFasAttachmentX ObjMail 
			addEmbeddedScreenshotsX ObjMail 
			IF lastPictureCaptured <> "aa" Then
				On error resume next
				ObjMail.attachments.add  directory & lastPictureCaptured
				ObjMail.attachments.add  lastPictureCaptured
				on error goto 0
			END IF			
			On Error Resume Next
				wScript.Sleep 3000
			On Error Goto 0
			ObjMail.Send
		end if
	else
		Set ObjMail = olApp.CreateItem (0)
		CCrecipients = "": BCCrecipients="": TOrecipients=""
		Set ObjMail = olApp.CreateItem (0)
		ObjMail.cc="Sathish Vijayaraghavan <Sathish.Vijayaraghavan@arkansas.gov>;Greg Bobrowski <Greg.Bobrowski@arkansas.gov>"
		ObjMail.to = "Neetin Hedau <Neetin.Hedau@arkansas.gov>; Sangam Yadagiri <Sangam.Yadagiri@arkansas.gov>; Shailendra Dixit <Shailendra.Dixit@arkansas.gov>; Lavanya Pulivarthi <Lavanya.Pulivarthi@arkansas.gov>"
		ObjMail.Subject = mid(messageSubject, 1, 256)
		ObjMail.HTMLBody =  messageBody
		ObjMail.attachments.add pdffilename
		on error resume next
		'ObjMail.attachments.add "D:\RFT\TestAutomation_AREEF_logs\AutomationTest_ExecutionLog\ConsoleLogs\"  &removedPartOfDir & ".log"
		on error goto 0
		addAllPDFasAttachmentX ObjMail 
		addEmbeddedScreenshotsX ObjMail 
		IF lastPictureCaptured <> "aa" Then
			On error resume next
			ObjMail.attachments.add  directory & lastPictureCaptured
			ObjMail.attachments.add  lastPictureCaptured
			on error goto 0
		END IF			
		On Error Resume Next
			wScript.Sleep 3000
		On Error Goto 0
		ObjMail.Send
	end if
end sub

sub copyToSharedOnNetwork( localDirP, dailyDirP )
	Dim objShell
    Dim fso
	Dim Folder, Subfolder
	Dim dateString, command3
	Dim command2, sharedPath, ss
	Dim testName, result, assembled
	Dim lSharedFolderName
	lSharedFolderName = sharedFolderName
	'result = "Pass"
	result = Verdict
	sharedPath = mid(lSharedFolderName, 1, instr(lSharedFolderName, "$\"))
	
	'dateString = Right("0" & DatePart("m",Date), 2) & Right("0" & DatePart("d",Date), 2) & DatePart("yyyy",Date) ' yyyymmdd
	dateString = DatePart("yyyy",Date) & "-" & Right("0" & DatePart("m",Date), 2) & "-"& Right("0" & DatePart("d",Date), 2) 'yyyy-mm-dd

	testName = left(strHTMLPage, instr(strHTMLPage, "\rational_ft_logframe.html")-1)
	testName  = mid(testName, InStrRev(testName, "\")+1)
	Set fso = CreateObject("Scripting.FileSystemObject")
	
	Set Folder = fso.GetFolder( lSharedFolderName )
	
	On Error Resume Next
	Set objShell = CreateObject("Shell.Application")

	WriteToLog  command2, ""
	ss = mid(directory, 1, len(directory)-1)
		
	command2 = "Z: "
	objShell.ShellExecute "cmd.exe", command2, " ", "runas", -1
	
	command2 = "cd " & chr(34) &  "Z:\Team Folders\AutomationTeam\Logs\AllCopies" & chr(34) 
	objShell.ShellExecute "cmd.exe", command2, " ", "runas", -1
	
	command2 = "/c mkdir " & chr(34) &  "Z:\Team Folders\AutomationTeam\Logs\" & removedPartOfDir  & chr(34)
	objShell.ShellExecute "cmd.exe", command2, " ", "runas", -1
	
    command2 = "/c copy " &chr(34) & directory & "*.doc" & chr(34) & " " & chr(34) &  "Z:\Team Folders\AutomationTeam\AllCopies\"  & chr(34)
	objShell.ShellExecute "cmd.exe", command2, " ", "runas", -1

    command2 = "/c copy " &chr(34) & directory & "Re*.pdf" & chr(34) & " " & chr(34) &  "Z:\Team Folders\AutomationTeam\AllCopies\"  & chr(34)
	objShell.ShellExecute "cmd.exe", command2, " ", "runas", -1	
	
    command2 = "/c copy " &chr(34) & directory & chr(34) & " " & chr(34) &  "Z:\Team Folders\AutomationTeam\Logs\" & removedPartOfDir & chr(34)
	objShell.ShellExecute "cmd.exe", command2, " ", "runas", -1

	command2 = "C:"
	objShell.ShellExecute "cmd.exe", command2, " ", "runas", -1
	
	
	on error goto 0

	'On Error Resume Next
	assembled = chr(34) & "D:\RFT\TestAutomation_AREEF\batches\maintainSharedExcel.vbs" & chr(34) & " " & chr(34) & mhtFileEnv & chr(34) & " " & chr(34) &  testName & chr(34) &  " " & chr(34) & result & chr(34)  & " "  & chr(34) & sharedFolderName & "\"  & chr(34) & " " & chr(34) & JenkinsEmailSubject & chr(34)
	assembled = assembled & " " & chr(34) & FirstName1  & chr(34) & " " & chr(34) & LastName1 & chr(34) & " " & chr(34) & DOB1 & chr(34) & " " & chr(34) & SSN1 & chr(34) & " " & chr(34)  & buildNo & chr(34)
	'msgbox assembled
	CreateObject("WScript.Shell").Run  assembled
	
	'Copying Regression Dashboard to Regression Status Folder
	Wscript.sleep 3000
	
	'on error goto 0
	Set objShell = Nothing
	Set fso = Nothing
	Set Folder = Nothing
end sub


Function translatedMachineName(strComputerName)
    If InStr(strComputerName, "ss-vm-gksh9y1" ) = 1 Then
		translatedMachineName="Jenkins.SIT"
    ElseIf InStr(strComputerName, "ss-D5K9FX1") = 1 Then
        translatedMachineName = "Sangam"    
    ElseIf InStr(strComputerName, "ss-vmd5m7fx1") = 1 Then
        translatedMachineName = "VM.101"
	ElseIf InStr(strComputerName, "ss-vm-gksh9y") = 1 Then
        translatedMachineName = "VM.176"
	Else
        translatedMachineName = strComputerName
    End If
End Function


sub RemoveEmailsInJenkins (JenkinsEmailSubject, outlookfolder)
	Const INBOX = 6
    if outlookfolder = "" then exit sub
	if len(outlookfolder) <5 then exit sub
	if ( JenkinsEmailSubject="" ) then exit sub
	if len(JenkinsEmailSubject) < 5 then exit sub
	Dim oFolder, oItem, oOutlook, MyFolders, ReleaseFolder
	Dim olApp, olNS
	Dim i, max
	max=15
	'msgbox " RemoveEmailsInJenkins " & JenkinsEmailSubject & " " & outlookfolder
    Set oOutlook = CreateObject( "Outlook.Application" )
    Set olNS = oOutlook.GetNamespace("MAPI")
    Set MyFolders = olNS.GetDefaultFolder(INBOX ).Folders
	For i = MyFolders.Count To 1 Step -1
	    if instr(MyFolders(i).name, outlookfolder ) > 0 then 
			Set ReleaseFolder = MyFolders(i) 
		end if
	next
	
	do 
	For Each oItem In ReleaseFolder.Items
		If instr(oItem.Subject , JenkinsEmailSubject) > 0 Then
			oItem.Delete
		End If
	Next
	max  = max - 1
	 wScript.Sleep 3000
	loop while ReleaseFolder.Items.count > 0 and max> 0
	Set oFolder = Nothing
	Set olNS = Nothing
	Set oOutlook = Nothing
end sub

''  RemoveEmailsInNotices "EEF Notify Admin"
sub RemoveEmailsInNotices ( outlookfolder)
	Const INBOX = 6
	Dim dateStr
    if outlookfolder = "" then exit sub
	if len(outlookfolder) <5 then exit sub
	if ( JenkinsEmailSubject="" ) then exit sub
	if len(JenkinsEmailSubject) < 5 then exit sub
	Dim oFolder, oItem, oOutlook, MyFolders, ReleaseFolder
	Dim olApp, olNS
	Dim i, max
	max=25
    Set oOutlook = CreateObject( "Outlook.Application" )
    Set olNS = oOutlook.GetNamespace("MAPI")
    Set MyFolders = olNS.GetDefaultFolder(INBOX ).Folders
	For i = MyFolders.Count To 1 Step -1
	    if instr(MyFolders(i).name, outlookfolder ) > 0 then 
			Set ReleaseFolder = MyFolders(i) 
		end if
	next
	
	do 
	For Each oItem In ReleaseFolder.Items
		If oItem.ReceivedTime < (Date - 3) Then
			oItem.Delete
		End If
	Next
	max  = max - 1
	 wScript.Sleep 3000
	loop while ReleaseFolder.Items.count > 0 and max> 0
	Set oFolder = Nothing
	Set olNS = Nothing
	Set oOutlook = Nothing
end sub

sub addResultsOfNoticeEvaluation(Pdirectory, wdapp, oDoc, numNotices)
    Dim loops
	for loops = 1 to numNotices
		makeTemplate wdapp, oDoc
		populateTemplate wdapp, Pdirectory, loops 
	next
end sub


Const NUMBER_OF_ROWS = 19
Const NUMBER_OF_COLUMNS = 4
Const END_OF_STORY = 6
Const wdPreferredWidthPercent = 2


Sub makeTemplate(wdapp, objDoc)
    noticeResultsLine(1) = ""
    dim objSelection, myRange, objRange, objTable
	dim lastRowNum
	lastRowNum = objDoc.tables(1).rows.count
'	wdapp.visible = true
	set objTable = objDoc.tables(1)
	objDoc.tables(1).rows.add 
	on error resume next  ''   merge cells if row has more than one
	if objTable.Rows(objDoc.Tables(1).Rows.Count).cells.count> 1 then
		objDoc.Tables(1).Cell(objDoc.Tables(1).Rows.Count, 1).Merge objTable.Cell(objDoc.Tables(1).Rows.Count, objTable.Rows(objDoc.Tables(1).Rows.Count).cells.count )
	end if
	on error goto 0
	Set objSelection = wdapp.Selection
	objSelection.TypeParagraph()
	Set myRange = objDoc.Tables(1).Cell(objDoc.Tables(1).Rows.Count, 1).Range
	myRange.Select
	Set objRange =  objSelection.Range
	objRange.Tables.Add objRange, NUMBER_OF_ROWS, NUMBER_OF_COLUMNS
	objRange.Tables.Add objRange, NUMBER_OF_ROWS, NUMBER_OF_COLUMNS

    Set objTable = objSelection.Range.Tables(1)
    objTable.AutoFormat(36)
	Set myRange = objDoc.Range(objTable.Cell(1, 1).Range.Start, objTable.Cell(1, 4 ).Range.End)
	myRange.Select
	objSelection.Shading.BackgroundPatternColor  = RGB(120,220,250)
	objSelection.Font.allcaps = false 
	objSelection.Font.bold  = true
	objSelection.Font.Name = "New Times Roman"
	objSelection.Font.size = 9
	objTable.Cell(1, 1).Range.Text = "Notice Evaluation Status"
	objTable.Cell(1, 2).Range.Text = "Field Name"
	objTable.Cell(1, 3).Range.Text = "Expected Value From Intake Portal (Property File)"
	objTable.Cell(1, 4).Range.Text = "Actual Value (Notice PDF)"

	Set myRange = objDoc.Range(objTable.Cell(2, 1).Range.Start, objTable.Cell(NUMBER_OF_ROWS, 4 ).Range.End)
	myRange.Select
	objSelection.Font.allcaps = false 
	objSelection.Font.bold  = false
	objSelection.Font.Name = "New Times Roman"
	objSelection.Font.size = 8
	

	Set myRange = objTable.Cell(1, 1)
	myRange.Select
	objSelection.Font.size = 5

	objTable.Cell(2, 1).Select
	objTable.Columns(4).Width = 191 
	objTable.Columns(3).Width = 191
	objTable.Columns(1).Width = 35
	objTable.Columns(2).Width = 70 
	Set innerTable = objTable
	'' objSelection.EndKey END_OF_STORY
end sub


sub populateTemplate( directory, notNum )
	Dim objSelection
	Set objSelection = objWord.Selection
	getMessageEvalBody directory, notNum 
	with innerTable	
	For i = LBound(noticeResultsLine) to UBound(noticeResultsLine)
		if (len( noticeResultsLine(i))>10) then
			Set myRange = .Cell(i+1, 1)
			myRange.Select
			if instr( LCase( mid(noticeResultsLine(i), 1,8)), "false" ) > 0 then objSelection.Font.color = vbRed else objSelection.Font.color = RGB(0,90,0)
			.Cell(i+1, 1).Range.Text = trim(mid(noticeResultsLine(i), 1,8))
			.Cell(i+1, 2).Range.Text = trim(mid(noticeResultsLine(i), 9,24))
			.Cell(i+1, 3).Range.Text = trim(mid(noticeResultsLine(i), 33,65))
			.Cell(i+1, 4).Range.Text = trim(mid(noticeResultsLine(i), 97,65))
		end if
	Next 
	end with
end sub


sub populateTemplate( objWord, directory, notNum )
	Dim objSelection
	Dim myRange, i 
	Set objSelection = objWord.Selection
	getMessageEvalBody directory, notNum 
	with innerTable	
	For i = LBound(noticeResultsLine) to UBound(noticeResultsLine)
		if (len( noticeResultsLine(i))>10) then
			Set myRange = .Cell(i+1, 1)
			myRange.Select
			if instr( LCase( mid(noticeResultsLine(i), 1,8)), "false" ) > 0 then objSelection.Font.color = vbRed else objSelection.Font.color = RGB(0,90,0)
			.Cell(i+1, 1).Range.Text = trim(mid(noticeResultsLine(i), 1,8))
			.Cell(i+1, 2).Range.Text = trim(mid(noticeResultsLine(i), 9,24))
			.Cell(i+1, 3).Range.Text = trim(mid(noticeResultsLine(i), 33,65))
			.Cell(i+1, 4).Range.Text = trim(mid(noticeResultsLine(i), 97,65))
		end if
	Next 
	end with
end sub

sub getMessageEvalBody ( directory, notNum)
	const ForReading = 1
	const linesToRead = 19
	Dim f
	Dim myLine, Body, filename 
	Dim found, fso
	Dim linesRead, noticeRedNum, fileneme
	linesRead=0
	Body = ""
	found = false
	noticeRedNum = 0
	filename = directory & "\PDFComparisonResult.txt"
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set f = fso.OpenTextFile(filename, ForReading)
	Do Until f.AtEndOfStream
		myLine = f.ReadLine
		if ( linesRead < linesToRead and found = true ) then
			linesRead = linesRead +1
			noticeResultsLine(linesRead ) = myLine
		end if
		if instr(myLine , "PASS<-->Property Name") then
			noticeRedNum = noticeRedNum + 1
			if ( noticeRedNum = notNum ) then found  = true
		end if
    Loop
	f.Close
end sub

Function getNumberOfNoticesRequired ( directory )
	getNumberOfNoticesRequired = 0
	Dim f, fso
	Dim myLine, filename
	Dim ind, max
	ind = 0
	max = 0
	filename = directory & "\PDFComparisonResult.txt"
	
	Set fso = CreateObject("Scripting.FileSystemObject")
	if  fso.FileExists(filename) then
		Set f = fso.OpenTextFile(filename, ForReading)
		Do Until  f.AtEndOfStream
			myLine = f.ReadLine
			ind = instr ( myLine, "TOTALNUMBER:") 
			if ( ind > 0 ) then
				getNumberOfNoticesRequired = CInt(mid(myLine,13))
			end if
			if max > 3000 then break
			max = max+1
		Loop
	f.Close
	end if
end function


Function GetReportSectionRowsWithFail( strHTMLPage )
    Dim fa, er
	emailInd=1
	fa = ""
	er = ""
	fa = GetReportSectionRowsWithFailDo( strHTMLPage, ">Fail<" )
	er = GetReportSectionRowsWithFailDo( strHTMLPage , ">Error<" )
	GetReportSectionRowsWithFail = fa & er 
	'msgbox "GetReportSectionRowsWithFail" & GetReportSectionRowsWithFail

end function


Function GetReportSectionRowsWithFailDo( strHTMLPage,searchString  )
	Dim f, fso
	Dim myAllContent, myWantedSection, myWantedAll, preIndex
	Dim sIndex, eIndex, nIndex,  trStart, trEnd
	dim grabFilename, onlyFile, appendedPart
	dim startP, endP
	screenshotArray(emailInd) = ""
	myAllContent = ""
	myWantedSection =""
	myWantedAll = "<table width='600px' "&(34)&" border='1' ><th>" & mid(searchString,2,len(searchString)-2 ) & " Result(s)</th><Th>Description</th><tbody>"
	Set fso = CreateObject("Scripting.FileSystemObject")
	if  fso.FileExists(strHTMLPage) then
		Set f = fso.OpenTextFile(strHTMLPage, ForReading)
		myAllContent = f.ReadAll
		nIndex = instr ( instr( myAllContent, "marker='manuhodonozor'") , myAllContent, searchString, 1 )
		Do Until nIndex < 200
		    preIndex = instrRev( myAllContent, "<tr>", nIndex ,1)
		    trEnd = instr(nIndex, myAllContent,  "</tr>", 1 )
			if trEnd > 100 then
				trStart = instr(trEnd , myAllContent, "<tr>", 1 )
				if trStart > 100 then
					trEnd = instr(trStart, myAllContent, "</tr>", 1 )
					if trEnd > preIndex then
						myWantedSection = Mid(myAllContent, preIndex, trEnd - preIndex+7 )
						if instr(myWantedSection, "<a") >1 then
							appendedPart = Left( myWantedSection, instr( 10, myWantedSection, "<tr")-1 ) '''&  Right( myWantedSection, length(myWantedSection)-instr(myWantedSection, "</a")+4 ) 
						else
							appendedPart = myWantedSection
						end if
						myWantedAll = myWantedAll & appendedPart
						startP = instr(  myWantedSection,"src")
						
						if startP > 0 then
							endP = instr(startP, myWantedSection,".png")
							if startP > 0 and endP > startP+6 then
								grabFilename =  Mid(myWantedSection, startP + 6  , endP-startP -2 )
								onlyFile = Right(grabFilename, 18)
								if fso.FileExists(grabFilename) then
									myWantedAll = myWantedAll & "<TR><TD colspan=" & chr(34) & "2" & CHR(34) & ">" & "<p><img src="&chr(39) &"cid:"& onlyFile  & chr(39) & " height=900 width=1500></p></td></tr>"  
									screenshotArray(emailInd) = grabFilename
									if emailInd < UBound(screenshotArray) then emailInd = emailInd + 1  end if
									screenshotArray(emailInd) = ""
								end if	
							end if
						end if
					end if	
				end if
			end if	
			nIndex = instr (trEnd , myAllContent, searchString , 1 )
		Loop
	f.Close
	end if
	myWantedAll = removeTimeInfo ( myWantedAll )
	Wscript.sleep(1000)
	GetReportSectionRowsWithFailDo = myWantedAll &"</tbody></table>"
end Function


Function GetReportSectionRowsWithFailText( )
    Dim fa, er
	Dim header
	fa = ""
	er = ""
	fa = formFailOrErrorHeaderText(  "Fail" )
	er = formFailOrErrorHeaderText(  "Error" )
	header = "<table style='width:100%; background-color:#ffffff;color:#006699;font-size: 40%; font-weight:normal'  border='1'><tbody><tr><td>ISSUE</td><td>Description</td></tr>" 
	GetReportSectionRowsWithFailText = header & fa & er & "<div marker='manuhodonozor'></div></tbody></table>"
'	msgbox "GetReportSectionRowsWithFailText" & GetReportSectionRowsWithFailText
	end function


function formFailOrErrorHeaderText( searchString )
    Dim aa, maax
	Dim content
	Dim prefix
	Dim retval
	maax = UBound(theCaptionArray)
	For aa=1 to maax
		if theCaptionArray(aa) <> "" then
		    prefix = left(theCaptionArray(aa), 10)
			if ( instr(prefix, searchString ) ) then
			    content = replace(theCaptionArray(aa), "\n", "<br>") & "("& aa &")"
				content = replace(content, "Failm-", "")
				content = replace(content, "Fail-", "")
				if (instr(searchString, "Error" )> 0 ) Then
					retval = retval & "<TR style='color:#000000;background-color:#FFFF66;' ><td >" & searchString & "</td><TD>" & FailedReportCommentInRed(content) & "</td></tr>"
				else
					retval = retval & "<TR style='color:#FF0000;background-color:#FFFFFF;' ><td>" & searchString & "</td><TD style='color:#000000;'>" & FailedReportCommentInRed(content) & "</td></tr>"
				'retval = retval & "<TR><TD >" & theCaptionArray(aa) & "</td></tr>"
				'retval = retval & "<TR><TD style=padding-left: 5px;padding-bottom:3px; font-family:sans-serif;font-size: 5px; font-color:#FF0000; >" & theCaptionArray(aa) & "</td></tr>"
			'	retval = retval & "<TR><TD> <font  face=sans-serif  size=1  color =red >" & theCaptionArray(aa) & "</font></td></tr>" 'WORKING
				'retval = retval & "<TR><TD font face="Arial"   size="1"  color = "red" >" & theCaptionArray(aa) & "</td></tr>"
				'retval = retval & "<TR><TD> {font-family: Arial; font-size: 10pt;}" & theCaptionArray(aa) & "</td></tr>"

				end if
			end if
			if ( instr(prefix, "Error" ) > 0 ) then aa = maax
			if ( instr(prefix, "ExitLoop" ) > 0 ) then aa = maax
		End If
	Next
	formFailOrErrorHeaderText = retval
	'msgbox "formFailOrErrorHeaderText" & formFailOrErrorHeaderText
end function


sub addEmbeddedScreenshots ( byval ObjSendMail )
	dim aa
	'on error resume next
	For aa=1 to UBound(screenshotArray)
		if screenshotArray(aa) <> "" then
		ObjSendMail.AddAttachment directory & screenshotArray(aa)
		else aa=UBound(screenshotArray)
		End If
	Next
	'on error goto 0
end sub



sub addEmbeddedScreenshotsX ( byval ObjSendMail )
	dim aa
	on error resume next
	For aa=1 to UBound(screenshotArray)
		if screenshotArray(aa) <> "" then
			ObjSendMail.attachments.add screenshotArray(aa)
		else aa=UBound(screenshotArray)
		End If
    Next
	on error goto 0
end sub


function removeTimeInfo ( myWantedAll )
     Dim indexFound, indexEnded, IndexStarted
	 Dim searchString, tobedeletedString
	 Dim myWantesOut
	 myWantesOut = myWantedAll
	 searchString = "CLASS=" & CHR(34) & "time"
	 indexFound =  instr ( 1, myWantedAll, searchString, 1 ) 
	 Do Until indexFound  < 10
		IndexStarted = instrRev(myWantesOut, "<TD", indexFound )
		indexEnded = 5 + instr(indexFound, myWantesOut, "</TD>")
		if (indexFound  < indexEnded ) then
			tobedeletedString = mid(myWantesOut,IndexStarted, indexEnded-IndexStarted )
			myWantesOut = Replace(myWantesOut, tobedeletedString, "")
		end if
		indexFound =  instr ( indexEnded, myWantesOut, searchString, 1 )
	 loop
	 removeTimeInfo = myWantesOut	
end function



sub ShortenFilenameDir( byVal inDirectory )
	Dim sd
	Dim objFSO
	Dim objFolder
	Dim upto
	Dim lelele
	Dim NameToLeave
	lelele = len(inDirectory)
	upto = 1 + instrRev (inDirectory, "\", (-2 + lelele)  )
	removedPartOfDir = mid( inDirectory, upto, lelele-upto )
'	NameToLeave = right(removedPartOfDir, 50 )
	NameToLeave = right(removedPartOfDir, 100 ) ' The entire path cannot be longer than 242 characters in Word, or 218 in Excel. So the parent path has 30 chars (D:\RFT\TestAutomation_AREEF_logs) and we can go for at least 100 chars in file name itself.. so, I increased it to 100..
	ShorterDir = left(inDirectory, upto-1) & NameToLeave
	set objFSO = createobject("Scripting.FileSystemObject")
	set objFolder = objFSO.GetFolder(inDirectory)
	on error resume next
	objFolder.Name = NameToLeave
	directory = ShorterDir &"\"
	On error goto 0
	set objFSO = Nothing
	set objFolder = Nothing
end sub

sub RestoreFilenameDir( )
	Wscript.sleep 3000
    ''exit sub
	Dim objFSO
	Dim objFolder
	set objFSO= createobject("Scripting.FileSystemObject")
	set objFolder = objFSO.GetFolder(ShorterDir)
	on error resume next
	objFolder.Name = removedPartOfDir
	on error goto 0
	set objFSO = Nothing
	set objFolder = Nothing	
end sub


sub AppendScreenshotsToHTML_X( destination , mhtFileEnv, testName, result )
	dim debug
	DIM objFSO, goFSO, objFolder, colFiles, objFilePicture
	Dim screenshotNumber, rowNumber
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFSO.GetFolder(destination)
	Set colFiles = objFolder.Files
	Dim objFile
	Dim htmlPart1, htmlPart2, StrData
	Dim logDate, LogTime 
	Dim selheader, lastPictName, screenshotName, failOrErrorHeader
	dim maxPictureNumber
	dim strForIF
	Set goFSO = CreateObject("Scripting.FileSystemObject")
	copyCaptionFile
	Set objFile = goFSO.OpenTextFile(destination & "\rational_ft_logframe.html", ForWriting, True)

	selHeader =  formAHeader(destination)
	Wscript.sleep(1000)
	failOrErrorHeader =  GetReportSectionRowsWithFailText
	
	htmlPart1 = "<html><header><title>Title</title></header><body><br><table style='width:90%' border=1><th  colspan='2' >" & selheader &  failOrErrorHeader & "</th>"
	objFile.WriteLine htmlPart1 
	debug = ""
	rowNumber=1	
    StrData = getCaption( rowNumber )
	strForIF = mid(StrData,1,12 )
	debug = debug & left(StrData , 40) & vbCrlf
	Do
			StrData = replace(StrData, "\n", "<br>")
			if ( instr(StrData, "Pass")>0 or instr(StrData, "Fail")>0 or instr(StrData, "Done")>0 or instr(StrData, "ExitLoop")>0  or instr(StrData, "Error")>0  or instr(StrData, "True")>0 or instr(StrData, "Pass-")>0  or instr(StrData, "Fail-")>0 ) then
				if instr(strForIF, "Pass") > 0  then 
					htmlPart1 =  "<tr><td style='color:#008800; width:10%;' >Pass</td><td>" &  mid(StrData, instr(StrData, "-") + 1 )  & "</td>" 
					screenshotName = "screenShot" & right("0000" & rowNumber, 4 )  & ".png"
		        	htmlPart1 = htmlPart1  & "</tr><tr><td  colspan='2' ><center><a href=" & chr(34) &  destination  & screenshotName & chr(34) & "><img src =" & chr(34) &  destination &  screenshotName & chr(34) &" width='97%' ></IMG></a></center></td></tr>"
				Elseif  instr(strForIF, "Fail") > 0 or instr(strForIF, "Failm") > 0 then
					htmlPart1 =  "<tr><td style='color:#AF0000; width:10%;' >Fail</td><td>" &  FailedReportCommentInRed( mid(StrData, instr(StrData, "-") + 1 ))  & "</td>" 
					screenshotName = "screenShot" & right("0000" &	rowNumber, 4 )  & ".png"
		        	htmlPart1 = htmlPart1  & "</tr><tr><td  colspan='2' ><center><a href=" & chr(34) &  destination  & screenshotName & chr(34) & "><img src =" & chr(34) &  destination & screenshotName & chr(34) &" width='97%' ></IMG></a></center></td></tr>"
				Elseif  instr(strForIF, "Error") > 0  then
					htmlPart1 =  "<tr><td style='color:#FF9900; width:10%;' >Error</td><td>" &  mid(StrData, instr(StrData, "-") + 1 )  & "</td>" 
					screenshotName = "screenShot" & right("0000" &	rowNumber, 4 )  & ".png"
		        	htmlPart1 = htmlPart1  & "</tr><tr><td  colspan='2' ><center><a href=" & chr(34) &  destination  & screenshotName & chr(34) & "><img src =" & chr(34) &  destination &  screenshotName & chr(34) &" width='97%' ></IMG></a></center></td></tr>"
					objFile.WriteLine htmlPart1 
					Exit Do
				Elseif  instr(strForIF, "Done") > 0 then
					htmlPart1 =  "<tr><td style='color:#0000FF; width:10%;' >Done</td><td>" &  mid(StrData, instr(StrData, "-") + 1 )  & " </td>"
				Elseif  instr(strForIF, "Fail-") > 0 then
					htmlPart1 =  "<tr><td style='color:#0000FF; width:10%;' >Fail</td><td>" & FailedReportCommentInRed( mid(StrData, instr(StrData, "-") + 1 ) ) & " </td>"
				Elseif  instr(strForIF, "Pass-") > 0 then
					htmlPart1 =  "<tr><td style='color:#0000FF; width:10%;' >Pass</td><td>" &  mid(StrData, instr(StrData, "-") + 1 )  & " </td>"
				Elseif  instr(strForIF, "True") > 0 then
					htmlPart1 =  "<tr><td style='color:#008800; width:10%;' >True</td><td>" &  mid(StrData, instr(StrData, "-") + 1 )  & "</td>" 
					screenshotName = "screenShot" & right("0000" & rowNumber, 4 )  & ".png"
		        	htmlPart1 = htmlPart1  & "</tr><tr><td  colspan='2' ><center><a href=" & chr(34) &  destination  & screenshotName & chr(34) & "><img src =" & chr(34) &  destination &  screenshotName & chr(34) &" width='97%' ></IMG></a></center></td></tr>"
				Elseif  instr(strForIF, "ExitLoop") > 0 then
					objFile.WriteLine htmlPart1 
					Exit Do
				end if
			else
					htmlPart1 =  "<tr><td style='width:10%;'></td><td>" &  FailedReportCommentInRed(mid(StrData, instr(StrData, "=") + 1 ))  & "</td>"
			end if
			objFile.WriteLine htmlPart1  
			rowNumber = rowNumber + 1 
			StrData = getCaption( rowNumber )
			strForIF = mid(StrData,1,8 )
			debug = debug & left(StrData , 40) & vbCrlf
	loop 
	'msgbox debug 
	htmlPart2 = "</table></body></html>"
	objFile.WriteLine htmlPart2 

end sub


Function FailedReportCommentInRed( hashTaggedText )
       DIM startH, endH, blackStartH, blackEnd, firstStart
	   Dim output
	   startH = instr( 1, hashTaggedText, "%1")
	   if (startH = 0) then
			output = hashTaggedText
			FailedReportCommentInRed = output 
			exit function
	   end if
	   endH = instr( startH, hashTaggedText, "%2" )
	   if (endH = 0) then
			output = hashTaggedText
			FailedReportCommentInRed = output 
			exit function
	   end if  
	   
	   output = ""
	   output = output & mid(hashTaggedText, 1,  startH-1)  '' begin in black by default
	   do while (startH >0  and endH >0  and endH > startH ) 
			output = output & "<span style='background-color:#DDDDDD;color:#ff0000;font-size: 100%; font-weight:normal'>"
	        output = output & mid(hashTaggedText, startH+2, endH - startH-2)  & "</span>"   ''   red
			output = output & "<span style='background-color:#FFFFFF;color:#000000;font-size: 100%; font-weight:normal'>"
			blackStartH = endH+2
			blackEnd = instr( blackStartH, hashTaggedText, "%1")
			if (blackEnd> blackStartH) then
				output = output & mid(hashTaggedText,  blackStartH, blackEnd - blackStartH) & "</span>"   '' black
				''msgbox "totalL" & len(hashTaggedText) & "  S:" &  startH & "  E:" & endH & vbCrlf & hashTaggedText
				startH = instr( startH + 1, hashTaggedText, "%1")
				if (startH > 0 ) then endH = instr( startH, hashTaggedText, "%2")
			else
				startH=0
			end if
	   loop 
	   Dim last
	   if (startH > endH ) then last = startH else last = endH 
	   output = output & mid(hashTaggedText, last+2 )
	   FailedReportCommentInRed =  output
end function


sub readInThePropertyFile(destination)
        Dim ObjFileCaption, sIndex, maxIndex, a
		Dim objFSO 
		Dim desired, StrData, criteria, digiString
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Dim index
	for a=1 to 200 
		theCaptionArray(a) = ""
	next 
        copyCaptionFile
		Wscript.Sleep 1000
		Set ObjFileCaption = objFSO.OpenTextFile( destination & "Captions.properties")
    maxIndex=1
 	do while not ObjFileCaption.AtEndOfStream 
		StrData =  ObjFileCaption.ReadLine()
		if instr(StrData,"Caption0")>0 then
			index = CInt(mid(StrData, 8,4))
			if ( maxIndex< index) then maxIndex = index
			desired = mid( StrData, instr(StrData, "=")+1 )
			desired = replace(desired, "\:", ":")
			desired = replace(desired, "\=", "=")
			desired = replace(desired, "\#", "#")
			desired = replace(desired, "\!", "!")
			'msgbox "index="& index & "   desired=" & desired
			theCaptionArray(index) =desired	
		end if	
	Loop
end sub	


function  getCaption( screenshotNumber )
	getCaption = theCaptionArray( screenshotNumber) 
end function


DIM TestCaseName, TestDescription, Environment, ExpectedResult, logDate, LogTime
sub  getHeader( destination  )
        copyCaptionFile
        Dim ObjFileCaption
		Dim objFSO 
		Dim desired, StrData, criteria, digiString
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Set ObjFileCaption = objFSO.OpenTextFile( destination & "TestHeader.properties")
 	do while not ObjFileCaption.AtEndOfStream 
		    StrData =  ObjFileCaption.ReadLine()	
			  StrData = replace(StrData, "\ ", " ")
			  StrData = replace(StrData, "\:", ":")
			  StrData = replace(StrData, "\=", "=")
			  StrData = replace(StrData, "\#", "#")
			  StrData = replace(StrData, "\!", "!")		
			  StrData = replace(StrData, "\n", "<br/>")
			if ( instr(StrData, "ExpectedResult") > 0 ) then
				ExpectedResult = mid(StrData, instr(StrData,"=")+1)
			end if
			if ( instr(StrData, "TestCase") > 0 ) then
				TestCaseName =  mid(StrData, instr(StrData,"=")+1)
			end if
			if ( instr(StrData, "ScenarioDescription") > 0 ) then
				TestDescription =  mid(StrData, instr(StrData,"=")+1)
			end if
			if ( instr(StrData, "Environment") > 0 ) then
				Environment =  mid(StrData, instr(StrData,"=")+1)
			end if  
	Loop      
end sub	

function formAHeader(destination)
	DIM header, verrdict
	DIM objFSO
	Dim ObjFileCaption
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	
	if  NOT ( ObjFso.FileExists(destination & "\TestHeader.properties")) then
	    formAHeader = "Test Results"
		exit function
	end if	
	getHeader destination  
	
	logDate = DatePart("yyyy",Date) & "-" & Right("0" & DatePart("m",Date), 2) & "-"& Right("0" & DatePart("d",Date), 2)
	LogTime = Right("0" & Hour(Now), 2) & ":"+ Right("0" & Minute(Now), 2) & ":"+ Right("0" & Second(Now), 2)

	'header = "<table style='width:70%; background-color:#FFFFFF;color:#ffffff;font-size: 100%; font-weight:bold'  border='1'>"
	header = "<table style='width:100%; background-color:#FFFFFF;color:#ffffff;font-size: 70%; '  border='1'>"
	header = header & "<tbody>"
	header = header & "<tr><td style='background-color:#455372;' font-size:150%' colspan='2' valign='middle' ><center>Test Automation Report</center></td></tr>"
	header = header & "<tr><td style='background-color:#808080;' valign='middle'>Date Time</td><td  style='width:70%; background-color:#228FCE;'>" & logDate & "  " & LogTime & "</td></tr>"
	header = header & "<tr><td style='background-color:#808080;' valign='middle'>Test Case Name</td><td  style='width:70%; background-color:#228FCE;'>" & TestCaseName & "</td></tr>"
	header = header & "<tr><td style='background-color:#808080;' valign='middle'>Environment</td><td  style='width:70%; background-color:#228FCE;'>" & Environment & "</td></tr>"
	header = header & "<tr><td style='background-color:#808080;'>Scenario Description</td><td style='width:70%; background-color:#228FCE;' >" & TestDescription & "</td></tr>"
	header = header & "<tr><td style='background-color:#808080;'>Expected Result</td><td  style='width:70%; background-color:#228FCE;'>" & ExpectedResult & "</td></tr>"
	
	verrdict = getPassFailFromCaptions(  )
	if (instr(verrdict , "Pass")> 0 ) then
		header = header & "<tr><td style='background-color:#3E7BFF;'>Verdict</td><td  style='width:70%; background-color:#008F00;' ><center>"
	elseif (instr(verrdict , "Fail")> 0 ) then
		header = header & "<tr><td style='background-color:#3E7BFF;'>Verdict</td><td  style='width:70%; background-color:#AF0000;' ><center>"
	else
		header = header & "<tr><td style='background-color:#3E7BFF;'>Verdict</td><td  style='width:70%; background-color:#FFFF66;color:#000000' ><center>"
	end if
	header = header &  verrdict & "</center></td></tr>"
	if ((instr(Environment , "TST") > 0) and (instr(testType, "Smoke") > 0) ) then
			header = header & getServiceTestHeader()
	end if
		
	header = header & "</tbody></table></body>"
	formAHeader = header
end function



function getPassFailFromCaptions( )
	dim veeerdict, debugg, chunk
	dim max
	max=1
	veeerdict = "Pass"
	debugg=""
	do while ( max < UBound(theCaptionArray)  )
	'    chunk = Left(theCaptionArray(max), 30)
	    chunk = Left(theCaptionArray(max), 17)  'max 17 will cover and after that should not go in...Caption0023=Pass-Error Validation 
	    debugg = debugg & chunk & vbCrlf
		if (instr(chunk , "ExitLoop")<>0 ) then exit Do
		IF (instr(chunk, "Fail")> 0 ) Then veeerdict="Fail" end if
		IF (instr(chunk, "Error")> 0 ) Then 
			veeerdict="Aborted"
			exit Do
		end if
		max = max+1
	loop
	getPassFailFromCaptions = veeerdict
	'msgbox debugg & vbCrlf & veeerdict
end function


function getServiceTestHeader()
	dim serviceHeader, debugg, chunk, StrData
	dim max, rowNumber
	max=6
	rowNumber=1	
	serviceHeader = ""
	debugg=""
	do while ( max >= rowNumber )
		StrData = getCaption( rowNumber*5 )	 
		if  instr(StrData, "Failm-") > 0 then
			StrData = mid(StrData, instr(StrData, "-") + 1 )
			StrData = Left(StrData, instr(StrData, "Webservice") + 10 )
			serviceHeader =  serviceHeader & "<tr><td style='background-color:#3E7BFF;'>" & StrData & "</td><td  style='width:70%; background-color:#AF0000;' ><center>" &  "Fail" & "</center></td></tr>"
		Elseif  instr(StrData, "Passm-") > 0 then
			StrData = mid(StrData, instr(StrData, "-") + 1 )
			StrData = Left(StrData, instr(StrData, "Webservice") + 10 )
			serviceHeader =  serviceHeader & "<tr><td style='background-color:#3E7BFF;'>" & StrData & "</td><td  style='width:70%; background-color:#008F00;' ><center>" &  "Pass" & "</center></td></tr>"
		end if
		rowNumber = rowNumber+1
	loop
	getServiceTestHeader = serviceHeader
end function


function copyCaptionFile()
	Dim command2 
	Dim WshShell, oExec
	DIM fso    
    Set fso = CreateObject("Scripting.FileSystemObject")
	Set objShell = CreateObject("Shell.Application")
 	if  NOT ( fso.FileExists(directory &"\Captions.properties")) then
		command2 = "/c copy " & chr(34) & propFilePath_Captions & chr(34) & " " & CHR(34) & directory & CHR(34) 
		objShell.ShellExecute "cmd.exe", command2, "", "runas", -1	
 	end if
	
 	if  NOT ( fso.FileExists(directory &"\TestHeader.properties")) then
		command2 = "/c copy " & chr(34) & propFilePath_TestHeader & chr(34) & " " & CHR(34) & directory & CHR(34) 
		objShell.ShellExecute "cmd.exe", command2, "", "runas", -1	
 	end if
	if  NOT ( fso.FileExists(directory &"\screenShot0001.png")) then
		command2 = "/c copy " & chr(34) & propFilePath_screenshots & chr(34) & " " & CHR(34) & directory & CHR(34) 
		objShell.ShellExecute "cmd.exe", command2, "", "runas", -1	
		Wscript.Sleep 3000
	end if
end function
	
	
	
sub createhtmlFileLocationDirectory()
	Dim command3, diiiir, suffix, strSafeDate, strSafeTime
	Dim WshShell, oExec
	DIM fso,  fso1  
    Set fso = CreateObject("Scripting.FileSystemObject")
	Set objShell = CreateObject("Shell.Application")
	diiiir = MID (htmlFileLocation, 1, InStrRev(htmlFileLocation, "\" )-1)
	
	strSafeDate = DatePart("yyyy",Date) & Right("0" & DatePart("m",Date), 2) & Right("0" & DatePart("d",Date), 2)
	strSafeTime = Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2) &  Right("0" & Second(Now), 2)
	suffix = strSafeDate & strSafeTime

	if ( fso.FolderExists(diiiir)) then
		Set fso1 = CreateObject("Scripting.FileSystemObject")
		fso1.deletefolder diiiir
		Wscript.sleep(1000)
		command3 = "/c mkdir " & chr(34) & diiiir & "\" & chr(34)
		objShell.ShellExecute "cmd.exe", command3, "", "runas", -1
		Wscript.Sleep 1001
	else
		command3 = "/c mkdir " & chr(34) & diiiir & "\" & chr(34)
		objShell.ShellExecute "cmd.exe", command3, "", "runas", -1
	end if
	Set objShell = Nothing
	Set fso = Nothing
	Set fso1 = Nothing
	Wscript.Sleep 2000

end sub

''>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''
''''''''''                                          EX-MAIN CHOPPED                                '''''''''''''''''''''''''''''
''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sub prepareEmailAndSendIt
	Dim wshNetworka
	TimeDiff1 = "<br/>After IE before DOC " & "( exactly " &  DateDiff("s", StartTimestamp, Now) & " sec ) "
	Dim messageSubject, verdictInSubject
	DIM lastPictureCapturedName , resultToAppend
	lastPictureCapturedName = mid(lastPictureCaptured, InStrRev(lastPictureCaptured, "\")+1)
	
	getSSN
	EndTimestampTxt = Right("0" & Hour(Now), 2) &":"& Right("0" & Minute(Now), 2) &":"&  Right("0" & Second(Now), 2)
	EndTimestamp = Now
	TimeDiff = "<br/>Selenium: " & testDuration & " <br/>VBS:&nbsp; &nbsp;&nbsp; &nbsp; " &  CInt(DateDiff("s", StartTimestamp, Now)/60) & " Min. " & ( DateDiff("s", StartTimestamp, Now) MOD 60 ) & " Sec. <BR>Total:&nbsp; &nbsp;&nbsp; &nbsp;"& CInt(MID(testDuration,1, instr(testDuration, " ")))+CInt(DateDiff("s", StartTimestamp, Now)/60) & " Min. " &  ( DateDiff("s", StartTimestamp, Now) MOD 60 ) & " Sec."
	messageBody = "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               "
	Verdict = getPassFailFromCaptions(  )
	if Verdict="Fail" then 
		verdictInSubject = "FAILED in "
		messageBody = "<html><p>Hi Team,</p><p>The " & testType & "<font color=""red""><b>failed</b></font> in " & mhtFileEnv  & ". Please find attached the execution summary report with screenshots. </p>"
		messageBody = messageBody & "<p><b><u>Build Number:</u></b>&nbsp; &nbsp; " & buildNo &"</p>" 
		messageBody = messageBody & "<p><b><u>Test Data:</u></b></p>" 
		messageBody = messageBody & "<P> <table border=1 > <TR><TD>First Name</TD><TD>Last Name</TD><TD>DOB</TD><TD>SSN (dummy)</TD></TR><TR><TD>"&FirstName1&"</TD><TD>"&LastName1&"</TD><TD>"&DOB1&"</TD><TD>"&SSN1&"</TD></TR></TABLE></P>"
		messageBody = messageBody & "<p><b><u>Test Steps Failed:</u></b></p>" 
		messageBody = messageBody & GetReportSectionRowsWithFail( strHTMLPage )
		if lastPictureCaptured <> "aa" then
			messageBody = messageBody & "<p><p><HR>The last snapshot before failure occurred:<HR></p><img src='cid:" & lastPictureCapturedName & "' height=440 width=700></p>"
		end if
		'messageBody = messageBody & "<p><b><u>Test Duration: </u></b>&nbsp; &nbsp; " & TimeDiff & "</p>"
		messageBody = messageBody & " <p>Thanks!</p><p>SIT Automation Team</p>"
		' <p><p></p><img src='cid:emailLogo.jpg' height=40 width=180></p> ' For logo in email
		resultToAppend = "FAIL"
	elseif Verdict="Pass" then
		verdictInSubject = "PASSED in "
		messageBody =  "<html><p>Hi Team,</p><p>The " & testType & "is <font color=""green""><b>successful</b></font> in " & mhtFileEnv & ". Please find attached the execution summary report with screenshots!</p> "
		messageBody = messageBody & "<p><b><u>Build Number: </u></b>&nbsp; &nbsp; " & buildNo &"</p>" 
		messageBody = messageBody & "<p><b><u> Test Data:</u></b></p>"
		messageBody = messageBody & "<P> <table border=3 > <TR> <TD> FirstName </TD> <TD> LastName </TD><TD> DOB </TD><TD> SSN </TD></TR>  <TR><TD>"&FirstName1&"</TD><TD>"&LastName1&"</TD><TD>"&DOB1&"</TD><TD>"&SSN1&"</TD></TR></TABLE></P>"
		if ((instr(mhtFileEnv , "TST") > 0) and (instr(testType, "Smoke") > 0) ) then
			messageBody = messageBody & "<p><b><u>Services Test :</u></b> </p>  <p>&bull;&nbsp;	Income Verification(H9) Webservice validated successfully</p> <p>&bull;&nbsp; RIDP Webservice(H1) validated successfully</p> <p>&bull;&nbsp; SSA Composite(H3) Webservice validated successfully</p> <p>&bull;&nbsp; Non ESI Inbound(H31) Webservice validated successfully</p>	<p>&bull;&nbsp; Address Verification Webservice validated successfully</p><p>&bull;&nbsp; Account Transfer(H15) Inbound Webservice validated successfully</p><br>"
		end if
		messageBody = messageBody & "<p><b><u>Validation Points:</u></b> </p>  <p>&bull;&nbsp;	Citizen Portal application is signed and submitted successfully</p> <p>&bull;&nbsp; Intake Person Search is able to retrieve the case participant's details</p> <p>&bull;&nbsp; Items verification & Authorization is successful</p> <p>&bull;&nbsp; Integrated Case(IC) & Product Delivery Case(PDC) have been created</p>	<p>&bull;&nbsp; Certification periods are displayed correctly</p><p>&bull;&nbsp; Determination periods / Categories are displayed correctly</p> <p>&bull;&nbsp; Medicaid IDs are generated</p> <p>&bull;&nbsp; Required Notices are generated in C&uacute;ram</p>  <br> <p><u>Note</u>: <i>Please validate the generated notices in DocuShare!</i></p><br>"
		'messageBody = messageBody & "<p><b><u>Test Duration: </u></b></p>&nbsp; &nbsp; "  & TimeDiff & "  </p>"
		messageBody = messageBody & "<p>Thanks!</p><p>SIT Automation Team</p>"  
		resultToAppend = "PASS"
	else 
		verdictInSubject = "ABORTED in "
		messageBody = "<html><p>Hi Team,</p><p>The " & testType & "<font color='orange'><b>aborted</b></font> in " & mhtFileEnv  & ". Please find attached the execution summary report with screenshots for debugging. </p>"
		messageBody = messageBody & "<p><b><u>Build Number:</u></b>&nbsp; &nbsp; " & buildNo &"</p>" 
		messageBody = messageBody & "<p><b><u>Test Data:</u></b></p>" 
		messageBody = messageBody & "<P> <table border=1 > <TR><TD>First Name</TD><TD>Last Name</TD><TD>DOB</TD><TD>SSN (dummy)</TD></TR><TR><TD>"&FirstName1&"</TD><TD>"&LastName1&"</TD><TD>"&DOB1&"</TD><TD>"&SSN1&"</TD></TR></TABLE></P>"
		messageBody = messageBody & "<p><b><u>Test Steps Failed:</u></b></p>" 
		messageBody = messageBody & GetReportSectionRowsWithFail( strHTMLPage )
		if lastPictureCaptured <> "aa" then
			messageBody = messageBody & "<p><p><HR>The last snapshot before test aborted:<HR></p><img src='cid:" & lastPictureCapturedName & "' height=440 width=700></p>"
		end if
		'messageBody = messageBody & "<p><b><u>Test Duration: </u></b>&nbsp; &nbsp; " & TimeDiff & "&nbsp; &nbsp;  ( " & StartTimestampTxt & " - " & EndTimestampTxt & " ) </p>"
		messageBody = messageBody & " <p>Thanks!</p><p>SIT Automation Team</p>"
		' <p><p></p><img src='cid:emailLogo.jpg' height=40 width=180></p> ' For logo in email
		resultToAppend = "ABORTED"
	end if
	if testType="Smoke Test " then
		messageSubject = testType & verdictInSubject & mhtFileEnv 
	else
		messageSubject = testType & verdictInSubject & mhtFileEnv & " - "  &  removedPartOfDir    '& objFile.Name 
	end if
	'messageBody =  messageBody & "<p><p>. . . . . . . . . . . . . . . . . . . . . . . . .<br><img src=" & chr(39) & "cid:emailLogo.jpg" & chr(39) & " height=40 width=180></p></p>"
	messageBody =  messageBody & "<p><br></p></html>"
	''getPropertyFilestoCurrentWorkingDirectory
    ''msgBox GetReportSectionRowsWithFail( strHTMLPage )

	Set wshNetworka = WScript.CreateObject( "WScript.Network" )
	strComputerName = wshNetworka.ComputerName
	if JenkinsEmailSubject = "" then 
		SendMessageX "N/A", "Jenkins", "Selenium.automation.class@gmail.com", messageSubject , messageBody, pdffilename
	else
		SendMessageX JenkinsEmailSubject , "Jenkins", "Selenium.automation.class@gmail.com", messageSubject , messageBody, pdffilename
	end if
	Set objShell = Nothing
	Set wshNetworka = Nothing
	Set objShell = Nothing	
end sub


sub readInCommanlLineParameters
	if WScript.Arguments.Count < 5 then
		WScript.Echo "Missing arguments" & vbCrlf & "1. HTML file location"  & vbCrlf & "2. Environment"  & vbCrlf & "3. Extra Images Message"  & vbCrlf & "4. Extra Images Message"  &_
						vbCrlf & "5. Subject of  email from Jenkins" & vbCrlf & "6. sharedFolderNames" & vbCrlf & "7. Dashboard directory"
		Exit Sub
	end  if 
	
	StartTimestampTxt = Right("0" & Hour(Now), 2) &":"& Right("0" & Minute(Now), 2) &":"&  Right("0" & Second(Now), 2)
	StartTimestamp = Now
	htmlFileLocation = Wscript.Arguments.Item(0)
	mhtFileEnv = Wscript.Arguments.Item(1)
	extraImageMessage = Wscript.Arguments.Item(2)
	dirWithExtraImages = Wscript.Arguments.Item(3)
	screenshotInEmail = Wscript.Arguments.Item(4)
	JenkinsEmailSubject = Wscript.Arguments.Item(5)
	sharedFolderName = Wscript.Arguments.Item(6) 
	DashAndPDFFolderName = Wscript.Arguments.Item(7)
	' This is to find out if the script is Smoke test or Regression.
	If instr(htmlFileLocation, "smokeTest") >= 1 then
		testType = "Smoke Test "
	else 
		testType = "Regression Test "
	end If
		
end sub

sub CreateDocHtmlPdfFileNames
	Dim wshNetworka
	Set wshNetworka = WScript.CreateObject( "WScript.Network" )
	strComputerName = wshNetworka.ComputerName
	Set objShell = CreateObject("Shell.Application")
	Set objIE = objShell.Windows.Item
	cleanupInstancesOfProcesses

	strHTMLPage = htmlFileLocation
	If Trim(strHTMLPage) = "" Then WScript.Quit
	If Right(strHTMLPage, 1) = "/" Then strHTMLPage = Left(strHTMLPage, Len(strHTMLPage) - 1)
	strMHTFile = Mid(strHTMLPage, InStrRev(strHTMLPage, "/") + 1)

	strMHTFile = Left(strMHTFile, InStrRev(strMHTFile, ".")) & "mht"
	strOutputMHT = Replace(strMHTFile, ".mht","_" & mhtFileEnv & ".mht")

	directory = left(strOutputMHT, instrRev(strOutputMHT, "\"))
	Originalidir = directory
	ShortenFilenameDir directory 
	Wscript.sleep(1000)
'	RestoreFilenameDir
	localHTML = directory & MID(strHTMLPage, 1+ instrrev(strHTMLPage,"\"))

	pdffilename = directory & right(extractedPDFFileName( strHTMLPage ), 240 - len(directory))&"_"&Verdict& ".pdf"
	DocFileOut = Replace(pdffilename, ".pdf", ".doc" )
	textfilename = Replace(pdffilename, ".pdf", ".txt")
	DocXFileOut = Replace(pdffilename, ".pdf", ".docx")
	MHTFileOut = Replace(pdffilename, ".pdf", ".mht")
	getPropertyFilestoCurrentWorkingDirectory
	WriteToLog ":: 1 ::", ""
	WriteToLog ":: 1 ::", directory
	TimeDiff3 = "<BR> AppendScreenshotsToHTML_X" & "( exactly " &  DateDiff("s", StartTimestamp, Now) & " sec ) "
end sub


sub createWordFromHTML
	Dim objFile
	Dim MyWord,oIE
	set MyWord=CreateObject("Word.Document") 
	Set oIE = CreateObject("InternetExplorer.Application")
	oIE.Navigate localHTML
	Wscript.Sleep 500

	Do While oIE.Busy : Loop
	Do until oIE.readystate = 4 : wscript.sleep 10 : loop
	oIE.Visible = False
	Const OLECMDID_SAVEAS = 4
	Const OLECMDEXECOPT_DONTPROMPTUSER = 2
	Const OLECMDID_COPY = 12
	Const OLECMDID_SELECTALL = 17
	dim vaIn, vaOut
	oIE.ExecWB OLECMDID_SELECTALL, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut
	oIE.ExecWB OLECMDID_COPY, OLECMDEXECOPT_DONTPROMPTUSER

	Wscript.Sleep 500
	MyWord.Content.Paste
	Wscript.Sleep 500
	on error resume next
	MyWord.SaveAs DocFileOut
	If Err.Number <> 0 Then 
		MyWord.SaveAs DocXFileOut
	end if
	on error goto 0
	Wscript.Sleep 1000
	MyWord.Close
	oIE.Quit
	Set oIE = Nothing
	set MyWord = Nothing 
	Wscript.Sleep 1000
	Set objIE = Nothing
	Set objMessage = Nothing
	set MyWord = Nothing
	Set oIE = Nothing
	Set objShell = Nothing
end sub


sub purgeMsWordOfemptyandSuppressedInfo
	dim wdApp 
	dim objTable
	Dim pic
	dim od
	dim objSelection
	dim myRange 
	dim cumulativePresent
	Set wdApp = CreateObject("word.application")
	on error resume next
	set od = wdapp.documents.open ( DocFileOut )
	If Err.Number <> 0 Then
		set od = wdapp.documents.open ( DocXFileOut )
	end if
	wdApp.visible=False
	Set objSelection = wdApp.Selection
	od.Tables(1).AllowAutoFit = False
	dim sscontent
	dim linkAddress
	Dim iir, rowwt, cellsInThisRow, nnn
	rowwt = od.Tables(1).rows.count
	Set objTable = od.Tables(1)
	With od.PageSetup
		.LeftMargin = od.Application.InchesToPoints(0.5)
		.RightMargin = od.Application.InchesToPoints(0.5)
	End With
	objTable.PreferredWidth = 100
	lastPictureCaptured = "aa"
	lastPicture = "aa"
	for iir = rowwt to 2 step -1 
		cellsInThisRow = objTable.Rows(iir).cells.count
		Set myRange = od.Range(objTable.Cell(iir, 1).Range.Start, objTable.Cell(iir, cellsInThisRow ).Range.End)
		if myRange.Hyperlinks.count > 0 then
			if instr(myRange.Hyperlinks(1).address, "rftvp") = 0  then
				myRange.Select
				linkAddress = myRange.Hyperlinks(1).address
				myRange.ListFormat.RemoveNumbers
				myRange.Text = ""
				On error resume next
				myRange.InlineShapes.AddPicture directory & linkAddress 
				myRange.InlineShapes.AddPicture linkAddress
				on error goto 0
				lastPicture = linkAddress
			end if 
		end if
		if instr( myRange.Text, "scoring" ) > 0 or instr(myRange.Text, "target object") > 0 or instr(myRange.Text, "script_id") > 0 or instr(myRange.Text, "script_name") > 0  or instr(myRange.Text, "Warning") > 0 or instr(myRange.Text, "Script end") > 0 or instr(myRange.Text,  "script_name" ) >0 or instr(myRange.Text,  "getProperty") > 0  then
			for nnn = 1 to objTable.Rows(iir).cells.count 
				objTable.Cell(iir, nnn).Range.Text = ""
				objTable.Cell(iir, nnn).Range.ListFormat.RemoveNumbers
			next
			objTable.Rows(iir).delete
		end if
		cumulativePresent = False
		for nnn = 1 to objTable.Rows(iir).cells.count 
			if instr(objTable.Cell(iir, nnn).Range.Text, "scoring") > 0 then cumulativePresent = True 
			if instr(objTable.Cell(iir, nnn).Range.Text, "target object") > 0 then  cumulativePresent = True
			if instr(objTable.Cell(iir, nnn).Range.Text, "script_id") > 0 then  cumulativePresent = True
			if instr(objTable.Cell(iir, nnn).Range.Text, "script_name") > 0 then  cumulativePresent = True
			if instr(objTable.Cell(iir, nnn).Range.Text, "Warning") > 0 then  cumulativePresent = True
		'	if instr(objTable.Cell(iir, nnn).Range.Text, "exception") > 0 then  cumulativePresent = True
			if instr(objTable.Cell(iir, nnn).Range.Text, "Script end") > 0 then  cumulativePresent = True
		'	if instr(objTable.Cell(iir, nnn).Range.Text, "shutdown") > 0 then  cumulativePresent = True
		'	if instr(objTable.Cell(iir, nnn).Range.Text, "unhandled") > 0 then  cumulativePresent = True
			if instr(objTable.Cell(iir, nnn).Range.Text, "script_name") > 0 then  cumulativePresent = True
		'	if instr(objTable.Cell(iir, nnn).Range.Text, "un-handled") > 0 then  cumulativePresent = True
		next	
				
		if cumulativePresent = True then 
			for nnn = 1 to objTable.Rows(iir).cells.count 
				objTable.Cell(iir, nnn).Range.Text = ""
				objTable.Cell(iir, nnn).Range.ListFormat.RemoveNumbers
			next
			objTable.Rows(iir).delete
		end if			
		if  (instr(myRange.Text, "Fail") > 0 or instr(myRange.Text, "Error") > 0 ) and screenshotInEmail = "T" then
			lastPictureCaptured = lastPicture
		end if
	next
	Wscript.Sleep 1000
	appendExtraPictures od, extraImageMessage, dirWithExtraImages
	RemoveDateAndMergreWithFollowing(od)
	DeleteEmptyTablerows(od)
	addFinalResult od
	Wscript.Sleep 1000
	TimeDiff2 = "<BR>After DOC: " & "( exactly " &  DateDiff("s", StartTimestamp, Now) & " sec ) "
	On Error Resume Next 
	Dim cc
	cc  = od.SaveAs ( pdffilename, 17)
	od.save
	cc  = od.SaveAs ( textfilename, 7)
	od.save
	cc  = od.SaveAs ( MHTFileOut, 9)
	od.save
	wdApp.Quit
	set wdApp = Nothing 
	On Error goto 0
	Set objIE = Nothing
	Set objMessage = Nothing
	Set wdApp = Nothing 
	set od = Nothing 
	Set objSelection = Nothing
	Set objTable = Nothing 
	Set myRange = Nothing 
	Set objShell = Nothing
end sub