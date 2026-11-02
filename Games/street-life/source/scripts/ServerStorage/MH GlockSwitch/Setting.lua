	--[[ Edited Version
====================================================================================================
Weapons and Tools Pack 2016's Gun by SuperEvilAzmil and edited by thienbao2109

Features:
- FilteringEnabled support
- Easy to edit with a bunch of settings
- No delays between Mouse Click and Gun Fire
====================================================================================================
]]

local Module = {
	--	====================
	--	BASIC
	--	A basic settings for the gun
	--	====================
	
	PlayAllSounds = true;
	AutoReload = false;
	
	Auto = true;
	BaseDamage = 19;
	FireRate = 0.084; --In second
	ReloadTime = 3.5; --In second
	AmmoPerMag = 33; --Put "math.huge" to make this gun has infinite ammo and never reload
	SpreadX = 0; --In degree
	SpreadY = 0; --In degree
	Range = 300; --The furthest distance the bullet can travel
	HeadshotEnabled = true; --Enable the gun to do extra damage on headshot
	HeadshotDamageMultiplier = 1.9;
	IdleAnimationID = 16210262149; --Set to "nil" if you don't want to animate  16389120715
	IdleAnimationSpeed = 1;
	FireAnimationID = 16276403049; --Set to "nil" if you don't want to animsate     16276403049
	FireAnimationSpeed = 1;
	ReloadAnimationID = 16210265205; --
	ReloadAnimationSpeed = 0.7;
	EquippedAnimationID = 16210267020; --Set to "nil" if you don't want to animate
	EquippedAnimationSpeed = 1;
	EquipTime = 1.25; --In second
	HitPlayerAnimationID = 16210268537;
	HitPlayerAnimationSpeed = 0.8;
	
	JamChance = 1, -- out of 150
	JamKey = Enum.KeyCode.F, -- mobile gets screen button
	JamKeyString = "F", -- what is shown when gun is jammed (key in text instead of enum)
	
	
	--	====================
	--	GORE VISUALIZER
	--	Create gore effect when humanoid died
	--	====================

	GoreEffectEnabled = true;
	GoreSoundIDs = {1930359546};
	GoreSoundPitchMin = 1; -- Minimum pitch factor you will acquire.
	GoreSoundPitchMax = 1.5; -- Maximum pitch factor you will acquire.
	GoreSoundVolume = 1;

	--	====================
	--	CRITICAL DAMAGE
	--	Damage critically within its chance
	--	====================

	CriticalDamageEnabled = false;
	CriticalBaseChance = 5; --In percent
	CriticalDamageMultiplier = 3;

	--	====================
	--	FIRE SOUND EFFECTS
	--	Special effects for fire sound
	--	====================

	EchoEffect = true; --Create echo effect from distance
	Replicate = true;

	--	====================
	--	WALK SPEED REDUTION
	--	Nerf chraracter's walk speed when equip the gun
	--	====================

	WalkSpeedRedutionEnabled = false;
	WalkSpeedRedution = 6;

	--	====================
	--	HOLD DOWN ANIMATION
	--	Character won't fire if hold down the gun
	--	====================

	HoldDownEnabled = true;
	HoldDownAnimationID = 16210271019;
	HoldDownAnimationSpeed = 0.8;

	--	====================
	--	BULLET HOLE VISUALIZER
	--	Create a bullet hole when a bullet hit something but not character
	--	====================

	BulletHoleEnabled = true;
	BulletHoleSize = 0.2;
	BulletHoleTexture = {3696144972}; --You can insert more IDs
	BulletHoleVisibleTime = 5; --In second
	BulletHoleFadeTime = 1; --In second
	PartColor = true; --Set to hit object color

	--	====================
	--	HIT VISUALIZER
	--	Create hit effect when a bullet hit something but not character(And hit sound, too)
	--	====================

	HitEffectEnabled = true;
	HitSoundIDs = {9102724020, 9063083721, 9103240392, 9102728886};
	HitSoundPitchMin = 1; -- Minimum pitch factor you will acquire.
	HitSoundPitchMax = 1; -- Maximum pitch factor you will acquire.
	HitSoundVolume = 1;
	CustomHitEffect = true; --Emits your custom hit effect. NOTE: If you this setting disabled, hit effect will set to default(material tracker included)

	--	====================
	--	BLOOD VISUALIZER
	--	Create blood when a bullet hit character(And hit character sound, too)
	--	====================

	BloodEnabled = true;
	HitCharSndIDs = {1255040462};
	HitCharSndPitchMin = 1; -- Minimum pitch factor you will acquire.
	HitCharSndPitchMax = 1; -- Maximum pitch factor you will acquire.
	HitCharSndVolume = 1;

	--	====================
	--	TWEEN SETTING
	--	Part of ironsight and sniper aim
	--	====================

	TweenLength = 0.8; --In second
	EasingStyle = Enum.EasingStyle.Quint; --Linear, Sine, Back, Quad, Quart, Quint, Bounce or Elastic?
	EasingDirection = Enum.EasingDirection.Out; --In, Out or InOut?

	--	====================
	--	TWEEN SETTING(NO AIM DOWN)
	--	Part of ironsight and sniper aim
	--	====================

	TweenLengthNAD = 0.8; --In second
	EasingStyleNAD = Enum.EasingStyle.Quint; --Linear, Sine, Back, Quad, Quart, Quint, Bounce or Elastic?
	EasingDirectionNAD = Enum.EasingDirection.Out; --In, Out or InOut?

	--	====================
	--	BULLET WHIZZING SOUND
	--	Create a sound when a bullet travelling through character
	--	====================

	WhizSoundEnabled = true;
	WhizSoundID = {269514869, 269514887, 269514807, 269514817};
	WhizSoundVolume = 0.5;
	WhizSoundPitchMin = 1; -- Minimum pitch factor you will acquire.
	WhizSoundPitchMax = 1.5; -- Maximum pitch factor you will acquire.
	WhizDistance = 100;

	--	====================
	--	HITMARKER
	--	Mark on somewhere when a bullet hit character
	--	====================

	HitmarkerEnabled = true;
	HitmarkerSoundID = {1255040462, 1255040462, 1255040462};

	--Normal
	HitmarkerColor = Color3.fromRGB(255, 255, 255);
	HitmarkerFadeTime = 1;
	HitmarkerSoundPitch = 1;
	--Headshot
	HitmarkerColorHS = Color3.fromRGB(255, 0, 0);
	HitmarkerFadeTimeHS = 1;
	HitmarkerSoundPitchHS = 1;

	--	====================
	--	CROSSHAIR
	--	A gun cursor
	--	====================

	CrossSize = 2.8;
	CrossExpansion = 29;
	CrossSpeed = 4;
	CrossDamper	= 0.99;

	--	====================
	--	MUZZLE
	--	Create a muzzle flash when firing
	--	====================

	MuzzleFlashEnabled = true;
	MuzzleLightEnabled = true;
	LightBrightness = 3;
	LightColor = Color3.new(255/255, 283/255, 0/255);
	LightRange = 8;
	LightShadows = true;
	VisibleTime = 0.02; --In second

	--	====================
	--	BULLET SHELL EJECTION
	--	Eject bullet shells when firing
	--	====================

	BulletShellEnabled = true;
	BulletShellOffset = Vector3.new(0, 0.4, 0);
	ShellSize = Vector3.new(0.2, 0.2, 0.32); --Scale the part
	AllowCollide = false; --If false, a bullet shell will go through any parts
	ShellScale = Vector3.new(1.5, 1.5, 1.5); --Scale mesh
	ShellMeshID = 95392019;
	ShellTextureID = 95391833;
	DisappearTime = 3; --In second

	--      You can edit velocity by go to GunScript_Local, and scroll down until you see "function EjectShell(ShootingHandle)"

	--	====================
	--	IRONSIGHT
	--	Allow user to ironsighting
	--	====================

	IronsightEnabled = false; --NOTE: If "SniperEnabled" is enabled, this setting is not work
	FieldOfViewIS = 59;
	MouseSensitiveIS = 0.2; --In percent
	SpreadRedutionIS = 0.6; --In percent. NOTE: Must be the same value as "SpreadRedutionS"
	CrossScaleIS = 0.8;

	--	====================
	--	LIMITED AMMO
	--	Make a gun has a limit ammo
	--	====================

	LimitedAmmoEnabled = true;
	Ammo = 33;
	MaxAmmo = 66; --Put "math.huge" to allow user to carry unlimited ammo

	--	====================
	--	SHOTGUN
	--	Enable the gun to fire multiple bullet in one shot
	--	====================

	ShotgunEnabled = false;
	BulletPerShot = 8;

	ShotgunReload = false; --Make user reloading like Shotgun, which user clipin shell one by one
	ShotgunClipinAnimationID = nil; --Set to "nil" if you don't want to animate
	ShotgunClipinAnimationSpeed = 1;
	ShellClipinSpeed = 0.5; --In second

	--		How "ShotgunEnabled" work [Example]:

	--		Play "ShotgunClipinAnimation" + Play "ShotgunClipin" Audio
	--		>>>
	--		Wait "ShellClipinSpeed" second
	--		>>>
	--		Repeat "AmmoPerClip" - "Current Ammo" times
	--		>>>
	--		Play "ReloadAnimation" + Play "ReloadSound"
	--		Wait "ReloadTime"

	--	====================
	--	BURST FIRE
	--	Enable the gun to do burst firing like Assault Rifle
	--	====================

	BurstFireEnabled = false;
	BulletPerBurst = 3;
	BurstRate = 0.075; --In second

	--	====================
	--	SNIPER
	--	Enable user to use scope
	--	====================

	SniperEnabled = false; --NOTE: If "IronsightEnabled" is enabled, this setting is not work
	FieldOfViewS = 12.5;
	MouseSensitiveS = 0.2; --In percent
	SpreadRedutionS = 0.6; --In percent. NOTE: Must be the same value as "SpreadRedutionOS"
	CrossScaleS = 0;
	ScopeSensitive = 0.25;
	ScopeKnockbackSpeed = 7;
	ScopeKnockbackDamper = 0.65;
	ScopeSwaySpeed = 10;
	ScopeSwayDamper	= 0.4;

	--      You can edit knockback offset by go to GunScript_Local, and scroll down until you reach line 421 and 486

	--	====================
	--	CAMERA RECOILING
	--	Make user's camera recoiling when shooting
	--	====================

	CameraRecoilingEnabled = true;
	Recoil = 14;
	AngleX_Min = 1; --In degree
	AngleX_Max = 1; --In degree
	AngleY_Min = 0; --In degree
	AngleY_Max = 0; --In degree
	AngleZ_Min = -1; --In degree
	AngleZ_Max = 1; --In degree
	Accuracy = 0.5; --In percent. For example: 0.5 is 50%
	RecoilSpeed = 13; 
	RecoilDamper = 0.3;
	RecoilRedution = 0.5; --In percent.

	--	====================
	--	EXPLOSIVE
	--	Make a bullet explosive so user can deal a damage to multiple enemy in single shot. NOTE: Explosion won't break joints
	--	====================

	ExplosiveEnabled = false;
	ExplosionSoundEnabled = false;
	ExplosionSoundIDs = {163064102};
	ExplosionSoundVolume = 1;
	ExplosionSoundPitchMin = 1; -- Minimum pitch factor you will acquire.
	ExplosionSoundPitchMax = 1.5; -- Maximum pitch factor you will acquire.
	ExplosionRadius = 8;
	CustomExplosion = false;

	--	====================
	--	BULLET VISUALIZER
	--	Enabled the gun to display a travelling bullet
	--	====================

	BulletTracerEnabled = true; --Create a tracer for the bullet when firing
	BulletParticleEnaled = true
	; --Create a particle effect for bullet when firing
	BulletTracerOffset0 = Vector3.new(0.1, 0, 0); --NOTE: Bullet tracer size is depends on position between two attachments
	BulletTracerOffset1 = Vector3.new(-0.1, 0, 0); --NOTE: Bullet tracer size is depends on position between two attachments
	BulletSpeed = 3200; --Studs/second
	DropGravity = 0; --The amount of gravity applied to the bullet. Default place gravity is 196.2 (see workspace.Gravity)
	WindOffset = Vector3.new(0, 0, 0); --The amount of force applied to the bullet in world space. Useful for wind effects
	BulletSize = Vector3.new(0.4, 0.4, 0.4);
	BulletColor = Color3.fromRGB(163, 162, 156); --I used "Color3" instead of using "BrickColor"
	BulletTransparency = 1;
	BulletMaterial = Enum.Material.Neon;
	BulletShape = Enum.PartType.Cylinder; --Block or Ball, or Cylinder?]]

	BulletMeshEnabled = false; --Create a custom mesh for the bullet when firing
	BulletMeshID = 6696543809;
	BulletTextureID = 0;
	BulletMeshScale = Vector3.new(0.007, 0.007, 0.007);

	BulletLightEnabled = false;
	BulletLightBrightness = 3;
	BulletLightColor = Color3.fromRGB(255, 165, 153);
	BulletLightRange = 6;
	BulletLightShadows = true;

	--	====================
	--	CHARGED SHOT
	--	Make a gun charging before firing. Useful for a gun like "Railgun" or "Laser Cannon"
	--	====================

	ChargedShotEnabled = false;
	ChargingTime = 0.1;

	--	====================
	--	MINIGUN
	--	Make a gun delay before/after firing
	--	====================

	MinigunEnabled = false;
	DelayBeforeFiring = 1;
	DelayAfterFiring = 1;

	--	====================
	--	MISCELLANEOUS
	--	Etc. settings for the gun
	--	====================

	Knockback = 0; --Setting above 0 will enabling the gun to push enemy back.
	Lifesteal = 0; --In percent - Setting above 0 will allow user to steal enemy's health by dealing a damage to them.

	FlamingBullet = false; --Enable the bullet to set enemy on fire. Its DPS and Duration can be edited inside "IgniteScript"
	IgniteChance = 100;

	FreezingBullet = false; --Enable the bullet to freeze enemy. Its Duration can be edited inside "IcifyScript"
	IcifyChance = 100;

	DualEnabled = false; --Enable the user to hold two guns instead one. In order to make this setting work, you must clone its Handle and name it to "Handle2". Enabling this setting will override Idle Animation ID.
	--Piercing = 0; --Setting above 0 will enabling the gun to penetrate up to XX victim(s). Cannot penetrate wall. NOTE: It doesn't work with "ExplosiveEnabled"

	--	====================
	--	END OF SETTING
	--	====================
}

return Module