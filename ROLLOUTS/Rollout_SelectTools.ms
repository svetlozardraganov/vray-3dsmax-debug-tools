modifiers_objects_array = #()		--collect objects per modifier
objects_per_class_array = #()

Rollout SelectTools "Select Tools" 
	(
		button 			btn_selectVrayLights 			"Select V-Ray Lights" 			pos:[0,0] 		width:140
		button 			btn_selectnonVrayLightsList 	"Select Non V-Ray Lights" 		pos:[147,0] 	width:140
		button 			btn_selectVrayProxies 			"Select V-Ray Proxies" 			pos:[147,27] 	width:140
		
		Label 			SML 							"Select objects by Modifer"		pos:[9,31]
		dropdownlist	sm 								"" 						  		pos:[0,54] 		width:289	height:30  items:#() 
		
		button 			btn_getSceneModifiers 			"Get Scene Modifiers" 			pos:[0,80] 		width:290
		listbox			listbox_ListModifiers			""								pos:[0,105]		width:285
		
		button 			btn_getObjectClasses 			"Get Object Types" 				pos:[0,250] 	width:290
		listbox			listbox_ListObjectClasses		""								pos:[0,275]		width:285
		

		--button btn_selectVrayDisplacement 	"Select V-Ray DispMod" 	pos:[147,27] width:140

		on btn_selectVrayLights pressed do
		(
			vrayLightList=#()
			
			for selectLight in Lights do
			(
				if classof selectLight == VRayLight or classof selectLight == VRaySun do
				(
					Append vrayLightList selectLight
				)
				if classof selectLight == VRaySun do
				(
					Append vrayLightList selectLight.target
					)
			)

			if vrayLightList.count > 0 then 
				(
					select vrayLightList
				)
			else
				(
					messagebox "There is no vrayLight in the scene."
				)
		)
		
		on btn_selectnonVrayLightsList pressed do
		(
			nonVrayLightsList=#()
			
			for selectLight in Lights do
			(
				if classof selectLight != VRayLight and classof selectLight != VRaySun and classof selectLight != Targetobject do 
				(
					Append nonVrayLightsList selectLight
					if (selectLight.Target != undefined) do (Append nonVrayLightsList selectLight.Target)
				)
			)

			if nonVrayLightsList.count > 0 then 
				(
					select nonVrayLightsList
				)
			else
				(
					messagebox "There is no non VrayLights in the scene."
				)
		)
		
		on btn_selectVrayProxies pressed do
		(
			vrayProxyList=#()
			
			for obj in Objects do
			(
				if classof obj == VRayProxy do 
				(
					Append vrayProxyList obj
				)
			)
			
			if vrayProxyList.count > 0 then 
				(
					select vrayProxyList
				)
			else
				(
					messagebox "There is no vrayProxys in the scene."
				)
		)
		
		on SelectTools open do
		(
			ss = stringstream ""
			showClass "*:mod*" to:ss
			seek ss 0
			modArr = #() -- these are the creation names, ie execute (modArr[1]+"()") will create an instance of the modifier
			modNmArr = #() -- these are the names as they appear on a newly created modifier in the modifier stack
			while not (eof ss) do 
			(
				modNm = (readdelimitedstring ss " :")
				append modArr modNm
				try (append modNmArr (execute (modNm+"()")).name) catch (append modNmArr "") -- modifiy the catch to handle non-creatable modifiers, right now it is an empty string
				skipToNextLine ss
			)
			sm.items = modArr
		)
		
		on sm selected i do
		(
			modificator = sm.selected
			selectobjs = #()
			
			for obj in Objects do
				(
					for mods in obj.modifiers do
					(
						--print (mods as string)
						currentmod = (mods as string)
						modname = substring currentmod 1 ((findString currentmod ":")-1)
						--print ("modes - " + currentmod)
						--print ("current name - " + modname)
						--print ("search for " + modificator)
						if modname == modificator do
						(
							Append selectobjs  obj
						)
					)
				)
				
			if selectobjs.count > 0 then 
				(
					select selectobjs 
				)
			else
				(
					messagebox ("There is no objects with " + modificator + " in the scene.")
				)
			
		)
		
		
		on btn_getSceneModifiers pressed do
		(
			modifiers_array = #() 	--collect objects modifiers
			modifiers_objects_array = #()		--collect objects per modifier
			
			for obj in Objects do
				(
					for mods in obj.modifiers do
					(
-- 						print (mods as string)
						modifier_class_str = classOf mods as string
						
						modifier_index_in_array = findItem modifiers_array (modifier_class_str) 
						
						if modifier_index_in_array==0 then --if modifier class is not yet in modifiers_array 
						(
							append modifiers_array (modifier_class_str) --add material class to mtl_classes_array
							append modifiers_objects_array #(obj) --add new array in mtls_by_class_array and add the material name to it
						)
						else --if material class is already in the mtl_classes_array
						(
							append modifiers_objects_array[modifier_index_in_array] (obj)
						)
						
										
-- 						currentmod = (mods as string)
-- 						modname = substring currentmod 1 ((findString currentmod ":")-1)
						--print ("modes - " + currentmod)
						--print ("current name - " + modname)
						--print ("search for " + modificator)
-- 						if modname == modificator do
-- 						(
-- 							Append selectobjs  obj
-- 						)
					)
				)
				
			--return undefined if there are no scene materials, and return list of classes/materials otherwise
			if modifiers_array[1] == undefined then
			(
				print("undefined")
				messageBox "No modifiers found"
				listbox_ListModifiers.items = #()
			)
			else
			(
-- 				print(modifiers_array)
-- 				print(modifiers_objects_array)
				listbox_ListModifiers.items = modifiers_array
			)
		)

		on btn_getObjectClasses pressed do
		(
			object_classes_array = #() 	--collect objects modifiers
			objects_per_class_array = #()		--collect objects per modifier
			
			--for obj in Geometry do print(classOf obj)
			
			for obj in Objects do
				(
					
-- 					print (mods as string)
					object_class_str = classOf obj as string
					
					modifier_index_in_array = findItem object_classes_array (object_class_str) 
					
					if modifier_index_in_array==0 then --if modifier class is not yet in object_classes_array 
					(
						append object_classes_array (object_class_str) --add material class to mtl_classes_array
						append objects_per_class_array #(obj) --add new array in mtls_by_class_array and add the material name to it
					)
					else --if material class is already in the mtl_classes_array
					(
						append objects_per_class_array[modifier_index_in_array] (obj)
					)
				)
				
			--return undefined if there are no scene materials, and return list of classes/materials otherwise
			if object_classes_array[1] == undefined then
			(
				print("undefined")
				messageBox "No modifiers found"
				listbox_ListObjectClasses.items = #()
			)
			else
			(
-- 				print(object_classes_array)
-- 				print(objects_per_class_array)
				listbox_ListObjectClasses.items = object_classes_array
			)
		)
		
		on listbox_ListModifiers selected itm do
		(
			select modifiers_objects_array[itm]
		)
		
		on listbox_ListObjectClasses selected itm do
		(
			select objects_per_class_array[itm]
		)
		
		-- 		on btn_selectVrayDisplacement pressed do
-- 		(
-- 			vrayDisplacementList=#()
-- 			
-- 			for obj in Objects do
-- 			(
-- 				for mods in obj.modifiers do
-- 				(
-- 					if classof mods == VRayDisplacementMod do
-- 					(
-- 						Append vrayDisplacementList  obj
-- 					)
-- 				)
-- 			)
-- 			
-- 			if vrayDisplacementList.count > 0 then 
-- 				(
-- 					select vrayDisplacementList 
-- 				)
-- 			else
-- 				(
-- 					messagebox "There is no objects with VRayDisplacementMod in the scene."
-- 				)
-- 		)
	)
	
----------------------This part is for testing when the code is ready, should be commented-----------------------------
/*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout SelectTools vray3dSupportDummyFloater 

-------------------------------------------------------------------------------------------------------------------------------