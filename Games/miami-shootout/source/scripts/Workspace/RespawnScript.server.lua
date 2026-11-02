--Respawn Time Script

--How long after someone dies do they respawn?
respawn_time = 10

--Allow players to chat to force their character to respawn?
allow_force_respawn = true

--If the above is true, what should they chat to force respawn?
force_respawn = "respawn"

--------------------------------------------

game.Players.CharacterAutoLoads = false

function onPlayerDied(player, character)
	wait(respawn_time)
	player:LoadCharacter()
end

function onPlayerSpawned(player, character)
	while not character:FindFirstChild("Humanoid") do wait() end
	character.Humanoid.Died:connect(function () onPlayerDied(player, character) end)
end

function onPlayerChatted(player, message, recipient)
	if message == force_respawn and allow_force_respawn then
		player:LoadCharacter()
	end
end

function onPlayerEntered(player)

	player.CharacterAdded:connect(function (char) onPlayerSpawned(player, char) end)
	player.Chatted:connect(function (msg, rec) onPlayerChatted(player, msg, rec) end)

	player:LoadCharacter()
end

game.Players.PlayerAdded:connect(onPlayerEntered)

--7/8/12 10:46 AM
