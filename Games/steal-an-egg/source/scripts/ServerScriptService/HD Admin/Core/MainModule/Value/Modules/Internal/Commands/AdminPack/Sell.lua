--!strict
-- LOCAL
local MarketplaceService = game:GetService("MarketplaceService")
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHumanoid = CommandAPI.getHumanoid
local promptPurchaseAsync = CommandAPI.promptPurchaseAsync


-- LOCAL FUNCTIONS
local function warnCaller(caller: Player?, warning: string)
	if caller then
		CommandAPI.prompt("warn", caller, warning)
	end
end

local function sellForType(player: Player, caller: Player?, assetId: number, infoType: Enum.InfoType)
	local success, infoOrWarning = pcall(function()
		return MarketplaceService:GetProductInfo(assetId, infoType)
	end)
	if not success then
		warnCaller(caller, `Invalid Id`)
		return
	end
	local success, warning = promptPurchaseAsync(assetId, player, infoType)
	if not success then
		warnCaller(caller, `Failed to Sell {infoType.Name}: {warning}`)
		return
	end
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "SellPass",
		aliases = {"SellGamepass"},
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			sellForType(target, task.caller, integer, Enum.InfoType.GamePass)
		end
	},

    --------------------
	{
		name = "SellAsset",
		aliases = {"SellModel", "SellDecal", "SellAudio"},
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			sellForType(target, task.caller, integer, Enum.InfoType.Asset)
		end
	},

    --------------------
	{
		name = "SellHat",
		aliases = {"SellAccessory", "SellUGC"},
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			sellForType(target, task.caller, integer, Enum.InfoType.Asset)
		end
	},

    --------------------
	{
		name = "SellBundle",
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			sellForType(target, task.caller, integer, Enum.InfoType.Bundle)
		end
	},

    --------------------
	{
		name = "SellProduct",
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			sellForType(target, task.caller, integer, Enum.InfoType.Product)
		end
	},

    --------------------

}


return commands
