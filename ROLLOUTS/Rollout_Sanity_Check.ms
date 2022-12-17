

-------------------------------------UI CODE-------------------------------------
--https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_3835162F_3EC5_485B_8453_E7960AF34837_htm


Rollout SanityCheck "Sanity Check" 
(		
	multilistBox 	mlb1 	pos:[1,5]		width:175 	height:20 	align:#left		toolTip:"Click or Drag to select objects, Righ-Mouse Click to deselect items"
	
	button	btn1	"VRay TraceSets"		pos:[180,5]		width:110	height:20	border:True 	toolTip:"Find Objects with V-Ray Trance Sets"
	button	btn2 	"VRay Properties" 		pos:[180,30]	width:110	height:20	border:True 	toolTip:"Find objects with non-default V-Ray Properties"			
	button	btn3 	"Object Properties" 	pos:[180,55]	width:110	height:20	border:True 	toolTip:"Find objects with non-default Object Properties \n Currently work only with Rendering Control parameters"			
		
	
	on SanityCheck open do
	(				
		--mlb1.items = settings_pameters_list						--discrepacies_parameters_list
	)
		
	on mlb1 rightClick do
	(
		mlb1.selection = 0
	)
				
	
	on mlb1 selectionEnd do
	(
		nodes = #()												--array to store nodes
		selIdx = (mlb1.selection as array)						--convert multibox
		for item in selIdx do									--convert obj-name string to node in order to select them later
			append nodes (getNodeByName mlb1.items[item])
				
		select nodes 											--select nodes
	)
	
	
	--GET VRAY TRACE SETS
	on btn1 pressed do
	(
		objects_with_trace_sets_list = #()							--list to store objects with vray trace sets
		
		for obj in geometry do										--loop through all the objects
		(

			get_trace_sets = vrayGetTraceSets obj					--get vray tracesets 
			
			if get_trace_sets != undefined do						--if tracesets exists 
			(
				append objects_with_trace_sets_list obj.name		--collect object
			)
			
		)
		
		mlb1.items = objects_with_trace_sets_list					--add objects with tracesets to multi-list-box items.
		mlb1.selection = 0											--set multi-list-box selection to none
		
	)
	
	--SELECT OBJECTS WITH VRAY PROPERTIES
	on btn2 pressed do
	(
		obj_with_vray_properties = #() --list to store objects with vray properties
		for obj in geometry do										--loop  throught all geometry items
		(
			x = getUserPropBuffer obj								--get Object Properties > User Defined properties (V-Ray properties are storred here)
			
			if x != "" then
			(
				if True==(
							(getUserProp obj "VRay_MoBlur_GeomSamples") != undefined or \
							(getUserProp obj "VRay_GI_Generate") != undefined or \
							(getUserProp obj "VRay_GI_Receive") != undefined or \
							(getUserProp obj "VRay_GI_Multipier") != undefined or \
							(getUserProp obj "VRay_GI_GenerateMultipier") != undefined or \
							(getUserProp obj "VRay_GI_SubdivsMultiplier") != undefined or \
							(getUserProp obj "VRay_Caustics_Generate") != undefined or \
							(getUserProp obj "VRay_Caustics_Receive") != undefined or \
							(getUserProp obj "VRay_Caustics_Multipier") != undefined or \
							(getUserProp obj "VRay_MoBlur_DefaultGeomSamples") != undefined or \
							(getUserProp obj "VRay_Matte_Enable") != undefined or \
							(getUserProp obj "VRay_Matte_Alpha") != undefined or \
							(getUserProp obj "VRay_Matte_Shadows") != undefined or \
							(getUserProp obj "VRay_Matte_ShadowAlpha") != undefined or \
							(getUserProp obj "VRay_Matte_ShadowColor") != undefined or \
							(getUserProp obj "VRay_Matte_ShadowBrightness") != undefined or \
							(getUserProp obj "VRay_Matte_ReflectionAmount") != undefined or \
							(getUserProp obj "VRay_Matte_RefractionAmount") != undefined or \
							(getUserProp obj "VRay_Matte_GIAmount") != undefined or \
							(getUserProp obj "VRay_Matte_GI_OtherMattes") != undefined or \
							(getUserProp obj "VRay_GI_SurfaceID") != undefined or \
							(getUserProp obj "VRay_SSS_SurfaceID") != undefined or \
							(getUserProp obj "VRay_GI_VisibleToGI") != undefined
					
				) then append obj_with_vray_properties obj		--if User Defined properties are not empty add this obj to list
				
			--else print(x)
			)
		)

		obj_with_modified_vray_properties = #()						--list to collect objecst with non-default vray properties
		
		for obj in obj_with_vray_properties do						--loop through previously collected objects with user-defined properties
		(															--check if there is a discrepancy between the default vray properties	
			if True !=(												
							(getUserProp obj "VRay_MoBlur_GeomSamples") == 2 and \
							(getUserProp obj "VRay_GI_Generate") == True and \
							(getUserProp obj "VRay_GI_Receive") == True and \
							(getUserProp obj "VRay_GI_Multipier") == 1.000000 and \
							(getUserProp obj "VRay_GI_GenerateMultipier") == 1.000000 and \
							(getUserProp obj "VRay_GI_SubdivsMultiplier") == 1.000000 and \
							(getUserProp obj "VRay_Caustics_Generate") == True and \
							(getUserProp obj "VRay_Caustics_Receive") == True and \
							(getUserProp obj "VRay_Caustics_Multipier") == 1.000000 and \
							(getUserProp obj "VRay_MoBlur_DefaultGeomSamples") == True and \
							(getUserProp obj "VRay_Matte_Enable") == False and \
							(getUserProp obj "VRay_Matte_Alpha") == 1.000000 and \
							(getUserProp obj "VRay_Matte_Shadows") == False and \
							(getUserProp obj "VRay_Matte_ShadowAlpha") == False and \
							(getUserProp obj "VRay_Matte_ShadowColor") == "[0,0,0]" and \
							(getUserProp obj "VRay_Matte_ShadowBrightness") == 1.000000 and \
							(getUserProp obj "VRay_Matte_ReflectionAmount") == 1.000000 and \
							(getUserProp obj "VRay_Matte_RefractionAmount") == 1.000000 and \
							(getUserProp obj "VRay_Matte_GIAmount") == 1.000000 and \
							(getUserProp obj "VRay_Matte_GI_OtherMattes") == True and \
							(getUserProp obj "VRay_GI_SurfaceID") == 0 and \
							(getUserProp obj "VRay_SSS_SurfaceID") == 0 and \
							(getUserProp obj "VRay_GI_VisibleToGI") == True
				
						)then append obj_with_modified_vray_properties obj.name		--collect objects with non-default vray properties
		)
		
		mlb1.items = obj_with_modified_vray_properties	--add objects found to multi-list-box items				
		mlb1.selection = 0								--remove multi-list-box selection	
		
	)
	
	--3ds Max Object Properties Rendering Control
	on btn3 pressed do
	(
		obj_non_default_object_properties = #()
		for obj in geometry do
		(
			if True != 
				( obj.renderByLayer == false and \
						obj.visibility 	== true and \
						obj.renderable 	== true and \
						obj.inheritVisibility == true and \
						obj.primaryVisibility == true and \
						obj.secondaryVisibility == true and \
						obj.receiveShadows == true and \
						obj.castShadows == true and \
						obj.applyAtmospherics == true and \
						obj.renderOccluded == false and \

						obj.gbufferChannel == 0
				)
			
				then append obj_non_default_object_properties obj.name
		)
		
		mlb1.items = obj_non_default_object_properties	--add objects found to multi-list-box items				
		mlb1.selection = 0								--remove multi-list-box selection	
	)
	

	
)


----------------------This part is for testing when the code is ready, should be commented-----------------------------

-- vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 400
-- addRollout SanityCheck vray3dSupportDummyFloater 

-------------------------------------------------------------------------------------------------------------------------------




