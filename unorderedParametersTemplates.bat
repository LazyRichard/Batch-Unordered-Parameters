@ECHO off
GOTO _start
:usage
ECHO �̸�
ECHO   unorderedParametersTemplates.bat
ECHO ����
ECHO   Batch���Ͽ��� ������ ��� ���� �Ķ���͸� ����ϱ� ���� ���ø��Դϴ�.
ECHO ����
ECHO   unorderredParametersTemplates.bat /par1:<string> /par2:<integer> [/Verbose]
ECHO �Ķ��Ÿ
ECHO  /SourceImageFile    : (�ʼ�)���ڿ�Ÿ���� �Ķ�����Դϴ�.
ECHO  /SourceIndex        : (�ʼ�)����Ÿ���� �Ķ�����Դϴ�.
ECHO  /Verbose            : �ڼ��� ������ �����ݴϴ�.

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

REM Set mandantory parameters behaiver
IF [%par1%]==[] GOTO usage
IF [%par2%]==[] GOTO usage

:_exit
ENDLOCAL