
function get_render_settings_discrepancies = 
(
	print(">>>get_render_settings_start")
	global current_settings_instance = renderers.current
	
	--check if V-Ray or V-Ray GPU is the current renderer
	if (matchPattern ((renderers.current) as string) pattern:"V_Ray_GPU_*")==true then
	(
		global default_settings_instance = VRayRT()
	)
	else
	(
		if (matchPattern ((renderers.current) as string) pattern:"V_Ray_*")==true then
		(
			global default_settings_instance = VRay()
		)
	)

	--https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_879ECFAD_7928_44B3_BCD7_276D53C89B52_htm
	settings_parameter_names = getPropNames(current_settings_instance) 	--get current render settings parameter names
	settings_range = settings_parameter_names.count 								--get the number of the parameters
	
	global settings_pameters_list = #()													-- render settings parameters
	
	global settings_current_values_list = #()											--current render settings current values 
	global settings_current_values_string_list = #()									--current render settings current values in sting format
	
	global setings_default_values_list = #()												--default render settings values
	global setings_default_values_string_list = #()										--default render settings values in string format

	
	for i in 1 to settings_range do 															--loop through all parameters
	(
		parameter_name = settings_parameter_names[i]										--get parameter name
		if (parameter_name as String) == "output_splitbitmap" do continue			--disable "output_splitbitmap" parameter check
			
-- 		print(parameter_name)
		current_value = getProperty current_settings_instance parameter_name		--get current parameter value
		default_value = getProperty default_settings_instance parameter_name		--get default parameter value
-- 		
		if (current_value as String) != (default_value as String) then					--compare curent vs default value
		(
			append settings_pameters_list parameter_name										--store paramter name
			
			append settings_current_values_list current_value									--store current value
			append settings_current_values_string_list (current_value as String)		--store current value as string
			
			append setings_default_values_list default_value									--store default value
			append setings_default_values_string_list (default_value as String) 			--store default value as string
			
			--format "%,%,% \n" parameter_name current_value default_value						--print parameter, current value, default value
			--format "%,%,% \n" ((ClassOf parameter_name) as string) ((ClassOf current_value) as string) ((ClassOf default_value) as string) 			
		)
	)
	
	print("<<<get_render_settings_end")
	--return #(settings_pameters_list, settings_current_values_list, settings_current_values_string_list, setings_default_values_list, setings_default_values_string_list) --return list of [parameters] and [values]
)


-------------------------------------UI CODE-------------------------------------
--https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_3835162F_3EC5_485B_8453_E7960AF34837_htm


