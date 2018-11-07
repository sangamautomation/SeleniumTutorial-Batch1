	 echo off


	REM '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	REM '''''''' Description : Running Selenium Regression Test - Manual Batch  '''''''
	REM ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


	set CALCTIME=%TIME%
	rem	set currdate=%date:/=%
	
	set currdate=%date:~4%
	set currdate=%currdate:/=-%
	echo currentDate is %currdate%
	
	Rem Remove : . and , and space
	set CALCTIME=%CALCTIME::=%   
	set CALCTIME=%CALCTIME:,=%
	set CALCTIME=%CALCTIME: =%
	set CALCTIME=%CALCTIME:.=%
	Rem Add leading zeros for time before 10 oclock
	set CALCTIME=0000%CALCTIME%
	Rem Take last 8 characters
	set CALCTIME=%CALCTIME:~-8%
	Rem Take first 6 characters
	set CALCTIME=%CALCTIME:~0,6%
	echo Time: %CALCTIME%

	setLocal EnableDelayedExpansion
	D:

	rem cd D:\SeleniumWebDriver\Selenium_Tutorial
 
	rem svn update .
	REM comment ant command if scripts dont compile
	rem call ant build 
	rem svn cleanup
	
	set CLASSPATH=".
	for /R D:\Selenium_Drivers\lib %%a in (*.jar) do (
		set CLASSPATH=!CLASSPATH!;%%a
	)
	

	set "JAVA_HOME=C:\Program Files (x86)\Java\jre1.8.0_111"
	  
 	echo !CLASSPATH!


	REM ################################ VBS Arguments ############################################
	REM ***Enter values without quotes to pass variables in quotes, if values are in quotes do not pass variables in quotes ***
	set buildEmailSubject=
	set logConsoleDir=D:\Selenium_Logs\AutoLogs\
	rem set DashboardReportsPath=\\MB-SAS-FP-01\EEF-Testers$\Team Folders\AutomationTeam\
	set DashboardReportsPath=D:\Selenium_Logs\\AutomationTeam\
	set FailScreenshotInEmail=F
	rem =T, for failed screenshot
	set AdditionalNotes=Remarks 
	rem add any notes at the end of report
	set AdditionalScreenshots=D:\Selenium_Logs\AdditionalScreenshots\
	REM et RegressionFolder=
	set RegressionFolder=AutomationReports
 


	REM ################### Change the below 2 values and comment the rest of scripts before execution #####################
	set env=http://output.jsbin.com/usidix/1
 	set startingTCNo=10
	set endingTCNo=10
	
REM ****************************  Execution List ********************************
set Script[10]=src.Hi
set Script[11]=src.testCases.Alert
set Script[12]=src.testCases.Dropdown
set Script[13]=src.testCases.Frames
set Script[14]=src.testCases.Menus
set Script[15]=src.testCases.TC1_E2E_hayneedle
set Script[16]=src.testCases.TC2_E2E_CheapOAir
set Script[17]=src.testCases.ToolsQA
set Script[18]=src.testCases.WebServicesTest


	REM =============================== END OF SCRIPTS ====================================== 


	REM +++++++++++++++++++++++ With Date in Log Name  (Ensure no spaces on right, put quotes either in variables or passing args)++++++++++++++++++++++++++++++++++++	

	cd D:\SeleniumWebDriver\Selenium_Tutorial
