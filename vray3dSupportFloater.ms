vray_is_current_renderer = undefined

if (substring((renderers.current) as string) 1 5) != "V_Ray" then
(
	answer = queryBox "V-Ray is not current renderer! \n Set V-Ray as current renderer?" title:"Warning" 	 
	if answer==true then
	(
		vray_is_current_renderer = true
		renderers.current = VRay()
		sleep 2
	) 
	else 
	(
		vray_is_current_renderer = false
		messageBox "3D Support Tools supports V-Ray only" title:"Warning"
	) 
	
)
else
(
	vray_is_current_renderer = true
)


-------------------< < < < < < < < < < FUNCTIONS AND VARIABLES > > > > > > > > > >-------------------

fn RolloutVerification=
(
	if (vray3dSupportFloater != undefined) do
	(
		--cui.UnRegisterDialogBar vray3dSupportFloater
		destroydialog vray3dSupportFloater
	)
)


------------------* * * * * * * Instaled/Saved-funktions and variables * * * * * * *------------------
-------------------funktions-------------------
fn checkinstaledtype = 
(
	if ((mod (((vrayversion())[1][4]) as Integer) 2) == 0.0) then
	(
		"Stable"
	)
	else 
	(
		"Nightly"
	)
)

fn checkinstaledrelese = 
(
	if ((((vrayversion())[2]) as Integer) < 100) then
	(
		print "Release"
	)
	else
	(
		print "Nightly"
	)
)

fn checksavedtype = 
(
	if (vraysavedversion())[1] != "" do 
	(
		if ((mod (((vraysavedversion())[1][4]) as Integer) 2) == 0.0)
		then 
		(
			"Stable"
		) 
		else 
		(
			"Nightly"
		)
	)
)

fn checksavedrelese = 
(
	if (vraysavedversion())[1] != "" do
	(
		if ((((vraysavedversion())[2]) as Integer) < 100) then
		(
			print "Release"
		)
		else
		(
			print "Nightly"
		)
	)
)

fn checksavedmax = 
(
	if (vraysavedversion())[1] != "" do
	(
		(((vraysavedversion())[4]/1000 - 2) - 10)as Integer
	)
)

fn svs =
(
	svs = ""
	vsv = (vraysavedversion())[1]
	svsa = (filterString vsv".")
		if svsa.count > 3 then
			deleteItem  svsa svsa.count
		for i = 1 to svsa.count do
		svs += svsa[i] + "."
		svs = substring svs 1 (svs.count-1)
	return svs
)

fn ivi =
(
	ivi = ""
	viv = (vrayversion())[1]
	ivia = (filterString viv".")
		if ivia.count > 3 then
			deleteItem  ivia ivia.count
		for i = 1 to ivia.count do
		ivi += ivia[i] + "."
		ivi = substring ivi 1 (ivi.count-1)
	return ivi
)


function GetNvidiaDriver=
(
	nvidia_smi_cmd= "\"G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\FUNCTIONS&DEFAULTS\\nvidia-smi.exe\"" +" --filename=" + sysInfo.tempdir +"output.tmp"
	HiddenDOSCommand(nvidia_smi_cmd)
	nvidia_smi_log_file = sysInfo.tempdir +"output.tmp"
	file = openFile nvidia_smi_log_file mode:"r"
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
	
	if gpu_ver_line != "not defined" then
		(
			return substring gpu_ver_line (findstring gpu_ver_line "Driver Version:") 22
		)
		else
		(
			return gpu_ver_line
		)
)

function Suggested_blacklisted_gpu_driver = 
(
	download_as = sysInfo.tempdir +"vray_gpu_driver_status.xml"
	web = dotNetObject "System.Net.WebClient"
	web.DownloadFile "https://vraygpudriverblacklist.chaosgroup.com/vray_gpu_driver_status_v2.xml" download_as
	
	gpu_file = openFile download_as mode:"r"
	gpu_blacklist_line = "not defined"
	gpu_ver_line = "not defined"
	evaluateit = true
	
	while evaluateit do
	(
		currentline = readline gpu_file
		if (findString currentline "nv_driver_blacklist") != undefined then
		(
			gpu_blacklist_line = currentline
		)
		
		if (findString currentline "nv_suggested_driver") != undefined then
		(
			gpu_ver_line = currentline
		)
		
		evaluateit = not(eof gpu_file)
	)
	
	close gpu_file
	if gpu_ver_line != "not defined" then
	(
		return #(substring gpu_ver_line (findstring gpu_ver_line ">" + 1) 6 , substring gpu_blacklist_line (findstring gpu_blacklist_line ">" + 1)  ( (findstring gpu_blacklist_line "</nv") - (findstring gpu_blacklist_line ">" + 1) ))
	)
	else
	(
		return #(gpu_ver_line, gpu_blacklist_line)
	)
)

