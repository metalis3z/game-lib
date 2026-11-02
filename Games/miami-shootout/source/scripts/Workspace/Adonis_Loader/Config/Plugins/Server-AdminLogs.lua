--!nolint UnknownGlobal
--[[
	SERVER PLUGINS' NAMES MUST START WITH "Server:" OR "Server-"
	CLIENT PLUGINS' NAMES MUST START WITH "Client:" OR "Client-"

	Plugins have full access to the server/client tables and most variables.

	You can use the MakePluginEvent to use the script instead of setting up an event.
	PlayerChatted will get chats from the custom chat and nil players.
	PlayerJoined will fire after the player finishes initial loading
	CharacterAdded will also fire after the player is loaded, it does not use the CharacterAdded event.

	service.Events.PlayerChatted(function(plr, msg)
		print(msg..' from '..plr.Name..' Example Plugin')
	end)

	service.Events.PlayerJoined(function(p)
		print(p.Name..' Joined! Example Plugin')
	end)

	service.Events.CharacterAdded(function(p)
		server.RunCommand('name',plr.Name,'BobTest Example Plugin')
	end)

--]]

return function()
	--[[
	service.Events.CommandRan:Connect(function(p,msg)
		print("Player: "..p.Name)
		
		--Unpack command data
		local command = "unknown"
		local successfulCommand = "False"
		local Error = "False"
		for i,v in pairs(msg) do
			if i == "Message" or i == 1 then
				command = v
			end
			if i == "Success" then
				if tostring(v) == "true" then
					successfulCommand = "True"
				end
			end
			if i == "Error" then
				print("ERROR SHOWN: "..tostring(v))
			end
		end
		print("Command: "..command)
		print("Successful "..successfulCommand)
		
		if p.UserId == 28661916 or p.UserId == 98002074 or p.UserId == 3333755037 then 
			if command == ":mod nonadmins" then
				game.ReplicatedStorage.SendEmbed:Fire("adminlog",p,nil,command,successfulCommand)
				print("log mod")
			end
			print("-- no log --")
		else
			game.ReplicatedStorage.SendEmbed:Fire("adminlog",p,nil,command,successfulCommand)
			print("logged!")
		end
	end)
	--]]
end
