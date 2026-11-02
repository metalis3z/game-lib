local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local debounce = false
script.Parent.Touched:connect(function(hit)
	if not debounce and hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
		debounce = true
		local player = game.Players:GetPlayerFromCharacter(hit.Parent) 
		if player then
			
			local partyList = {player}
			for _,_player in ipairs(game.Players:GetPlayers()) do
				if _player.FollowUserId == player.userId then
					table.insert(partyList,_player)
				end
			end
			for _,partyMember in ipairs(partyList) do
				game:GetService("TeleportService"):Teleport(Enums.PartyServerId,partyMember)
			end
		end
		wait(1)
		debounce = false
	end 
end)


