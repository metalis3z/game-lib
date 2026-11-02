local EmoteExecuteRemote = script.Parent.EmoteWheel.EmoteExecute

EmoteExecuteRemote.OnServerEvent:Connect(function(Player: Player, Emote: string): ()
	warn(Player, Emote);
end)

-- // This function just gets the group ranks :p  - katamari
local function GroupRank(Player: Player): number
	local BBNConfig = require('@game/ServerStorage/BBNConfig')
	if BBNConfig.GroupID then
		return Player:GetRankInGroupAsync(BBNConfig.GroupID)
	end
	return BBNConfig.ManualRanks[Player.UserId] or 1
end

for _, plr in game:GetService("Players"):GetPlayers() do
	plr:SetAttribute("Rank", GroupRank(plr))
end

game:GetService("Players").PlayerAdded:Connect(function(plr)
	plr:SetAttribute("Rank", GroupRank(plr))
end)