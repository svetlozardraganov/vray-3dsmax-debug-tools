function GetNvidiaDriver=
(
-- 	x= "\"C:\\2 2\\nvidia-smi.exe\"" +" --filename=" + sysInfo.tempdir +"output.tmp"
	x= "\"G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\FUNCTIONS&DEFAULTS\\nvidia-smi.exe\"" +" --filename=" + sysInfo.tempdir +"output.tmp"

-- 	print(x)
	HiddenDOSCommand(x)

	file = openFile "C:\2\output.tmp" mode:"r"
	gpu_ver_line = "not defined"
	evaluateit = true

	while evaluateit do
	(
		currentline = readline file
		if (findString currentline "Driver Version:") != undefined then
		(
			gpu_ver_line = currentline
			exit
			)
		evaluateit = not(eof file)
	)

	close file

	-- print(gpu_ver_line)

	if gpu_ver_line != "not defined" then
		(
			return substring gpu_ver_line (findstring gpu_ver_line "Driver Version:") 22
		)
		else
		(
			return gpu_ver_line
		)
)

x = GetNvidiaDriver()