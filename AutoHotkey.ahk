; encoding: UTF-8BOM
#SingleInstance Force

; https://www.autohotkey.com/docs/Hotkeys.htm

; Emoji - ctrl(+shift)+f10
^+F10::
	Input,v,L1
	If (v=="1") {
		SendRaw 👍
		Return
	}

	If (v=="2") {
		SendRaw 👎
		Return
	}

	If (v=="=") {
		SendRaw 🙂
		Return
	}

	If (v=="+") {
		SendRaw (✿◡‿◡)
		Return
	}

	If (v=="-") {
		SendRaw 🙁
		Return
	}

	If (v=="_") {
		SendRaw ╯︿╰
		Return
	}

	If (v=="3") {
		SendRaw ❤️
		Return
	}

	If (v=="*") {
		SendRaw ༼ つ ◕_◕ ༽つ
		Return
	}

	If (v=="?") {
		SendRaw ¯\_(ツ)_/¯
		Return
	}

	If (v=="b") {
		SendRaw ᕦʕ •ᴥ•ʔᕤ
		Return
	}

	If (v=="r") {
		SendRaw 🏳‍🌈
		Return
	}

	SendRaw %v%

	Return


; fix ctrl+backspace
#IfWinActive ahk_exe explorer.exe
	^Backspace::
		Send ^+{Left}{Backspace}
#IfWinActive

; always ontop - alt+t
;!t::
;	WinSet, AlwaysOnTop, Toggle, A
;	WinSet, Style, ^0xC00000, A  ; Remove the active window's title bar (WS_CAPTION).
