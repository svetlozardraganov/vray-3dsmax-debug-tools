---------------------------------------------Import Functions & Defauts---------------------------------------------------------

-- filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\FUNCTIONS&DEFAULTS\Functions&Defauts.ms")


-------------------------------------------Functions------------------------------------------------------------

fn getMaterialClasses = 
(
	mtl_classes_array = #() 		--collect material classes in this array
	mtls_by_class_array = #()		--collect material names by class-name in this array
-- 	print(mtl_classes_array)
-- 	print(mtls_by_class_array)
	

	for mat in scenematerials do		--loop over scene-materials (applied to objects)
	(
		mtlClass = classof mat			--get material class
		print ("material name: " + mat.name)
		print("material class: " + mtlClass as String)
		
		mtl_class_index_in_array = findItem mtl_classes_array (mtlClass as String) -- returns index if found or zero if not
		
		if mtl_class_index_in_array==0 then --if material class is not yet in mtl_classes_array 
		(
			append mtl_classes_array (mtlClass as String) --add material class to mtl_classes_array
			append mtls_by_class_array #(mat.name) --add new array in mtls_by_class_array and add the material name to it
		)
		else --if material class is already in the mtl_classes_array
		(
			append mtls_by_class_array[mtl_class_index_in_array] (mat.name)
		)
	)
	
	--return undefined if there are no scene materials, and return list of classes/materials otherwise
	if mtl_classes_array[1] == undefined and mtls_by_class_array[1]==undefined then
	(
		return undefined
	)
	else
	(
		return #(mtl_classes_array, mtls_by_class_array)
	)

)


fn getUnsupportedMaterials = 
(
	mtl_classes_array = #() 		--collect material classes in this array
	mtls_by_class_array = #()		--collect material names by class-name in this array
-- 	print(mtl_classes_array)
-- 	print(mtls_by_class_array)
	

	for mat in scenematerials do		--loop over scene-materials (applied to objects)
	(
		mtlClass = classof mat			--get material class
		if not areMtlAndRendererCompatible mtlClass renderer:renderers.current do
		(
-- 	 		print ("material name: " + mat.name)
-- 	 		print("material class: " + mtlClass as String)
			
			mtl_class_index_in_array = findItem mtl_classes_array (mtlClass as String) -- returns index if found or zero if not
			
			if mtl_class_index_in_array==0 then --if material class is not yet in mtl_classes_array 
			(
				append mtl_classes_array (mtlClass as String) --add material class to mtl_classes_array
				append mtls_by_class_array #(mat.name) --add new array in mtls_by_class_array and add the material name to it
			)
			else --if material class is already in the mtl_classes_array
			(
				append mtls_by_class_array[mtl_class_index_in_array] (mat.name)
			)
		)
	)
	
	--return undefined if there are no scene materials, and return list of classes/materials otherwise
	if mtl_classes_array[1] == undefined and mtls_by_class_array[1]==undefined then
	(
		return undefined
	)
	else
	(
		return #(mtl_classes_array, mtls_by_class_array)
	)

)


-- fn matSortFN mat1 mat2 =
-- (
-- 	case of
-- 	(
-- 		(mat1.name < mat2.name):-1
-- 		(mat1.name > mat2.name):1
-- 		default:0
-- 	)
-- )

-- fn getSceneMats =
-- (
-- 	local sceneMats = #()
-- 	for c in material.classes where c.creatable do
-- 	(
-- 		mats = getClassInstances c
-- 		join sceneMats mats
-- 	)
-- 	qsort sceneMats matSortFN
-- 	print(sceneMats)
-- 	return sceneMats
-- )

-- fn analyseScene =
-- (
-- 	local objs = #()
-- 	for om in getSceneMats() where not areMtlAndRendererCompatible om renderer:renderers.current do
-- 	(
-- 		local nodes = refs.dependentNodes om
-- 		format "% - % %\n" (classOf om) om.name nodes
-- 		for n in nodes do appendIfUnique objs n
-- 	)
-- 	select objs
-- )


----------Rollout Variables ---------------------------------------------------------------------------------------------

