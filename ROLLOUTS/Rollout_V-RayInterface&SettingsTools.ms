
Rollout VRITST "V-Ray Interface & Settings Tools"
	(
-- 	checkbutton 	chkbtn_1 	"Settings Comparison Tool"	pos:[0,0] 		width:140  	enabled:false
	button 			btn_2 		"VFB Reset"  						pos:[0,0]	width:140 toolTip:"Sets the VRay frame buffer to its default position"
	button 			btn_3 		"VRayLog"  							pos:[147,0]		width:140 toolTip:"Saves VRayLog file to max file derectory"
		
-- 	on chkbtn_1 changed theState do
-- 	(
-- 		if  (theState as string) == "true" do
-- 			(
-- 			filein("\\\\SUPPORT-PC\\3d_Support_Files\\V-Ray_3D_Support_Tools\\ROLLOUTS\\SettingsComparisonTool_Window.ms")
-- 			)
-- 		if  (theState as string) == "false" do
-- 			(
-- 			try ( destroyDialog SCT ) catch ()
-- 			)
-- 	)
		
	on btn_2 pressed do
	(
		vfbcontrol #pos "reset"	
	)
	
	on btn_3 pressed do
	(
		renderers.current.system_vrayLog_file = maxFilePath + "VRayLog_" + maxFileName + ".txt"
	)
	)
	
----------------------This part is for testing when the code is ready, should be commented-----------------------------
/*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout VRITST vray3dSupportDummyFloater 

-----------------------------------------------------------------------------------------------------------------------