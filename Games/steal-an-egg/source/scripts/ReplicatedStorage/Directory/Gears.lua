-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local SearchGearToolUtil = require(ReplicatedStorage.Library.Util.SearchGearToolUtil)
local t = {}
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "GearsDir",
	rootName = "Gears.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

t.Directory = v1
t.Types = Interface
function t.Types.GearNameExists(p1) --[[ Line: 33 | Upvalues: v1 (copy) ]]
	if pcall(function() --[[ Line: 34 | Upvalues: v1 (ref), p1 (copy) ]]
		return v1[p1]
	end) then
		return true
	end

	return false, ("Gears name \"%*\" does not exist in the Gears directory."):format(p1)
end

if Constants.IS_STUDIO then
	for k, v in pairs(script._Index:GetDescendants()) do
		if v:IsA("ModuleScript") then
			local v2 = v1[v.Name]
			local v3, v4 = Interface.DefaultConfig(v2)

			assert(v3, (("Failed to validate config %*: %*"):format(v.Name, v4)))

			local v6 = if v2.MaxShopStockQuantity >= v2.MinShopStockQuantity then true else false

			assert(v6, (("Config %* has MaxShopStockQuantity %* < MinShopStockQuantity %*"):format(v.Name, v2.MaxShopStockQuantity, v2.MinShopStockQuantity)))

			local v8 = v2.ToolModel or v.Name
			local v9 = SearchGearToolUtil(v8)

			assert(v9, (("Missing GearModel %* for %* in ReplicatedStorage.GearTools"):format(v8, v.Name)))
		end
	end
end

MakeTableStrict(v1, "Gears")

return t