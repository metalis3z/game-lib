--[[
	@author TwinPlayzDev_YT
	@since OCT/25/2021
	This script handles the Invite Friend Top Bar Gui
	
	Youtube.com/c/TwinPlayz_YT
	
--]]

--[LOCALS]--

local Icon = require(game:GetService("ReplicatedStorage").Icon)
local SocialService = game:GetService("SocialService")
local Player = game.Players.LocalPlayer
local icon = Icon.new()
:setLabel("Invite Friends", "deselected")
:setLabel("Open", "selected")
:setCaption("Invite your friends to join!")
--:setImage(6764432408) Use this to your liking

--[MAIN FUNCTION]--

local function onButtonPressed()
	local success, result = pcall(
		function()
			return SocialService:CanSendGameInviteAsync(Player)
		end
	)

	if result == true then
		SocialService:PromptGameInvite(Player)
	end
end

icon.selected:Connect(function()
	onButtonPressed()
end)