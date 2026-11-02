-- Server-side Cmdr command handler for the admin panel.
-- Processes command strings sent via the CmdrFunction RemoteFunction.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CmdrClient = ReplicatedStorage:WaitForChild("CmdrClient")
local CmdrFunction = CmdrClient:WaitForChild("CmdrFunction")
local CmdrEvent = CmdrClient:FindFirstChild("CmdrEvent")

-- Track god mode state per player
local godModePlayers = {}

local function isAdmin(player)
	return player:GetAttribute("IsAdministrator") == true
end

local function findPlayer(query)
	if not query or query == "" then return nil end
	query = string.lower(query)

	-- Handle "me" keyword
	if query == "me" then
		return nil -- will be handled by caller with the invoking player
	end

	-- Handle "all" keyword
	if query == "all" then
		return Players:GetPlayers()
	end

	-- Try exact name match first
	for _, p in ipairs(Players:GetPlayers()) do
		if string.lower(p.Name) == query or string.lower(p.DisplayName) == query then
			return p
		end
	end

	-- Try partial match
	for _, p in ipairs(Players:GetPlayers()) do
		if string.find(string.lower(p.Name), query, 1, true) or string.find(string.lower(p.DisplayName), query, 1, true) then
			return p
		end
	end

	return nil
end

local function findPlayers(query, invokingPlayer)
	if not query or query == "" then return {} end
	query = string.lower(query)

	if query == "me" and invokingPlayer then
		return { invokingPlayer }
	end

	if query == "all" then
		return Players:GetPlayers()
	end

	local result = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if string.lower(p.Name) == query or string.lower(p.DisplayName) == query then
			return { p }
		end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if string.find(string.lower(p.Name), query, 1, true) or string.find(string.lower(p.DisplayName), query, 1, true) then
			table.insert(result, p)
		end
	end
	return result
end

local function getCharacter(player)
	return player.Character
end

local function getHumanoid(player)
	local char = player.Character
	if not char then return nil end
	return char:FindFirstChildOfClass("Humanoid")
end

local function getRoot(player)
	local char = player.Character
	if not char then return nil end
	return char:FindFirstChild("HumanoidRootPart")
end

-- Command handlers
local commands = {}

commands.kick = function(admin, args)
	if #args < 1 then return false, "Usage: kick <player>" end
	local targets = findPlayers(args[1], admin)
	if #targets == 0 then return false, "Player not found." end
	local count = 0
	for _, p in ipairs(targets) do
		if p ~= admin then
			p:Kick("You have been kicked by an administrator.")
			count += 1
		end
	end
	return true, ("Kicked %d player(s)."):format(count)
end

commands.ban = function(admin, args)
	if #args < 1 then return false, "Usage: ban <player>" end
	local targets = findPlayers(args[1], admin)
	if #targets == 0 then return false, "Player not found." end
	local count = 0
	for _, p in ipairs(targets) do
		if p ~= admin then
			p:Kick("You have been banned by an administrator.")
			count += 1
		end
	end
	return true, ("Banned %d player(s)."):format(count)
end

commands.teleport = function(admin, args)
	if #args < 1 then return false, "Usage: teleport <player>" end
	local targets = findPlayers(args[1], admin)
	if #targets == 0 then return false, "Player not found." end
	local adminChar = admin.Character
	if not adminChar then return false, "Your character is not available." end
	local count = 0
	for _, p in ipairs(targets) do
		local targetRoot = getRoot(p)
		if targetRoot then
			adminChar:PivotTo(targetRoot.CFrame * CFrame.new(0, 0, -5))
			count += 1
			break -- only teleport to the first found target
		end
	end
	return true, ("Teleported to %d player(s)."):format(count)
end

commands.bring = function(admin, args)
	if #args < 1 then return false, "Usage: bring <player>" end
	local targets = findPlayers(args[1], admin)
	if #targets == 0 then return false, "Player not found." end
	local adminRoot = getRoot(admin)
	if not adminRoot then return false, "Your character is not available." end
	local count = 0
	for _, p in ipairs(targets) do
		local targetRoot = getRoot(p)
		if targetRoot then
			local char = p.Character
			if char then
				char:PivotTo(adminRoot.CFrame * CFrame.new(0, 0, -5))
				count += 1
			end
		end
	end
	return true, ("Brought %d player(s)."):format(count)
end

commands.kill = function(admin, args)
	if #args < 1 then return false, "Usage: kill <player>" end
	local targets = findPlayers(args[1], admin)
	if #targets == 0 then return false, "Player not found." end
	local count = 0
	for _, p in ipairs(targets) do
		local humanoid = getHumanoid(p)
		if humanoid and humanoid.Health > 0 then
			humanoid.Health = 0
			count += 1
		end
	end
	return true, ("Killed %d player(s)."):format(count)
end

