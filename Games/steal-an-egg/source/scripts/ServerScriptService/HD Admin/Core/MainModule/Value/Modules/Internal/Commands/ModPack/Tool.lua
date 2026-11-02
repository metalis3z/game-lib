--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHumanoid = CommandAPI.getHumanoid


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "Sword",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local toolClone = script.Sword:Clone()
			toolClone.Parent = target.Backpack
			local swordClone = toolClone :: any
			swordClone.SwordScript.Enabled = true
			swordClone.MouseIcon.Enabled = true
		end
	},

    --------------------
	{
		name = "HandTo",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local caller = task.caller
			local callerChar = caller and caller.Character
			local callerHumanoid = getHumanoid(caller)
			local targetHumanoid = getHumanoid(target)
			if not callerChar or not callerHumanoid or not targetHumanoid then
				return
			end
			local tool = callerChar:FindFirstChildOfClass("Tool")
			if not tool then
				return
			end
			local toolClone = tool:Clone()
			toolClone.Parent = target.Backpack
			callerHumanoid:UnequipTools()
			targetHumanoid:EquipTool(toolClone)
			tool:Destroy()
		end
	},

    --------------------
	{
		name = "Give",
		aliases = {"GiveTool"},
		args = {"Player", "Tools"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local tools = task:getArg("Tools")
			for _, tool in tools do
				tool:Clone().Parent = target.Backpack
			end
		end
	},

    --------------------
	{
		name = "GiveAll",
		aliases = {"GiveAllTools"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local getToolsInfoAsync = CommandAPI.getToolsInfoAsync
			local target = task.target
			local success, toolsInfo = getToolsInfoAsync()
			if not success or typeof(toolsInfo) ~= "table" then
				return
			end
			for _, toolInfo in toolsInfo do
				local tool = (toolInfo :: any).tool
				if tool then
					tool:Clone().Parent = target.Backpack
				end
			end
		end
	},

    --------------------
	--[[{
		name = "Gears",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			CommandAPI.prompt("info", "Coming soon!")
		end
	},--]]

    --------------------
	{
		name = "Gear",
		args = {"Player", "Integer"},
		config = {
			DenyList = {},
			AllowList = {},
			ReplaceList = {},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			local loadAssetCommand = CommandAPI.loadAssetCommand
			loadAssetCommand(Enum.AssetType.Gear, task, integer, function(item: Instance)
				item.Parent = target.Backpack
			end)
		end
	},

    --------------------
	{
		name = "BuildingTools",
		aliases = {"BTools"},
		credit = {"GigsD4X"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local toolClone = (script :: any)["Building Tools"]:Clone()
			toolClone.Parent = target.Backpack
			-- Only load scripts within building tools once this command is executed to be doubly sure
			-- no vulerabilities accidentally work their way into HD Admin
			for _, child in toolClone:GetDescendants() do
				if child:IsA("Script") or child:IsA("LocalScript") then
					child.Enabled = true
				end
			end
		end
	},

    --------------------
	{
		name = "ClearBackpack",
		aliases = {"ClrBackpack", "ClrBP", "ClearTools", "ClrTools"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local unequipTools = CommandAPI.unequipTools
			local target = task.target
			unequipTools(target)
			task.wait()
			for _, tool in target.Backpack:GetChildren() do
				tool:Destroy()
			end
		end
	},

    --------------------

}


return commands
