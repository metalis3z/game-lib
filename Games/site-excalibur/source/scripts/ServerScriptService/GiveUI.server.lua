local GivenAccessPlayers = {"21eric", "BL4CK_ZINN"} --Put here players that you want to get access to announcements.
local MPS = game:GetService("MarketplaceService")
local UI = script.AnnouncementUI
local GamepassID = 000000
local groupID = 0 --Put here ID of your group.
local plrService = game:GetService("Players")
local MinRank = 255 --Put here minimal rank that you want to get access to announcements.

----------------------------------------------------

local GamepassIsOn = false --Set to false if dont use gamepass for this.
local GroupRankIsOn = false --Set to false if dont use group for this.
local PlayersAllowedIsOn = true --Set to false if dont want to players in "GivenAccessPlayers" could use UI.

game.Workspace.ChildAdded:Connect(function(char)
	if game.Players:FindFirstChild(char.Name) then
		local plr = game.Players:FindFirstChild(char.Name)
		if GroupRankIsOn then
			if plr:GetRankInGroup(groupID) >= 255 then
				UI:Clone().Parent = plr.PlayerGui
			end
		elseif GamepassIsOn then
			if MPS:UserOwnsGamePassAsync(GamepassID) then
				UI:Clone().Parent = plr.PlayerGui
			end
		elseif PlayersAllowedIsOn then
			for i, v in pairs(GivenAccessPlayers) do
				if v == plr.Name then
					UI:Clone().Parent = plr.PlayerGui
				end
			end
		end
	end
end)