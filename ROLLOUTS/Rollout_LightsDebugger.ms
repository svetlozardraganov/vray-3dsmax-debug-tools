----------Start Functions & Defauts--------------------------------------------------------------------------------------------

filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\FUNCTIONS&DEFAULTS\Functions&Defauts.ms")

----------Stop Functions & Defauts---------------------------------------------------------------------------------------------

Rollout LightsDebugger "Lights Debug Tools" 
(
radioButtons rdoSA 						"" 							pos:[0,0] 		labels:#("Selected", "All")	offsets:#([35,0], [84,0])	columns:2
button 			btn_on 						"ON" 						pos:[0,20]  	width:140
button 			btn_off 						"OFF" 					pos:[147,20]	width:140\

group "Increase/Decrease Multiplier"
	(	
	button 			btn_increaseMultiplier 	"Increase Multiplier" 	align:#left 		width:130	across:2
	button 			btn_decreaseMultiplier 	"Decrease Multiplier" align:#right 	width:130
	radioButtons rdoID 						"" 							pos:[0,95] 		labels:#("", "")	offsets:#([101,0], [50,0])	columns:2
	Label			labgp1						"By Geometric"			pos:[26,86] 
	Label			labgp2						" Progression"			pos:[26,99] 
	Label			labap1						"By Arithmetic"		pos:[195,86] 
	Label			labap2						" Progression"			pos:[195,99] 
	spinner 		spnr_val 					"" 							pos:[119,95]	width:48	type:#float		range:[1,1000, 2]	scale:1
	)
	
-- group "Reset/Copy/Paste Tools"
-- 	(
-- 	button 		btn_resetSettings 		"Reset V-Ray Light Settings" 	align:#left width:260
-- 	button 		btn_copy 					"Copy vLight Settings" 			align:#left across:2 width:130
-- 	button 		btn_paste 					"Paste vLight Settings" 			align:#right width:130
-- 	checkbox 	cbox_keepLightType 	"Keep Light Type" 				align:#left across:2 width:130
-- 	checkbox 	cbox_keepMultiplier 		"Keep Multiplier"
-- 	checkbox 	cbox_keepSize 			"Keep Size"
-- 	)

-- group "Overrides"
-- 	(
-- 	dropDownList 	dd_lightType 		"" width:130 height:20 items:#("Plane Light", "Dome Light", "Sphere Light", "Mesh Light", "Disk Light") align:#left across:2 width:130
-- 	spinner 			spnr_intensity 	"Intensity" type:#float range:[0,1000, 0]  align:#right width:130
-- 	checkbox 			cbox_invisible 		"Invisible"
-- 	)

	fn setLightsProperty propname value = 
		(
		if rdoSA.state == 1 then 
			(
			lightlist = #()
				
			for obj in $selection do 
				(
				if superclassof obj == light do append lightlist obj
				)
			)
		else if rdoSA.state == 2 do 
			(
			lightlist = $Lights
			)
		
		for light in lightlist do 
			(
			if classof propname == Array then 
				(
				for prop in propname do 
					(
					if (hasproperty light prop) do (setproperty light prop value)
					)
				)
			else 
				(
				if (hasproperty light propname) do (setproperty light propname value)
				)
			)
		)

	on btn_on pressed do
	(
		setLightsProperty #("on", "enabled", "OnCbx") true
	)

	on btn_off pressed do
	(
		setLightsProperty #("on", "enabled", "OnCbx") false
	)
		
	on btn_increaseMultiplier pressed do
		(
			if rdoSA.state == 1 then 
				(
				lightlist = #()
					
				for obj in $selection do 
					(
					if superclassof obj == light do append lightlist obj
					)
				)
			if rdoSA.state == 2 do 
				(
				lightlist = $Lights
				)

			for light in lightlist do 
				(
				if rdoID.state == 1 do
					(
					if hasproperty light "multiplier" do light.multiplier *=spnr_val.value
					if hasproperty light "intensity_multiplier" do light.intensity_multiplier *=spnr_val.value
					)
				if rdoID.state == 2 do
					(
					if hasproperty light "multiplier" do light.multiplier +=spnr_val.value
					if hasproperty light "intensity_multiplier" do light.intensity_multiplier +=spnr_val.value
					)
				)
		)
		
	on btn_decreaseMultiplier pressed do
		(
			if rdoSA.state == 1 then 
				(
				lightlist = #()
					
				for obj in $selection do 
					(
					if superclassof obj == light do append lightlist obj
					)
				)
			if rdoSA.state == 2 do 
				(
				lightlist = $Lights
				)

			for light in lightlist do 
				(
				if rdoID.state == 1 do
					(
					if hasproperty light "multiplier" do light.multiplier /=spnr_val.value
					if hasproperty light "intensity_multiplier" do light.intensity_multiplier /=spnr_val.value
					)
				if rdoID.state == 2 do
					(
					if hasproperty light "multiplier" do light.multiplier -=spnr_val.value
					if hasproperty light "intensity_multiplier" do light.intensity_multiplier -=spnr_val.value
					)
				)
		)
		
	on btn_resetSettings pressed do
		(
			$.on = defaultLightSettings[1]
			
			if cbox_keepLightType.checked ==false then $.type = defaultLightSettings[2]
			
			$.targeted = defaultLightSettings[3]
			$.target_distance = defaultLightSettings[4]
			$.color_mode = defaultLightSettings[5]
			$.color_temperature = defaultLightSettings[6]
			$.color = defaultLightSettings[7]
			
			if cbox_keepMultiplier.checked ==false then $.multiplier = defaultLightSettings[8]

			$.normalizeColor = defaultLightSettings[9]
			
			if cbox_keepSize.checked ==false do 
			(
				$.size0 = defaultLightSettings[10]
				$.size1 = defaultLightSettings[11]
				$.size2 = defaultLightSettings[12]
			)
			
			$.castShadows = defaultLightSettings[13]
			$.doubleSided = defaultLightSettings[14]
			$.invisible = defaultLightSettings[15]
			$.affect_diffuse = defaultLightSettings[16]
			$.diffuse_contribution = defaultLightSettings[17]
			$.affect_specular = defaultLightSettings[18]
			$.specular_contribution = defaultLightSettings[19]
			$.affect_reflections = defaultLightSettings[20]
			$.ignoreNormals = defaultLightSettings[21]
			$.noDecay = defaultLightSettings[22]
			$.storeWithIrradMap = defaultLightSettings[23]
			$.skylightPortal = defaultLightSettings[24]
			$.simplePortal = defaultLightSettings[25]
			$.subdivs = defaultLightSettings[26]
			$.shadowBias = defaultLightSettings[27]
			$.cutoffThreshold = defaultLightSettings[28]
			$.notUsed = defaultLightSettings[29]
			$.smoothSurfaceShadows = defaultLightSettings[30]
			$.texmap = defaultLightSettings[31]
			$.texmap_on = defaultLightSettings[32]
			$.texmap_resolution = defaultLightSettings[33]
			$.texmap_adaptiveness = defaultLightSettings[34]
			$.texmap_locktodome = defaultLightSettings[35]
			$.dome_emitRadius = defaultLightSettings[36]
			$.dome_targetRadius = defaultLightSettings[37]
			$.dome_spherical = defaultLightSettings[38]
			$.dome_affect_alpha = defaultLightSettings[39]
			$.dome_rayDistanceMode = defaultLightSettings[40]
			$.dome_rayDistance = defaultLightSettings[41]
			$.dome_visibleOriginal = defaultLightSettings[42]
			$.mesh_source = defaultLightSettings[43]
			$.mesh_replaceOnPick = defaultLightSettings[44]
			$.mesh_flip = defaultLightSettings[45]
			$.lightDistribution = defaultLightSettings[46]
			$.preview_distribution = defaultLightSettings[47]
			$.preview_texmap = defaultLightSettings[48]
			$.use_mis = defaultLightSettings[49]
			$.enable_viewport_shading = defaultLightSettings[50]
			$.viewport_wire_color_on = defaultLightSettings[51]
			$.viewport_wire_color = defaultLightSettings[52]
			$.icon_text = defaultLightSettings[53]
		--	$.excludeList = defaultLightSettings[54]
		--	$.includeList = defaultLightSettings[55]
		--	$.inclExclType = defaultLightSettings[56]
		) 
	)
----------------------This part is for testing when the code is ready, should be commented-----------------------------
/*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout LightsDebugger vray3dSupportDummyFloater 

-------------------------------------------------------------------------------------------------------------------------------