mtl_classes_output = #()
rollout_width = 295
rollout_height = 400
btn_height = 20
btn_width = 140
offset = 5
second_row_y = 185


----------------------------------------Rollout Class---------------------------------------------------------------

Rollout MtlDebugger "Material Tools" width:rollout_width height:rollout_height autoLayoutOnResize:true 
(
	button 	btn_get_mtl_classes					"Get Scene Materials" 			pos:[0,0]  													width:(rollout_width/2-offset) 		height:btn_height		toolTip:"Get scene-material(s) type(s) and name(s)"
	button 	btn_get_unsupport_mtls 				"Get Unsupported Materials" 	pos:[rollout_width/2,0] 									width:(rollout_width/2-offset)		height:btn_height		toolTip:"Get unsuported-material(s) type(s) and name(s)"

	listBox MtlClasses_listBox					"Material Types" 				pos:[0,btn_height+offset] 									width:(rollout_width/2-offset)								toolTip:"Click to select object(s) of this material-type"
	listBox MtlNames_listBox					"Material Names" 				pos:[rollout_width/2,btn_height+offset] 					width:(rollout_width/2-offset)								toolTip:"Click to select object(s) of this material-name"

	button 	btn_selectMtl_Slate					"Selected in Slate Editor" 		pos:[0, second_row_y]  										width:(rollout_width/2-offset)		height:btn_height		toolTip:"View material(s) of selected object(s) in Slate Editor"
	button 	btn_selectMtl_Compact				"Selected in Compact Editor" 	pos:[rollout_width/2,second_row_y] 							width:(rollout_width/2-offset)		height:btn_height		toolTip:"View material(s) of selected object(s) in Compact Editor. \n (24 materials max)"
	
	button 	btn_assignNewVRayMtltoSelection 	"VRayMtl to Selection" 			pos:[0,second_row_y + btn_height+offset] 					width:(rollout_width/2-offset)		height:btn_height		toolTip:"Assign VRayMtl if object(s) have no material. Diffuse = Wireframe"
	button 	btn_removeMtl 						"Remove Mtl from Selected" 		pos:[rollout_width/2,second_row_y+btn_height+offset] 		width:(rollout_width/2-offset)		height:btn_height		toolTip:"Remove material(s) from selected object(s)"
	
	button 	btn_grayWF 							"Gray Wireframe" 				pos:[rollout_width/2,second_row_y + 2*(btn_height+offset)]	width:(rollout_width/2-offset)		height:btn_height		toolTip:"Set grey-wireframe to selecterd object(s)"
-- 	button 	btn_grayWF 							"Gray Wireframe" 				pos:[158,150]												width:130													toolTip:"Set Gray Wirefrem To Selecterd Objects"
	

	
	on btn_selectMtl_Slate pressed do
	(
		if (selection.count > 0) then
		(
			sme.Open()
			--DELETE AND CREATE A NEW VIEW
			view_index = sme.GetViewByName "3D_Support_View" 
			if view_index > 0 then
			(
				sme.DeleteView view_index false
			)
			
			NewView = sme.GetView(sme.CreateView "3D_Support_View")
			
			--POPULATE THE VIEW
			for obj in selection do
			(
				NewView.CreateNode obj.material[0,0]
			)
			--ARRANGE THE VIEW
			actionMan.executeAction 369891408 "40060"
		)
		else
		(
			messagebox "You must have at least one object selected!"
		)
	)	

	
	on btn_selectMtl_Compact pressed do
	(
		if (selection.count > 0) then
		(
			MatBank=#()
			indexMat=1
			
			for i in 1 to selection.count where selection[i].material!=undefined do
				if (i<25) then
					(
						append MatBank selection[i].material
					)
					else 
					(
						messagebox "Compact Editor can store up to 24 material, for more material use Slate Editor"
						exit
					)
				for i=1 to MatBank.count do 
				(
					setmeditmaterial indexMat MatBank[i]
					indexMat +=1
				)
				
				--SET ACTIVE SLOT
				if(selection.count<25) then activeMeditSlot = selection.count
				else activeMeditSlot = 1
				
				--OPEN COMPACT EDITOR
			MatEditor.mode=#basic
			MatEditor.Open()

		)
		else
		(
			messagebox "You must have at least one object selected!"
		)
	)
	
	on btn_assignNewVRayMtltoSelection pressed do
	(
		if (selection.count > 0) then
		(
			for i = 1 to selection.count do
			(
				newmat = VRayMtl()
				newmat.name = (selection[i].name as string + "_mat")
				newmat.diffuse = selection[i].wirecolor --Get diffuse color from wireframe
				selection[i].material = newmat
			)
		)
		else
		(
			messagebox "You must have at least one object selected!"
		)
	)
	
	on btn_get_unsupport_mtls pressed do
	(
		(
			clearSelection()
 			--clearListener()

 			--analyseScene()
			mtl_classes_output = getUnsupportedMaterials()				--get material classes of scene-materials
			if mtl_classes_output !=undefined then
			(
				MtlClasses_listBox.items = mtl_classes_output[1]		--add material classes found to MtlClasses_listBox
				MtlNames_listBox.items = mtl_classes_output[2][1]		--load materials from material-type on the first position of MtlClasses_listBox into MtlNames_listBox
				MtlClasses_listBox.selection=1
				MtlNames_listBox.selection=1
			)
			else
			(
				messageBox "No Materials found!"
				MtlClasses_listBox.items = #()
				MtlNames_listBox.items = #()
			)
		)
	)
	
	on btn_removeMtl pressed  do
	(
		if (selection.count > 0) then
		(
			undo on
			$.material = undefined
			-- $.wirecolor = [160,160,160]
		)
		else
		(
			messagebox "You must have at least one object selected!"
		)
	)
		
		
	on btn_grayWF pressed  do
		undo on
	(
		if selection.count > 0 then
		(
		for i = 1 to selection.count do
			(
				if (superClassOf(selection[i]) as string) == "light" then
					(
						selection[i].wirecolor = color 254 229 0
					)
				else if (superClassOf(selection[i]) as string) == "camera" or (ClassOf(selection[i]) as string) == "Targetobject" then
					(
						selection[i].wirecolor = color 86 120 203
					)	
				else
					(
						selection[i].wirecolor = color 127 127 127 
					)
			)
		)
		else
			(
				messagebox "You must have at least one object selected!"
			)
	)
		
	on btn_get_mtl_classes pressed do
	(
		mtl_classes_output = getMaterialClasses()				--get material classes of scene-materials
		if mtl_classes_output !=undefined then
		(
			MtlClasses_listBox.items = mtl_classes_output[1]		--add material classes found to MtlClasses_listBox
			MtlNames_listBox.items = mtl_classes_output[2][1]		--load materials from material-type on the first position of MtlClasses_listBox into MtlNames_listBox
			MtlClasses_listBox.selection=1
			MtlNames_listBox.selection=1
		)
		else
		(
			messageBox "No Materials found!"
			MtlClasses_listBox.items = #()
			MtlNames_listBox.items = #()
		)
	)
	
	on MtlClasses_listBox selected itm do
	(
		MtlNames_listBox.items = mtl_classes_output[2][itm]
		select (for o in Geometry where o.material != undefined and ((classof o.material) as String) == MtlClasses_listBox.selected collect o)		--select all objects with material class equal to MtlClasses_listBox selection
		MtlNames_listBox.selection=1
	)
	
	on MtlNames_listBox selected itm do
	(
		select (for o in Geometry where o.material != undefined and o.material.name == MtlNames_listBox.selected collect o)		--select objects by selected material in MtlNames_listBox
	)
		
)
	
	

	
----------------------This part is for testing when the code is ready, should be commented-----------------------------

-- vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support MtlTools Floater" (rollout_width+2*offset) rollout_height  --style:#(#style_titlebar, #style_border, #style_sysmenu, #style_minimizebox) lockHeight:false lockWidth:false
-- addRollout MtlDebugger vray3dSupportDummyFloater 

-----------------------------------------------------------------------------------------------------------------------

--fluent/dynamic rollout/window https://forums.autodesk.com/t5/3ds-max-programming/resizing-rollout-floater/m-p/8640008#M23038
