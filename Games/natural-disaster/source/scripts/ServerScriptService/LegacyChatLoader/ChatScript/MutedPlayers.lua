-- // Keeps track of other players who this player has muted.

local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer

local MutedPlayers = {}

local mutedPlayers: {[Player]: boolean?} = {}

local playerMutedBindable = Instance.new("BindableEvent")
playerMutedBindable.Name = "PlayerMuted"
local playerUnmutedBindable = Instance.new("BindableEvent")
playerUnmutedBindable.Name = "PlayerUnmuted"

function MutedPlayers.isMuted(player: Player): boolean
	return mutedPlayers[player] == true
end

function MutedPlayers.mute(player: Player): (boolean, string)
	if player == localPlayer then
		return false, "You can't mute yourself."
	end
	
	if mutedPlayers[player] then
		return false, `{player.Name} is already muted.`
	end
	mutedPlayers[player] = true
	return true, `Muted {player.Name}.`
end

function MutedPlayers.unmute(player: Player)
	if player == localPlayer then
		return false, "You can't mute yourself."
	end
	
	if not mutedPlayers[player] then
		return false, `{player.Name} is already unmuted.`
	end
	mutedPlayers[player] = nil
	return true, `Unmuted {player.Name}.`
end

function MutedPlayers.getPlayerMutedBindable()
	return playerMutedBindable
end

function MutedPlayers.getPlayerUnmutedBindable()
	return playerUnmutedBindable
end

function MutedPlayers.init()
	Players.PlayerRemoving:Connect(function(player)
		if mutedPlayers[player] ~= nil then
			mutedPlayers[player] = nil
		end
	end)
end

return MutedPlayers