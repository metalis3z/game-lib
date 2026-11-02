--!strict

--[[

	We keep the internal API behaviours in here so that we can safely make changes to the
	internals of HD Admin without worrying about impacting developers

--]]


-- LOCAL
local CommandAPI = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local TaskObject = require(modules.Objects.Task)
local Prompt = require(modules.Prompt)


-- TYPES
export type Commands = TaskObject.Commands
export type Command = TaskObject.Command
export type Task = TaskObject.Class
export type ClientCommand = TaskObject.ClientCommand
export type ClientCommands = TaskObject.ClientCommands
export type PromptType = Prompt.PromptType
export type PromptOptions = Prompt.PromptOptions
export type PromptHandle = Prompt.Disconnect


-- LOADING
function CommandAPI.loadCommands(details: any): Commands
	local Internal = require(modules.Internal) :: any
	return Internal.loadCommands(details)
end


-- PROMPT FUNCTIONS
function CommandAPI.prompt(promptType: PromptType, ...: any): PromptHandle
	-- on SERVER: CommandAPI.prompt("info", player, text, options?)
	-- on CLIENT: CommandAPI.prompt("info", text, options?)
	local promptFunction = (Prompt :: any)[promptType]
	if typeof(promptFunction) ~= "function" then
		error(`HD Admin: '{tostring(promptType)}' is not a valid prompt type`)
	end
	return (promptFunction :: any)(...)
end


-- CHARACTER FUNCTIONS
CommandAPI.getHumanoid = require(modules.PlayerUtil.getHumanoid)
CommandAPI.getHRP = require(modules.PlayerUtil.getHRP)
CommandAPI.getHead = require(modules.PlayerUtil.getHead)
CommandAPI.getNeck = require(modules.PlayerUtil.getNeck)
CommandAPI.getTorso = require(modules.PlayerUtil.getTorso)
CommandAPI.loadCharacter = require(modules.PlayerUtil.loadCharacter)


-- PLAYER FUNCTIONS
CommandAPI.getUserInfoAsync = require(modules.PlayerUtil.getUserInfoAsync)
CommandAPI.getNameFromUserIdAsync = require(modules.PlayerUtil.getNameFromUserIdAsync)
CommandAPI.teleportAsync = require(modules.PlayerUtil.teleportAsync)
CommandAPI.unequipTools = require(modules.PlayerUtil.unequipTools)


-- TASK FUNCTIONS
CommandAPI.getTasks = TaskObject.getTasks
CommandAPI.getTasksByCallerId = TaskObject.getTasksByCallerId


-- CHAT FUNCTIONS
CommandAPI.systemMessage = require(modules.ChatUtil.systemMessage)
CommandAPI.forceChat = require(modules.ChatUtil.forceChat)
CommandAPI.forceBubbleChat = require(modules.ChatUtil.forceBubbleChat)


-- OUTFIT FUNCTIONS
CommandAPI.getDescription = require(modules.OutfitUtil.getDescription)
CommandAPI.applyDescription = require(modules.OutfitUtil.applyDescription)
CommandAPI.outfitBuff = require(modules.OutfitUtil.outfitBuff)
CommandAPI.setFakeBodyParts = require(modules.OutfitUtil.setFakeBodyParts)
CommandAPI.clearFakeBodyParts = require(modules.OutfitUtil.clearFakeBodyParts)
CommandAPI.runBundleId = require(modules.OutfitUtil.runBundleId)


-- ASSET FUNCTIONS
CommandAPI.registerSound = require(modules.AssetUtil.registerSound)
CommandAPI.setAnchored = require(modules.AssetUtil.setAnchored)
CommandAPI.setTransparency = require(modules.AssetUtil.setTransparency)
CommandAPI.promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
CommandAPI.ownsAssetAsync = require(modules.AssetUtil.ownsAssetAsync)
CommandAPI.isTypeAsync = require(modules.VerifyUtil.isTypeAsync)
CommandAPI.loadAssetCommand = require(modules.CommandUtil.loadAssetCommand)
CommandAPI.getToolsInfoAsync = require(modules.CommandUtil.getToolsInfoAsync)


-- UTILITY FUNCTIONS
CommandAPI.getTargets = require(modules.CommandUtil.getTargets)
CommandAPI.setCameraSubject = require(modules.CommandUtil.setCameraSubject)
CommandAPI.runPromptCommand = require(modules.CommandUtil.runPromptCommand)
CommandAPI.runEmoteId = require(modules.CommandUtil.runEmoteId)
CommandAPI.createEmoteCommand = require(modules.CommandUtil.createEmoteCommand)
CommandAPI.createBundleCommand = require(modules.CommandUtil.createBundleCommand)
CommandAPI.bindEmotePrompt = require(modules.CommandUtil.bindEmotePrompt)
CommandAPI.openProfile = require(modules.CommandUtil.openProfile)
CommandAPI.openPage = require(modules.CommandUtil.openPage)
CommandAPI.openEmotes = require(modules.CommandUtil.openEmotes)
CommandAPI.colourRoleName = require(modules.RoleUtil.colourRoleName)
CommandAPI.isTableEmpty = require(modules.TableUtil.isTableEmpty)
CommandAPI.round = require(modules.MathUtil.round)


return CommandAPI
