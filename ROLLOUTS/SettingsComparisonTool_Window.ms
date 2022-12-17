	defaultSettings = createInstance (classof renderers.current)

rollout SCT "Settings Comparison Tool" width:600
(
	/*
	
	dotNetControl lv "system.windows.forms.listView" height:450 --width:287 offset:[-14,0]
		
	fn initLv theLv=
	(
		--Setup the forms view
		theLv.view=(dotNetClass "system.windows.forms.view").details
		theLv.FullRowSelect=true		--Set so full width of listView is selected and not just first column.
		theLv.GridLines=true			--Show lines between the items. 
		theLv.MultiSelect=true			--Allow for multiple selections. 
	)
	
	fn addColumns theLv columnsAr=
	(
		w= 200 --(theLv.width/columnsAr.count)-1 --Set column width
		for x in columnsAr do
		(
			theLv.columns.add x w
		)
	)
		
-- 	fn populateList theLv=
-- 	(
-- 		RendererProperties = getPropNames  renderers.current --get vray properties (array)
-- 		rows=#()			--Empty array to collect rows of data
-- 		
-- 		for i=1 to RendererProperties.count do		--Loop through vrayProperties array
-- 		(
-- 			li=dotNetObject "System.Windows.Forms.ListViewItem" RendererProperties[i]	--Create a listViewItem object and name it. 
-- 			
-- 			li.subitems.add (defaultSettings as array)	--Add data to the second column.
-- 			
-- 			RendererPropertiesValue = execute ("renderers.current." + RendererProperties[i]) as string
-- 			
-- 			append rows li		--Added the listViewItem to the rows array
-- 		)
-- 		theLv.items.addRange rows		--Add the array of rows to the listView control. 
-- 	)
	
	on SCT open do
	(
		initLv lv
		addColumns lv #("Renderer Properties","Default Value", "Current Value")
-- 		populateList lv
	)*/
	
	
)
createDialog SCT 	pos:[(getDialogpos vray3dSupportFloater)[1]+vray3dSupportFloater.width+6,(getDialogPos vray3dSupportFloater)[2]]	modal:false style:#(#style_sunkenedge) 
