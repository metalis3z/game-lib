local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local UPGRADE_STATION_POS = CFrame.new(-378.437, -5.726, 29.668)

local activeTimer = nil
local stationActive = false

local module = function(Conch, Config)
	Conch.register("addupgrade", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Duration",
				description = "Duration in seconds",
				default = 300,
				optional = true,
			}
		end,

		callback = function(duration)
			if stationActive then
				return false, "Upgrade Station is already active! Use /stopupgrade to remove it first."
			end

			duration = tonumber(duration) or 300
			if duration < 10 then
				return false, "Duration must be at least 10 seconds"
			end

			-- Get the template
			local template = ReplicatedStorage.Models:FindFirstChild("Upgrade Station")
			if not template then
				return false, "Upgrade Station template not found in ReplicatedStorage.Models"
			end

			-- Clone and place in Workspace
			local station = template:Clone()
			station:PivotTo(UPGRADE_STATION_POS)
			station.Parent = workspace

			-- Set up the service
			local UpgradeStationService = require(ServerScriptService.Services.UpgradeStationService)
			UpgradeStationService:SetupStation(station)

			stationActive = true

			-- Send admin notification to all players
			local formattedText = '<b><font color="rgb(255, 50, 50)">ADMIN A MIS LA UPGRADE MACHINE</font></b> <font color="rgb(255, 221, 0)">(' .. duration .. 's)</font>'
			for _, player in ipairs(Players:GetPlayers()) do
				NotificationEvent:FireClient(player, formattedText, 8, nil, "Top")
			end

			-- Play sound
			local ok, SoundController = pcall(function()
				return require(ReplicatedStorage.Controllers.SoundController)
			end)
			if ok and SoundController and SoundController.PlaySound then
				local sfx = ReplicatedStorage.Sounds and ReplicatedStorage.Sounds.Sfx
				if sfx then
					local blop = sfx:FindFirstChild("Blop")
					if blop then
						SoundController:PlaySound(blop)
					end
				end
			end

			-- Countdown notifications
			local function sendCountdown(text)
				for _, player in ipairs(Players:GetPlayers()) do
					if player.Parent then
						NotificationEvent:FireClient(player, text, 5, nil, "Top")
					end
				end
			end

			-- Start timer
			activeTimer = task.spawn(function()
				local remaining = duration
				local lastNotify = 0

				while remaining > 0 and stationActive do
					task.wait(1)
					remaining = remaining - 1

					-- Notify at 60s, 30s, 10s, 5s, 4s, 3s, 2s, 1s
					if remaining == 60 or remaining == 30 or remaining <= 10 then
						sendCountdown('<b><font color="rgb(255, 221, 0)">Upgrade Machine</font></b> se termine dans <b>' .. remaining .. 's</b>')
					end
				end

				-- Time's up - clean up
				if stationActive then
					stationActive = false
					sendCountdown('<b><font color="rgb(255, 50, 50)">Upgrade Machine</font></b> a ete retiree!')
					UpgradeStationService:CleanupStation()
					activeTimer = nil
				end
			end)

			return true, string.format("Upgrade Station spawned for %d seconds at position (-378.437, -5.726, 29.668)", duration)
		end,
	})

	-- Stop command to remove the station early
	Conch.register("stopupgrade", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {}
		end,

		callback = function()
			if not stationActive then
				return false, "No Upgrade Station is currently active"
			end

			stationActive = false

			local UpgradeStationService = require(ServerScriptService.Services.UpgradeStationService)
			UpgradeStationService:CleanupStation()

			local formattedText = '<b><font color="rgb(255, 50, 50)">Upgrade Machine</font></b> a ete retiree par un admin!'
			for _, player in ipairs(Players:GetPlayers()) do
				if player.Parent then
					NotificationEvent:FireClient(player, formattedText, 5, nil, "Top")
				end
			end

			activeTimer = nil

			return true, "Upgrade Station removed and all brainrots returned to their owners"
		end,
	})
end

return module