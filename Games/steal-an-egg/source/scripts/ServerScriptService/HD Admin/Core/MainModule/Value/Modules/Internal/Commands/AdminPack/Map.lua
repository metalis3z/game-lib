--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local Teams = game:GetService("Teams")
local getHumanoid = CommandAPI.getHumanoid
local ServerStorage = game:GetService("ServerStorage")
local mapBackupFolder = Instance.new("Folder")
local backupTerrain: any = nil
local Players = game:GetService("Players")


-- LOCAL FUNCTIONS
local function forEveryValidWorkspaceChild(callback: (part: Instance) -> ())
	local playerNames = {}
	for _, player in Players:GetPlayers() do
		playerNames[player.Name] = true
	end
	for _, instance in workspace:GetChildren() do
		if instance:IsA("Terrain") then
			continue
		end
		if not instance.Archivable then
			continue
		end
		local lowerName = instance.Name:lower()
		if lowerName:match("hd admin") or lowerName:match("hdadmin") then
			continue
		end
		if instance:IsA("Script") then
			continue
		end
		if instance:IsA("Model") and playerNames[instance.Name] then
			continue
		end
		callback(instance)
	end
end

local function getLeaderstats(player: Player): Instance?
	return player:FindFirstChild("leaderstats") or player:FindFirstChild("Leaderstats")
end

local function findStat(player: Player, statName: string): Instance?
	local leaderstats = getLeaderstats(player)
	if not leaderstats then
		return nil
	end
	local statNameLower = statName:lower()
	for _, childStat in leaderstats:GetChildren() do
		if childStat.Name:lower() == statNameLower then
			return childStat
		end
	end
	return nil
end

local function giveStat(player: Player, statName: string)
	if findStat(player, statName) then
		return
	end
	local leaderstats = getLeaderstats(player)
	if not leaderstats then
		leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player
	end
	local stat = Instance.new("IntValue")
	stat.Name = statName
	stat.Parent = leaderstats
end

