local data = {}
data.CombatType = "Gun"
data.AimingEnabled = true
data.AimingOffset = Vector3.new(1.75, 0.25, -1.5)
data.AimKeys = {
	Enum.UserInputType.MouseButton2,
	Enum.KeyCode.ButtonL2,
	Enum.KeyCode.Q
}
data.AimFOV = 70
data.AimDistance = -7
data.AimSensitivity = 0.125
data.GamepadAimSensitivity = 0.1
data.BulletSpeed = 50
data.BulletType = "normal"
data.Damage = 19
data.HeadshotDamage = 27
data.FiringEnabled = true
data.AttackKeys = {
	Enum.UserInputType.MouseButton1,
	Enum.KeyCode.ButtonR2
}
data.FireMode = "Auto"
data.FireDelay = 0.12
data.Range = 1000
data.AccuracyMin = Vector3.new(-0.002, -0.002, 0)
data.AccuracyMax = Vector3.new(0.012, 0.012, 0)
data.ClipSize = 30
data.ReloadKeys = {
	Enum.KeyCode.R,
	Enum.KeyCode.ButtonX
}
data.ReloadSpeed = 1
data.ShotReloadSpeed = 1
data.NumBullets = 1
data.ShotReloadEnabled = false
data.ReloadType = "Standard"
data.Weight = 1.2
data.HipfireFOV = 50
data.CamRecoilMin = Vector3.new(-.2, -0.3, -0.6)
data.CamRecoilMax = Vector3.new(.2, -0.9, 0.6)
data.AimScopeEnabled = false
data.AimScopeImageId = ""
data.MinAimDistance = 3
data.AnimationData = {
	Equip = {
		Id = "rbxassetid://10214185112"
	},
	Idle = {
		Id = "rbxassetid://10214195446"
	},
	Walk = {
		Id = "rbxassetid://10214221676"
	},
	Sprint = {
		Id = "rbxassetid://10214226612"
	},
	Swim = {
		Id = "rbxassetid://0"
	},
	Aim = {
		Id = "rbxassetid://10214200817"
	},
	Fire = {
		Id = "rbxassetid://10214190163"
	},
	CrouchAim = {
		Id = "rbxassetid://10214230538"
	},
	Reload = {
		Id = "rbxassetid://10214207128"
	},
	TacticalReload = {
		Id = "rbxassetid://10214214809"
	},
	ShotReload = {
		Id = "rbxassetid://0"
	},
	ShellIn = {
		Id = "rbxassetid://0"
	},
	ShellInEnd = {
		Id = "rbxassetid://0"
	}
}
data.SoundData = {
	AimIn = "rbxassetid://619576313",
	AimOut = "rbxassetid://619576578",
	MagIn = "rbxassetid://234393726",
	MagOut = "rbxassetid://268445237",
	PullBack = "rbxassetid://299287260",
	EmptyClip = "rbxassetid://240785604"
}
return data
