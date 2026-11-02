--!strict
-- LOCATION: ReplicatedStorage/Modules/SettingConfiguration
local SettingConfiguration = {}

SettingConfiguration.Settings = {
	{
		Id = "CubesSoundOff",
		Template = "OnAndOffTemplate",
		Name = "Turn Off Cubes Sound",
		Title = "Turn Off Cubes Sound",
		Desc = "Turn off the sound of the cubes",
		isoff = false,
	},
	{
		Id = "KeyboardSoundOff",
		Template = "OnAndOffTemplate",
		Name = "Turn Off Keyboards Sound",
		Title = "Turn Off Keyboards Sound",
		Desc = "Turn off the sound of the Keyboards",
		isoff = false,
	},
	{
		Id = "MusicOff",
		Template = "OnAndOffTemplate",
		Name = "Turn Off Background Music",
		Title = "Turn Off Background Music",
		Desc = "Turn off the Background Music",
		isoff = false,
	},
	{
		Id = "EditRange",
		Template = "TextBoxTemplate",
		Name = "EditRange",
		Title = "Change Range",
		Desc = "change range for more or less asmr",
		Min = 1,
		Max = 1.5,
	},
}

return SettingConfiguration