local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local PopUpUi = require(game.StarterPlayer.StarterPlayerScripts.Client.InterfaceModules.PopUpUI)

local ClaimButton = script.Parent:WaitForChild("HeaderFrame"):WaitForChild("ClaimButton")
local CheckFollowEvent = ReplicatedStorage:WaitForChild("CheckFollowEvent")

ClaimButton.Activated:Connect(function()
	local player = Players.LocalPlayer
	local success, isFollowing = pcall(function()
		return CheckFollowEvent:InvokeServer()
	end)

	if success then
		if isFollowing then
			PopUpUi.AddPopUp("You are following the user! Reward claimed.", "green")
		else
			PopUpUi.AddPopUp(" You're not following the user. Please follow first.", "red")
		end
	else
		PopUpUi.AddPopUp(" Could not verify. Try again later.", "red")
	end
end)
