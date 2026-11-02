-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SettingsState, time of decompilation: Sun May  3 10:11:55 2026 ]]
local DataTemplate = require(game:GetService("ReplicatedStorage").Source.Game.Items.DataTemplate)
local SettingsServiceClient = require(script.Parent.SettingsServiceClient)
local SettingsServiceUtils = require(script.Parent.SettingsServiceUtils)
local t1 = {}
local v5 = table.clone(DataTemplate.settings)
local u6 = false

function t1.init() -- line: 9
	-- upvalues: u6 (ref), v5 (copy), SettingsServiceClient (copy), SettingsServiceUtils (copy)
	if u6 then
		return
	end

	u6 = true

	for v7 in v5 do
		SettingsServiceClient:subscribe(v7, function(p1) -- line: 17
			-- upvalues: v5 (copy), v7 (copy), SettingsServiceUtils (copy)
			v5[v7] = SettingsServiceUtils.resolveValue(v7, p1)
		end)
	end
end
function t1.get(p2) -- line: 23
	-- upvalues: SettingsServiceUtils (copy), v5 (copy)
	local v9 = SettingsServiceUtils.getSettingKey(p2)

	return SettingsServiceUtils.resolveValue(p2, v5[v9])
end

return t1
