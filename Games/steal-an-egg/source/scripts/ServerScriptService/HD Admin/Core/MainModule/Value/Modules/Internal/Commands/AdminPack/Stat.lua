--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHumanoid = CommandAPI.getHumanoid


-- LOCAL FUNCTIONS
local function warnInvalidStat(task: CommandAPI.Task, target: Player)
	local leaderstats = target:FindFirstChild("leaderstats") or target:FindFirstChild("Leaderstats")
	local statNames = {}
	if leaderstats then
		for _, childStat in leaderstats:GetChildren() do
			table.insert(statNames, childStat.Name)
		end
	end
	if #statNames == 0 then
		CommandAPI.prompt("warn", task.caller, `{target.Name} has no leaderstats`)
		return
	end
	CommandAPI.prompt("warn", task.caller, `Specify a leaderstat: {table.concat(statNames, ", ")}`)
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "ChangeStat",
		args = {"Player", "Leaderstat", "String"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local stat = task:getArg("Leaderstat")
			local text = task:getArg("String")
			if not stat then
				warnInvalidStat(task, target)
				return
			end
			if stat:IsA("IntValue") or stat:IsA("NumberValue") then
				local value = tonumber(text)
				if not value then
					CommandAPI.prompt("warn", task.caller, "Value must be a number")
					return
				end
				stat.Value = value
				return
			end
			stat.Value = text
		end
	},

    --------------------
	{
		name = "AddStat",
		args = {"Player", "Leaderstat", "String"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local stat = task:getArg("Leaderstat")
			local text = task:getArg("String")
			if not stat then
				warnInvalidStat(task, target)
				return
			end
			local value = tonumber(text)
			if not value then
				CommandAPI.prompt("warn", task.caller, "Value must be a number")
				return
			end
			stat.Value += value
		end
	},

    --------------------
	{
		name = "SubtractStat",
		aliases = {"SubStat"},
		args = {"Player", "Leaderstat", "String"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local stat = task:getArg("Leaderstat")
			local text = task:getArg("String")
			if not stat then
				warnInvalidStat(task, target)
				return
			end
			local value = tonumber(text)
			if not value then
				CommandAPI.prompt("warn", task.caller, "Value must be a number")
				return
			end
			stat.Value -= value
		end
	},

    --------------------
	{
		name = "ResetStats",
		aliases = {"ReStats", "ClearStats"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local leaderstats = target:FindFirstChild("leaderstats") or target:FindFirstChild("Leaderstats")
			if not leaderstats or #leaderstats:GetChildren() == 0 then
				CommandAPI.prompt("warn", task.caller, `{target.Name} has no leaderstats to reset`)
				return
			end
			for _,stat in leaderstats:GetChildren() do
				if stat:IsA("IntValue") or stat:IsA("NumberValue") then
					stat.Value = 0
				elseif stat:IsA("BoolValue") then
					stat.Value = false
				end
			end
		end
	},

    --------------------
	
}


return commands
