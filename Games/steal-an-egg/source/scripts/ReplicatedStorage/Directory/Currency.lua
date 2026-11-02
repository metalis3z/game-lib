-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local t = {}
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "CurrencyDir",
	rootName = "Currency.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

t.Directory = v1
t.Types = Interface
function t.Types.CurrencyNameExists(p1) --[[ Line: 33 | Upvalues: v1 (copy) ]]
	if pcall(function() --[[ Line: 34 | Upvalues: v1 (ref), p1 (copy) ]]
		return v1[p1]
	end) then
		return true
	end

	return false, ("Currency name \"%*\" does not exist in the Currency directory."):format(p1)
end

if Constants.IS_STUDIO then
	for k, v in pairs(script._Index:GetChildren()) do
		local v2 = v:IsA("ModuleScript")

		assert(v2, (("Bad instance found inside the configs env: %*"):format(v.Name)))

		local v5, v6 = Interface.DefaultConfig(v1[v.Name])

		assert(v5, (("Failed to validate config %*: %*"):format(v.Name, v6)))
	end
end

MakeTableStrict(v1, "Currency")

return t