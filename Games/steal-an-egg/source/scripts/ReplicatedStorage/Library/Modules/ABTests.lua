-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local GameAnalytics = require(ReplicatedStorage.Library.Modules.Packages.GameAnalytics)
local ABTestExperiments = require(ReplicatedStorage.Directory.ABTestExperiments)
local LocalPlayer = Players.LocalPlayer
local t = {
	_loaded = false,
	_loadedSignal = Signal.new(),
	_remoteConfigs = {},
	_runExperiments = function(p1) --[[ _runExperiments | Line: 27 | Upvalues: ABTestExperiments (copy), LocalPlayer (copy) ]]
		if not p1._remoteConfigs then
			return
		end

		for v1, v2 in ABTestExperiments do
			if not v2.Disabled then
				local v3 = p1._remoteConfigs[v2.RemoteConfig] or v2.DefaultState
				local v4 = v2.States[v3]

				if v4 and v4.Client then
					task.defer(v4.Client, LocalPlayer, v3)
				end
			end
		end
	end,
	IsLoaded = function(p1) --[[ IsLoaded | Line: 43 ]]
		return p1._loaded
	end,
	OnLoad = function(p1, p2) --[[ OnLoad | Line: 47 ]]
		return p1._loadedSignal:Connect(p2)
	end,
	GetRemoteConfig = function(p1, p2) --[[ GetRemoteConfig | Line: 51 ]]
		return p1._remoteConfigs[p2], p1:IsLoaded()
	end,
	Start = function(p1) --[[ Start | Line: 55 | Upvalues: GameAnalytics (copy), ReplicatedStorage (copy), HttpService (copy) ]]
		GameAnalytics:initClient()
		ReplicatedStorage:WaitForChild("GameAnalyticsRemoteConfigs").OnClientEvent:Connect(function(p12) --[[ Line: 57 | Upvalues: HttpService (ref), p1 (copy) ]]
			if typeof(p12) ~= "table" then
				return
			end

			local t = {}

			for k, v in pairs(p12) do
				local v1
				local ok, result = pcall(HttpService.JSONDecode, HttpService, v)

				v1 = if ok and result ~= nil then result else v
				t[k] = v1
			end

			p1._remoteConfigs = t

			if p1._loaded then
				return
			end

			p1._loaded = true
			p1._loadedSignal:Fire(t)
			p1:_runExperiments()
		end)
	end
}

task.spawn(t.Start, t)

return t