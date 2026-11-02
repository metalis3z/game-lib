-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeepCopyUnsafe = require(ReplicatedStorage.Library.Functions.DeepCopyUnsafe)
local AbstractItem = require(script.Parent.AbstractItem)
local t = {
	Types = {
		Currency = require(script.Parent.CurrencyItem),
		Gear = require(script.Parent.GearItem),
		Brainrot = require(script.Parent.BrainrotItem),
		SpeedPower = require(script.Parent.SpeedPowerItem)
	}
}

function t.TypeUnchecked(p1) --[[ TypeUnchecked | Line: 28 | Upvalues: t (copy) ]]
	return t.Types[p1]
end
function t.Type(p1) --[[ Type | Line: 32 | Upvalues: t (copy) ]]
	local v1 = t.Types[p1]

	assert(v1, (("Item type \'%*\' does not exist in ItemTypes.Types"):format(p1)))

	return v1
end
function t.AssertTypeName(p1) --[[ AssertTypeName | Line: 38 | Upvalues: t (copy) ]]
	assert(type(p1) == "string", (("Expected typeName to be a string, got %*"):format((type(p1)))))
	assert(t.Types[p1], (("Item type \'%*\' does not exist in ItemTypes.Types"):format(p1)))

	return nil
end
function t.FromModule(p1, p2) --[[ FromModule | Line: 44 ]]
	return p1:From(p2)
end
function t.From(p1, p2) --[[ From | Line: 48 | Upvalues: t (copy) ]]
	return t.Type(p1):From(p2)
end
function t.DecodeNetwork(p1) --[[ DecodeNetwork | Line: 52 | Upvalues: t (copy) ]]
	return t.From(p1.class, p1.data):SetUID(p1.uid)
end
function t.DecodeNetworkCloned(p1) --[[ DecodeNetworkCloned | Line: 56 | Upvalues: t (copy), DeepCopyUnsafe (copy) ]]
	return t.From(p1.class, DeepCopyUnsafe(p1.data)):SetUID(p1.uid)
end
function t.DecodeUnpacked(p1) --[[ DecodeUnpacked | Line: 60 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs(p1) do
		local v1 = t.TypeUnchecked(k)

		if v1 then
			for k2, v2 in pairs(v) do
				table.insert(t2, (v1:From(v2):SetUID(k2)))
			end
		end
	end

	return t2
end
function t.EncodePacked(p1) --[[ EncodePacked | Line: 75 | Upvalues: AbstractItem (copy) ]]
	local t = {}

	for i, v in ipairs(p1) do
		local v1 = v.Class.Name
		local v2 = t[v1]

		if not v2 then
			v2 = {}
			t[v1] = v2
		end

		local v3 = v:GetOptionalUID() or AbstractItem.GenerateUID()

		assert(not v2[v3], (("Duplicate UID found for item of type \'%*\': %*"):format(v1, v3)))
		v2[v3] = v:GetData()
	end

	return t
end
function t.Pack(p1) --[[ Pack | Line: 91 | Upvalues: AbstractItem (copy) ]]
	local t = {}

	for i, v in ipairs(p1) do
		local v1 = v.Class.Name
		local v2 = t[v1]

		if not v2 then
			v2 = {}
			t[v1] = v2
		end

		local v3 = v:GetOptionalUID() or AbstractItem.GenerateUID()

		assert(not v2[v3], (("Duplicate UID found for item of type \'%*\': %*"):format(v1, v3)))
		v2[v3] = v
	end

	return t
end
function t.Unpack(p1) --[[ Unpack | Line: 107 ]]
	local t = {}

	for k, v in pairs(p1) do
		for k2, v2 in pairs(v) do
			table.insert(t, v2)
		end
	end

	return t
end
t.AssertUniqueItems = AbstractItem.AssertUniqueItems

return t