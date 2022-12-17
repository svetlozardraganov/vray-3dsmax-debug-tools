--https://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_00AB0CFA_3190_4A28_A185_4774B684F6D8_htm

(
	local obj_non_default_object_properties = #()
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
		
			then append obj_non_default_object_properties obj
		
	)
) 

-- for obj in geometry do
-- (
-- 	print(obj.visibility)
-- )


/* --Rendering Control Properties
$.renderByLayer --default false

$.visibility 			--default true (only tru or false, there is no option to get the visibility value)
$.renderable			--default true
$.inheritVisibility		--default true
$.primaryVisibility		--default true
$.secondaryVisibility	--default true
$.receiveShadows		--default true
$.castShadows			--default true
$.applyAtmospherics		--default true
$.renderOccluded 		--default false

$.gbufferChannel		--default 0 */