-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local tbl = {
	SpinnyWheelTicketFix = {
		Default = false,
		Name = "Patches: Spinny Wheel Ticket Fix",
		Type = "boolean"
	},
	DoubleAutoResolution = {
		Default = true,
		Name = "Double Auto Resolution",
		Type = "boolean"
	},
	DisableWorldFrontend = {
		Default = false,
		Name = "DisableWorldFrontend",
		Type = "boolean"
	},
	ExistCount = {
		Default = true,
		Name = "Exist Count (Heroku)",
		Type = "boolean"
	},
	ExistCountPush = {
		Default = true,
		Name = "Exist Count Push (Heroku)",
		Type = "boolean"
	},
	ExistCountPull = {
		Default = true,
		Name = "Exist Count Pull (Heroku)",
		Type = "boolean"
	},
	ExistCountOverlay = {
		Default = true,
		Name = "Exist Count Info Overlay",
		Type = "boolean"
	},
	RAP = {
		Default = true,
		Name = "RAP (Heroku)",
		Type = "boolean"
	},
	RAPPush = {
		Default = true,
		Name = "RAP Push (Heroku)",
		Type = "boolean"
	},
	RAPPull = {
		Default = true,
		Name = "RAP Pull (Heroku)",
		Type = "boolean"
	},
	RAPOverlay = {
		Default = true,
		Name = "RAP Info Overlay",
		Type = "boolean"
	},
	RAPPreventInvalid = {
		Default = true,
		Name = "RAP Prevent Invalid",
		Type = "boolean"
	},
	DevRAP = {
		Default = true,
		Name = "Dev RAP (Analytics)",
		Type = "boolean"
	},
	DevRAPPull = {
		Default = true,
		Name = "Dev RAP Pull (Analytics)",
		Type = "boolean"
	},
	DevRAPOverlay = {
		Default = true,
		Name = "Dev RAP Info Overlay",
		Type = "boolean"
	},
	LegacyPrompting = {
		Default = false,
		Name = "Legacy Developer Product Prompting",
		Type = "boolean"
	},
	PurchaseAdditionalLocks = {
		Default = true,
		Name = "Purchase Additional Locks",
		Type = "boolean"
	},
	FavoritePrompt = {
		Default = true,
		Name = "Favorite Prompt",
		Type = "boolean"
	},
	NotificationPrompt = {
		Default = true,
		Name = "Notification Prompt",
		Type = "boolean"
	},
	NewUserExperience = {
		Default = 0,
		Name = "New User Experience",
		Type = "number"
	},
	Input = {
		Default = false,
		Name = "Input",
		Type = "boolean"
	},
	GP = {
		Default = 50,
		Name = "GP",
		Type = "number"
	},
	NotificationGift = {
		Default = true,
		Name = "Notification Gift",
		Type = "boolean"
	},
	PlayerProfiles = {
		Default = true,
		Name = "Player Profiles",
		Type = "boolean"
	},
	PrimaryPartForPlayerInit = {
		Default = true,
		Name = "Use Primary Part For Player Init",
		Type = "boolean"
	},
	KeybindCreate = {
		Default = true,
		Name = "Keybind: Create",
		Type = "boolean"
	},
	KeybindActivate = {
		Default = true,
		Name = "Keybind: Activate",
		Type = "boolean"
	},
	Tutorial = {
		Default = true,
		Name = "Tutorial",
		Type = "boolean"
	},
	SpinnyWheel = {
		Default = true,
		Name = "Machine: Spinny Wheel",
		Type = "boolean"
	},
	ProductBypassWhitelist = {
		Default = false,
		Name = "Product Bypass Whitelist",
		Type = "boolean",
		Important = true
	},
	DistanceChecksMachines = {
		Default = true,
		Name = "Distance Check Machines",
		Type = "boolean",
		Important = true
	},
	Purchases = {
		Default = true,
		Name = "Purchase Prompts",
		Type = "boolean",
		Important = true
	},
	SFX = {
		Default = true,
		Name = "SFX",
		Type = "boolean",
		Important = true
	},
	InterfaceScaling = {
		Default = true,
		Name = "InterfaceScaling",
		Type = "boolean",
		Important = true
	},
	BlockRepeatSingleProductPurchases = {
		Default = true,
		Name = "Block Repeat Product Purchases",
		Type = "boolean"
	},
	ChatFilters = {
		Default = true,
		Name = "Chat Filters",
		Type = "boolean"
	},
	AntiAFK = {
		Default = true,
		Name = "AntiAFK",
		Type = "boolean",
		Important = true
	},
	AntiAFKServer = {
		Default = true,
		Name = "AntiAFK: Server Tracking",
		Type = "boolean",
		Important = true
	},
	AntiAFKMoveTime = {
		Default = 1155,
		Name = "Anti AFK: Move Seconds",
		Type = "number",
		Min = 0,
		Max = 3600,
		Important = true
	},
	AntiAFKMoveTimeMitchell = {
		Default = 1155,
		Name = "Anti AFK: Move Seconds (Mitchell)",
		Type = "number",
		Min = 0,
		Max = 3600,
		Important = true
	},
	AntiAFKStartServerTimerAt = {
		Default = 15,
		Name = "Anti AFK: Start Server Timer At",
		Type = "number",
		Min = 10,
		Max = 1260,
		Important = true
	},
	Product_Global = {
		Default = true,
		Name = "Products: Global",
		Type = "boolean"
	},
	Gamepass_Global = {
		Default = true,
		Name = "Gamepasses: Global",
		Type = "boolean"
	},
	Trading = {
		Default = true,
		Name = "Trading",
		Type = "boolean",
		Important = true
	},
	PauseMobileBaseCullDuringMurderMysteryRound = {
		Default = false,
		Name = "Pause Mobile Base Cull During Murder Mystery Round",
		Type = "boolean"
	}
}
local count = 1

for k, v in pairs(tbl) do
	assert(if type(k) == "string" then true else false, "Flag name must be a string")
	assert(if type(v) == "table" then true else false, "Flag configuration must be a table")

	local v4 = count + (if v.Important then 1000 else 0)

	count = count + 1

	local v5 = v.Name or k:gsub("[A-Z]", function(p1) --[[ Line: 273 ]]
		return " " .. p1
	end):gsub("^.", string.upper)

	assert(v5, "Display name must be provided or generated")

	local Default = v.Default
	local Type = v.Type

	if not Type then
		assert(Default ~= nil, "Default value must be provided if type is not specified")
		Type = typeof(Default)
	end

	assert(Type, "Flag type must be specified or inferred from default value")

	local Nullable = v.Nullable

	if Nullable == nil then
		Nullable = if Default == nil then true else false
	end

	local v9 = if v.Toggles == nil then false else true
	local Toggles = v.Toggles

	if not Toggles then
		Toggles = {}
		assert(Toggles, "Toggle options must be provided or generated")

		if Type == "boolean" then
			table.insert(Toggles, false)
			table.insert(Toggles, true)
		end
	end

	if not table.find(Toggles, Default) then
		table.insert(Toggles, Default)
	end

	if Nullable and not table.find(Toggles, nil) then
		table.insert(Toggles, nil)
	end

	tbl[k] = table.freeze({
		Order = v4,
		Key = k,
		Name = v5,
		Type = Type,
		Nullable = Nullable,
		Default = Default,
		Toggles = Toggles,
		HasToggles = v9,
		Important = v.Important or false,
		Min = v.Min,
		Max = v.Max
	})
end

table.freeze(tbl)

return tbl