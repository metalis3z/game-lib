--!strict
-- LOCAL
local FLIGHT_GROUPS = {"Flight"}
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local teleportAsync = CommandAPI.teleportAsync
local getHRP = CommandAPI.getHRP
local getHead = CommandAPI.getHead
local farlandBaseplate = nil :: any
local farlandCount = 0


-- LOCAL FUNCTIONS
local function teleportPlayers(playersToTeleport: {Player}, toPlayer: Player?)
	-- This could be improved in the future to account for each individual characters width
	local GAP = 2
	local totalPlrs = #playersToTeleport
	local targetHead = toPlayer and getHead(toPlayer)
	if not targetHead then
		return
	end
	for index, plr in playersToTeleport do
		if plr == toPlayer then
			continue
		end
		local head = getHead(plr)
		if not head then
			continue
		end
		local targetCFrame = targetHead.CFrame * CFrame.new(-(totalPlrs*(GAP/2))+(index*GAP)-(GAP/2), 0, -4) * CFrame.Angles(0, math.rad(180), 0)
		task.defer(function()
			teleportAsync(plr, targetCFrame)
		end)
	end
end

local function runFlight(task: CommandAPI.Task, target: Player)
	task:keep("UntilTargetRespawns")
	task.client:run(target, task:getArg("FlightSpeed"))
	task:bindPrompt({
		text = "Press E to toggle • WASD to move • Space / Ctrl for up / down",
		args = {"FlightSpeed"},
		onChange = function(arg, value)
			task.client:run(target, value)
		end,
	})
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "Fly",
		aliases = {"Flight"},
		groups = FLIGHT_GROUPS,
		args = {"Player", "FlightSpeed"},
		run = function(task: CommandAPI.Task)
			runFlight(task, task.target)
		end
	},

    --------------------
	{
		name = "Fly2",
		aliases = {"Flight2"},
		groups = FLIGHT_GROUPS,
		args = {"Player", "FlightSpeed"},
		run = function(task: CommandAPI.Task)
			runFlight(task, task.target)
		end
	},

    --------------------
	{
		name = "NoClip",
		undoAliases = {"Clip"},
		groups = FLIGHT_GROUPS,
		args = {"Player", "FlightSpeed"},
		run = function(task: CommandAPI.Task)
			runFlight(task, task.target)
		end
	},

    --------------------
	{
		name = "Noclip2",
		undoAliases = {"Clip2"},
		groups = FLIGHT_GROUPS,
		args = {"Player", "FlightSpeed"},
		run = function(task: CommandAPI.Task)
			runFlight(task, task.target)
		end
	},

    --------------------
	{
		name = "Farland",
		args = {"Player"},
		credit = {"Mavreis", "ForeverHD"},
		run = function(task: CommandAPI.Task)

			local target = task.target
			local janitor = task.janitor
			local FARLAND_CFRAME = CFrame.new(993648,993648,993648)
			local baseplateCFrame = FARLAND_CFRAME + Vector3.new(0, -10, 0)
			if not farlandBaseplate then
				farlandBaseplate = require(script.baseplate)() :: any
				farlandBaseplate.Name = "HDAdminFarlandBaseplate"
				farlandBaseplate.CFrame = baseplateCFrame
				farlandBaseplate.Parent = workspace
			end
			farlandCount += 1
			janitor:add(function()
				farlandCount -= 1
				if farlandCount <= 0 and farlandBaseplate then
					farlandBaseplate:Destroy()
					farlandBaseplate = nil
				end
			end)

			local baseplateStand = janitor:add(farlandBaseplate:Clone())
			baseplateStand.Name = "HDAdminFarlandBaseplateStand"
			baseplateStand.CFrame = baseplateCFrame
			baseplateStand.Transparency = 1
			baseplateStand.Texture.Transparency = 1
			baseplateStand.Parent = workspace
			task.client:expose(target, baseplateStand)

			-- This handles teleportation
			task:keep("UntilTargetRespawns")
			task:buff(target, "Teleport", function(hasEnded, originalValue: any, isFirst)
				local hrp = getHRP(target)
				local originalCFrame = if hrp then hrp.CFrame else CFrame.new(0, 0, 0)
				local targetCFrame = if hasEnded then originalValue else FARLAND_CFRAME
				teleportAsync(target, targetCFrame)
				return originalCFrame
			end)

		end
	},

    --------------------
	{
		name = "Apparate",
		aliases = {"Ap", "Skip"},
		args = {
			"Player",
			{arg = "Number", display = "Distance", default = 8, min = 0, max = 250, step = 1, logarithmic = true},
		},
		run = function(task: CommandAPI.Task)
			local target: Player = task.target
			local targetHRP = getHRP(target)
			if not targetHRP then return end
			local distance = task:getArg("Number")
			local targetCFrame = targetHRP.CFrame * CFrame.new(0, 0, -distance)
			teleportAsync(target, targetCFrame)
		end
	},

	--------------------
	{
		name = "Teleport",
		aliases = {"TP"},
		args = {"Players", "SinglePlayer"},
		run = function(task: CommandAPI.Task)
			local players = task:getArg("Players")
			local toPlayer = task:getArg("SinglePlayer")
			teleportPlayers(players, toPlayer)
		end
	},

    --------------------
	{
		name = "Bring",
		aliases = {"Br"},
		args = {"Players"},
		run = function(task: CommandAPI.Task)
			local players = task:getArg("Players")
			local toPlayer = task.caller
			teleportPlayers(players, toPlayer)
		end
	},

    --------------------
	{
		name = "GoTo",
		aliases = {"To"},
		args = {"SinglePlayer"},
		run = function(task: CommandAPI.Task)
			local singlePlayer = task.target
			local callerPlayer = task.caller
			if singlePlayer and callerPlayer then
				teleportPlayers({callerPlayer}, singlePlayer)
			end
		end
	},

    --------------------

}


return commands
