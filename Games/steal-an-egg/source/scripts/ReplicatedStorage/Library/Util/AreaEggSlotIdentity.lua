-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}

local function getNestPosition(p1) --[[ getNestPosition | Line: 36 ]]
	local EggSpotBottom = p1.EggSpotBottom
	local v1 = EggSpotBottom:IsA("BasePart")

	assert(v1, (("%*.EggSpotBottom must be a BasePart"):format((p1:GetFullName()))))

	return EggSpotBottom.Position
end

local function quantize(p1) --[[ quantize | Line: 42 ]]
	return math.round(p1 * 1000)
end

local function getSlotId(p1) --[[ getSlotId | Line: 46 ]]
	return string.format("Slot_%03d", p1)
end

function t.GetSortedNests(p1) --[[ GetSortedNests | Line: 54 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p1)

	local Nests = p1.Nests
	local v1 = Nests:IsA("Folder") or Nests:IsA("Model")

	assert(v1, (("%*.Nests must be a Folder or Model"):format((p1:GetFullName()))))

	local list = {}

	for i, v in ipairs(Nests:GetChildren()) do
		if v:IsA("Model") then
			local EggSpotBottom = v.EggSpotBottom

			assert(EggSpotBottom:IsA("BasePart"), (("%*.EggSpotBottom must be a BasePart"):format((v:GetFullName()))))

			local Position = EggSpotBottom.Position
			local t = {
				Nest = v
			}

			t.X = math.round(Position.X * 1000)
			t.Y = math.round(Position.Y * 1000)
			t.Z = math.round(Position.Z * 1000)
			t.Name = v.Name
			table.insert(list, t)
		end
	end

	table.sort(list, function(p1, p2) --[[ Line: 74 ]]
		if p1.X == p2.X then
			if p1.Z == p2.Z then
				if p1.Y == p2.Y then
					return p1.Name < p2.Name
				end

				return p1.Y < p2.Y
			end

			return p1.Z < p2.Z
		end

		return p1.X < p2.X
	end)

	local t = {}

	for i, v in ipairs(list) do
		table.insert(t, v.Nest)
	end

	return t
end
function t.GetNestId(p1, p2) --[[ GetNestId | Line: 94 | Upvalues: Asserts (copy), t (copy), getSlotId (copy) ]]
	Asserts.Model(p1)
	Asserts.Model(p2)

	for i, v in ipairs(t.GetSortedNests(p1)) do
		if v == p2 then
			return getSlotId(i)
		end
	end

	error((("Nest %* is not inside %*.Nests"):format(p2:GetFullName(), (p1:GetFullName()))))
end
function t.BuildSlotKey(p1, p2) --[[ BuildSlotKey | Line: 107 | Upvalues: Asserts (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)

	return ("%*:%*"):format(p1, p2)
end
function t.IsFirstAreaUid(p1) --[[ IsFirstAreaUid | Line: 114 | Upvalues: Asserts (copy) ]]
	Asserts.string(p1)

	return string.find(p1, "FirstAreaEgg_", 1, true) == 1
end
function t.GetFirstAreaOwnerUserId(p1) --[[ GetFirstAreaOwnerUserId | Line: 119 | Upvalues: Asserts (copy) ]]
	Asserts.string(p1)

	local v1 = string.match(p1, "^FirstAreaEgg_(-?%d+)_")

	if v1 == nil then
		return nil
	end

	return tonumber(v1)
end
function t.ResolveNest(p1, p2) --[[ ResolveNest | Line: 128 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p1)
	Asserts.string(p2)

	local v1 = string.match(p2, "^Slot_(%d+)$")

	assert(v1 ~= nil, (("Invalid area egg nest id %*"):format(p2)))

	local v4 = tonumber(v1)

	assert(if v4 == nil then false else true, (("Invalid area egg nest index %*"):format(p2)))

	local v7 = t.GetSortedNests(p1)[v4]

	assert(v7 ~= nil, (("Missing area egg nest %*.%*"):format(p1.Name, p2)))

	return v7
end

return table.freeze(t)