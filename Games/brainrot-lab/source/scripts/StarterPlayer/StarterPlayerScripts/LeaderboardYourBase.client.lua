local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

local player = Players.LocalPlayer

local function findValueLabel()
	local leaderboardsFolder = Workspace:FindFirstChild("Leaderboards")
	if not leaderboardsFolder then return nil end
	local moneyModel = leaderboardsFolder:FindFirstChild("Money")
	if not moneyModel then return nil end
	local yourPart = moneyModel:FindFirstChild("Your")
	if not yourPart then return nil end
	local ui = yourPart:FindFirstChild("UI")
	if not ui or not ui:IsA("SurfaceGui") then return nil end
	local background = ui:FindFirstChild("Background")
	if not background then return nil end
	local valueLabel = background:FindFirstChild("Value")
	if not valueLabel or not valueLabel:IsA("TextLabel") then return nil end
	return valueLabel
end

local valueLabel = findValueLabel()

-- Keep trying to find the label in case the leaderboard loads late
task.spawn(function()
	while not valueLabel do
		task.wait(1)
		valueLabel = findValueLabel()
	end
end)

-- Update the "Your Base" value with the local player's income/s
task.spawn(function()
	while true do
		task.wait(0.5)
		if valueLabel then
			local incomePerSecond = player:GetAttribute("IncomePerSecond") or 0
			valueLabel.Text = "$" .. NumberFormatter.Format(incomePerSecond) .. "/s"
		end
	end
end)
