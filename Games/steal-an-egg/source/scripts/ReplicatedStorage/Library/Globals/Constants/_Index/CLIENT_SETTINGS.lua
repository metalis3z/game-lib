-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

for i, v in ipairs({
	"Inventory",
	"Settings",
	"Potions",
	"AutoTapper",
	"VendingStocks",
	"TradeHistory",
	"BoothHistory",
	"MailLog",
	"ItemIndex",
	"PetHatchCount",
	"GlitchEvent",
	"Achievements",
	"MasteryPerksEnabled",
	"Mastery",
	"EquippedPets",
	"Buffs",
	"Boosts",
	"Potions",
	"Fruits",
	"ZoneQuests",
	"FreeGiftsTime",
	"PrisonEvent",
	"DinoTycoonEvent"
}) do
	t[v] = true
end

return {
	CoinGrabDistance = 300,
	MusicVolume = 0.5,
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