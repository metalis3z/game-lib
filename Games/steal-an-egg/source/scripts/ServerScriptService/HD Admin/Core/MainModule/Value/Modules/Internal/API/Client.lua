--!strict

--[[

	We keep the internal API behaviours in here so that we can safely make changes to the
	internals of HD Admin without worrying about impacting developers

--]]


-- LOCAL
local ClientAPI = {}
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Framework = require(modules.Framework)
local Prompt = require(modules.Prompt)
local clientUser = require(modules.References.clientUser)
local Navigate = require(modules.Parent.Controllers.UI.Util.Navigate)


-- TYPES
export type PromptType = Prompt.PromptType
export type PromptOptions = Prompt.PromptOptions
export type PromptHandle = Prompt.Disconnect


-- LOCAL FUNCTIONS
local function findSettingIn(container: any, settingName: string): any
	if typeof(container) ~= "table" then
		return nil
	end
	local playerSettings = container.PlayerSettings
	if typeof(playerSettings) == "table" and playerSettings[settingName] ~= nil then
		return playerSettings[settingName]
	end
	local systemSettings = container.SystemSettings
	if typeof(systemSettings) == "table" and systemSettings[settingName] ~= nil then
		return systemSettings[settingName]
	end
	return container[settingName]
end


-- FUNCTIONS
function ClientAPI.prompt(promptType: PromptType, text: string, options: PromptOptions?): PromptHandle
	Framework.waitUntilLoaded()
	local promptFunction: any = (Prompt :: any)[promptType]
	if typeof(promptFunction) ~= "function" then
		error(`HD Admin: '{tostring(promptType)}' is not a valid prompt type`)
	end
	return promptFunction(text, options)
end

function ClientAPI.getSetting(settingName: string, optionalPlayer: Player?): any
	Framework.waitUntilLoaded()
	local _, gameSettings = (clientUser.everyone :: any):fetchAsync("GameSettings")
	local isLocked = false
	if typeof(gameSettings) == "table" then
		local systemSettings = (gameSettings :: any).SystemSettings
		if typeof(systemSettings) == "table" then
			isLocked = systemSettings["CanChangeYouSettings" .. settingName] == false
		end
	end
	local value: any = nil
	if not isLocked and optionalPlayer == Players.LocalPlayer then
		local _, youSettings = (clientUser.perm :: any):fetchAsync("YouSettings")
		value = findSettingIn(youSettings, settingName)
	end
	if value == nil then
		value = findSettingIn(gameSettings, settingName)
	end
	return value
end

function ClientAPI.getVersion(): string
	Framework.waitUntilLoaded()
	local VERSION = require(modules.Parent.Controllers.UI.Config.VERSION) :: any
	return VERSION.appVersion
end

function ClientAPI.getAppIcon(): any
	Framework.waitUntilLoaded()
	return require(modules.References.appIcon)
end

function ClientAPI.openPanel()
	Framework.waitUntilLoaded()
	Navigate.openPanel()
end

function ClientAPI.closePanel()
	Framework.waitUntilLoaded()
	Navigate.closePanel()
end

function ClientAPI.isPanelOpen(): boolean
	Framework.waitUntilLoaded()
	return Navigate.isPanelOpen()
end

function ClientAPI.openPage(pageName: string)
	Framework.waitUntilLoaded()
	Navigate.openPanel()
	Navigate.toPage(pageName)
end

function ClientAPI.openProfile(userId: number)
	Framework.waitUntilLoaded()
	local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
	Panels.openProfile(userId)
end


return ClientAPI