rem D:\Selenium_Logs\Screenshots\src.testCases.Alert_%currdate%_%CALCTIME%_!env!

	FOR /L %%a IN (!startingTCNo!,1,!endingTCNo!) DO (
	  ECHO %%a
	  set ScriptName=!Script[%%a]!
	  call echo scriptName: !ScriptName!
	  call echo environment: !env!
	 set logDir=D:\Selenium_Logs\Screenshots
	 rem set logScript=!ScriptName!_%currdate%_%CALCTIME%_!env!
	 set logScript=!ScriptName!_%currdate%_%CALCTIME%
	 set logFolder=!logDir!\!logScript!
	 set logHTML=!logFolder!\rational_ft_logframe.html
	 set logFile=!logFolder!\!logScript!.log
	 set logFileOut=!logDir!\!logScript!.log
	 set logConsole=D:\Selenium_Logs\Screenshots\Automation_RunningConsole.log
	 set logFileConsole=D:\Selenium_Logs\Screenshots\ConsoleLogs\!logScript!.log
	set timestamp=*** Date: %DATE:/=-% and Time:%TIME::=-% ***
	 echo timestamp
	 
	rem call mkdir !logFolder!\!logScript!
	 
	REM mkdir !logDir! >NUL
 
	timeout /t 1 /nobreak

	cd D:\SeleniumWebDriver\Selenium_Tutorial

	rem set path=D:\RFT\TestAutomation_AREEF\
	rem set ext=.java
	rem >!logDir!\output.txt (
	rem  call "%JAVA_HOME%\bin\java" -Xms128m -Xmx384m -Xnoclassgc !ScriptName! !env! >>!logFileConsole!
	 REM call "%JAVA_HOME%\bin\java" -Xms128m -Xmx384m -Xnoclassgc !ScriptName! !env! 2>&1>>!logFileConsole! >!logConsole!
	 rem   call "%JAVA_HOME%\bin\java" -Xms128m -Xmx384m -Xnoclassgc !ScriptName! !env! >>!logFileConsole! & type !logFileConsole! >>!logConsole!
		call "%JAVA_HOME%\bin\java" -Xms128m -Xmx384m -Xnoclassgc !ScriptName! !env! 2>&1>!logConsole! REM 2>&1 for errors & stdout
		 
rem		 cd C:\Program Files (x86)\IBM\SDP\jdk\bin
rem		java -Xms128m -Xmx384m -Xnoclassgc "D:\RFT\TestAutomation_AREEF\regressionTest.magi.AT_100_HCIP" "TST3"  
		
		ping localhost  -n 1 -w 123 >nul
		rem echo %date% > outputfile
		type !logConsole! >> !logFileConsole!
		rem	copy !logConsole! >> !logFileConsole!


	timeout /t 15 /nobreak > NUL
	rem call cscript //b D:\Selenium_Docs\AutomationReporting\SeleniumReporting_New.vbs "!logHTML!" "!env!" "!AdditionalNotes!" "!AdditionalScreenshots!" "!FailScreenshotInEmail!" "!buildEmailSubject!" "!DashboardReportsPath!" "!RegressionFolder!"
	rem call D:\RFT\TestAutomation_AREEF\batches\SeleniumReporting_New.vbs "D:\RFT\TestAutomation_AREEF_logs\!ScriptName!_%currdate%_%CALCTIME%_!env!\rational_ft_logframe.html" "!env!" "!AdditionalNotes!" "!AdditionalScreenshots!" "!FailScreenshotInEmail!" "!buildEmailSubject!" "!DashboardReportsPath!" "!RegressionFolder!"
	 call cscript //b D:\Selenium_Docs\AutomationReporting\SeleniumReporting.vbs "D:\Selenium_Logs\Screenshots\!ScriptName!_%currdate%_!env!\rational_ft_logframe.html" "!env!" "Additional Screenshots" "D:\RFT\Automation_AREEF_logs\AdditionalScreenshots" "LastFailScreenshotNotApplicable_T_Applicable" "!buildEmailSubject!" "\\MB-SAS-FP-01\EEF-Testers$\Team Folders\AutomationTeam\"

	)

	rem waits for 123 millisec
	ping localhost  -n 1 -w 123 >nul

	call D:\RFT\TestAutomation_AREEF\batches\cleanupInstancesOfProcesses.vbs

 rem	 choice /C X /T 5 /D X > nul
 rem 	 timeout /T 3 /nobreak
	 
	