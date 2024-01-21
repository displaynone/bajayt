!include "MUI2.nsh"

Name "Baja YT"
OutFile "BajaYT.exe"
InstallDir "$PROGRAMFILES\BajaYT"
ShowInstDetails show
ShowUninstDetails show

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section "PrincipalSection" SEC01
  SetOutPath "$INSTDIR"
  File /r ".\build\windows\x64\runner\Release\*.*"

  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\*.*"
  RMDir "$INSTDIR"
  Delete "$DESKTOP\BajaYT.lnk"
SectionEnd
