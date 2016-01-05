@echo off

call "%~dp0BuildServer\ProgramPaths.bat"

REM ===================================================

echo ##teamcity[progressMessage 'Building Solution']

cd "%~dp0"
%DEVENV_2013% CoverageDemo.sln /Rebuild Debug
if %ERRORLEVEL% NEQ 0 goto exit_batch

REM ===================================================

echo ##teamcity[progressMessage 'Running Tests']

set SOURCES=%~dp0CoverageDemo\
set APP=%~dp0Debug\CoverageDemoTests.exe

cd "%~dp0"
del Coverage.bin
del Coverage.txt
del Coverage.xml
rmdir /s /q CoverageReport
del CoverageReport.zip

opencppcoverage --sources %SOURCES% --export_type=binary:Coverage.bin -- %APP% --gtest_output=xml:tests.xml
REM This may have a %ERRORLEVEL% other than 0 due to failed tests, this can be
REM ignored as the build will fail on failed tests but we still want to generate
REM the report files

echo ##teamcity[importData type='gtest' path='tests.xml']

echo ##teamcity[progressMessage 'Generating Coverage Reports']

opencppcoverage --input_coverage Coverage.bin --export_type=cobertura:Coverage.xml
if %ERRORLEVEL% NEQ 0 goto exit_batch

cd "%CURRENT_DIRECTORY%"
BuildServer\xslconvert "Coverage.xml" BuildServer\CoverageToTeamCity.xslt Coverage.txt
if %ERRORLEVEL% NEQ 0 goto exit_batch

type Coverage.txt

opencppcoverage --input_coverage Coverage.bin --export_type=html:CoverageReport
if %ERRORLEVEL% NEQ 0 goto exit_batch

%SEVENZIP% a "%~dp0CoverageReport.zip" "%~dp0CoverageReport"
if %ERRORLEVEL% NEQ 0 goto exit_batch

echo ##teamcity[publishArtifacts '%~dp0CoverageReport.zip']

REM ===================================================

:exit_batch
exit /b %ERRORLEVEL%
