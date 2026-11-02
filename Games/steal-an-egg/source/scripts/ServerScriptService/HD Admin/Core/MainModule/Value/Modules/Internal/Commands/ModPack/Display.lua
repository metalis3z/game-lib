--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHumanoid = CommandAPI.getHumanoid
local getHead = CommandAPI.getHead
local openPage = CommandAPI.openPage


-- COMMANDS
local commands: CommandAPI.Commands = { 

    --------------------
	{
		name = "Ping",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target: Player = task.target
			task.client:run(target)
			task.client.replicator = function(replicateTo, ...)
				replicateTo(target, ...)
			end
			task.wait(1)
		end
	},

    --------------------
	{
		name = "HideGuis",
		aliases = {"HideScreen"},
		undoAliases = {"ShowGuis", "ShowScreen"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target: Player = task.target
			task:keep("UntilTargetLeaves")
			task.client:run(target)
		end
	},

    --------------------
	{
		name = "NightVision",
		aliases = {"NV"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetLeaves")
			task.client:run(target)
			task:bindPrompt({
				title = "Night Vision",
			})
		end
	},

    --------------------
	{
		name = "Blur",
		args = {
			"Player",
			{arg = "Number", default = 20, min = 0, max = 100, step = 1},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local blurSize = task:getArg("Number")
			task:keep("UntilTargetLeaves")
			task.client:run(target, blurSize)
		end
	},

    --------------------
	{
		name = "View",
		aliases	= {"Watch", "Spectate"},
		args = {"SinglePlayer"},
		run = function(task: CommandAPI.Task)
			local playerToView = task.target
			local caller = task.caller
			if not playerToView or not caller then return end
			task:keep("UntilCallerLeaves")
			task:keep("UntilTargetLeaves")
			task.client:run(caller, playerToView)
			task:bindPrompt({
				title = "Spectating",
				text = `Viewing {playerToView.DisplayName}`,
				audience = caller,
			})
		end
	},

    --------------------
	{
		name = "Name",
		aliases = {"FakeName"},
		args = {"Player", "Text"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local humanoid = getHumanoid(target)
			local text = task:getArg("Text")
			if not text or text == "" then
				text = "Example Fake Name"
			end
			if not humanoid then return end
			task:keep("UntilTargetRespawns")
			humanoid.DisplayName = text
			CommandAPI.prompt("info", target, `Updated display name to '{text}'`)
			task:onEnded(function()
				humanoid.DisplayName = target.Name
				CommandAPI.prompt("info", target, `Reset display name to '{target.Name}'`)
			end)
		end
	},

    --------------------
	{
		name = "HideName",
		undoAliases = {"ShowName"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local humanoid = getHumanoid(target)
			if not humanoid then return end
			task:keep("UntilTargetRespawns")
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			CommandAPI.prompt("info", target, `Your display name has been hidden from other players`)
			task:onEnded(function()
				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
				CommandAPI.prompt("info", target, `Your display name is now visible to other players`)
			end)
		end
	},

    --------------------
	{
		name = "Title",
		groups = {"Title"},
		args = {"Player", "OptionalColor", "Text"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local text = task:getArg("Text")
			local head = getHead(target)
			if not head then return end
			local color = task:getArg("OptionalColor")
			local janitor = task.janitor
			local hue, saturation, value = color:ToHSV()
			local title = janitor:add(require(script.title)()) :: any
			task:keep("UntilTargetRespawns")
			title.Name = "HDAdminTitle"
			title.Parent = head
			title.TextLabel.Text = text
			title.TextLabel.TextColor3 = color
			title.TextLabel.TextStrokeColor3 = Color3.fromHSV(hue, saturation, value*0.2)
		end
	},

    --------------------
	{
		name = "Commands",
		aliases = {"Cmds"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Commands")
		end
	},

    --------------------
	{
		name = "Bans",
		aliases = {"Banland"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Moderation", "Bans")
		end
	},

    --------------------
	{
		name = "Warns",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Moderation", "Warns")
		end
	},

    --------------------
	{
		name = "Logs",
		aliases = {"ChatLogs"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Logs")
		end
	},

    --------------------
	{
		name = "Roles",
		aliases = {"RoleList"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Roles", "Roles")
		end
	},

    --------------------
	{
		name = "Members",
		aliases = {"MemberList"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Roles", "Members")
		end
	},

    --------------------
	{
		name = "Tasks",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Tasks")
		end
	},

    --------------------
	{
		name = "Analytics",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Analytics")
		end
	},

    --------------------
	{
		name = "YouSettings",
		aliases = {"Settings"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Settings", "You")
		end
	},

    --------------------
	{
		name = "GameSettings",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			openPage(target, "Settings", "Game")
		end
	},

    --------------------

}


return commands