RolloutVerification()


----------Rollout code----------------------------------------------------------------------------------------

rollout vray3dSupportFloater "V-Ray 3D Support Tools V2.1" width:300  --height:500 autoLayoutOnResize:true
(
	
	button 	btn_chaos_installer		"Chaos Installer"	pos:[5,10] 		width:140 	toolTip:"Launch Chaos Installer"
	button	open_ticket_in_zendesk	"Zendesk Ticket"	pos:[150,10]	width:140	toolTip:"Open Zendesk Ticket in Chrome"
	
	group "V-Ray Version"
	(	
		label	edt1	"Instaled:"		align:#left		bold:true	
		label	edt2	"Saved:"			align:#left		bold:true
	)
	
	group "NVIDIA GPU Driver Version"
	(	
		label	edt3	"Instaled Driver Version:"		align:#left		bold:true
		label	edt4	"Recomended Driver Version:"	align:#left		bold:true 
	)
	
	on vray3dSupportFloater open do
	(

		edt1.text = "Instaled:" +" "+ ivi()+" "+(checkinstaledtype())+" "+(checkinstaledrelese())--+" ("
		
		edt2.text = 
		(
			if (vraysavedversion())[1] != "" then
			(
				"Saved:" +" "+ svs() + " "+(checksavedtype())+" "+(checksavedrelese())+" "+"3dsMax201"+(checksavedmax()as String)
			)
			else if (vraysavedversion())[1] == "" then
			(
				("Saved:" +" "+ "For this info, you need to open a file first")
			)
		)
		
		edt3.text = "Instaled " + GetNvidiaDriver()
		
		edt4.text = "Recomended Driver Version:" + " " + (Suggested_Blacklisted_gpu_driver())[1]
	)
	
	on btn_chaos_installer pressed do
	(
		ShellLaunch "G:\\Shared drives\\3D SUPPORT\\Scripts\\Chaos-Installer\\Start-Chaos-Installer.bat" ""
	)
	
	on open_ticket_in_zendesk pressed do
	(
		file_path = maxFilePath as String
		index = findstring maxFilePath @"G:\Shared drives\3D SUPPORT\Scenes\"
		if index == 1 then 		--if filepath contains "G:\Shared drives\3D SUPPORT\Scenes\"
		(
			text_replace = substituteString file_path @"G:\Shared drives\3D SUPPORT\Scenes\" ""
			index = findstring text_replace @"\"
			ticket_id = substring text_replace 1 (index-1)
			print(ticket_id)
			zendesk_url_prefix = @"https://chaos4812.zendesk.com/agent/tickets/"
			url = zendesk_url_prefix + ticket_id
			print(url)
			ShellLaunch "chrome.exe" url
		)
		else
		(
			messageBox @"File not stored in: G:\Shared drives\3D SUPPORT\Scenes\"
		)

	)
	
	subrollout vray3dSupport "vray3dSupport" pos:[0,160] width:300 height:500
	
)

if vray_is_current_renderer == true do
(                                     -- the bellow code allows to window-resizing
	createdialog vray3dSupportFloater --style:#(#style_resizing,#style_titlebar, #style_border, #style_sysmenu)
)


----------Start Importing Rollouts From Other Files----------------------------------------------------------------------------------------
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_DemoScenes.ms")
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_V-RayInterface&SettingsTools.ms")
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_SelectTools.ms")
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_ScriptedRendererProperties.ms")
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_LightsDebugger.ms")		
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_MtlTools.ms")
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_AssetsControls.ms")		
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_Compare_Render_Settings.ms")
filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\ROLLOUTS\\Rollout_Sanity_Check.ms")
	


----------Rollouts order-------------------------------------------------------------------------------------------------------
addsubRollout vray3dSupportFloater.vray3dSupport DS rolledUp:true
addsubRollout vray3dSupportFloater.vray3dSupport VRITST rolledUp:true
addsubRollout vray3dSupportFloater.vray3dSupport SelectTools rolledUp:true
addsubRollout vray3dSupportFloater.vray3dSupport LightsDebugger rolledUp:true
addsubRollout vray3dSupportFloater.vray3dSupport MtlDebugger rolledUp:true 
addsubRollout vray3dSupportFloater.vray3dSupport ScriptedRendererProperties rolledUp:true
addsubRollout vray3dSupportFloater.vray3dSupport CompareRenderSettings rolledUp:true
addsubRollout vray3dSupportFloater.vray3dSupport SanityCheck rolledUp:true
addsubRollout vray3dSupportFloater.vray3dSupport AssetsControls rolledUp:true



