-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

require(ReplicatedStorage.Library.Types.AssetItem)

local RarityNumber = Rarity.Rarities.Secret.RarityNumber
local t = {
	CFrame.new(-17.4227905, 1.14494324, -23.6600342),
	CFrame.new(-13.1647339, 1.14494324, -28.0780945),
	CFrame.new(-7.01275635, 1.14494324, -31.1100464),
	CFrame.new(7.54925537, 1.79094315, -31.1380615),
	CFrame.new(13.3172607, 1.14494324, -28.1280518),
	CFrame.new(17.959259, 1.14494324, -24.9380493)
}
local t2 = {}

local function hasDropTable(p1) --[[ hasDropTable | Line: 41 | Upvalues: Assets (copy) ]]
	local v1 = Assets.Directory[p1]
	local v2 = if v1 then v1.LuckyBlockDropTable or nil else nil

	return if typeof(v2) == "table" then #v2 > 0 else false
end

local function getProgressGoalForRarityNumber(p1) --[[ getProgressGoalForRarityNumber | Line: 47 | Upvalues: RarityNumber (copy) ]]
	if p1 < RarityNumber then
		return 1
	end

	if p1 == RarityNumber then
		return 2
	end

	return 3
end

local function getCapturedAt(p1, p2) --[[ getCapturedAt | Line: 59 ]]
	local SpecialLuckyBlockCapturedAt = p2.SpecialLuckyBlockCapturedAt

	if typeof(SpecialLuckyBlockCapturedAt) == "number" then
		return SpecialLuckyBlockCapturedAt
	end

	return string.byte(p1, 1) or 0
end

function t2.IsCategory(p1) --[[ IsCategory | Line: 69 | Upvalues: Assets (copy) ]]
	local v1 = Assets.Directory[p1]
	local v2 = if v1 then v1.LuckyBlockDropTable or nil else nil

	return if typeof(v2) == "table" then #v2 > 0 else false
end
function t2.IsItemData(p1) --[[ IsItemData | Line: 73 | Upvalues: Assets (copy) ]]
	local v1 = Assets.Directory[p1.Category]
	local v2 = if v1 then v1.LuckyBlockDropTable or nil else nil

	return if typeof(v2) == "table" then #v2 > 0 else false
end
function t2.GetProgressGoalForCategory(p1) --[[ GetProgressGoalForCategory | Line: 77 | Upvalues: Assets (copy), RarityNumber (copy) ]]
	local Rarity = Assets.Directory[p1].Rarity
	local v1 = if Rarity then Rarity.RarityNumber else Rarity

	assert(if typeof(v1) == "number" then true else false, (("Missing rarity number for special lucky block asset \"%*\""):format(p1)))

	if v1 < RarityNumber then
		return 1
	end

	if v1 == RarityNumber then
		return 2
	end

	return 3
end
function t2.GetProgressGoalForItemData(p1) --[[ GetProgressGoalForItemData | Line: 86 | Upvalues: t2 (copy) ]]
	return t2.GetProgressGoalForCategory(p1.Category)
end
function t2.GetMaxCount() --[[ GetMaxCount | Line: 90 ]]
	return 36
end
function t2.CountInventory(p1) --[[ CountInventory | Line: 94 | Upvalues: t2 (copy) ]]
	local count = 0

	for k, v in pairs(p1) do
		if t2.IsItemData(v) then
			count = count + 1
		end
	end

	return count
end
function t2.FindAvailableColumn(p1, p2) --[[ FindAvailableColumn | Line: 106 | Upvalues: t2 (copy) ]]
	local t = {}

	for k, v in pairs(p1) do
		if k ~= p2 and t2.IsItemData(v) then
			local SpecialLuckyBlockColumn = v.SpecialLuckyBlockColumn

			if typeof(SpecialLuckyBlockColumn) == "number" and (SpecialLuckyBlockColumn >= 1 and SpecialLuckyBlockColumn <= 6) then
				t[SpecialLuckyBlockColumn] = (t[SpecialLuckyBlockColumn] or 0) + 1
			end
		end
	end

	local v1 = (1 / 0)
	local v2 = nil

	for i = 1, 6 do
		local v3 = t[i] or 0

		if v3 < 6 and v3 < v1 then
			v1 = v3
			v2 = i
		end
	end

	return v2
end
function t2.GetLayout(p1, p2) --[[ GetLayout | Line: 136 | Upvalues: t2 (copy), t (copy) ]]
	local t3 = {}

	for k, v in pairs(p1) do
		if t2.IsItemData(v) then
			local SpecialLuckyBlockColumn = v.SpecialLuckyBlockColumn

			if typeof(SpecialLuckyBlockColumn) == "number" and not (SpecialLuckyBlockColumn < 1 or SpecialLuckyBlockColumn > 6) then
				local v1 = t3[SpecialLuckyBlockColumn]

				if not v1 then
					v1 = {}
					t3[SpecialLuckyBlockColumn] = v1
				end

				v1[#v1 + 1] = {
					uid = k,
					data = v
				}
			end
		end
	end

	local t4 = {}

	for i = 1, 6 do
		local v2 = t3[i]

		if v2 then
			table.sort(v2, function(p1, p2) --[[ Line: 171 ]]
				local SpecialLuckyBlockCapturedAt = p1.data.SpecialLuckyBlockCapturedAt
				local v1 = if typeof(SpecialLuckyBlockCapturedAt) == "number" then SpecialLuckyBlockCapturedAt else string.byte(p1.uid, 1) or 0
				local SpecialLuckyBlockCapturedAt2 = p2.data.SpecialLuckyBlockCapturedAt
				local v2 = if typeof(SpecialLuckyBlockCapturedAt2) == "number" then SpecialLuckyBlockCapturedAt2 else string.byte(p2.uid, 1) or 0

				if v1 == v2 then
					return p1.uid < p2.uid
				end

				return v1 < v2
			end)

			for i2, v in ipairs(v2) do
				if i2 > 6 then
					break
				end

				t4[#t4 + 1] = {
					uid = v.uid,
					data = v.data,
					column = i,
					row = i2,
					cframe = p2 * t[i] + Vector3.new(0, 1, 0) * ((i2 - 1) * 6)
				}
			end
		end
	end

	return t4
end

return t2