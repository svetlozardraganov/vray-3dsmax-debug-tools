
Rollout RenderingMethods "Rendering Methods"
(
	button 			btn_LTS 			"Load Test Scene" 	align:#center		width:258
	
	checkButton 	ckb_P 				"Production" 			/*pos:[89,36]*/align:#center		across:3		width:84	checked:true
	checkButton 	ckb_AS 				"ActiveShade" 		/*pos:[154,36]*/align:#center	across:3		width:84
	checkButton 	ckb_S 				"standalone" 			/*pos:[222,36]*/align:#center	across:3		width:84
		
	button 			btn_BK 				"Bucket" 				/*pos:[0,62]*/align:#center		across:3		width:84
	button 			btn_PR 				"Progres" 				/*pos:[97,62]*/align:#center		across:3		width:84
	button 			btn_INT 			"Interactive" 			/*pos:[194,62]*/align:#center		across:3		width:84
		
	button 			btn_CPU 			"CPU" 					/*pos:[0,98]*/align:#center		across:3		width:84
	button 			btn_GPU 			"CUDA" 					/*pos:[97,98]*/align:#center		across:3		width:84
	button 			btn_OCL 			"OpenCL" 				/*pos:[194,98]*/align:#center		across:3		width:84
		
		
	on ckb_P changed theState do
	(
		if ckb_P.state == 1 then
		(
			ckb_AS.state = 0
			ckb_S.state = 0
			
			btn_BK.enabled = true
			btn_PR.enabled = true
			btn_INT.enabled = true
		)
		else
		(
			ckb_P.state = 1
		)
	)
	on ckb_AS changed theState do
	(
		if ckb_AS.state == 1 then
		(
			ckb_S.state = 0
			ckb_P.state = 0
			
			btn_BK.enabled = false
			btn_PR.enabled = false
			btn_INT.enabled = false
		)
		else
		(
			ckb_AS.state = 1
		)
	)
	on ckb_S changed theState do
	(
		if ckb_S.state == 1 then
		(
			ckb_P.state = 0
			ckb_AS.state = 0
			
			btn_BK.enabled = true
			btn_PR.enabled = true
			btn_INT.enabled = false
		)
		else
		(
			ckb_S.state = 1
		)
	)
-----------------------------------------------
-----------------------------------------------
	on btn_BK presed do
	(
		if ckb_P.state == 1 do
		(			
			sceneStateMgr.Capture "ambient" #{1,2,3,4,5,6,7,8,9}
			
			renderpresets.SaveAll 0 "ambient"
			
			macros.run "Render" "RenderButtonMenu_Switch_To_Production_Mode"
			
		)
		
		if ckb_S.state == 1 do
		(
			
		)
	)
	on btn_PR presed do
	(
		if ckb_P.state == 1 do
		(
			
		)
		
		if ckb_S.state == 1 do
		(
			
		)
	)
	on btn_BK presed do
	(
		
	)
-----------------------------------------------
-----------------------------------------------
	on btn_CPU presed do
	(
		if ckb_P.state == 1 do
		(
			
		)
		
		if ckb_AS.state == 1 do
		(
			
		)
		
		if ckb_S.state == 1 do
		(
			
		)
	)
	on btn_GPU presed do
	(
		if ckb_P.state == 1 do
		(
			
		)
		
		if ckb_AS.state == 1 do
		(
			
		)
		
		if ckb_S.state == 1 do
		(
			
		)
	)
	on btn_OCL presed do
	(
		if ckb_P.state == 1 do
		(
			
		)
		
		if ckb_AS.state == 1 do
		(
			
		)
		
		if ckb_S.state == 1 do
		(
			
		)
	)
)
----------------------This part is for testing when the code is ready, should be commented-----------------------------
-- /*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout RenderingMethods vray3dSupportDummyFloater 

-----------------------------------------------------------------------------------------------------------------------