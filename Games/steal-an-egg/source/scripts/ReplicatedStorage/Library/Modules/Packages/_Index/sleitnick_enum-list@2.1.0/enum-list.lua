-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Types = require(script.Private.Types)
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)
local v1 = Random.new()
local v2 = newproxy()
local v3 = newproxy()
local v4 = newproxy()

local function CreateEnumItem(p1, p2, p3, p4, p5) --[[ CreateEnumItem | Line: 28 ]]
	return table.freeze({
		Name = p1,
		Value = p2,
		Position = p3,
		EnumType = p5,
		Id = p4
	})
end

local t = {}

t.__index = t
t.__types = Types
function t.new(p1, p2) --[[ new | Line: 65 | Upvalues: Types (copy), v2 (copy), v3 (copy), v4 (copy), TableUtil (copy), t (copy) ]]
	assert(Types._basicParams(p1, p2))

	local t2 = {
		[v2] = {},
		[v3] = p1,
		[v4] = TableUtil.Copy(p2, true)
	}

	for k, v in pairs(p2) do
		assert(Types._currentEnum(v, k))

		local v1 = if typeof(v) == "table" then true else false
		local v22 = if v1 then v.Name or k else v
		local v32 = v1 and v.Position or k
		local v6 = table.freeze({
			Name = v22,
			Value = v1 and v.Value or v,
			Position = v32,
			EnumType = t2,
			Id = v1 and v.Id or nil
		})

		t2[v22] = v6
		table.insert(t2[v2], v32, v6)
	end

	return table.freeze((setmetatable(t2, t)))
end
function t.buildFrom(p1, p2, p3) --[[ buildFrom | Line: 102 | Upvalues: t (copy), Types (copy), TableUtil (copy) ]]
	assert(t.is(p1), "EnumList is not a valid EnumList object.")
	assert(Types._cloneParams(p2, p3))

	local v2 = p1:GetEnumNames()
	local v3 = p3 and TableUtil.Reconcile(v2, p3) or v2

	return t.new(if p2 then p2 else p1:GetName(), v3)
end
function t.is(p1) --[[ is | Line: 117 | Upvalues: t (copy) ]]
	if typeof(p1) ~= "table" then
		return false
	end

	return getmetatable(p1) == t
end
function t.isItem(p1) --[[ isItem | Line: 129 | Upvalues: Types (copy) ]]
	if typeof(p1) == "table" then
		return Types.EnumItem(p1)
	end

	return false, "Invalid type"
end
function t.BelongsTo(p1, p2) --[[ BelongsTo | Line: 142 ]]
	if if type(p2) == "table" then if p2.EnumType == p1 then true else false else false then
		return true
	end

	return false, ("%* does not belong to enum-list \"%*\""):format(p2, (p1:GetName()))
end
function t.Exists(p1, p2) --[[ Exists | Line: 156 ]]
	return if p2 == nil then false else p1[p2]
end
function t.GetEnumItemFromPosition(p1, p2) --[[ GetEnumItemFromPosition | Line: 164 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	return p1:GetEnumItems()[p2]
end
function t.GetStartingFromPosition(p1, p2) --[[ GetStartingFromPosition | Line: 173 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	if p2 == 0 then
		return {}
	end

	local v1 = p1:GetEnumItems()

	assert(if p2 > 0 then if p2 <= #v1 then true else false else false, "Position must be positive and within the available enums")

	return table.move(v1, p2, #v1, 1, {})
end
function t.RollIfPossible(p1, p2) --[[ RollIfPossible | Line: 190 | Upvalues: Asserts (copy), v1 (copy) ]]
	local v2 = assert(p1:Exists(p2), "Invalid enum name. Not valid member of EnumList.")

	Asserts.table(v2.Value)

	return v2.Value[v1:NextInteger(1, #v2.Value)]
end
function t.Compare(p1, p2, p3) --[[ Compare | Line: 199 ]]
	local v2 = assert(p1[p2], "First argument is not a member of this EnumList")

	return v2.Position - assert(p1[p3], "Second argument is not a member of this EnumList").Position
end
function t.UnitCompare(p1, p2, p3) --[[ UnitCompare | Line: 207 ]]
	return math.clamp(p1:Compare(p2, p3), -1, 1)
end
function t.Equal(p1, p2, p3) --[[ Equal | Line: 217 ]]
	return p1:Compare(p2, p3) == 0
end
function t.IsLessThan(p1, p2, p3) --[[ IsLessThan | Line: 226 ]]
	return p1:Compare(p2, p3) < 0
end
function t.IsGreaterThan(p1, p2, p3) --[[ IsGreaterThan | Line: 235 ]]
	return p1:Compare(p2, p3) > 0
end
function t.GetEnumItems(p1) --[[ GetEnumItems | Line: 244 | Upvalues: v2 (copy) ]]
	return p1[v2]
end
function t.GetEnumNames(p1) --[[ GetEnumNames | Line: 253 | Upvalues: v4 (copy) ]]
	return p1[v4]
end
function t.GetName(p1) --[[ GetName | Line: 262 | Upvalues: v3 (copy) ]]
	return p1[v3]
end

return t