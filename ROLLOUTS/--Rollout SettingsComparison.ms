
Rollout VRSD "DummyRollout"
	(
		listBox 		lbx1 					pos:[0,0] 		width:282  align:#left
	
		on VRSD open do
		(
			vrdefault = createInstance (classof renderers.current)
			vrcurrent = renderers.current
			
			for pname in (getpropnames renderers.current) do (
				pdefault = getproperty vrdefault pname
				pcurrent = getproperty vrcurrent pname
				if (pdefault != pcurrent) do (
					print ("difference found in " + (pname as String) + " " + (pdefault as String) + ":" + (pcurrent as String))
				)
			)
		)
	)
	
----------------------This part is for testing when the code is ready, should be commented-----------------------------
--/*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout VRSD vray3dSupportDummyFloater 

-----------------------------------------------------------------------------------------------------------------------