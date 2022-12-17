----------Start Functions & Defauts--------------------------------------------------------------------------------------------

filein("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\FUNCTIONS&DEFAULTS\Functions&Defauts.ms")

----------Stop Functions & Defauts---------------------------------------------------------------------------------------------



Rollout AssetsControls "Assets Controls"
(
	group "Asset Collector"
	(
		edittext 	PathField 		"" 					fieldWidth:210 		align:#left across:2 	offset:[-7,0]
		button 		BrowseButton 	"Browse" 		width:50 height:19	align:#right				offset:[4,-1]
		
		checkbox 	UpdateCheckBox 			"update asset path."		checked:false align:#left across:2 	offset:[-2,0] 
		checkbox 	StripCheckBox 			"strip all path."			checked:false align:#left 				offset:[-12,0] 
		checkbox 	SaveSelectedCheckBox	"save selected object."	checked:false align:#left across:2 	offset:[-2,0] 	width:116 
		checkbox 	MaxFileCheckBox 			"collect max file." 		checked:false align:#left 			 	offset:[-12,0]	width:87 
		
		button 		ColectButton 				"Colect Assets"		align:#left					 	pos:[227,50]				offset:[4,0]width:50 height:35
		
		progressbar prg color:[51,153,255] align:#left	offset:[-4,0] width:269 height:10
	)
	
	on PathField changed text do 
	(
		if text[text.count] != "\\" then text = text + "\\"
		newPathValue = text
		PathField.text = text
	)
	
	on BrowseButton pressed do 
	(
		newpath = getSavePath()
		saveSelectedPath = newpath
		if newpath != undefined then 
		(
			if newpath[newpath.count] != "\\" then newpath = newpath + "\\"
			newPathValue = newpath
			PathField.text = newpath
		)
		else 
		(
			newPathValue = ""
			PathField.text = ""
		)
	)
	
	on UpdateCheckBox changed theState do
	(
		StripCheckBox.checked = false
		setPath = UpdateCheckBox.state
	)
	
	on StripCheckBox changed theState do
	(
		UpdateCheckBox.checked = false
		stripPath = StripCheckBox.state
	)
	
	on SaveSelectedCheckBox changed theState do
	(
		MaxFileCheckBox.checked = true
	)
	
	on ColectButton pressed do
	(
		local myAssetList = #()
		ATSOps.Refresh()
		iCount = ATSOps.GetFiles &myAssetList
		i = 0
		maxFileArrayNumber = 0
		if (SaveSelectedCheckBox.state == true) then
		(
			boolSucceed = false
			fn GetBitmapTextures theObjects =
			(
				texMaps = #()
				for obj in theObjects do
				(
					join texMaps (getClassInstances bitmapTexture target:obj asTrackViewPick:off)
				)
				makeUniqueArray texMaps
			)
			texMaps = (GetBitmapTextures selection)
			for texMap in texMaps do 
			(
				local resolvedPath = pathConfig.mapPaths.getfullfilepath(texMap.filename) 
				fileName = getFilenameFile (texMap.filename)
				fileName += getFilenameType (texMap.filename)
				endpath = saveSelectedPath + "\\" + fileName
				destinationPath = saveSelectedPath + "\\" + filenamefrompath(texMap.filename)
				
				if((setPath == true) and (SaveSelectedCheckBox.state == true)) then
				(
					texMap.filename = endpath
				)
				
				if((stripPath == true) and (SaveSelectedCheckBox.state == true)) then
				(
					texMap.filename = filename
				)
				
				boolSucceed  = copyfile (resolvedPath) (destinationPath)
/*
				if (boolSucceed  == true) then
				(
					print ("copied : " + (resolvedPath) + " to: " + (destinationPath))
				)
				else
				(
					print ("fail to copy : " + (resolvedPath) + " to: " + (destinationPath))
						
				)
*/
			)

			if((MaxFileCheckBox.state == true) and (SaveSelectedCheckBox.state == true)) then
			(
				-- instantiate the object
				theObj = dotNetObject "MaxCustomControls.RenameInstanceDialog" "Type in new name here"
				theobj.text ="Enter New Save Selected Object Name"
				DialogResult = theObj.Showmodal()

				--test if the ok button was pressed
				dotnet.compareenums TheObj.DialogResult ((dotnetclass "System.Windows.Forms.DialogResult").OK)
				--get the new text string
				saveSelectedFileName  = theobj.InstanceName + ".max"

				saveSelectedDestinationPath = saveSelectedPath + "\\" + saveSelectedFileName --this is the complete string
	
				if $ != undefined do 
				saveNodes $ saveSelectedDestinationPath --this saves ("copies") the objects as a file
			)
		)
		
		if ((iCount > 0) and (newpath != undefined) and (SaveSelectedCheckBox.state == false)) then 
		(
			for i in myAssetList do
			(
				local resolvedPath = pathConfig.mapPaths.getfullfilepath(i) 
				--local targetPath = ""
				--local destinationPath = ""

				if (i != resolvedPath) then 
				(								
					targetPath = resolvedPath
					destinationPath = newpath + "\\" + filenamefrompath(i)
				)
				else 
				(											
					targetPath = i
					destinationPath = newpath + "\\" + filenamefrompath(i)	
				)
		
				if (maxFileArrayNumber < 1) then
				(
					MaxFileTargetPath = targetPath
					MaxFileDestinationPath = destinationPath
					boolSucceed = false
				) else	boolSucceed  = copyfile (targetPath) (destinationPath)
/*
				if (boolSucceed  == true) then
				(
					print ("copied : " + (targetPath) + " to: " + (destinationPath))
				)
				else
				(
					print ("fail to copy : " + (targetPath) + " to: " + (destinationPath))
				)		
*/	
					maxFileArrayNumber+=1
					barValue = 100.0*maxFileArrayNumber/iCount
					AssetsControls.prg.value = barValue
				
					AssetsControls.prg.color = colStart + (colEnd - colStart) * barValue / 100
				
					AssetsControls.prg.value = 0
			)
		)
		
		if((setPath == true) and (SaveSelectedCheckBox.state == false)) then
		(
			ATSOps.SetPath newpathValue CreateOutputFolder:false
			ATSOps.SetPath newpathValue CreateOutputFolder:false
		)
		
		if((stripPath == true) and (SaveSelectedCheckBox.state == false)) then
		(
			ATSOps.SetPath "" CreateOutputFolder:false
			ATSOps.SetPath "" CreateOutputFolder:false	
		)
		
		if((MaxFileCheckBox.state == true) and (SaveSelectedCheckBox.state == false)) then
		(
			saveMaxFile MaxFileDestinationPath
		)
	)
)

	
----------------------This part is for testing when the code is ready, should be commented-----------------------------
/*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout AssetsControls vray3dSupportDummyFloater 

-----------------------------------------------------------------------------------------------------------------------