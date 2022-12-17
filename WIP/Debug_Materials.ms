mtl_classes_array = #() 		--collect material classes in this array
mtls_by_class_array = #()		--collect material names by class-name in this array

fn getMaterialClasses = 
(

	for mat in scenematerials do		--loop over scene-materials (applied to objects)
	(
		mtlClass = classof mat			--get material class
	--  print ("material name: " + mat.name)
	-- 	print("material class: " + mtlClass as String)
		
		mtl_class_index_in_array = findItem mtl_classes_array (mtlClass as String) -- returns index if found or zero if not
		
		if mtl_class_index_in_array==0 then --if material class is not yet in mtl_classes_array 
		(
			append mtl_classes_array (mtlClass as String) --add material class to mtl_classes_array
			append mtls_by_class_array #(mat.name) --add new array in mtls_by_class_array and add the material name to it
		)
		else --if material class is already in the mtl_classes_array
		(
			append mtls_by_class_array[mtl_class_index_in_array] mat.name
		)
	)
)

-- print(mtl_classes_array)
-- print(mtls_by_class_array)