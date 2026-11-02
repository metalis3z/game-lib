-- SecretEggTimerScript: compte a rebours d'une heure sur le panneau SecretEggTimerSign
-- Quand le timer atteint 0, il se reaffiche a 01:00:00

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local sign = workspace:FindFirstChild("SecretEggTimerSign")
if not sign then
	warn("[SecretEggTimerScript] Panneau SecretEggTimerSign introuvable!")
	return
end

local board = sign:FindFirstChild("Board")
if not board then return end

local surfaceGui = board:FindFirstChild("SignGui")
if not surfaceGui then return end

local timerLabel = surfaceGui:FindFirstChild("Frame") and surfaceGui.Frame:FindFirstChild("TimerLabel")
if not timerLabel then return end

local TIMER_DURATION = 3600 -- 1 heure en secondes
local endTime = os.time() + TIMER_DURATION

local function formatTime(seconds)
	seconds = math.max(0, math.floor(seconds))
	local h = math.floor(seconds / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60
	return string.format("%02d:%02d:%02d", h, m, s)
end

-- Couleur du timer qui change selon le temps restant
local function updateColor(remaining)
	if remaining <= 60 then
		timerLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- rouge
	elseif remaining <= 300 then
		timerLabel.TextColor3 = Color3.fromRGB(255, 180, 50) -- orange
	else
		timerLabel.TextColor3 = Color3.fromRGB(100, 255, 100) -- vert
	end
end

task.spawn(function()
	while true do
		local now = os.time()
		local remaining = endTime - now

		if remaining <= 0 then
			-- Le timer est termine : on donne un oeuf secret a tous les joueurs
			local AdminSystem = ReplicatedStorage:FindFirstChild("AdminSystem")
			local bindables = AdminSystem and AdminSystem:FindFirstChild("Bindables")
			local giveEgg = bindables and bindables:FindFirstChild("GiveEgg")
			if giveEgg then
				local Players = game:GetService("Players")
				for _, player in Players:GetPlayers() do
					giveEgg:Fire(player, "DemonEgg")
				end
				print("[SecretEggTimer] Oeuf secret garanti donne a tous les joueurs!")
			end

			-- Reset du timer
			endTime = os.time() + TIMER_DURATION
			remaining = TIMER_DURATION
		end

		timerLabel.Text = formatTime(remaining)
		updateColor(remaining)

		task.wait(1)
	end
end)