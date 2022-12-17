
Rollout ScriptedRendererProperties "Scripted Renderer Properties" 
	(
		button		btn1	"EXECUTE"	pos:[227,0]	height:17
		editText 	edit1					pos:[0,0]		width:222 --edit1:(lbx1.selected)
		listBox 		lbx1 					pos:[4,40] 		width:282 height:30 align:#left
		Label		lbl1	"Difference Found In"		pos:[4,22]	--enabled:false
		
		
			
		
		on ScriptedRendererProperties open do
			(
			vrdefault=createInstance (classof renderers.current)
			vrcurrent=renderers.current

			list=#(
				"filter_kernel",
				"imageSampler_renderMask_layers",
				"options_overrideMtl_excl_layers",
				"excludeListOverrideMtl",
				"includeListRenderSubset"
			)

			for pname in (getpropnames renderers.current) do (
				same=true
				pdefault=getproperty vrdefault pname
				pcurrent=getproperty vrcurrent pname

				if ((findItem list pname)!=0) then (
					if (pdefault!=pcurrent) do (same=false)
				)
				else (
					if ((classof pdefault)!=(classof pcurrent)) do (same=false)
					if (same) do (
						if ((classof pcurrent==ArrayParameter) OR classof pcurrent==Array) do (
							for element in pcurrent do (
								if ((findItem pdefault element)==0) do (same=false)
							)
						)
					)
				)

				if (same!=true) do (
					print ("difference found in "+(pname as String)+" "+(pdefault as String)+":"+(pcurrent as String))
				)
			)
				--vr=renderers.current 
				--showproperties vr 
				--vr_properties
				--lbx1.items = (getPropNames  renderers.current)
				lbx1.items = (pname)
			)
			
		on lbx1 selected nameIndex do
			(
				lbx1.items = (getPropNames  renderers.current)
				edit1.text=execute ("renderers.current." + lbx1.selected) as string
				print (classof (execute ("renderers.current." + lbx1.selected) ) as string)
			)
			
		on lbx1 doubleClicked itm do
			(
				setclipboardText ("renderers.current." + lbx1.selected+"="+edit1.text)
			)
			
		on btn1 pressed do
			(
				execute ("renderers.current." + lbx1.selected+"="+edit1.text)
			)
			
			
	)
	
----------------------This part is for testing when the code is ready, should be commented-----------------------------
-- /*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout ScriptedRendererProperties vray3dSupportDummyFloater 

-------------------------------------------------------------------------------------------------------------------------------