commands.respawn = function(admin, args)
	if #args < 1 then return false, "Usage: respawn <player>" end
	local targets = findPlayers(args[1], admin)
	if #targets == 0 then return false, "Player not found." end
	local count = 0
	for _, p in ipairs(targets) do
		p:LoadCharacter()
		count += 1
	end
	return true, ("Respawned %d player(s)."):format(count)
end

commands.announce = function(admin, args)
	if #args < 1 then return false, "Usage: announce <message>" end
	local message = table.concat(args, " ")
	for _, p in ipairs(Players:GetPlayers()) do
		local notify = ReplicatedStorage:FindFirstChild("Remotes")
		if notify then
			local notifyEvent = notify:FindFirstChild("Notify")
			if notifyEvent and notifyEvent:IsA("RemoteEvent") then
				notifyEvent:FireClient(p, "📢 " .. message)
			end
		end
	end
	return true, "Announcement sent."
end

commands.speed = function(admin, args)
	if #args < 2 then return false, "Usage: speed <player> <value>" end
	local targets = findPlayers(args[1], admin)
	if #targets == 0 then return false, "Player not found." end
	local speed = tonumber(args[2])
	if not speed then return false, "Invalid speed value." end
	speed = math.clamp(speed, 0, 200)
	local count = 0
	for _, p in ipairs(targets) do
		local humanoid = getHumanoid(p)
		if humanoid then
			humanoid.WalkSpeed = speed
			count += 1
			-- Reapply on respawn
			p:SetAttribute("AdminWalkSpeed", speed)
		end
	end
	return true, ("Set speed to %d for %d player(s)."):format(speed, count)
end

commands.god = function(admin, args)
	local targetName = args[1] or "me"
	local targets = findPlayers(targetName, admin)
	if #targets == 0 then return false, "Player not found." end
	local count = 0
	for _, p in ipairs(targets) do
		if godModePlayers[p.UserId] then
			godModePlayers[p.UserId] = nil
			p:SetAttribute("AdminGodMode", false)
			local humanoid = getHumanoid(p)
			if humanoid then
				humanoid.MaxHealth = 100
				humanoid.Health = 100
			end
		else
			godModePlayers[p.UserId] = true
			p:SetAttribute("AdminGodMode", true)
			local humanoid = getHumanoid(p)
			if humanoid then
				humanoid.MaxHealth = math.huge
				humanoid.Health = math.huge
			end
			count += 1
		end
	end
	if count > 0 then
		return true, ("God mode enabled for %d player(s)."):format(count)
	else
		return true, "God mode disabled."
	end
end

commands.fix = function(admin, args)
	local targetName = args[1] or "me"
	local targets = findPlayers(targetName, admin)
	if #targets == 0 then return false, "Player not found." end
	local count = 0
	for _, p in ipairs(targets) do
		-- Reset avatar to default Roblox avatar
		task.spawn(function()
			local success, description = pcall(function()
				return Players:GetHumanoidDescriptionFromUserIdAsync(p.UserId)
			end)
			if success and description then
				local humanoid = getHumanoid(p)
				if humanoid then
					pcall(function() humanoid:ApplyDescriptionReset(description) end)
					description:Destroy()
				end
			end
		end)
		count += 1
	end
	return true, ("Fixing avatar for %d player(s)."):format(count)
end

-- Handle god mode on respawn
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		task.wait(0.5)
		if godModePlayers[player.UserId] then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.MaxHealth = math.huge
				humanoid.Health = math.huge
			end
		end
		local adminSpeed = player:GetAttribute("AdminWalkSpeed")
		if adminSpeed then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = adminSpeed
			end
		end
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	godModePlayers[player.UserId] = nil
end)

-- Handle existing players
for _, player in ipairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(function(character)
		task.wait(0.5)
		if godModePlayers[player.UserId] then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.MaxHealth = math.huge
				humanoid.Health = math.huge
			end
		end
		local adminSpeed = player:GetAttribute("AdminWalkSpeed")
		if adminSpeed then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = adminSpeed
			end
		end
	end)
end

-- Main command handler
CmdrFunction.OnServerInvoke = function(player, commandStr, options)
	if not isAdmin(player) then
		return "You are not authorized to use admin commands."
	end

	if type(commandStr) ~= "string" or commandStr == "" then
		return "Empty command."
	end

	-- Parse command string
	local args = {}
	for word in string.gmatch(commandStr, "%S+") do
		table.insert(args, word)
	end

	if #args == 0 then
		return "Empty command."
	end

	local commandName = string.lower(table.remove(args, 1))
	local handler = commands[commandName]

	if not handler then
		return ("Unknown command: %s"):format(commandName)
	end

	local success, result = pcall(handler, player, args)
	if not success then
		return ("Command failed: %s"):format(tostring(result))
	end

	if type(result) == "string" then
		return result
	end
	return "Command executed."
end

print("[CmdrServer] Admin command handler ready")