-- By SolarNolys
-- DM for help; im new leaker !!!

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))


local ALLOWED_USER_IDS = {
	8520359746,
}


local creatorId = game.CreatorId
local creatorType = game.CreatorType

local function isAuthorized()

	if creatorType == Enum.CreatorType.User then
		if player.UserId == creatorId then
			return true
		end
	end


	for _, id in ipairs(ALLOWED_USER_IDS) do
		if player.UserId == id then
			return true
		end
	end

	return false
end


if isAuthorized() then
	Cmdr:SetActivationKeys({ Enum.KeyCode.F4 })
	print("Cmdr enabled for", player.Name)
else

	Cmdr:SetActivationKeys({})
	print("Cmdr disabled for", player.Name)
end