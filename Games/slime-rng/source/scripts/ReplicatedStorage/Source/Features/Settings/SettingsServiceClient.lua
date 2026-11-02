-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SettingsServiceClient, time of decompilation: Sun May  3 10:11:54 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local client = require(ReplicatedStorage.Packages.DataService).client
local SettingsServiceUtils = require(script.Parent.SettingsServiceUtils)
local Networker = require(ReplicatedStorage.Packages.Networker)
local convertPathToSettingPath = SettingsServiceUtils.convertPathToSettingPath

return {
	init = function(p1) --[[ init ]] -- line: 11
		-- upvalues: Networker (copy)
		if p1.networker then
			return
		end

		p1.networker = Networker.client.new("SettingsService", p1)
	end,
	set = function(p2, p3, p4) --[[ set ]] -- line: 19
		-- upvalues: client (copy), convertPathToSettingPath (copy), RunService (copy)
		client:set(convertPathToSettingPath(p3), p4)

		if RunService:IsRunning() then
			p2.networker:fire("set", p3, p4)
		end
	end,
	get = function(_, p6) --[[ get ]] -- line: 26
		-- upvalues: SettingsServiceUtils (copy), client (copy), convertPathToSettingPath (copy)
		return SettingsServiceUtils.resolveValue(p6, client:get(convertPathToSettingPath(p6)))
	end,
	subscribe = function(_: {[any]: any}, p7, p8: ((...any) -> ...any)) --[[ subscribe ]] -- line: 30
		-- upvalues: SettingsServiceUtils (copy), client (copy), convertPathToSettingPath (copy)
		p8(SettingsServiceUtils.resolveValue(p7, client:get(convertPathToSettingPath(p7))))
		client:getChangedSignal(convertPathToSettingPath(p7)):Connect(function(p9) -- line: 32
			-- upvalues: p8 (copy), SettingsServiceUtils (copy), p7 (copy)
			p8(SettingsServiceUtils.resolveValue(p7, p9))
		end)
	end
}