local function saveMap(caller: Player?)
	CommandAPI.prompt("info", caller, "Saving copy of map...")
	if not mapBackupFolder.Parent then
		mapBackupFolder.Name = "HDAdminMapBackup"
		mapBackupFolder.Parent = ServerStorage
	end
	local terrain = workspace:FindFirstChildOfClass("Terrain")
	backupTerrain = terrain and terrain:CopyRegion(terrain.MaxExtents)
	mapBackupFolder:ClearAllChildren()
	forEveryValidWorkspaceChild(function(instance)
		instance:Clone().Parent = mapBackupFolder
	end)
	CommandAPI.prompt("success", caller, "Map saved!")
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "SaveMap",
		aliases = {"BackupMap"},
		args = {},
		cooldown = 3,
		config = {saveMapOnStart = false},
		loaded = function(command: any)
			if command.config.saveMapOnStart then
				saveMap()
			end
		end,
		run = function(task: CommandAPI.Task)
			saveMap(task.caller)
		end
	},

    --------------------
	{
		name = "LoadMap",
		aliases = {"RestoreMap"},
		args = {},
		cooldown = 3,
		run = function(task: CommandAPI.Task)
			local caller = task.caller
			if not mapBackupFolder.Parent then
				CommandAPI.prompt("error", caller, "No backup found! Use ;saveMap first or set saveMapOnStart to true in <b><i>Config &gt; Commands &gt; Admin</i></b>")
				return
			end
			if caller then
				CommandAPI.prompt("info", caller, "Restoring map...")
			end
			forEveryValidWorkspaceChild(function(instance)
				instance:Destroy()
			end)
			if backupTerrain then
				local terrain = workspace:FindFirstChildOfClass("Terrain")
				if terrain then
					terrain:Clear()
					terrain:PasteRegion(backupTerrain, terrain.MaxExtents.Min, true)
				end
			end
			local mapBackupClone = mapBackupFolder:Clone()
			mapBackupClone.Parent = workspace
			for _, instance in mapBackupClone:GetChildren() do
				instance.Parent = workspace
			end
			mapBackupClone:Destroy()
			if caller then
				CommandAPI.prompt("success", caller, "Map restored!")
			end
		end
	},

    --------------------
	{
		name = "LockMap",
		description = "Locks all parts in workspace, preventing players from selecting and editing parts",
		args = {},
		run = function(task: CommandAPI.Task)
			task:keep("Indefinitely")
			for _, instance in workspace:GetDescendants() do
				if instance:IsA("BasePart") then
					instance.Locked = true
					task:onEnded(function()
						instance.Locked = false
					end)
				end
			end
		end
	},

    --------------------
	{
		name = "LockCharacter",
		aliases = {"LockChar", "LockPlayer", "LockPlr", "LockP"},
		args = {"Player"},
		description = "Locks all parts with the specified player",
		run = function(task: CommandAPI.Task)
			local target = task.target
			local char = target and target.Character
			if not char then return end
			task:keep("UntilTargetRespawns")
			for _, instance in char:GetDescendants() do
				if instance:IsA("BasePart") then
					instance.Locked = true
					task:onEnded(function()
						instance.Locked = false
					end)
				end
			end
		end
	},

    --------------------
	{
		name = "CreateTeam",
		aliases = {"CTeam"},
		args = {"Color", "Text"},
		run = function(task: CommandAPI.Task)
			local color: Color3 = task:getArg("Color")
			local text = task:getArg("Text")
			if text == "" or text == " " then
				text = "Unnamed"
			end
			local textLower = text:lower()
			for _, existingTeam in Teams:GetChildren() do
				if existingTeam:IsA("Team") and existingTeam.Name:lower() == textLower then
					CommandAPI.prompt("warn", task.caller, `Team '{existingTeam.Name}' already exists`)
					return
				end
			end
			local team = Instance.new("Team")
			team.TeamColor = BrickColor.new(color)
			team.Name = text
			team.AutoAssignable = false
			team.Parent = Teams
			CommandAPI.prompt("success", task.caller, `Created team '{text}'`)
		end
	},

    --------------------
	{
		name = "RemoveTeam",
		aliases = {"RTeam"},
		args = {"Team"},
		run = function(task: CommandAPI.Task)
			local team = task:getArg("Team")
			local caller = task.caller
			if not team then
				local allTeams = {}
				for _, existingTeam in Teams:GetChildren() do
					if existingTeam:IsA("Team") then
						table.insert(allTeams, existingTeam)
					end
				end
				if #allTeams == 0 then
					CommandAPI.prompt("warn", caller, "There are no teams to remove")
					return
				end
				-- With a single team the intent is obvious so we just remove it
				if #allTeams == 1 then
					team = allTeams[1]
				else
					local teamNames = {}
					for _, existingTeam in allTeams do
						table.insert(teamNames, existingTeam.Name)
					end
					CommandAPI.prompt("warn", caller, `Specify a team to remove: {table.concat(teamNames, ", ")}`)
					return
				end
			end
			local teamName = team.Name
			team:Destroy()
			CommandAPI.prompt("success", caller, `Removed team '{teamName}'`)
		end
	},

    --------------------
	{
		name = "CreateStat",
		aliases = {"CStat"},
		args = {"Text"},
		-- Stackable so the watchers for different stats can run at the same time
		stackable = true,
		run = function(task: CommandAPI.Task)
			local text = task:getArg("Text")
			local caller = task.caller
			local statName = if typeof(text) == "string" then text:gsub("^%s+", ""):gsub("%s+$", "") else ""
			if statName == "" then
				CommandAPI.prompt("warn", caller, "Specify a stat name, like ;createStat Cash")
				return
			end
			local statNameLower = statName:lower()
			for _, otherTask in CommandAPI.getTasks(task.commandKey) do
				if otherTask ~= task and otherTask.isActive and (otherTask.extra :: any).statName == statNameLower then
					CommandAPI.prompt("warn", caller, `Leaderstat '{statName}' already exists`)
					return
				end
			end
			for _, player in Players:GetPlayers() do
				giveStat(player, statName)
			end
			task.extra.statName = statNameLower
			task:keep("Indefinitely")
			task.janitor:add(Players.PlayerAdded:Connect(function(player: Player)
				giveStat(player, statName)
			end))
			CommandAPI.prompt("success", caller, `Created stat '{statName}'`)
		end
	},

    --------------------
	{
		name = "RemoveStat",
		aliases = {"RStat"},
		args = {"Leaderstat"},
		run = function(task: CommandAPI.Task)
			local stat = task:getArg("Leaderstat")
			local caller = task.caller
			local statName = if stat then (stat :: Instance).Name else nil
			if not statName then
				local callerStatNames = {}
				if caller then
					local leaderstats = getLeaderstats(caller)
					if leaderstats then
						for _, childStat in leaderstats:GetChildren() do
							table.insert(callerStatNames, childStat.Name)
						end
					end
				end
				if #callerStatNames == 0 then
					CommandAPI.prompt("warn", caller, "There are no leaderstats to remove")
					return
				end
				-- With a single stat the intent is obvious so we just remove it
				if #callerStatNames == 1 then
					statName = callerStatNames[1]
				else
					CommandAPI.prompt("warn", caller, `Specify a leaderstat to remove: {table.concat(callerStatNames, ", ")}`)
					return
				end
			end
			if not statName then
				return
			end
			-- End the matching ;createStat watcher too, otherwise joiners would
			-- instantly gain the stat back
			local statNameLower = statName:lower()
			for _, createTask in CommandAPI.getTasks("createstat") do
				if createTask.isActive and (createTask.extra :: any).statName == statNameLower then
					createTask:destroy()
				end
			end
			for _, player in Players:GetPlayers() do
				local playerStat = findStat(player, statName)
				if playerStat then
					playerStat:Destroy()
				end
			end
			CommandAPI.prompt("success", caller, `Removed stat '{statName}'`)
		end
	},

    --------------------

}


return commands
