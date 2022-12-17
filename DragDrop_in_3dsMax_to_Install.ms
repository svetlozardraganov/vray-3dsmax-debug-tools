--Helpful references 
--https://forums.cgsociety.org/t/how-do-i-create-my-own-menus-inside-3dsmax-interface/1165096/5
--https://forums.cgsociety.org/t/creating-a-new-main-menu-in-3ds-max/2064794
--https://help.autodesk.com/view/MAXDEV/2023/ENU/?guid=GUID-258F6015-6B45-4A87-A7F5-BB091A2AE065
--https://help.autodesk.com/view/MAXDEV/2023/ENU/?guid=GUID-1374EDCA-CC8B-4B43-81A5-6ED98DBE01D3



--Remove "3D Support" menu if exists

fn Remove3DSupportMenu =
(
	number_of_menus = menuMan.numMenus()
	collect_menus = #()

	for i=1 to number_of_menus do
	(
		menu = menuMan.getMenu i
		menu_name = menu.getTitle()
		
		if menu_name == "3D Support" do
		(
			print(menu_name)
			append collect_menus menu
		)
	)

	for menu in collect_menus do
	(
		print("Remove Menu: " + menu.getTitle())
		menuMan.unRegisterMenu menu
	)
)

Remove3DSupportMenu()

--Add "3D Support" menu to 3ds Max
fn Add3DSupportMenu = 
(
	if menuMan.findMenu "3D Support" == undefined then(

		macroScript VRay3DSupportTools category:"3D Support" --some macro script
		(
			filein(@"G:\Shared drives\3D SUPPORT\Scripts\MaxScript\V-Ray_3D_Support_Tools\vray3dSupportFloater.ms")

		)

		theMainMenu = menuMan.getMainMenuBar() --get the main menu bar
		theMenu = menuMan.createMenu "3D Support" --create a menu called Forum Help
		theSubMenu = menuMan.createSubMenuItem "3D Support" theMenu --create a SubMenuItem
		theMainMenu.addItem theSubMenu (theMainMenu.numItems()+1) --add the SubMenu to the Main Menu
		theAction = menuMan.createActionItem "VRay3DSupportTools" "3D Support" --create an ActionItem from the MacroScript
		theMenu.addItem theAction (theMenu.numItems()+1) --add the ActionItem to the menu
		menuMan.updateMenuBar() --update the menu bar
		
		messageBox "3D Support Tools installed succesfully! \n You can access it from: 3ds Max menu-bar > 3D Support menu."
	)
	else
	(
		messageBox "3D Support Tools is already installed"
	)
)

Add3DSupportMenu()