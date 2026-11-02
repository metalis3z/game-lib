local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

local player = Players.LocalPlayer
local gui = script.Parent
local doubleLabel = gui.LeftDownSide.Cash.Double
local amountLabel = doubleLabel.Amount

local DataRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayerDataService")
local DataUpdateEvent = DataRemotes:WaitForChild("DataUpdate")
local RequestDataFunc = DataRemotes:WaitForChild("RequestData")

-- Disabled: CashDisplayController now owns GUI.HUD.LeftDownSide.Cash.Double and
-- drives it with a smooth count-up lerp. This legacy script used to snap the
-- label instantly, fighting that animation -- so setDisplay is a no-op.
local function setDisplay(_amount)
end

DataUpdateEvent.OnClientEvent:Connect(function(statName, value)
	if statName == "Cash" then
		setDisplay(value)
	end
end)

task.spawn(function()
	for _ = 1, 20 do
		local ok, data = pcall(function() return RequestDataFunc:InvokeServer() end)
		if ok and data and data.Cash then
			setDisplay(data.Cash)
			return
		end
		task.wait(0.5)
	end

	local leaderstats = player:WaitForChild("leaderstats", 15)
	if leaderstats then
		local cashStat = leaderstats:WaitForChild("Cash", 5)
		if cashStat then
			setDisplay(cashStat.Value)
			cashStat.Changed:Connect(function(val)
				setDisplay(val)
			end)
		end
	end
end)