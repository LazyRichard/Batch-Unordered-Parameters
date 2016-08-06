@ECHO off
GOTO _start
:usage
ECHO 이름
ECHO   unorderedParametersTemplates.bat
ECHO 개요
ECHO   Batch파일에서 순서에 상관 없는 파라미터를 사용하기 위한 템플릿입니다.
ECHO 구문
ECHO   unorderredParametersTemplates.bat /par1:<string> /par2:<integer> [/Verbose]
ECHO 파라메타
ECHO  /SourceImageFile    : (필수)문자열타입의 파라미터입니다.
ECHO  /SourceIndex        : (필수)숫자타입의 파라미터입니다.
ECHO  /Verbose            : 자세한 설명을 보여줍니다.

GOTO _exit

:_start
SETLOCAL ENABLEDELAYEDEXPANSION

REM Parsing parameters
IF [%1]==[] ( GOTO usage )
FOR %%i IN (%*) DO (
  FOR /f "tokens=1* delims=:" %%j IN ("%%i") DO (
    REM Declear parameters
    IF [%%j]==[/par1] (
      SET par1=%%~k )
    IF [%%j]==[/par2] (
      SET par2=%%k )
    IF [%%j]==[/Verbose] (
      SET verbose=true )
  )
)

REM Verbose mode
IF [%verbose%]==[true] (
  ECHO ================================================================
  ECHO par1  : %par1%
  ECHO par2  : %par2%
  ECHO ================================================================
)

REM Set mandantory parameters behavior
IF [%par1%]==[] GOTO usage
IF [%par2%]==[] GOTO usage

:_exit
ENDLOCAL
