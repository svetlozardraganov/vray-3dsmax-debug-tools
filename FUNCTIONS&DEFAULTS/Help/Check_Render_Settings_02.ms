renderers.current = VRay()
vray_renderer = renderers.current

--SWITCH DEFAULT VALUES IN ORDER TO GET SOME DISCREPANCIES

vray_renderer.imageSampler_type=1
vray_renderer.caustics_on=1
vray_renderer.lightcache_subdivs=1234
vray_renderer.twoLevel_threshold = 0.456


-------------------------------------GENERAL WORKFLOW-------------------------------------

current_settings = get_render_settings()	-- get a list current render settings [parameters][values]

renderers.current = Default_Scanline_Renderer()		-- reset v-ray render settings to default
renderers.current = VRay()

default_settings = get_render_settings()	-- get a list of defaut render settings [parameters][values]

restore_customer_render_settings current_settings[1] current_settings[2]


--print(current_settings.count)
--print(default_settings[2][1])
--default_settings[2][1] = 22
--print(default_settings[2][1])


discrepacies_output = compare_render_settings current_settings default_settings --compare render settings function, output [parameters][current][default]
discrepacies_parameters = discrepacies_output[1]
discrepacies_current = discrepacies_output[2]
discrepacies_default = discrepacies_output[3]

-- check if discrepancies exists
if discrepacies_parameters.count ==0 and discrepacies_current.count ==0 and discrepacies_default.count == 0 then
(	
	global discrepacies_found = False
	print("discrepacies_NOT_found")
)
else(
	global discrepacies_found = True
	print("discrepacies_found")
)	


--for item in settings_discrepacies_current_value do print(item)


-------------------------------------SET V-RAY AS RENDER ENGINE-------------------------------------
function  switchToVRay = 
(
	number_of_renderers = (rendererClass.classes).count 
	for i in 1 to number_of_renderers do
		
	(
		--print (rendererClass.classes)[i]
		
		if matchPattern ((rendererClass.classes)[i] as string) pattern:"V_Ray_*" == true and 
		   matchPattern ((rendererClass.classes)[i] as string) pattern:"V_Ray_GPU*" != true do
		(
			print (rendererClass.classes)[i]
			Renderers.Production = RendererClass.Classes[i]()
		)
		
	)

)


-------------------------------------GET V-RAY SETTINGS-------------------------------------
function get_render_settings = 
(
	print(">>>get_render_settings_start")
	vray_renderer = renderers.current
	--showproperties vray_renderer

	--https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_879ECFAD_7928_44B3_BCD7_276D53C89B52_htm
	vray_settings_parameters = getPropNames(vray_renderer) 			--get all v-ray settings parameters in a list
	vray_settings_values = #() 										--a list to collect v-ray settings parameter values

	number_of_vray_settings_parameters = print(vray_settings_parameters.count) --get the number of v-ray settings parameters
	--vray_settings[1]

	for i in 1 to number_of_vray_settings_parameters do 			--loop through all parameters
	(
		parameter_name = vray_settings_parameters[i]				--get parameter name
		parameter_value = getProperty vray_renderer parameter_name	--get parameter value
		
		--print(parameter_name)
		--print(parameter_value)
		
		append vray_settings_values parameter_value					--append parameter value array
		--apend to array
	)

	--print(vray_settings_parameters[1])
	--print(vray_settings_values[1])
	--format "param:%, value:%\n" vray_settings_parameters[2] vray_settings_values[2]
	
	print("<<<get_render_settings_end")
	return #(vray_settings_parameters, vray_settings_values) --return list of [parameters] and [values]
)


-------------------------------------COMPARE SETTINGS-------------------------------------
function compare_render_settings current_settings default_settings =
(
	print(">>>compare_render_settings_start")
	number_of_settings = current_settings[2].count 		-- get number of parameters
	discrepacies_parameter_local = #()				-- collect discrepancy parameters
	discrepacies_current_value_local = #()			-- collect discrepancy current values
	discrepacies_default_value_local = #()			-- collect discrepancy default values

	
	for i in 1 to number_of_settings do
	(
		parameter_name = current_settings[1][i] as string
		current_value = current_settings[2][i] as string
		default_value = default_settings[2][i] as string
		
		if current_value != default_value do --compare parameter values of current and default settings
		(
			--format "parameter:% current:%, default:%\n" parameter_name current_value default_value	-- print the parameter, current-value, default-value
			--check variable type
			--print((ClassOf current_value) as string)
			
			append discrepacies_parameter_local parameter_name		--append discrepancy parameter
			append discrepacies_current_value_local current_value	--append discrepancy parameter
			append discrepacies_default_value_local default_value	--append discrepancy parameter
		)
	)
	
	print("<<<compare_render_settings_end")
	return #(discrepacies_parameter_local, discrepacies_current_value_local, discrepacies_default_value_local)
)



