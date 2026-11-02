--[[

Starterpack handler

--]]

local Remote_v0 = game.ReplicatedStorage.Remote
local var1 = game
local var2 = Remote_v0.FetchStarterpackTimer:InvokeServer(game.Players.LocalPlayer) -- default is 604740
local CL_MAIN_GameScript = game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript

local function formatTime(seconds)
	local days = math.floor(seconds / 86400)
	local remainingAfterDays = seconds % 86400

	local hours = math.floor(remainingAfterDays / 3600)
	local remainingAfterHours = remainingAfterDays % 3600

	local minutes = math.floor(remainingAfterHours / 60)

	return days, hours, minutes
end
local function updateTimer()
	while var2 > 0 do
		var2 = var2 - 1  -- Decrement the total seconds by 1
		game.ReplicatedStorage.Remote.UpdateCount:FireServer(var2)
		local days, hours, minutes = formatTime(var2)
		script.Parent.Timer.Text = days .. "d " .. hours .. "h " .. minutes .. "m"

		wait(1)  -- Wait for 1 second before updating again
	end

	script.Parent.Visible = false  -- Hide the timer when it reaches 0
end
script.Parent.Visible = true

if var2 <= 0 then
	script.Parent.Visible = false
else
	script.Parent.Visible = true
	game.ReplicatedStorage.Remote.UpdateCount:FireServer(var2)
	local days, hours, minutes = formatTime(var2)
	script.Parent.Timer.Text = days .. "d " .. hours .. "h " .. minutes .. "m"
	wait(1)
	task.spawn(updateTimer)
end

script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Visible then
		CL_MAIN_GameScript.Notify:Fire("The Startpack includes 600 Coins, 300 Gems, 6000 XP and an EXCLUSIVE Vaporwave Aura! Only available for the first 7 days. Purchase for 250R$?", "Staterpack", function(bool : boolean)
			game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer, 1833071674)
		end, 1)
	end
end)