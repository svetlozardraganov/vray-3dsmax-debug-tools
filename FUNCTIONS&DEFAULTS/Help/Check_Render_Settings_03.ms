
function get_render_settings_discrepancies = 
(
	print(">>>get_render_settings_start")
	global current_settings_instance = renderers.current
	global default_settings_instance = VRay()

	--https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_879ECFAD_7928_44B3_BCD7_276D53C89B52_htm
	settings_parameter_names = getPropNames(current_settings_instance) 	--get current render settings parameter names
	settings_range = settings_parameter_names.count 								--get the number of the parameters
	
	output_settings_pameters_list = #()
	output_current_settings_values_list = #()
	output_current_settings_values_string_list = #()
	
	output_default_setings_values_list = #()
	output_default_setings_values_string_list = #()

	for i in 1 to settings_range do 			--loop through all parameters
	(
		parameter_name = settings_parameter_names[i]												--get parameter name
		current_value = getProperty current_settings_instance parameter_name				--get current parameter value
		default_value = getProperty default_settings_instance parameter_name				--get default parameter value
		
		if (current_value as String) != (default_value as String) then							--compare curent vs default value
		(
			append output_settings_pameters_list parameter_name									--store paramter name
			
			append output_current_settings_values_list current_value								--store current value
			append output_current_settings_values_string_list (current_value as String)			--store current value as string
			
			append output_default_setings_values_list default_value									--store default value
			append output_default_setings_values_string_list (default_value as String) 				--store default value as string
			
			--format "%,%,% \n" parameter_name current_value default_value						--print parameter, current value, default value
			--format "%,%,% \n" ((ClassOf parameter_name) as string) ((ClassOf current_value) as string) ((ClassOf default_value) as string) 			
		)
	)
	
	print("<<<get_render_settings_end")
	return #(output_settings_pameters_list, output_current_settings_values_list, output_current_settings_values_string_list, output_default_setings_values_list, output_default_setings_values_string_list) --return list of [parameters] and [values]
)

--[1-params][2-current values][3-current values string][4-default values][5-default values string]
render_settings_discrepancies_lists = get_render_settings_discrepancies()

discrepacies_parameters_list = render_settings_discrepancies_lists[1]

discrepacies_current_values_list = render_settings_discrepancies_lists[2]
discrepacies_current_string_list = render_settings_discrepancies_lists[3]

discrepacies_default_values_list = render_settings_discrepancies_lists[4]
discrepacies_default_string_list = render_settings_discrepancies_lists[5]



-- check if discrepancies exists
if discrepacies_parameters_list.count ==0 and discrepacies_current_values_list.count ==0 and discrepacies_default_values_list.count == 0 then
(	
	global discrepacies_found = False
	print("discrepacies_NOT_found")
)
else(
	global discrepacies_found = True
	print("discrepacies_found")
)	



-------------------------------------UI CODE-------------------------------------
--https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_3835162F_3EC5_485B_8453_E7960AF34837_htm


Rollout CompareRenderSettings "Current vs Default Render Settings" 
(		
	Label	lbl1	"Parameter name"	pos:[1,1]	enabled:true
	Label	lbl2	"Customer value"	pos:[205,1]	enabled:true
	Label	lbl3	"Default Value"		pos:[305,1]	enabled:true
	
	listBox 	lbx1 	pos:[1,20]		width:195 	height:10 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=print current value"
	listBox 	lbx2 	pos:[200,20]	width:90 	height:10 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=apply value"
	listBox 	lbx3 	pos:[295,20]	width:90 	height:10 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=apply value"
	
	listBox 	lbx4 	pos:[1,160]	width:385 	height:1 	align:#left		toolTip:"Display Current Value"

	button	btn1		"Apply Customer Settings"		pos:[1,185]		width:195	toolTip:"Apply Customer Settings" 	border:True 
	button	btn2 		"Apply Default Settings" 		pos:[200,185]		width:195	toolTip:"Apply Default Settings"		border:True 
	
	on CompareRenderSettings open do
		(
			--vr=renderers.current 
			--showproperties vr 
			--vr_properties
			
			if discrepacies_found == True then		--only add items if discrepancies are found
				lbx1.items = discrepacies_parameters_list
				lbx2.items = discrepacies_current_string_list
				lbx3.items = discrepacies_default_string_list
		)
	
	 --selection logic, when item from one listbox is selected, transfer selection to the other two listboxes
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
		setProperty renderers.current  parameter_name discrepacies_current_values_list[nameIndex]
		
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
		setProperty renderers.current  parameter_name discrepacies_default_values_list[nameIndex]
		
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
	
)
	
----------------------This part is for testing when the code is ready, should be commented-----------------------------

vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 400 300
addRollout CompareRenderSettings vray3dSupportDummyFloater 

-------------------------------------------------------------------------------------------------------------------------------




