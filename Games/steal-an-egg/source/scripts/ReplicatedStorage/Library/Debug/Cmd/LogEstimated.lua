-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)
local v1 = table.freeze({
	Common = 6,
	Rare = 15,
	Epic = 60,
	Legendary = 360,
	Mythic = 1020,
	BrainrotGod = 5400,
	Secret = 21600
})

local function formatDuration(p1) --[[ formatDuration | Line: 37 ]]
	if p1 >= 3600 then
		local v1 = p1 / 3600

		if v1 >= 48 then
			return string.format("%.2fd", v1 / 24)
		end

		return string.format("%.2fh", v1)
	end

	if p1 >= 120 then
		return string.format("%.2fm", p1 / 60)
	end

	return string.format("%.2fs", p1)
end

local tbl = {}
local sum = 0

for k, v in pairs(Assets.Directory or Assets) do
	local v3
	local DropWeight = v.DropWeight

	if typeof(DropWeight) == "number" and not (DropWeight <= 0) then
		local Rarity = v.Rarity
		local v4 = "Unknown"

		if typeof(Rarity) == "table" then
			local _id = Rarity._id

			if typeof(_id) == "string" and _id ~= "" then
				v4 = _id
			end

			local DisplayName = Rarity.DisplayName

			v3 = if typeof(DisplayName) == "string" and DisplayName ~= "" then DisplayName else v4
		else
			v3 = v4
		end

		local v5 = tbl[v4]

		if not v5 then
			local t = {
				totalWeight = 0,
				id = v4,
				displayName = v3,
				entries = {}
			}

			tbl[v4] = t
			v5 = t
		end

		v5.totalWeight = v5.totalWeight + DropWeight
		table.insert(v5.entries, {
			name = k,
			dropWeight = DropWeight
		})
		sum = sum + DropWeight
	end
end

if sum <= 0 then
	warn("[LogEstimatedTime] No assets with positive DropWeight found.")

	return
end

local list = {}

for k, v in pairs(tbl) do
	table.insert(list, v)
	table.sort(v.entries, function(p1, p2) --[[ Line: 108 ]]
		if p1.dropWeight == p2.dropWeight then
			return p1.name < p2.name
		end

		return p1.dropWeight > p2.dropWeight
	end)
end

table.sort(list, function(p1, p2) --[[ Line: 116 ]]
	if p1.totalWeight == p2.totalWeight then
		return p1.id < p2.id
	end

	return p1.totalWeight > p2.totalWeight
end)
print(string.format("[LogEstimatedTime] total drop weight = %.12f", sum))

for i, v in ipairs(list) do
	local v6
	local v7 = v.totalWeight / sum
	local v8 = 2 / v7
	local v9 = formatDuration(v8)
	local v10 = v1[v.id]

	if typeof(v10) == "number" then
		local v11 = v8 - v10

		v6 = string.format(" (target %.2fs, %s by %s)", v10, if v11 >= 0 then "slower" else "faster", (formatDuration((math.abs(v11)))))
	else
		v6 = ""
	end

	print(string.format("[LogEstimatedTime] Rarity %s: weight=%.12f, probability=%.6f%%%%, expected interval \226\137\136 %s%s", v.displayName, v.totalWeight, v7 * 100, v9, v6))

	for i2, v4 in ipairs(v.entries) do
		local v15 = v4.dropWeight / sum

		print(string.format("    - %s: weight=%.12f, probability=%.6f%%%%, expected interval \226\137\136 %s", v4.name, v4.dropWeight, v15 * 100, formatDuration(2 / v15)))
	end
end

local t = {}

for i, v in ipairs((table.freeze({ "Common", "Rare", "Epic", "Legendary", "Mythic", "BrainrotGod", "Secret" }))) do
	t[v] = i
end

local list2 = {}

for k, v in pairs(tbl) do
	local v17 = t[v.id] or (1 / 0)

	for i, v4 in ipairs(v.entries) do
		table.insert(list2, {
			name = v4.name,
			rarityId = v.id,
			rarityDisplay = v.displayName,
			rank = v17,
			dropWeight = v4.dropWeight
		})
	end
end

table.sort(list2, function(p1, p2) --[[ Line: 188 ]]
	if p1.dropWeight == p2.dropWeight then
		return p1.name < p2.name
	end

	return p1.dropWeight > p2.dropWeight
end)
print("[AllAssetsByRarity] (least rare -> rarest)")

for i, v in ipairs(list2) do
	print(string.format(" - %s  [%s]  weight=%.6f", v.name, v.rarityDisplay, v.dropWeight))
end

return {}