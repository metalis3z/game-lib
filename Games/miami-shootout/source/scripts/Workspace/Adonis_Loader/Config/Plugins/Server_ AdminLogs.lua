server = nil
service = nil

local abusiveCommands = {
	["kill"] = 3,
	["kick"] = 2,
	["ban"] = 2,
	["permban"] = 2,
	["directban"] = 2,
	["gameban"] = 2,
	["pban"] = 2,
	["trelloban"] = 2,
	["tban"] = 2,
	["brazil"] = 2,
	["bring"] = 5,
	["massbring"] = 5,
	["give"] = 2,
	["jail"] = 2,
	["respawn"] = 2,
	["explode"] = 2,
	["rope"] = 2,
	["re"] = 2,
	["refresh"] = 2,
	["freeze"] = 2,
	["clone"] = 3,
	["bot"] = 3,
	["removetools"] = 3,
	["nuke"] = 1,
	["size"] = 3
}

_G.commandsRan = {}

function detectAbuse(command,arg1,plrNum)
	if abusiveCommands[command] then
		-- first
		
		if arg1 == "others" or arg1 == "all" then
			print("ABUSE (all/others)")
			-- abuse!
			return true
		end
		
		if abusiveCommands[command] <= plrNum then
			print("ABUSE (maximum breached)")
			return true
		end
		
	else
		return false
	end
	return false
end

return function()

	local function findCommand(name)
		local ret = nil
		for _,x in pairs(server.Commands) do
			for _,b in ipairs(x.Commands) do
				if b:lower() == name:lower() then
					print("found command return")
					ret = x
				end
			end
		end
		return ret
	end

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
				Error = tostring(v)
			end
		end
		print("Command: "..command)
		print("Successful "..successfulCommand)
		
		local cmdName = command:split(" ")[1]:sub(2)
		local arg1 = command:split(" ")
		
		if arg1[2] then
			arg1 = arg1[2]
		end
		
		local extra = ""
		extra = Error
		--local plrLevel = _G.Adonis.GetLevel(p)
		local commandData = findCommand(cmdName)
		wait()
		--local dataLevel = commandData.AdminLevel
		
		--if plrLevel < 899 and dataLevel > plrLevel then
		--	print("player can't run this command")
		--	extra = "Player is unable to run this command (Level required: "..dataLevel..", current level: "..plrLevel..")"	
		--	successfulCommand = "False"
		--else
		--	print("player can run this command")
		--	extra = ""
		--end
		
		local playersAffected = {p}
		--print(commandData)
		if arg1 and typeof(arg1) ~= "table" and commandData.Args and commandData.Args[1] == "player" then
			print("FINDING PLAYERS")
			playersAffected = service.GetPlayers(p, arg1)
		end
		
		local isAbuse = detectAbuse(cmdName,arg1,#playersAffected)
		local sender = ""
		
		if isAbuse == true then
			sender = "ABUSE"
		end
		
		game.ReplicatedStorage.SendEmbed:Fire("adminlog",p,command,successfulCommand,extra,sender,playersAffected)
		
		if not _G.commandsRan[p] then
			_G.commandsRan[p] = 1
		else
			_G.commandsRan[p] = _G.commandsRan[p] + 1
		end
	end)
end


