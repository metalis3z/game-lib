--[[
Read this to understand what each one of the values does to the plane:

-Acceleration:
	This changes how fast the plane accelerates. 1000 being the highest, and 0 being the lowest. If you make it 0, the plane will
	accelerate every 0.5 seconds. If you make it 1000, the plane will accelerate every 0 seconds
	
-AltitudeRestrict:
	This value determines whether there will be altitude restrictions on the plane or not

	-MaxAltitude:
		This value sets the limit as to how high the plane can fly. If you go higher than the MaxAltitude, the plane will stall
		until you are below the limit
	-MinAltitude:
		This value sets the limit as to how low the plane can fly. If you go lower than the MinAltitude, the plane will explode. If
		you fly just a few studs above the limit, a warning indicator will appear that tells you to pull up
		
-CameraType:
	This value determines what cameratype you will have when you select the plane tool. It can be either one of these:
	Attach, Custom, Fixed, Follow, Scriptable, Track, and Watch. If the value is blank, the cameratype will automatically be Custom
	
-CanCrash:
	This value determines whether the plane can crash or not at a given force
	
	-Force:
		This value sets the minimum force required to make the plane crash. If you hit any object at a speed faster than the Force
		value, then you will crash
		
-Ejectable:
	This value determines whether you can eject from the plane or not
		
-FlightControls:
	These are the controls that allow you to fly the plane

	-Eject:
		This key will eject you from the plane
	-Engine:
		This key will turn on or turn off the engine
	-Gear:
		This key will make the landing gear retract or extend
	-SlowDown:
		This key will make the plane slow down. The key can either be "ArrowKeyUp", "ArrowKeyDown", or any other key
	-SpeedUp:
		This key will make the plane speed up. The key can either be "ArrowKeyUp", "ArrowKeyDown", or any other key

-GroupSpecific:
	This value determines whether only a certain group can access it or everyone can access it
	
	-GroupId:
		This value is the Id of the group that the plane is specific too. As long as GroupSpecific is set to true
	
	-KillOnEnter:
		If this value is true, then if GroupSpecific is true and the player that entered the plane isn't part of the group,
		the script will kill them. If it false it won't kill them

-MaxBank:
	This value sets the maximum angle the plane can bank. The lowest it can be is -90, and the highest it can be is 90
	
-MaxSpeed:
	This value sets the maximum speed that the plane can fly at. The higher the acceleration value, the faster the plane will reach
	its top speed
	
-PlaneName:
	This value names the plane and it will appear on the top of the Plane Gui
	
-ReloadTimes:
	These are the reload times for each weapon on the plane
	
	-Bombs:
		This value sets how much time you have to wait before you can drop another bomb. The reload time for guided bombs are twice
		this value
		
	-Flares:
		This value sets how much time you have to wait before you can deploy more flares
		
	-Guns:
		This value sets the firerate of the guns. This value should be no less than 0.01
		
	-Missiles:
		This value sets how much time you have to wait before you can fire another missile. The reload time for guided missiles are
		twice this value
		
	-Rockets:
		This value sets how much time you have to wait before you can fire another set of rockets
		
-StallSpeed:
	This value sets the minimum speed that the plane can fly before it stalls. If the plane is flying at a speed lower than the
	StallSpeed, the plane will stall until the speed is increased
	
-TargetControls:
	These are the controls that control the targeting system on the plane
	
	-Modes:
		This key switches the modes on the plane. There are two modes. In flying mode, the sign "Flying Mode" will be displayed on the
		Plane Gui, and you can't target objects. In targeting mode, the sign "Targeting Mode" will be displayed on the Plane Gui, and
		you will be able to target objects
		
	-UnTarget:
		This key unlocks from whatever object that you locked onto, and it allows you to lock onto another object
		
-Targetable:
	This value determines whether the plane will have a targeting system or not, which allows you to lock onto any object or player
	according to the Targeting System
	
-NewTargeting:
	This value determines whether the plane will have the newest targeting system or not. The newer targeting system allows you to
	target player's from as far as you want and the mouse doesn't have to be directly over the target. However, the newer targeting
	system doesn't allow you to lock onto objects, only players
	
-ThrottleInc:
	This value changes how fast the throttle increases. The max this value should be is 1, and the minimum should be 0.01. The higher
	the number, the faster the throttle increases
	
-TurnSpeed:
	This value affects how fast the plane turns. The lowest it should be is 0 and the highest it should be is 10000. If you make the
	value higher than 10000, the plane could become unstable
	
-WeaponControls:
	These are the controls that fire the given weapons
	
	-DeployFlares:
		This key will make the plane deploy flares
	-DropBombs:
		This key will make the plane drop bombs
	-FireGuns:
		This key will make the plane fire its guns
	-FireMissile:
		This key will make the plane fire missiles
	-FireRockets:
		This key will make the plane fire rockets
		
-Weapons:
	This value determines whether the plane will have weapons or not
	
	-Bombs:
		This value will determine whether the plane can drop bombs or not
	-Flares:
		This value will determine whether the plane can deploy flares or not
	-Guns:
		This value will determine whether the plane can fire guns or not
	-Missiles:
		This value will determine whether the plane can fire missiles or not
	-Rockets:
		This value will determine whether the plane can fire rockets or not
		
Well, these are all the controls! If you have any questions, send me a message

--TurboFusion--

]]