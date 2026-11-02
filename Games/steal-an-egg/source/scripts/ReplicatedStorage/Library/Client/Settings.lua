-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

for i, v in ipairs({ "Inventory", "Settings" }) do
	t[v] = true
end

return {
	CoinGrabDistance = 300,
	MusicVolume = 1,
	SoundsVolume = 0.5,
	SupportsVR = false,
	SupportsPortrait = false,
	ForcedPortrait = false,
	Scale9Slice = true,
	ScaleStrokes = true,
	ScalePadding = false,
	ScaleLists = false,
	ScaleGrids = false,
	ScaleRichText = true,
	ScaleScrollbars = false,
	UIEasingStyle = "Sine",
	StatsNoFreeze = t
}