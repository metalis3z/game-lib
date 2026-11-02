-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Registries.BaseSkinRegistry)
require(v1.Registries.BrainrotRegistry)
require(v1.Registries.MutationRegistry)
require(v1.Types.ItemSchemas)
local v2 = {
	["Cash"] = 0,
	["Rebirths"] = 0,
	["SessionCount"] = 1,
	["BackpackBrainrots"] = {},
	["Brainrots"] = {},
	["FuseBrainrots"] = {},
	["Index"] = {
		["Normal"] = {},
		["Diamond"] = {},
		["Bloodmoon"] = {},
		["Gold"] = {},
		["Rainbow"] = {},
		["Emerald"] = {}
	},
	["LastSaveTime"] = nil,
	["LeaveTime"] = 0,
	["OtherData"] = {
		["Favorited"] = false,
		["FuseTime"] = 0,
		["Fusing"] = false,
		["GroupReward"] = false,
		["ObbyBrainrot"] = false,
		["StarterPack"] = false,
		["TutorialDone"] = false
	},
	["Upgrades"] = {
		["Base"] = 0,
		["Carry"] = 1,
		["Jump"] = 0,
		["Speed"] = 0
	},
	["PlayerFlags"] = {},
	["Inventory"] = {
		["Entries"] = {}
	},
	["PlotBrainrots"] = {},
	["FuseMachine"] = {
		["FuseLuckEndTime"] = 0,
		["LuckAppliedToFuse"] = false,
		["StartedFuse"] = 0,
		["Fusing"] = false,
		["Result"] = nil,
		["ResultMetadata"] = {},
		["Entries"] = {}
	},
	["EquippedBaseSkin"] = "Default",
	["BaseSkins"] = {
		["Default"] = true
	},
	["ImpersonationData"] = {
		["TargetUserId"] = nil,
		["Verified"] = false
	}
}
return table.freeze(v2)
