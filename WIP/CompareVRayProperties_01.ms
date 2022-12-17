/* References:
http://www.scriptspot.com/forums/3ds-max/general-scripting/vray-properties-in-maxscript
https://forums.chaosgroup.com/forum/v-ray-for-3ds-max-forums/v-ray-for-3ds-max-general/10618-controlling-vray-object-properties-in-maxscript
https://forums.chaosgroup.com/forum/v-ray-for-3ds-max-forums/v-ray-for-3ds-max-general/17219-vray-object-properties-visible-to-maxscript
https://docs.chaosgroup.com/display/VMAX/MAXScript 

https://forums.autodesk.com/t5/3ds-max-programming/iterate-through-everything-in-scene/td-p/4110167
 */
(
	local x = getUserPropBuffer $Box001
	print(x)
	classOf x
)




(
	--SET OBJECTS AS MATTE
	fn SetAsMatte obj =
	(
		try(setUserProp obj "VRay_Matte_Enable" true)catch()
		try(setUserProp obj "VRay_Matte_Alpha" -1.0)catch()
		try(setUserProp obj "VRay_Matte_Shadows" true)catch()
		try(setUserProp obj "VRay_Secondary_Matte_Enable" true)catch()
	)
	for n = 1 to objects.count do SetAsMatte objects[n]
)


--ITTERATE THROUGH ALL OBJECTS IN SCENE
for obj in objects do
	x = getUserPropBuffer obj
	print(x)
	print("---")


--ITTERATE THROUGH ALL GEOMETRIES IN SCENE
for obj in geometry do
	x = getUserPropBuffer obj
	print(x)
	print("---")



--SELECT OBJECTS WITH VRAY PROPERTIES
(
	obj_with_vray_properties = #()
	for obj in geometry do
	(
		x = getUserPropBuffer obj
		
		if x != "" then append obj_with_vray_properties obj
		else print(x)
	)
	select obj_with_vray_properties

	/* obj_with_modified_vray_properties = #()
	
	for obj in select_objects_with_vray_properties do
	(
		if True !=
		(
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
			
		)then append obj_with_modified_vray_properties obj
	)
	select obj_with_modified_vray_properties */
)






--GET SPECIFIC V-RAY PROPERTY
getUserProp $ "VRay_GI_VisibleToGI"

(
	--1-create box
	Box pos:[0,0,0] isSelected:on width:10 length:10 height:10
)

--DISPLAY VRAY OBJECT PROPERTIES WINDOW
-- doVRayObjectProperties()	
-- macros.run "VRay" "VRayProperties"


--FIND OBJECTS WITH TRACE SETS /
--vrayGetTraceSets()

objects_with_trace_sets_list = #()
global i = 0
for obj in geometry do
(
	i=i+1
	print(i)
	select obj
	print(obj.name)
	get_trace_sets = vrayGetTraceSets() obj
	--print(x)
	if get_trace_sets != undefined do
	(
		append objects_with_trace_sets_list obj
	)		 
)
select objects_with_trace_sets_list

	



/* --VRAY USER PROPERTIES--
VRay_MoBlur_GeomSamples = 2
VRay_GI_Generate = True
VRay_GI_Receive = True
VRay_GI_Multipier = 1.000000
VRay_GI_GenerateMultipier = 1.000000
VRay_GI_SubdivsMultiplier = 1.000000
VRay_Caustics_Generate = True
VRay_Caustics_Receive = True
VRay_Caustics_Multipier = 1.000000
VRay_MoBlur_DefaultGeomSamples = True
VRay_Matte_Enable = False
VRay_Matte_Alpha = 1.000000
VRay_Matte_Shadows = False
VRay_Matte_ShadowAlpha = False
VRay_Matte_ShadowColor = [0,0,0]
VRay_Matte_ShadowBrightness = 1.000000
VRay_Matte_ReflectionAmount = 1.000000
VRay_Matte_RefractionAmount = 1.000000
VRay_Matte_GIAmount = 1.000000
VRay_Matte_GI_OtherMattes = True
VRay_GI_SurfaceID = 0
VRay_SSS_SurfaceID = 0
VRay_GI_VisibleToGI = True */


/* --GET VRAY PROPERTIES OF SELECTED OBJECT
getUserProp $ "VRay_MoBlur_GeomSamples"
getUserProp $ "VRay_GI_Generate"
getUserProp $ "VRay_GI_Receive"
getUserProp $ "VRay_GI_Multipier"
getUserProp $ "VRay_GI_GenerateMultipier"
getUserProp $ "VRay_GI_SubdivsMultiplier"
getUserProp $ "VRay_Caustics_Generate"
getUserProp $ "VRay_Caustics_Receive"
getUserProp $ "VRay_Caustics_Multipier"
getUserProp $ "VRay_MoBlur_DefaultGeomSamples"
getUserProp $ "VRay_Matte_Enable"
getUserProp $ "VRay_Matte_Alpha"
getUserProp $ "VRay_Matte_Shadows"
getUserProp $ "VRay_Matte_ShadowAlpha"
getUserProp $ "VRay_Matte_ShadowColor"
getUserProp $ "VRay_Matte_ShadowBrightness"
getUserProp $ "VRay_Matte_ReflectionAmount"
getUserProp $ "VRay_Matte_RefractionAmount"
getUserProp $ "VRay_Matte_GIAmount"
getUserProp $ "VRay_Matte_GI_OtherMattes"
getUserProp $ "VRay_GI_SurfaceID"
getUserProp $ "VRay_SSS_SurfaceID"
getUserProp $ "VRay_GI_VisibleToGI" */

