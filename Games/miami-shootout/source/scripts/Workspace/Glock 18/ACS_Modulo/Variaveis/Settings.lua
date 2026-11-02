local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "Glock - 18"
	,BulletType = "9x19mm"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {70, 60}
	,ZoomAnim = false
	,FocusOnSight = false
	,FocusOnSight2 = false
	,MagCount = true
	,Bullets = 1
	,FireRate = 1200
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 0				--- 0 - Pistol, 1 - Rifle, 2 - Shotgun
	,ReloadType = 1				--- 1 - Magazine, 2 - Shell inserting
	,Mode = "Semi"				--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
	,FireModes = {
		ChangeFiremode = true;		
		Semi = true;
		Burst = false;
		Auto = true;
		Safe = true;
		Explosive = false;}
	,CanDamageBlizzard = false
	,BlizzardDamage = 0
----------------------------------------------------------------------------------------------------
-----------------------=[ PUMP-ACTION ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,AutoChamber = false
	,ChamberWhileAim = false
----------------------------------------------------------------------------------------------------
-----------------=[ RECOIL & PRECISAO ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	
	,VRecoil = {12,16}				--- Vertical Recoil
	,HRecoil = {4,6}				--- Horizontal Recoil
	,AimRecover = 0.8					---- Between 0 & 1

	,RecoilPunch = 2
	,VPunchBase = 12					--- Vertical Punch
	,HPunchBase = 2					--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless

	,AimRecoilReduction = 1 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 0.4
	,MinRecoilPower = 1
	,MaxRecoilPower = 2
	,RecoilPowerStepAmount = .15

	,MinSpread = 4					--- Min bullet spread value | Studs
	,MaxSpread = 40					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = 2.5
	,AimInaccuracyDecrease = .5
	,WalkMultiplier = 0.2				--- Bullet spread based on player speed

	,SwayBase = 0.1					--- Weapon Base Sway | Studs
	,MaxSway =	1					--- Max sway value based on player stamina | Studs
----------------------------------------------------------------------------------------------------
---------------------=[ DANO ]=---------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,LimbsDamage = {20,35}
	,TorsoDamage = {35,65}
	,HeadDamage = {85,100}
	,BulletPenetration = 45 ---- Between 0 & 100%
	,FallOfDamage = 1.2
	,OffsetAngle = 5
	,OffsetSens = .1
----------------------------------------------------------------------------------------------------
-------------------=[ PROJETIL ]=-------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,Distance = 2000
	,BDrop = .25
	,BSpeed = 1500
	
	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds
	
	,BulletWhiz = true
	,BWEmitter = 25
	,BWMaxDistance = 200
	
	,BulletFlare = false
	,BulletFlareColor = Color3.fromRGB(255,255,255)
	
	,Tracer = false
	,TracerColor = Color3.fromRGB(255,255,255)
	,TracerLightEmission = 1
	,TracerLightInfluence = 0
	,TracerLifeTime = .2
	,TracerWidth = .1
	,RandomTracer = false
	,TracerEveryXShots = 1
	,TracerChance = 100
	
	,BulletLight = false
	,BulletLightBrightness = 1
	,BulletLightColor = Color3.fromRGB(255,255,255)
	,BulletLightRange = 10
	
	,ExplosiveHit = false
	,ExPressure = 500
	,ExpRadius = 25
	,DestroyJointRadiusPercent = 0	--- Between 0 & 1
	,ExplosionDamage = 100
	
	,LauncherDamage = 100
	,LauncherRadius = 25
	,LauncherPressure = 500
	,LauncherDestroyJointRadiusPercent = 0
----------------------------------------------------------------------------------------------------
--------------------=[ OUTROS ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,FastReload = true					--- Automatically operates the bolt on reload if needed
	,CanADS = true						--- Allow you to aim down sights with the gun
	,Amphibious = false					--- if set to true the gun can be used underwater
	,SlideLock = true
	,MoveBolt = true
	,BoltLock = false
	,CanBreachDoor = false
	,CanBreak = true					--- Weapon can jam?
	,JamChance = 900					--- This old piece of brick doesn't work fine >;c
	,IncludeChamberedBullet = true		--- Include the chambered bullet on next reload
	,Chambered = true					--- Start with the gun chambered?
	,LauncherReady = false				--- Start with the GL ready?
	,CanCheckMag = true					--- You can check the magazine
	,VisibleBullets = false             --- Allows for accurate mag check.
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 1
	,GunFOVReduction = 5

	,BoltExtend = Vector3.new(0, 0, 0.17)
	,SlideExtend = Vector3.new(0, 0, 0.17)
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = true
	,HolsterTo = 'LowerTorso'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(1.2,-0.32,0.19) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
	
	,RightArmPos = CFrame.new(-0.85, .42, .3) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
	,RightLowerArmPos = CFrame.new(0,.5,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
	,LeftArmPos = CFrame.new(.6,.3,.35) * CFrame.Angles(math.rad(-65),math.rad(30),math.rad(-25))	--server
	,LeftLowerArmPos = CFrame.new(0,.55,-0.05) * CFrame.Angles(math.rad(-10), math.rad(0), math.rad(0))
	
	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,SV_GunPos = CFrame.new(-.3, -.2, -0.4) * CFrame.Angles(math.rad(-90), math.rad(-90), math.rad(0))

	,SV_RightArmPos = CFrame.new(-0.575, 0.65, -1.185) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
	,SV_LeftArmPos = CFrame.new(1.15,0.25,-1.3) * CFrame.Angles(math.rad(-95),math.rad(20),math.rad(-25))	--server

	,SV_RightElbowPos = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))		--Server
	,SV_LeftElbowPos = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))	--server

	,SV_RightWristPos = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))		--Server
	,SV_LeftWristPos = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))	

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	
	,ServerGunPos = CFrame.new(-.3, -1.3, -.42) * CFrame.Angles(math.rad(-90), math.rad(-90), math.rad(0))
	,GunPos = CFrame.new(0.15, -0.222, .8) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
	
	,RightPos = CFrame.new(-.65, 0.9, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Client
	,LeftPos = CFrame.new(1.1,0,-1.6) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-20))	--Client
}

return Config

