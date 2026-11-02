--Merchaant ♥

--[[
		INSTRUCTIONS:
		1. Put this script under StarterPlayer > StarterPlayerScripts
		2. Change the GROUP_ID to your group's ID
		3. Enjoy!
		
		This script will not show the 'join group' notification if the user is already in the group.

]]

--// Services \\--
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local GroupService = game:GetService("GroupService")

--// Variables \\--
local player = Players.LocalPlayer
local GROUP_ID = 218109404 --PUT YOUR GROUP ID HERE <----------------

--// Ensure LocalPlayer is ready \\--
if not player then
	Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	player = Players.LocalPlayer
end

--// Function to show notification \\--
local function showNotification()
	local bindable = Instance.new("BindableFunction")

	bindable.OnInvoke = function(response)
		if response == "Join" then
			task.spawn(function()
				pcall(function()
					GroupService:PromptJoinAsync(GROUP_ID)
				end)
			end)
		end
	end

	StarterGui:SetCore("SendNotification", {
		Title = "Join the Group!",
		Text = "Join the group for rewards!",
		Duration = 8,
		Button1 = "Join",
		Callback = bindable
	})
end

--// Initial delay (30 seconds) \\--
task.wait(30)

--// Loop every 4 minutes \\--
while true do
	local success, isInGroup = pcall(function()
		return player:IsInGroup(GROUP_ID)
	end)

	if success and not isInGroup then
		showNotification()
	end

	task.wait(240)
end