/*
-------------------------------------UI CODE-------------------------------------
--https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_3835162F_3EC5_485B_8453_E7960AF34837_htm


function apply_value_depending_on_its_type parameter_name parameter_value = 
(	
	expected_value_type = classof (getProperty vray_renderer parameter_name)
			print(expected_value_type)
			
			if (expected_value_type as String) == "Integer" then
				setProperty vray_renderer parameter_name (parameter_value as Integer)
			
			else if (expected_value_type as String) == "Float" then
				 setProperty vray_renderer parameter_name (parameter_value as Float)
					
			else if (expected_value_type as String) == "BooleanClass" then
			
				if parameter_value == "true" then
					setProperty vray_renderer parameter_name true
				
				else
					setProperty vray_renderer parameter_name false
				
			else
				print("Can't apply this value! Supported values: Integer, Float,Boolean")
)

Rollout CompareRenderSettings "Current vs Default Render Settings" 
	(		
		Label	lbl1	"Parameter name"	pos:[1,1]	enabled:true
		Label	lbl2	"Customer value"	pos:[205,1]	enabled:true
		Label	lbl3	"Default Value"		pos:[305,1]	enabled:true
		
		listBox 	lbx1 	pos:[1,20]		width:200 	height:10 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=print current value"
		listBox 	lbx2 	pos:[205,20]	width:90 	height:10 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=apply value"
		listBox 	lbx3 	pos:[300,20]	width:90 	height:10 	align:#left		toolTip:"single-click=select corresponding items\ndouble-click=apply value"
		
		on CompareRenderSettings open do
			(
				--vr=renderers.current 
				--showproperties vr 
				--vr_properties
				
				if discrepacies_found == True then		--only add items if discrepancies are found
					lbx1.items = discrepacies_parameters
					lbx2.items = discrepacies_current
					lbx3.items = discrepacies_default
			)
		
		--selection logic, when item from one listbox is selected, transfer selection to the other two listboxes
		on lbx1 selected nameIndex  do
		(
			lbx2.selection=nameIndex
			lbx3.selection=nameIndex
		)
		
		on lbx2 selected nameIndex  do
		(
			lbx1.selection=nameIndex
			lbx3.selection=nameIndex
		)
		
		on lbx3 selected nameIndex  do
		(
			lbx1.selection=nameIndex
			lbx2.selection=nameIndex
		)
		
		--DOUBLE-CLICK LOGIC
		on lbx1 doubleClicked nameIndex  do
		(
			--switch selection of all boxes to double-clicked element index
			lbx1.selection=nameIndex
			lbx2.selection=nameIndex
			lbx3.selection=nameIndex
			
			parameter_name=lbx1.selected								--get parameter name text from lbx1
			current_value = getProperty vray_renderer lbx1.selected		--get current value of the parameter
			format "%=%\n" parameter_name current_value 
		)
		
		on lbx2 doubleClicked nameIndex  do
		(
			--switch selection of all boxes to double-clicked element index
			lbx1.selection=nameIndex
			lbx2.selection=nameIndex
			lbx3.selection=nameIndex
			
			
			parameter_name = lbx1.selected				--get parameter-name text from lbx1
			current_value = lbx2.selected as Integer	--get value as Integer from lbx2
			--lbx3.selected = lbx2.selected				--copy item-text from lbx2 to lbx3
			
			format "%,%\n" parameter_name current_value	
			
			apply_value_depending_on_its_type parameter_name lbx2.selected	--function to apply parameters in expected type
			
			--if matchPattern (lbx2.selected) pattern:"true*" == true do print("its true") --play with parameter type				
			--try setProperty vray_renderer parameter_name current_value	--set property value to double-clicked item value
			--catch print("Can't apply non-Integer values")
		)
		
		on lbx3 doubleClicked nameIndex  do
		(
			
			--switch selection of all boxes to double-clicked element index
			lbx1.selection=nameIndex
			lbx2.selection=nameIndex
			lbx3.selection=nameIndex
			
			
			parameter_name = lbx1.selected				--get parameter-name text from lbx1
			default_value = lbx3.selected as Integer	--get value as Integer from lbx3
			--lbx2.selected = lbx3.selected				--copy item-text from lbx3 to lbx2
			
			format "%,%\n" parameter_name default_value	
			
			apply_value_depending_on_its_type parameter_name lbx3.selected	--function to apply parameters in expected type
			
-- 			try setProperty vray_renderer parameter_name default_value	--set property value to double-clicked item value
-- 			catch print("Can't apply non-Integer values")
			
		)
		
	)
	
----------------------This part is for testing when the code is ready, should be commented-----------------------------

vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 400 300
addRollout CompareRenderSettings vray3dSupportDummyFloater 

-------------------------------------------------------------------------------------------------------------------------------





-------------------------------------BACKUP CODE-------------------------------------

/*
i=0
for p in getPropNames(vray_renderer) do
(	
	i+=1
	print(i)
	print(p)
	print(getProperty vray_renderer p)
--vray_renderer.imageSampler_type

--for p in getPropNames vray_renderer do
--	getProperty(p)
)
*/