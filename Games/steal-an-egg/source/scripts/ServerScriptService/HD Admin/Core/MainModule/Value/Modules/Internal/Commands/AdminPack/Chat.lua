--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHumanoid = CommandAPI.getHumanoid


-- LOCAL FUNCTIONS
local function runChatCommand(realTask: CommandAPI.Task, startPrompt: string, endPrompt: string, properties: any)
	local target = realTask.target
	if not target then
		return
	end
	local forceChat = CommandAPI.forceChat
	for key, value in properties do
		target:SetAttribute(key, value)
	end
	target:SetAttribute("HDChatConfigEnabled", true)
	if target == realTask.caller then
		forceChat(target, startPrompt)
	end
	realTask:keep("UntilTargetLeaves")
	realTask:onEndedForGood(function()
		for key, value in properties do
			target:SetAttribute(key, nil)
		end
		if target ~= realTask.caller then
			return
		end
		forceChat(target, endPrompt)
	end)
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "ChatTag",
		aliases	= {"CTag"},
		args = {
			"Player",
			{arg = "OptionalColor", default = Color3.fromRGB(255, 85, 127)},
			"Text",
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local color = task:getArg("OptionalColor")
			local text = task:getArg("Text")
			if text == "" or text == " " then
				text = "ExampleTag"
			end
			runChatCommand(task, "Updated chat tag!", "Reset chat tag!", {
				ChatTag = text,
				ChatTagColor = color,
			})
		end
	},

    --------------------
	{
		name = "ChatTagColor",
		aliases	= {"TagColor"},
		args = {
			"Player",
			{arg = "Color", default = Color3.fromRGB(255, 170, 127)},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local color = task:getArg("Color")
			runChatCommand(task, "Updated chat tag color!", "Reset chat tag color!", {
				ChatTagColor = color,
			})
		end
	},

    --------------------
	{
		name = "ChatName",
		aliases	= {"CName"},
		args = {
			"Player",
			{arg = "OptionalColor", default = Color3.fromRGB(85, 255, 127)},
			"Text",
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local color = task:getArg("OptionalColor")
			local text = task:getArg("Text")
			if text == "" or text == " " then
				text = "ExampleName"
			end
			runChatCommand(task, "Updated chat name!", "Reset chat name!", {
				ChatName = text,
				ChatNameColor = color,
			})
		end
	},

    --------------------
	{
		name = "ChatNameColor",
		aliases	= {"NameColor"},
		args = {
			"Player",
			{arg = "Color", default = Color3.fromRGB(130, 222, 255)},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local color = task:getArg("Color")
			runChatCommand(task, "Updated chat name color!", "Reset chat name color!", {
				ChatNameColor = color,
			})
		end
	},
	
    --------------------
	{
		name = "BubbleChat",
		aliases	= {"BChat"},
		args = {"Player", "Text"},
		run = function(task: CommandAPI.Task)
			local player = task.target
			local text = task:getArg("Text")
			if text == "" or text == " " then
				text = "Example Bubble Message"
			end
			local character = player.Character
			if #text > 0 and character then
				local forceBubbleChat = CommandAPI.forceBubbleChat
				forceBubbleChat(player, character, text)
			end
		end
	},

    --------------------
	{
		name = "SystemMessage",
		aliases	= {"SystemChat", "SystemChat", "SC"},
		args = {"OptionalPlayer", "Text"},
		run = function(task: CommandAPI.Task)
			local player = task.target
			local text = task:getArg("Text")
			if text == "" or text == " " then
				text = "Example System Message"
			end
			if #text > 0 then
				local systemMessage = CommandAPI.systemMessage
				systemMessage(player, text)
			end
		end
	},

    --------------------
}


return commands
