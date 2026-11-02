--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local runVoteCommand = require(modules.CommandUtil.runVoteCommand)
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")


-- COMMANDS
local commands: CommandAPI.Commands = {

	--------------------
	{
		name = "Insert",
		args = {"Integer"},
		config = {
			DenyList = {},
			AllowList = {},
			ReplaceList = {},
		},
		run = function(task: CommandAPI.Task)
			local integer = task:getArg("Integer")
			local loadAssetCommand = CommandAPI.loadAssetCommand
			loadAssetCommand(Enum.AssetType.Model, task, integer, function(item: Instance)
				task:keep("Indefinitely")
				task.janitor:add(item)
				item.Parent = workspace
			end)
		end,
	},

	--------------------
	{
		name = "ForcePlace",
		aliases	= {"FPlace"},
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local caller = task.caller
			local target = task.target
			local integer = task:getArg("Integer")
			local success, placeInfo = pcall(function()
				return MarketplaceService:GetProductInfo(integer)
			end)
			local placeName = placeInfo and placeInfo.Name
			if typeof(placeName) ~= "string" then
				CommandAPI.prompt("error", caller, `{integer} is an invalid placeId`)
				return
			end
			local success = pcall(function()
				return TeleportService:Teleport(integer, target)
			end)
			if not success then
				CommandAPI.prompt("error", caller, `Teleport failed for {target.Name}`)
				return
			end
		end
	},

	--------------------
	-- This broadcasts itself from its own run rather than carrying the global modifier
	{
		name = "GlobalVote",
		aliases = {"GV", "GlobalPoll"},
		stackable = true,
		autoPreview = true,
		disableModifiers = true,
		disableGlobalModifiers = true,
		args = {"OptionalPlayers", "OptionalVoteTime", "OptionalShareResults", {arg = "Text", display = "Question"}, "Fields"},
		run = runVoteCommand,
	},

	--------------------

}


return commands
