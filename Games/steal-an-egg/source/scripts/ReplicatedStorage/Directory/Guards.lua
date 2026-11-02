-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local Interface = require(script.Types.Interface)
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "GuardsDir",
	rootName = "Guards.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})
local v2 = (1 / 0)
local v3 = 0
local t2 = {}

for k, v in pairs(v1) do
	v2 = math.min(v2, v.WalkSpeed)
	v3 = math.max(v3, v.WalkSpeed)
end

t2.Directory = v1
t2.Types = Interface

if Constants.IS_STUDIO then
	for k, v in pairs(script._Index:GetChildren()) do
		local v4 = v:IsA("ModuleScript")

		assert(v4, (("Bad instance found inside the guard configs env: %*"):format(v.Name)))

		local v7, v8 = Interface.DefaultConfig(v1[v.Name])

		assert(v7, (("Failed to validate guard config %*: %*"):format(v.Name, v8)))
	end
end

MakeTableStrict(v1, "Guards")

local function GuardNameExists(p1) --[[ GuardNameExists | Line: 54 | Upvalues: v1 (copy) ]]
	if pcall(function() --[[ Line: 55 | Upvalues: v1 (ref), p1 (copy) ]]
		return v1[p1]
	end) then
		return true
	end

	return false, ("Guard name \"%*\" does not exist in the Guards directory."):format(p1)
end

t2.Types.GuardNameExists = GuardNameExists
function t2.GetLowestWalkSpeed() --[[ GetLowestWalkSpeed | Line: 66 | Upvalues: v2 (ref) ]]
	if v2 == (1 / 0) then
		return 0
	end

	return v2
end
function t2.GetHighestWalkSpeed() --[[ GetHighestWalkSpeed | Line: 74 | Upvalues: v3 (ref), v2 (ref) ]]
	return math.max(v3, (math.max(v2, 1)))
end

return t2