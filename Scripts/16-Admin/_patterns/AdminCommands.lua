--[[
	AdminCommands  (ModuleScript, server only)

	A small, safe text command system for your own staff.
	  * ONE RemoteFunction; the server checks the permission level on every call
	  * commands registered with a required level, argument list and help text
	  * player selectors: me, all, others, @username, exact or partial name
	  * per-admin rate limit and an audit log that is only ever sent to admins
	  * real bans with the Roblox Ban API (Players:BanAsync / UnbanAsync)
	  * no "run code" command, no hidden ids, nothing loaded from outside

	Credit: drill-and-mine AdminCommandsService (tokenize + command table + aliases + help,
	destructive commands for the owner only), catalogue-avatar-creator CmdrServer (me/all
	selectors, pcall'd handlers), aura-ascension AdminService (rate limit, allowed-command
	whitelist, audit trail), escape-kitty-keyboard AdminPanelServer (kick/ban/unban/freeze).

	Usage (server Script):
		local AdminPermissions = require(script.AdminPermissions)
		local AdminCommands = require(script.AdminCommands)
		AdminPermissions.Configure({ GroupRanks = { Moderator = 100, Admin = 200 } })
		AdminCommands.Start() -- creates ReplicatedStorage.AdminCommand (RemoteFunction)

		AdminCommands.Register("givecoins", {
			Level = "Admin",
			Args = { "players", "number" },
			Help = "givecoins <players> <amount>",
			Run = function(admin, targets, amount)
				for _, target in targets do
					local data = MyData:Get(target)
					if data then data.Coins += amount end
				end
				return ("Gave %d coins to %d player(s)"):format(amount, #targets)
			end,
		})

	Client: local reply = ReplicatedStorage.AdminCommand:InvokeServer("givecoins me 500")
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AdminPermissions = require(script.Parent.AdminPermissions)

local AdminCommands = {}

local RATE_LIMIT = 0.5 -- seconds between commands per admin
local MAX_INPUT = 300
local AUDIT_SIZE = 100

local commands = {} -- [name] = definition
local aliases = {} -- [alias] = name
local lastRun = {}
local audit = {}

------------------------------------------------------------------------
-- Argument parsing
------------------------------------------------------------------------

local function findByName(query)
	query = string.lower(query)
	for _, player in ipairs(Players:GetPlayers()) do
		if string.lower(player.Name) == query or string.lower(player.DisplayName) == query then
			return { player }
		end
	end
	local matches = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if string.sub(string.lower(player.Name), 1, #query) == query
			or string.sub(string.lower(player.DisplayName), 1, #query) == query then
			table.insert(matches, player)
		end
	end
	return matches
end

local function parsePlayers(admin, text)
	local lower = string.lower(text)
	if lower == "me" then
		return { admin }
	elseif lower == "all" then
		return Players:GetPlayers()
	elseif lower == "others" then
		local list = {}
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= admin then
				table.insert(list, player)
			end
		end
		return list
	end
	return findByName((text:gsub("^@", "")))
end

local PARSERS = {
	string = function(_, text)
		return text
	end,
	number = function(_, text)
		local value = tonumber(text)
		if not value or value ~= value or math.abs(value) == math.huge then
			return nil, "not a number: " .. text
		end
		return value
	end,
	player = function(admin, text)
		local list = parsePlayers(admin, text)
		if #list ~= 1 then
			return nil, if #list == 0 then "no player matches '" .. text .. "'" else "'" .. text .. "' matches several players"
		end
		return list[1]
	end,
	players = function(admin, text)
		local list = parsePlayers(admin, text)
		if #list == 0 then
			return nil, "no player matches '" .. text .. "'"
		end
		return list
	end,
}

------------------------------------------------------------------------

function AdminCommands.Register(name, definition)
	assert(type(definition.Run) == "function", "command needs Run")
	assert(AdminPermissions.Levels[definition.Level or "Admin"], "unknown level for " .. name)
	definition.Level = definition.Level or "Admin"
	definition.Args = definition.Args or {}
	commands[string.lower(name)] = definition
	for _, alias in ipairs(definition.Aliases or {}) do
		aliases[string.lower(alias)] = string.lower(name)
	end
end

local function log(admin, line, ok, reply)
	table.insert(audit, 1, { By = admin.Name, UserId = admin.UserId, Command = line, Ok = ok, Reply = reply, At = os.time() })
	while #audit > AUDIT_SIZE do
		table.remove(audit)
	end
end

function AdminCommands.Run(admin, line)
	if type(line) ~= "string" or #line == 0 or #line > MAX_INPUT then
		return "Invalid input."
	end
	if not AdminPermissions.Has(admin, "Moderator") then
		return "You don't have permission." -- lowest staff level; each command checks its own level too
	end
	local now = os.clock()
	if now - (lastRun[admin] or 0) < RATE_LIMIT then
		return "Slow down."
	end
	lastRun[admin] = now

	local words = {}
	for word in string.gmatch(line, "%S+") do
		table.insert(words, word)
	end
	local name = string.lower(table.remove(words, 1))
	name = aliases[name] or name
	local command = commands[name]
	if not command then
		return ("Unknown command '%s'. Try 'help'."):format(name)
	end
	if not AdminPermissions.Has(admin, command.Level) then
		log(admin, line, false, "denied")
		return ("'%s' needs %s."):format(name, command.Level)
	end

	-- The last "string" argument swallows the rest of the line (for reasons / messages).
	local values = {}
	for index, kind in ipairs(command.Args) do
		local text = words[index]
		if index == #command.Args and kind == "string" and #words > index then
			text = table.concat(words, " ", index)
		end
		if text == nil then
			if command.Optional and index > command.Optional then
				break
			end
			return "Usage: " .. (command.Help or name)
		end
		local value, err = PARSERS[kind](admin, text)
		if value == nil then
			return "Error: " .. err
		end
		values[index] = value
	end

	local ok, reply = pcall(command.Run, admin, table.unpack(values, 1, #command.Args))
	reply = if ok then tostring(reply or "Done.") else "Command failed: " .. tostring(reply)
	log(admin, line, ok, reply)
	return reply
end

-- Last audit entries; only call this for admins.
function AdminCommands.GetAudit()
	return table.clone(audit)
end

------------------------------------------------------------------------
-- Built-in commands
------------------------------------------------------------------------

local function registerBuiltIns()
	AdminCommands.Register("help", {
		Level = "Moderator",
		Help = "help - list the commands you can use",
		Run = function(admin)
			local lines = {}
			for name, command in pairs(commands) do
				if AdminPermissions.Has(admin, command.Level) then
					table.insert(lines, command.Help or name)
				end
			end
			table.sort(lines)
			return table.concat(lines, "\n")
		end,
	})

	AdminCommands.Register("kick", {
		Level = "Moderator",
		Args = { "player", "string" },
		Optional = 1,
		Help = "kick <player> [reason]",
		Run = function(admin, target, reason)
			if target == admin or AdminPermissions.Has(target, AdminPermissions.GetLevel(admin)) then
				return "You can't kick someone at or above your level."
			end
			target:Kick(reason or "Kicked by a moderator.")
			return "Kicked " .. target.Name
		end,
	})

	AdminCommands.Register("ban", {
		Level = "Admin",
		Args = { "player", "number", "string" },
		Optional = 1,
		Help = "ban <player> [hours, 0 = forever] [reason]",
		Run = function(admin, target, hours, reason)
			if target == admin or AdminPermissions.Has(target, AdminPermissions.GetLevel(admin)) then
				return "You can't ban someone at or above your level."
			end
			local duration = if hours and hours > 0 then math.floor(hours * 3600) else -1
			Players:BanAsync({
				UserIds = { target.UserId },
				Duration = duration,
				DisplayReason = reason or "You have been banned.",
				PrivateReason = ("Banned by %s (%d)"):format(admin.Name, admin.UserId),
				ExcludeAltAccounts = false,
				ApplyToUniverse = true,
			})
			return ("Banned %s %s"):format(target.Name, if duration < 0 then "forever" else "for " .. hours .. "h")
		end,
	})

	AdminCommands.Register("unban", {
		Level = "Admin",
		Args = { "number" },
		Help = "unban <userId>",
		Run = function(_, userId)
			Players:UnbanAsync({ UserIds = { math.floor(userId) }, ApplyToUniverse = true })
			return "Unbanned " .. math.floor(userId)
		end,
	})

	AdminCommands.Register("announce", {
		Level = "Admin",
		Args = { "string" },
		Help = "announce <message>",
		Run = function(admin, message)
			local remote = ReplicatedStorage:FindFirstChild("AdminAnnouncement")
			if remote then
				remote:FireAllClients(message, admin.DisplayName)
			end
			return "Announced."
		end,
	})
end

function AdminCommands.Start()
	registerBuiltIns()

	local remote = Instance.new("RemoteFunction")
	remote.Name = "AdminCommand"
	remote.Parent = ReplicatedStorage
	remote.OnServerInvoke = AdminCommands.Run

	local announcement = Instance.new("RemoteEvent")
	announcement.Name = "AdminAnnouncement"
	announcement.Parent = ReplicatedStorage

	Players.PlayerRemoving:Connect(function(player)
		lastRun[player] = nil
	end)
end

return AdminCommands
