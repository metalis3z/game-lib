-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local Interface = require(script.Types.Interface)
local t2 = {}
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "TrailsDir",
	rootName = "Trails.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

t2.Directory = v1
t2.Types = Interface

if Constants.IS_STUDIO then
	local Trails = ReplicatedStorage.Assets.Trails

	for k, v in pairs(script._Index:GetChildren()) do
		assert(v:IsA("ModuleScript"), (("Bad trail config instance: %*"):format(v.Name)))

		local v4 = v1[v.Name]
		local v5, v6 = Interface.DefaultConfig(v4)

		assert(v5, (("Failed to validate trail config %*: %*"):format(v.Name, v6)))

		local v8 = Trails:FindFirstChild(v4._id)

		assert(v8 ~= nil, (("Trail asset not found for config %*"):format(v.Name)))
		assert(v8:IsA("BasePart"), (("Trail asset for config %* must be a BasePart"):format(v.Name)))

		local MainPartTrailWeldConstraint = v8:FindFirstChild("MainPartTrailWeldConstraint")

		assert(if MainPartTrailWeldConstraint == nil then false else true, (("Trail asset for config %* is missing MainPartTrailWeldConstraint"):format(v.Name)))
		assert(MainPartTrailWeldConstraint:IsA("WeldConstraint"), (("Trail asset for config %* MainPartTrailWeldConstraint must be a WeldConstraint"):format(v.Name)))
	end
end

MakeTableStrict(v1, "Trails")

local function TrailNameExists(p1) --[[ TrailNameExists | Line: 56 | Upvalues: v1 (copy) ]]
	if pcall(function() --[[ Line: 57 | Upvalues: v1 (ref), p1 (copy) ]]
		return v1[p1]
	end) then
		return true
	end

	return false, ("Trail name \"%*\" does not exist in the Trails directory."):format(p1)
end

t2.Types.TrailNameExists = TrailNameExists

return t2