--!strict

local SettingsService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Services.PlotService)
local SkinService = require(ServerScriptService.Services.SkinService)

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local BasesData = require(ReplicatedStorage.Datas.Bases)
local SharedGame = require(ReplicatedStorage.Shared.Game)

local ToggleSetting = Net:RemoteFunction("SettingsService/ToggleSetting")
local lastSkinTime: { [Player]: number } = {}

ToggleSetting.OnServerInvoke = function(player: Player, setting: string, new: any): (boolean, string?)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "There was an error getting your data. Please rejoin."
	end

	if new == nil then
		local current = playerChannel:Get(string.format("Settings.%s", setting))
		new = not current
	end

	playerChannel:Set(string.format("Settings.%s", setting), new)

	if setting == "Base Skin" then
		local now = os.clock()
		if lastSkinTime[player] and now - lastSkinTime[player] < 0.5 then
			return true
		end
		lastSkinTime[player] = now

		local plot = PlotService.getPlot(player)
		if plot then
			task.spawn(function()
				SkinService:Apply(new, plot, playerChannel:Get("Rebirth"))
			end)
		end
	end

	return true
end

return SettingsService
