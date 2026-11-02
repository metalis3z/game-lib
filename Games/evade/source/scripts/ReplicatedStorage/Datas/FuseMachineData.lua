-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Net)
local v3 = {
	["FuseSlots"] = 4,
	["FuseTime"] = {
		["Common"] = 900,
		["Rare"] = 900,
		["Epic"] = 900,
		["Legendary"] = 1800,
		["Mythic"] = 1800,
		["Brainrot God"] = 1800,
		["Secret"] = 5400
	},
	["LuckMultipliers"] = { 1, 4 },
	["RevealNowProductId"] = 3354160217,
	["FuseLuckProductId"] = 3483927303,
	["FFlagDefaults"] = {
		["FuseMachine/Disabled"] = false,
		["FuseMachine/CanStealBrainrot"] = true,
		["FuseMachine/CostMultiplier"] = 1.25
	},
	["Remotes"] = {
		["RemoveBrainrot"] = v2:RemoteFunction("FuseMachine/RemoveBrainrot"),
		["ClaimBrainrot"] = v2:RemoteFunction("FuseMachine/ClaimBrainrot"),
		["ConfirmFusion"] = v2:RemoteFunction("FuseMachine/ConfirmFusion"),
		["Delivery"] = v2:RemoteFunction("FuseMachine/Delivery"),
		["RevealNow"] = v2:RemoteEvent("FuseMachine/RevealNow"),
		["FuseAnimation"] = v2:RemoteEvent("FuseMachine/FuseAnimation"),
		["ForceUpdate"] = v2:RemoteEvent("FuseMachine/ForceUpdate")
	}
}
return v3