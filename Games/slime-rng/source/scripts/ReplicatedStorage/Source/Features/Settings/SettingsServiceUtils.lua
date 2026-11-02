-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SettingsServiceUtils, time of decompilation: Sun May  3 10:11:54 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataTemplate = require(ReplicatedStorage.Source.Game.Items.DataTemplate)
local Sift = require(ReplicatedStorage.Packages.Sift)
local t1 = {}
local t2 = {
	{
		value = "low",
		label = "Low",
		threshold = 400
	},
	{
		value = "medium",
		label = "Medium",
		threshold = 5000
	},
	{
		value = "high",
		label = "High",
		threshold = 50000
	},
	{
		value = "extreme",
		label = "Extreme",
		threshold = 500000
	},
	{
		value = "off",
		label = "Off",
		threshold = nil
	}
}
local t3 = {}

for _, v8 in t2 do
	t3[v8.value] = v8
end

local function resolveSpecialValue(s1: string, p1) -- line: 40
	-- upvalues: t3 (copy), DataTemplate (copy)
	if s1 == "rareRollCutscenes" then
		if p1 == true then
			return "low"
		end

		if p1 == false then
			return "off"
		end

		if type(p1) == "string" and t3[p1] ~= nil then
			return p1
		end

		return DataTemplate.settings.rareRollCutscenes
	end

	if s1 == "playerWalkSpeed" then
		if type(p1) == "number" then
			return (math.round(p1))
		end

		return DataTemplate.settings.playerWalkSpeed
	end

	if s1 == "enemyLimit" then
		if type(p1) == "number" and p1 == p1 then
			return (math.max(math.floor(p1), 1))
		end

		return DataTemplate.settings.enemyLimit
	end

	if s1 == "luckOverrideValue" then
		if type(p1) == "number" and p1 == p1 then
			return (math.max(math.floor(p1), 1))
		end

		return DataTemplate.settings.luckOverrideValue
	end

	return p1
end

function t1.convertPathToSettingPath(p2) -- line: 78
	-- upvalues: Sift (copy)
	if type(p2) == "string" then
		return {
			"settings",
			p2
		}
	end

	if p2[1] == "settings" then
		return p2
	end

	return Sift.Array.insert(p2, 1, "settings")
end
function t1.getSafeSettingPath(p3) -- line: 88
	-- upvalues: DataTemplate (copy)
	local v14 = nil

	if type(p3) == "string" then
		v14 = p3
	elseif type(p3) == "table" then
		if #p3 == 1 then
			v14 = p3[1]
		elseif #p3 == 2 and p3[1] == "settings" then
			v14 = p3[2]
		end
	end

	if type(v14) ~= "string" or DataTemplate.settings[v14] == nil then
		return nil
	end

	return {
		"settings",
		v14
	}
end
function t1.getSettingKey(p4) -- line: 107
	if type(p4) == "string" then
		return p4
	end

	return p4[#p4]
end
function t1.getDefaultValue(p5) -- line: 115
	-- upvalues: DataTemplate (copy), t1 (copy)
	return DataTemplate.settings[t1.getSettingKey(p5)]
end
function t1.getRareRollCutsceneOptions() -- line: 119
	-- upvalues: t2 (copy)
	return table.clone(t2)
end
function t1.isValidRareRollCutsceneValue(p6) -- line: 123
	-- upvalues: t3 (copy)
	return type(p6) == "string" and t3[p6] ~= nil
end
function t1.getRareRollCutsceneThreshold(p7) -- line: 127
	-- upvalues: t3 (copy), DataTemplate (copy)
	local v19 = t3[if p7 ~= true then if p7 ~= false then if type(p7) ~= "string" or t3[p7] == nil then DataTemplate.settings.rareRollCutscenes else p7 else "off" else "low"]

	if v19 then
		return v19.threshold
	end

	return nil
end
function t1.isPositiveInteger(p8) -- line: 133
	return type(p8) == "number" and (p8 == p8 and (p8 > -1e999 and (p8 < 1e999 and (p8 == math.floor(p8) and p8 >= 1))))
end
function t1.resolveValue(p9, p10) -- line: 142
	-- upvalues: t1 (copy), resolveSpecialValue (copy)
	local v23 = t1.getSettingKey(p9)
	local v24 = resolveSpecialValue(v23, p10)

	if v24 ~= nil then
		return v24
	end

	if p10 ~= nil then
		return p10
	end

	return t1.getDefaultValue(p9)
end

return t1
