-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local Interface = require(script.Types.Interface)
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "TreadmillsDir",
	rootName = "Treadmills.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})
local list = {}
local t2 = {}
local t3 = {}

for k, v in pairs(v1) do
	table.insert(list, v)
end

table.sort(list, function(p1, p2) --[[ Line: 33 ]]
	return p1.Price < p2.Price
end)

for i, v in ipairs(list) do
	t2[v._id] = i
end

table.freeze(list)
table.freeze(t2)
t3.Directory = v1
t3.Types = Interface

if Constants.IS_STUDIO then
	for k, v in pairs(script._Index:GetChildren()) do
		local v2 = v:IsA("ModuleScript")

		assert(v2, (("Bad treadmill config instance: %*"):format(v.Name)))

		local v4 = v1[v.Name]
		local v5, v6 = Interface.DefaultConfig(v4)

		assert(v5, (("Failed to validate treadmill config %*: %*"):format(v.Name, v6)))

		if Constants.IS_SERVER then
			local v8 = ReplicatedStorage.Assets.Models.Treadmills[v4._id]

			assert(v8 ~= nil, (("Treadmill model not found for config %*"):format(v.Name)))
			assert(if v8.BoundingBoxPart == nil then false else true, (("Treadmill model for config %* is missing a BoundingBoxPart"):format(v.Name)))
		end
	end
end

MakeTableStrict(v1, "Treadmills")

local function TreadmillNameExists(p1) --[[ TreadmillNameExists | Line: 70 | Upvalues: v1 (copy) ]]
	if pcall(function() --[[ Line: 71 | Upvalues: v1 (ref), p1 (copy) ]]
		return v1[p1]
	end) then
		return true
	end

	return false, ("Treadmill name \"%*\" does not exist in the Treadmills directory."):format(p1)
end

t3.Types.TreadmillNameExists = TreadmillNameExists
function t3.GetOrdered() --[[ GetOrdered | Line: 82 | Upvalues: list (copy) ]]
	return table.clone(list)
end
function t3.GetByUpgradeLevel(p1) --[[ GetByUpgradeLevel | Line: 86 | Upvalues: list (copy) ]]
	return list[p1]
end
function t3.GetUpgradeLevel(p1) --[[ GetUpgradeLevel | Line: 90 | Upvalues: t2 (copy) ]]
	return t2[p1]
end

return t3