-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local v1 = require(ReplicatedStorage.Library.Modules.Mutations).GetMutationsMap()
local t = {}

local function hasMutation(p1, p2) --[[ hasMutation | Line: 20 ]]
	return if p1.BaseMutation == p2 then true else table.find(p1.Mutations, p2) ~= nil
end

function t.GetMultiplier(p1) --[[ GetMultiplier | Line: 28 | Upvalues: AssetItem (copy), v1 (copy) ]]
	assert(AssetItem.AssetItemData(p1), "Invalid asset item data")

	local Rainbow = v1.Rainbow

	if if p1.BaseMutation == Rainbow then true elseif table.find(p1.Mutations, Rainbow) == nil then false else true then
		return 2
	end

	local Golden = v1.Golden

	if if p1.BaseMutation == Golden then true elseif table.find(p1.Mutations, Golden) == nil then false else true then
		return 0.5
	end

	local Silver = v1.Silver

	if if p1.BaseMutation == Silver then true else table.find(p1.Mutations, Silver) ~= nil then
		return 0.7
	end

	return 1
end

return t