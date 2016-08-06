# Batch-Unordered-Parameters
## 개요
배치파일에서 순서에 상관 없는 파라미터를 사용하기 위한 스크립트 템플릿입니다.

CMD에서 배치파일을 작성하다 보면 파라미터들이 많은 경우 순서나 왜 이런 인자를 전달했는지 햇갈리는 경우가 종종 발생합니다.
이를 해결하고자 파라미터에 이름을 부여하고 순서에 상관 없이 전달 할 수 있게 만들고자 합니다.
DISM에서 사용하는 방식처럼 각각의 인자는 /<파라미터 이름>으로 전달되는 것을 기본으로 하였습니다.
그리고 값은 :(콜론) 뒤에 넣도록 작성하였습니다.
다시 말해서 인자를 전달하려면 <배치파일 이름.bat> /<파라미터 이름>:<값>의 형태로 전달하면 됩니다.
또한 스위치 인자를 사용할 수 있습니다.

## 사용법
###### 기본적인 파라미터 작성법
REM Parsing parameters
IF [%1]==[] ( GOTO usage )
FOR %%i IN (%*) DO (
  FOR /f "tokens=1* delims=:" %%j IN ("%%i") DO (
    REM 이 곳에 선언하고 싶은 파라미터를 작성하시면 됩니다.
	REM 작성 형태는 다음과 같습니다.
	REM IF [%%j]==[/<원하는 파라미터 이름>] (
	REM   SET <원하는 파라미터 이름>==%%k )
	
	REM 만약 파라미터가 디렉터리와 같이 문자열 형태를 나타낼 경우 큰 따옴표가 있을 수 있습니다.
	REM 이를 제거하기 위하여 문자열 파라미터는 아래와 같이 작성합니다.
	REM IF [%%j]==[/<문자열 파라미터 이름>] (
	REM   SET <문자열 파라미터 이름>==%%~k )
	
	REM 만약 파라미터가 스위치 형태를 같는 경우에는 아래와 같이 작성합니다.
	REM IF [%%j]==[/<스위치 파라미터 이름>] (
	REM   SET <스위치 파라미터 이름>=true )
	
	REM 아래는 예제입니다.
    IF [%%j]==[/par1] (
      SET par1=%%~k )
    IF [%%j]==[/par2] (
      SET par2=%%k )
    IF [%%j]==[/Verbose] (
      SET verbose=true )
  )
)

###### 필수 항목 작성법
필수 항목의 파라미터를 작성하는 방법은 아래와 같습니다.
REM Parsing parameters
IF [%1]==[] ( GOTO usage )
FOR %%i IN (%*) DO (
  FOR /f "tokens=1* delims=:" %%j IN ("%%i") DO (
    REM 이 곳에 선언하고 싶은 파라미터를 작성하시면 됩니다.
	REM 필수 항목 역시 기본적인 파라미터 작성법과 동일하게 작성합니다.
	
	REM IF [%%j]==[/<필수 파라미터 이름>] (
	REM   SET <필수 파라미터 이름>==%%k )
	
	REM 아래는 예제입니다.
	IF [%%j]==[/par3] (
	  SET par3=%%k )
  )
)

REM 이후 필수 파라미터는 아래 위치에 만약 파라미터의 값이 없을 경우 추가적으로 처리하는 루틴을 작성합니다.
REM Set mandantory parameters behaiver
IF [%par3%]==[] GOTO usage

## 알려진 문제점
1. 문자열 파라미터 입력을 받을 때, 띄어쓰기 처리가 안됩니다.
즉, unorderedparmetertemplates.bat /par1:"aaa"는 가능하지만
unorderedparmetertemplates.bat /par1:"aaa bbb"는 에러가 납니다.

2. 파라미터 이름을 작성 할 때, 대소문자 구분을 합니다.
만약 파라미터 이름을 /Par로 작성하였으면 파라미터를 전달 할때도 /Par:<value>로 전달해야 합니다.
그렇지 않으면 에러가 납니다.
