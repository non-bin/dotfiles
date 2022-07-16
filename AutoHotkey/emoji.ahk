; encoding: UTF-8BOM

#SingleInstance Force

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
