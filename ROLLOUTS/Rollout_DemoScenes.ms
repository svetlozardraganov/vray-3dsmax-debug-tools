Rollout DS "Demo Scenes" --, Saved For 3dsMax 2015
	(
		button Scene01 ""  pos:[0,0] 		height:77 width:140 tooltip:"Sound Mixer(ANIMATION)"
		button Scene02 ""  pos:[147,0] 	height:77 width:140 tooltip:"Chocolate(Progressive)"
		button Scene03 ""  pos:[0,84] 		height:77 width:140 tooltip:"Modern Interior(Bucket)"
		button Scene04 ""  pos:[147,84] 	height:77 width:140 tooltip:"Hot Air Balloon"
		button Scene05 ""  pos:[0,168] 	height:77 width:140 tooltip:"Flower & Bee(GPU)"
		button Scene06 ""  pos:[147,168] 	height:77 width:140 tooltip:"Beach Waves(Bucket)"
		button Scene07 ""  pos:[0,252] 	height:77 width:140 tooltip:"Ink In Water(Bucket)"
		button Scene08 ""  pos:[147,252] 	height:77 width:140 tooltip:"Smoke And Fire Follow Path(Bucket)"
		button Scene09 ""  pos:[0,336] 	height:77 width:140 tooltip:"Liquid Morphing(Bucket)"
		button Scene10 ""  pos:[147,336] 	height:77 width:140 tooltip:"Nuke(Bucket)"
		button Scene11 ""  pos:[0,420] 	height:77 width:140 tooltip:"Ship(Bucket)"
		button Scene12 ""  pos:[147,420] 	height:77 width:140 tooltip:"Volcano(Bucket)"
		
		on DS open do 
		(
			Scene01.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,1,1,1,1,false,false)
			Scene02.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,2,2,2,2,false,false)
			Scene03.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,3,3,3,3,false,false)
			Scene04.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,4,4,4,4,false,false)
			Scene05.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,5,5,5,5,false,false)
			Scene06.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,6,6,6,6,false,false)
			Scene07.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,7,7,7,7,false,false)
			Scene08.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,8,8,8,8,false,false)
			Scene09.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,9,9,9,9,false,false)
			Scene10.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,10,10,10,10,false,false)
			Scene11.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,11,11,11,11,false,false)
			Scene12.images = #("G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\Scenes.bmp","G:\\Shared drives\\3D SUPPORT\\Scripts\\MaxScript\\V-Ray_3D_Support_Tools\\IMG\\ScenesA.bmp",12,12,12,12,12,false,false)
		)
		
		on Scene01 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\SoundMixer\\Sound_Mixer.max")
		)
		
		on Scene02 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\Chocolate\\Chocolate.max")
		)
		
		on Scene03 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\ModernInterior\\Modern_Interior.max")
		)
		
		on Scene04 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\HotAirBalloon\\Hot_Air_Balloon.max")
		)
		
		on Scene05 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\Flower&Bee\\Flower_&_Bee.max")
		)
		
		on Scene06 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\BeachWaves\\Beach_Waves.max")
		)
		
		on Scene07 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\InkInWater\\Ink_In_Water.max")
		)
		
		on Scene08 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\SmokeAndFireFollowPath\\Smoke_And_Fire_Follow_Path.max")
		)
		
		on Scene09 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\LiquidMorphing\\Liquid_Morphing.max")
		)
		
		on Scene10 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\Nuke\\Nuke.max")
		)
		
		on Scene11 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\Ship\\Ship.max")
		)
		
		on Scene12 pressed do
		(
			CheckForSave()
			loadMaxFile ("G:\\Shared drives\\3D SUPPORT\\Test_scenes\\3dsMax\\Volcano\\Volcano.max")
		)
		
-- 		on Scene06 pressed do
-- 		(
-- 			Rollout OPT "" width:120 height:44 
-- 			(
-- 				button btn1 "Simulation Is Ready" 	pos:[0,0] 	width:120 height:22 bold:true
-- 				button btn2 "Ready For Simulation" pos:[0,22] 	width:120 height:22
-- 				
-- 				on btn1 pressed do
-- 				(
-- 					CheckForSave()
-- 					loadMaxFile ("\\\\SUPPORT-PC\\3d_Support_Files\\V-Ray_3D_Support_Tools\\Scenes\\BeachWaves\\beach_waves.max")
-- 				)
-- 				on btn2 pressed do
-- 				(
-- 					CheckForSave()
-- 					loadMaxFile ("\\\\SUPPORT-PC\\3d_Support_Files\\V-Ray_3D_Support_Tools\\Scenes\\BeachWaves\\beach_waves.max")
-- 				)
-- 			)

-- 			CreateDialog OPT modal:false style:#(#style_sunkenedge) 
-- 			CheckForSave()
-- 			loadMaxFile ("\\\\SUPPORT-PC\\3d_Support_Files\\V-Ray_3D_Support_Tools\\Scenes\\SoundMixer\\SoundMixer.max")
-- 		)
	)
	
----------------------This part is for testing when the code is ready, should be commented-----------------------------
/*
vray3dSupportDummyFloater = newRolloutFloater "V-Ray 3D Support Tools Dummy Floater" 300 600
addRollout DR vray3dSupportDummyFloater 

-----------------------------------------------------------------------------------------------------------------------