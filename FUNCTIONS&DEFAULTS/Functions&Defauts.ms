----------Start Instaled/Saved Functions--------------------------------------------------------------------------------------------------
fn checkinstaledtype = (if ((mod (((vrayversion())[1][4]) as Integer) 2) == 0.0) then ("Stable") else ("Nightly"))

fn checkinstaledrelese = (if ((((vrayversion())[2]) as Integer) < 100) then print "Release" else print "Nightly")

fn checksavedtype = (if (vraysavedversion())[1] != "" do 
	(if ((mod (((vraysavedversion())[1][4]) as Integer) 2) == 0.0) then ("Stable") else ("Nightly")))

fn checksavedrelese = (if (vraysavedversion())[1] != "" do
	(if ((((vraysavedversion())[2]) as Integer) < 100) then print "Release" else print "Nightly"))

fn checksavedmax = (if (vraysavedversion())[1] != "" do
	(((vraysavedversion())[4]/1000 - 2) - 10)as Integer)

----------Stop Instaled/Saved Functions--------------------------------------------------------------------------------------------------
----------Start Renderer Verification--------------------------------------------------------------------------------------
fn RendererVerification=(
		if	
		(matchPattern (renderers.current as String) pattern:"V_Ray_Adv*") != true and
		(matchPattern (renderers.current as String) pattern:"V_Ray_RT*") != true and
		(matchPattern (renderers.current as String) pattern:"V_Ray_Edu*") != true and
		(matchPattern (renderers.current as String) pattern:"V_Ray_NFR*") != true do
		(
			renderers.current = VRay()
			renderers.activeshade = VRayRT()
		)
		
		try
			(
				if (vraysavedversion())[1] != "" then
				(
-- 					if (substring (vrayversion())[1] 1 4 as float) >= 3.5 then
-- 					(
						(vraysavedversion())[1]+" "+(checksavedtype())+" "+(checksavedrelese())+"     "+"3dsMax201"+(checksavedmax()as String)
-- 					)
-- 					else
-- 					(
-- 						("V-Ray saved version is seen above 3.50.03")
-- 					)
				)
				else if (vraysavedversion())[1] == "" then
				(
					("For this info, you need to open a file first")
				)
						
			)
		catch
		(
			("V-Ray saved version is seen above 3.50.03")
		)

		/*
		if (vraysavedversion())[1] != "" then
				(
					if (substring (vrayversion())[1] 1 4 as float) >= 3.5 then
					(
						(vraysavedversion())[1]+" "+(checksavedtype())+" "+(checksavedrelese())+"     "+"3dsMax201"+(checksavedmax()as String)
	--  					(vraysavedversion())[1]+" | "+((vraysavedversion())[2] as String)+" | "+((vraysavedversion())[3] as String)
					)
					else
					(
						("V-Ray saved version is seen above 3.50.03")
					)
				)
				else if (vraysavedversion())[1] == "" then
				(
					("For this info, you need to open a file first")
				)*/
		
	)
	
	
----------Stop Renderer Verification---------------------------------------------------------------------------------------
----------Start Rollout Verification----------------------------------------------------------------------------------------
fn RolloutVerification=(
	if (vray3dSupportFloater != undefined) do
		(
		--cui.UnRegisterDialogBar vray3dSupportFloater
		destroydialog vray3dSupportFloater
		)
	)
----------Stop Rollout Verification----------------------------------------------------------------------------------------

-----------------------------------------------Start Default Light Settings--------------------------------------------------------
defaultLightSettings = #(true,0,false,200.0,0,6500.0,(color 255 255 255),30.0,0,10.0,10.0,10.0,true,false,false,true,1.0,true,1.0,true,true,false,false,false,false,8,0.02,0.001,1,false,undefined,true,512,1.0,0,150.0,100.0,true,false,0,100.0,2,undefined,true,false,0.0,2,true,true,true,false,(color 255 229.5 0),false,undefined,3)
-----------------------------------------------Stop Default Light Settings---------------------------------------------------------



-----------------------------------------------Start Global Variables For Assets Controls--------------------------------------------------------
global newPathValue = ""
global newpath = ""
global setPath = false
global stripPath = false
global maxSceneFile = ""
global MaxFileTargetPath = ""
global MaxFileDestinationPath = ""
global targetPath = ""
global destinationPath = ""
global barValue = 0
global saveSelectedPath = ""
global saveSelectedDestinationPath = ""

colStart = red as point3; print colA
colEnd = green as point3; print colB
-----------------------------------------------Stop Global Variables For Assets Controls--------------------------------------------------------

-----------------------------------------------Start Debug Tools--------------------------------------------------------

fn DebugRemoveHalpObjects = 
(
	a=#()
	numerator = 0
	for o in objects do 
	(
		numerator+=1
		if mod numerator 2==0 do
		(
			append a o
		)
	)
	selectmore a
	delete a
)

-----------------------------------------------Stop Debug Tools--------------------------------------------------------
