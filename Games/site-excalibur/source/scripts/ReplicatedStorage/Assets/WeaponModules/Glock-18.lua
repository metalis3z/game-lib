local data = {}
data.CombatType = "Gun"
data.AimingEnabled = true
data.AimingOffset = Vector3.new(1.75, 0.25, -1.25)
data.AimingOffset2 = Vector3.new(-1.75, 0.25, -1.25)
data.AimKeys = {
	Enum.UserInputType.MouseButton2,
	Enum.KeyCode.ButtonL2,
	Enum.KeyCode.Q
}
data.AimFOV = 70
data.AimDistance = -5
data.AimSensitivity = 0.125
data.GamepadAimSensitivity = 0.1
data.BulletSpeed = 50
data.BulletType = "normal"
data.Damage = 11.5
data.HeadshotDamage = 30
data.FiringEnabled = true
data.AttackKeys = {
	Enum.UserInputType.MouseButton1,
	Enum.KeyCode.ButtonR2
}
data.FireMode = "Auto"
data.FireDelay = 0.12
data.Range = 1000
data.AccuracyMin = Vector3.new(-0.01, -0.01, 0)
data.AccuracyMax = Vector3.new(0.01, 0.01, 0)
data.ClipSize = 22
data.ReloadKeys = {
	Enum.KeyCode.R,
	Enum.KeyCode.ButtonX
}
data.ReloadSpeed = 1
data.ShotReloadSpeed = 1
data.NumBullets = 1
data.ShotReloadEnabled = false
data.ReloadType = "Standard"
data.Weight = 1
data.HipfireFOV = 60
data.CamRecoilMin = Vector3.new(0, -0.2, 0)
data.CamRecoilMax = Vector3.new(0, -1.6, 0)
data.AimScopeEnabled = false
data.AimScopeImageId = ""
data.MinAimDistance = 3
data.AnimationData = {
	Equip = {
		Id = "rbxassetid://8073555232"
	},
	Idle = {
		Id = "rbxassetid://10085849067"
	},
	Walk = {
		Id = "rbxassetid://0"
	},
	Sprint = {
		Id = "rbxassetid://8073552976"
	},
	Swim = {
		Id = "rbxassetid://0"
	},
	Aim = {
		Id = "rbxassetid://10085807944"
	},
	Fire = {
		Id = "rbxassetid://10085844243"
	},
	CrouchAim = {
		Id = "rbxassetid://8073535400"
	},
	Reload = {
		Id = "rbxassetid://10085993653"
	},
	TacticalReload = {
		Id = "rbxassetid://8073558814"
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
	MagIn = "rbxassetid://1550643261",
	MagOut = "rbxassetid://1550642637",
	PullBack = "rbxassetid://299287260",
	EmptyClip = "rbxassetid://240785604"
}
return data
