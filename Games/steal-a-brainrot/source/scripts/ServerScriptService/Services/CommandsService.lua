local CommandsService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)
local Config = require(script.Config)

local OpenCommandBar = Net:RemoteEvent("CommandsService/OpenCommandBar")

local Debug = false

function CommandsService.new()
	CommandsService:SetupRemoteFunctions()

	task.spawn(function()
		local waited = 0
		while not (Conch.console and Conch.console.commands and Conch.console.commands["clear"]) and waited < 5 do
			task.wait(0.1)
			waited += 0.1
		end
		CommandsService:LoadCommandModules()
	end)

	CommandsService:ConnectPlayerJoin()
	return CommandsService
end

function CommandsService:SetupRemoteFunctions()
	Net:Handle("CommandsService/ViewCommands", function(player)
		local role = CommandsService:GetRoleAsync(player)
		local allowed = role == "Dev" or role == "Lead"
		if Debug then
			print(string.format("[CommandsService] ViewCommands invoked by %s | allowed=%s", player.Name, tostring(allowed)))
		end
		if allowed then
			local user = Conch.get_user(player)
			if user then
				local role = CommandsService:GetRoleAsync(player)
				if role == "Dev" or role == "Lead" then
					local role = CommandsService:GetRoleAsync(player)
			if role == "Dev" or role == "Lead" then
				Conch.give_roles(user, "super-user")
			end
				end
				task.delay(0.25, function()
					if Debug then
						print("[CommandsService] Marking user.dirty after ViewCommands (", player.Name, ")")
					end
					user.dirty = true
				end)
			end

			local snapshot = {}
			for name, cmd in pairs(Conch.console.commands) do
				if CommandsService:GetRoleAsync(player) == "Dev" or CommandsService:GetRoleAsync(player) == "Lead" or Conch._.has_permissions(Conch.get_user(player), unpack(cmd.permissions)) then
					table.insert(snapshot, {
						name = cmd.name,
						description = cmd.description,
						permissions = cmd.permissions,
						arguments = cmd.arguments,
					})
				end
			end
			return snapshot
		end
		return nil
	end)
end

function CommandsService:ConnectPlayerJoin()
	local function giveRole(player)
		task.spawn(function()
			local role = CommandsService:GetRoleAsync(player)
			while player.Parent and not (role == "Dev" or role == "Lead") do
				task.wait(1)
			end

			if not player.Parent then
				return
			end

			if Debug then
				print(string.format("[CommandsService] %s authorised", player.Name))
			end

			local user
			while player.Parent do
				user = Conch.get_user(player)
				if user then break end
				task.wait(0.1)
			end

			if not user then
				warn("[CommandsService] Failed to obtain Conch user for", player)
				return
			end

			Conch.give_roles(user, "super-user")

			if Debug then
				local role = CommandsService:GetRoleAsync(player)
				if role == "Dev" or role == "Lead" then
					print(string.format("[CommandsService] super-user role given to %s", player.Name))
				end
			end

			task.delay(0.25, function()
				if Debug then
					print(string.format("[CommandsService] Marking user.dirty after role assignment (%s)", player.Name))
				end
				if user then
					user.dirty = true
				end
			end)
		end)
	end

	for _, plr in ipairs(Players:GetPlayers()) do
		giveRole(plr)
	end

	Players.PlayerAdded:Connect(giveRole)
end

function CommandsService:LoadCommandModules()
	local cmdsFolder = script:FindFirstChild("Commands")
	if not cmdsFolder then
		return
	end

	for _, moduleScript in ipairs(cmdsFolder:GetChildren()) do
		if moduleScript:IsA("ModuleScript") then
			local ok, handler = pcall(require, moduleScript)
			if not ok then
				warn("[CommandsService] Failed to require command module", moduleScript:GetFullName(), handler)
			elseif type(handler) == "function" then
				local success, err = pcall(handler, Conch, Config)
				if not success then
					warn("[CommandsService] Command module error", moduleScript.Name, err)
				end
				if Debug then
					print("[CommandsService] Loaded command module", moduleScript.Name)
					for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
						local hadBefore = Conch.console and Conch.console.commands and Conch.console.commands[moduleScript.Name] ~= nil
						print(string.format("  └ replicate_to_player -> %s (command pre-existed=%s)", p.Name, tostring(hadBefore)))
					end
				end
			end
		end
	end

	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		local user = Conch.get_user(player)
		if user then
			user.dirty = true
		end
	end
end

function CommandsService:GetRoleAsync(player)

	for role, users in pairs(Config.Roles) do
		for _, userId in ipairs(users) do
			if tonumber(userId) and player.UserId == tonumber(userId) then
				return role
			elseif tostring(player.Name) == tostring(userId) then
				return role
			end
		end
	end

	if Config.GroupId and Config.MinGroupRank then
		local success, rank = pcall(function()
			return player:GetRankInGroup(Config.GroupId)
		end)

		if success and rank >= Config.MinGroupRank then
			return "Lead"
		end
	end
	

	return nil
end

return CommandsService.new()