Rollout CompareRenderSettings "Compare Render Settings" 
(		
	Label	lbl1	"Parameter name"		pos:[50,1]			enabled:true
	Label	lbl2	"User"					pos:[190,1]		enabled:true
	Label	lbl3	"Default"					pos:[240,1]		enabled:true
	
	listBox 	lbx1 	pos:[1,20]		width:175 	height:20 	align:#left		toolTip:"single-click=select corresponding items"
	listBox 	lbx2 	pos:[180,20]	width:50 	height:20 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=apply value"
	listBox 	lbx3 	pos:[235,20]	width:50 	height:20 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=apply value"
	
	Label	lbl4	"Current Value"					pos:[1,292]		enabled:true
	
	listBox 	lbx4 	pos:[70,290]	width:215 	height:1 	align:#left		toolTip:"Display Current Value"

	button	btn1		"User settings"			pos:[1,315]		width:90	toolTip:"Apply Customer Settings" 	border:True 
	button	btn2 		"Default settings" 	pos:[100,315]		width:90	toolTip:"Apply Default Settings"		border:True 
	button	btn3 		"Compare settings" 	pos:[195,315]		width:90	toolTip:"Compare User vs Default Settings"		border:True 
		
	
	on CompareRenderSettings open do
		(	
			get_render_settings_discrepancies()					--run get discrepancies function
			
			lbx1.items = settings_pameters_list						--discrepacies_parameters_list
			lbx2.items = settings_current_values_string_list	--discrepacies_current_string_list
			lbx3.items = setings_default_values_string_list		--discrepacies_default_string_list
		)
			
	
	 --SELECTION LOGIC, when item from one listbox is selected, transfer selection to the other two listboxes
	on lbx1 selected nameIndex  do
	(
		lbx2.selection=nameIndex
		lbx3.selection=nameIndex
		
		lbx4.items = #((lbx1.selected as String) + " = " + ((getProperty renderers.current lbx1.selected) as String)) --display current parameter value in lbx4 
	)
	
	on lbx2 selected nameIndex  do
	(
		lbx1.selection=nameIndex
		lbx3.selection=nameIndex
		lbx4.items = #((lbx1.selected as String) + " = " + ((getProperty renderers.current lbx1.selected) as String)) --display current parameter value in lbx4 
	)
	
	on lbx3 selected nameIndex  do
	(
		lbx1.selection=nameIndex
		lbx2.selection=nameIndex
		lbx4.items = #((lbx1.selected as String) + " = " + ((getProperty renderers.current lbx1.selected) as String)) --display current parameter value in lbx4 
	)
	
	
	--DOUBLE-CLICK LOGIC
-- 	on lbx1 doubleClicked nameIndex  do
-- 	(
-- 		--switch selection of all boxes to double-clicked element index
-- 		lbx1.selection=nameIndex
-- 		lbx2.selection=nameIndex
-- 		lbx3.selection=nameIndex
-- 		
-- 		parameter_name=lbx1.selected								--get parameter name text from lbx1
-- 		current_value = getProperty renderers.current lbx1.selected		--get current value of the parameter
-- 		format "%=%\n" parameter_name current_value 
-- 		
-- 		lbx4.items = #((lbx1.selected as String) + " = " + ((getProperty renderers.current lbx1.selected) as String)) --display current parameter value in lbx4 
-- 	)
	
	
	on lbx2 doubleClicked nameIndex  do
	(
		--print(nameIndex)
		--switch selection of all boxes to double-clicked element index
		lbx1.selection=nameIndex
		lbx2.selection=nameIndex
		lbx3.selection=nameIndex
		lbx4.items = #((lbx1.selected as String) + " = " + ((getProperty renderers.current lbx1.selected) as String)) --display current parameter value in lbx4 

		
		
		parameter_name = lbx1.selected				--get parameter-name 
		--current_value = lbx2.selected as Integer	--get value as Integer from lbx2
		--lbx3.selected = lbx2.selected				--copy item-text from lbx2 to lbx3
		
		format "%,%\n" parameter_name current_value
		setProperty renderers.current  parameter_name settings_current_values_list[nameIndex]
		
		lbx4.items = #((lbx1.selected as String) + " = " + ((getProperty renderers.current lbx1.selected) as String)) --display current parameter value in lbx4 
		
		--print((ClassOf render_settings_discrepancies_lists[nameIndex]) as String)
		--print((ClassOf discrepacies_current_values_list[nameIndex]) as String)
		
	)
	
	
	on lbx3 doubleClicked nameIndex  do
	(
		
		--switch selection of all boxes to double-clicked element index
		lbx1.selection=nameIndex
		lbx2.selection=nameIndex
		lbx3.selection=nameIndex
				
		parameter_name = lbx1.selected				--get parameter-name text from lbx1
		--default_value = lbx3.selected as Integer		--get value as Integer from lbx3
		--lbx2.selected = lbx3.selected						--copy item-text from lbx3 to lbx2
		
		--format "%,%\n" parameter_name default_value
		setProperty renderers.current  parameter_name setings_default_values_list[nameIndex]
		
		lbx4.items = #((lbx1.selected as String) + " = " + ((getProperty renderers.current lbx1.selected) as String)) --display current parameter value in lbx4 
	)
	
	on btn1 pressed do
	(
		renderers.current = current_settings_instance
	)
	
	on btn2 pressed do
	(
		renderers.current = default_settings_instance
	)
	
	--RERUN SCRIPT TO RELOAD CHANGES
	on btn3 pressed do
	(
		get_render_settings_discrepancies()					--run get discrepancies function
			
		lbx1.items = settings_pameters_list						--discrepacies_parameters_list
		lbx2.items = settings_current_values_string_list	--discrepacies_current_string_list
		lbx3.items = setings_default_values_string_list		--discrepacies_default_string_list
	)
	
)


----------------------This part is for testing when the code is ready, should be commented-----------------------------

-- vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 400
-- addRollout CompareRenderSettings vray3dSupportDummyFloater 

-------------------------------------------------------------------------------------------------------------------------------