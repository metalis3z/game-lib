--!strict
-- LOCAL 
local PromptController = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local Popups = require(modules.Parent.Controllers.UI.Util.Popups)
local Fusion = require(modules.Parent.Packages.Fusion)
local activePrompts: {[string]: any} = {}
local actionStates: {[string]: any} = {}
local actionIconButtons: {[string]: any} = {}
local actionButtonLoading: {[string]: any} = {}
local actionControlValues: {[string]: any} = {}


-- TYPES
type PromptType = Prompt.PromptType
type PromptOptions = Prompt.PromptOptions


-- LOCAL
local controlRemote: any = nil
local function getControlRemote(): any
	if not controlRemote then
		controlRemote = Remote.get("PromptControl")
	end
	return controlRemote
end

local function openPageDirect(pageId: string)
	local Navigate = require(modules.Parent.Controllers.UI.Util.Navigate) :: any
	Navigate.awaitReady(3)
	if Navigate.isPanelOpen() then
		Navigate.toPage(pageId)
		return
	end
	-- Navigate while the menu is still hidden and let the slide settle, so
	-- opening lands straight on the page instead of flashing the dashboard
	Navigate.toPage(pageId)
	task.wait(0.35)
	Navigate.openPanel()
end

local promptUpdateConnected = false
local function ensurePromptUpdateListener()
	if promptUpdateConnected then
		return
	end
	promptUpdateConnected = true
	local remote = Remote.get("PromptUpdate")
	if not remote then
		return
	end
	remote:onClientEvent(function(promptId: string?, state: string?, updated: any)
		if typeof(promptId) ~= "string" then
			return
		end
		local stateValue = actionStates[promptId]
		if stateValue and typeof(state) == "string" then
			stateValue:set(state)
		end
		if typeof(updated) == "table" then
			local iconButtonsValue = actionIconButtons[promptId]
			if iconButtonsValue and updated.iconButtons then
				iconButtonsValue:set(updated.iconButtons)
			end
			local buttonLoadingValue = actionButtonLoading[promptId]
			if buttonLoadingValue and typeof(updated.buttonLoading) == "table" then
				local current = Fusion.peek(buttonLoadingValue)
				local merged = table.clone(if typeof(current) == "table" then current else {})
				for buttonId, isLoading in updated.buttonLoading do
					merged[buttonId] = isLoading == true
				end
				buttonLoadingValue:set(merged)
			end
			local controlValuesValue = actionControlValues[promptId]
			if controlValuesValue and typeof(updated.controlValues) == "table" then
				controlValuesValue:set(updated.controlValues)
			end
		end
	end)
end


-- SETUP
Remote.get("Prompt"):onClientEvent(function(promptType: PromptType, text: string, options: PromptOptions?, promptId: string?)
	local func = (Prompt :: any)[promptType :: any] :: any
	if not func then
		warn(`HD Admin: No client handler for prompt type {promptType}`)
		return
	end
	local opts: any = options
	if typeof(opts) == "table" and typeof(opts.localEpoch) == "number" and typeof(text) == "string" then
		local formatted = os.date("%H:%M on %d %b %Y", opts.localEpoch)
		text = (text:gsub("%%TIME%%", tostring(formatted)))
	end
	if typeof(text) == "string" and text:find("%PRIMARY%", 1, true) then
		local Theme = require(modules.Parent.Controllers.UI.Util.Theme) :: any
		local primary = Fusion.peek(Theme.Color.Primary) :: Color3
		local hex = string.format("%02X%02X%02X", math.floor(primary.R * 255 + 0.5), math.floor(primary.G * 255 + 0.5), math.floor(primary.B * 255 + 0.5))
		text = (text:gsub("%%PRIMARY%%", "#" .. hex))
	end
	if typeof(opts) == "table" and typeof(opts.openPage) == "string" then
		local pageId = opts.openPage
		if pageId == "About" then
			(require(modules.Parent.Controllers.UI.Util.AboutPreload) :: any).warm()
		end
		opts.onActivate = function()
			task.spawn(openPageDirect, pageId)
		end
	end
	if typeof(opts) == "table" and opts.openVetting == true then
		opts.onActivate = function()
			task.spawn(function()
				local VettingState = require(modules.Parent.Controllers.UI.Config.VettingState) :: any
				VettingState.open(true)
			end)
		end
	end
	if typeof(opts) == "table" and opts.openProfile == true then
		opts.onActivate = function()
			task.spawn(function()
				local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
				Panels.openProfile(game:GetService("Players").LocalPlayer.UserId)
			end)
		end
	end
	if typeof(opts) == "table" and typeof(opts.promptProduct) == "string" then
		local productName = opts.promptProduct :: string
		opts.onActivate = function()
			task.spawn(function()
				local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
				promptPurchaseAsync(productName :: any)
			end)
		end
	end
	if typeof(opts) == "table" and typeof(opts.linkButtons) == "table" then
		local Icons = require(modules.Parent.Controllers.UI.Config.Icons) :: any
		local footerButtons = {}
		for _, buttonInfo in opts.linkButtons :: {any} do
			if typeof(buttonInfo) ~= "table" or typeof(buttonInfo.label) ~= "string" then
				continue
			end
			local pageId = if typeof(buttonInfo.page) == "string" then buttonInfo.page else nil
			-- We pre-load About here before its potentially tapped through too
			if pageId == "About" then
				(require(modules.Parent.Controllers.UI.Util.AboutPreload) :: any).warm()
			end
			local opensProfile = buttonInfo.profile == true
			local unlockRoleKey = if typeof(buttonInfo.unlockRole) == "string" then buttonInfo.unlockRole else nil
			local icon = if pageId then (Icons.Pages :: any)[pageId]
				elseif opensProfile then (Icons.Pages :: any).Profile
				else nil
			table.insert(footerButtons, {
				label = buttonInfo.label,
				icon = icon,
					large = unlockRoleKey ~= nil,
				style = if typeof(buttonInfo.style) == "string" then buttonInfo.style else nil,
				onActivate = function()
					if opensProfile then
						local Panels = require(modules.Parent.Controllers.UI.Config.Panels) :: any
						Panels.openProfile(game:GetService("Players").LocalPlayer.UserId)
					elseif unlockRoleKey then
						-- Re-prompts the role's best giver (purchase or group join)
						local CommandAccess = require(modules.Parent.Controllers.UI.Util.CommandAccess) :: any
						local clientUser = require(modules.References.clientUser) :: any
						local success, roleInfo = clientUser.everyone:fetchAsync("RoleInfo")
						if success then
							CommandAccess.promptUnlock(roleInfo, unlockRoleKey)
						end
					elseif pageId then
						openPageDirect(pageId)
					end
				end,
			})
		end
		if #footerButtons > 0 then
			opts.footerButtons = footerButtons
		end
	end
	if typeof(opts) == "table" and typeof(opts.openImage) == "table" and typeof(opts.openImage.image) == "string" then
		local imageDetails = opts.openImage
		opts.keepOpenOnActivate = true
		opts.onActivate = function()
			Popups.push("centre", {
				kind = "message",
				text = "",
				options = {
					title = imageDetails.title,
					image = imageDetails.image,
					imageRatio = if typeof(imageDetails.ratio) == "number" then imageDetails.ratio else nil,
					duration = 0,
					userOpened = true,
				},
			})
		end
	end
	if typeof(promptId) == "string" then
		local id: string = promptId
		opts = opts or {}
		opts.onClosed = function()
			activePrompts[id] = nil
			actionStates[id] = nil
			actionIconButtons[id] = nil
			actionButtonLoading[id] = nil
			actionControlValues[id] = nil
		end
		if promptType == "action" then
			ensurePromptUpdateListener()
			actionStates[id] = Popups.value(if typeof(opts.state) == "string" then opts.state else "active")
			opts.actionState = actionStates[id]
			actionIconButtons[id] = Popups.value(opts.iconButtons)
			opts.iconButtonsState = actionIconButtons[id]
			actionButtonLoading[id] = Popups.value({})
			opts.buttonLoadingState = actionButtonLoading[id]
			actionControlValues[id] = Popups.value({})
			opts.controlValuesState = actionControlValues[id]
			opts.onAction = function(actionType: string, controlId: string, value: any)
				local remote = getControlRemote()
				if remote then
					remote:fireServer(id, actionType, controlId, value)
				end
			end
		end
	end
	local disconnect = func(text, opts)
	if typeof(promptId) == "string" then
		activePrompts[promptId] = disconnect
	end
end)

Remote.get("PromptDismiss"):onClientEvent(function(promptId: string?)
	if typeof(promptId) ~= "string" then
		return
	end
	local disconnect = activePrompts[promptId]
	if not disconnect then
		return
	end
	activePrompts[promptId] = nil
	actionStates[promptId] = nil
	actionIconButtons[promptId] = nil
	actionButtonLoading[promptId] = nil
	if typeof(disconnect) == "table" and disconnect.Disconnect then
		disconnect.Disconnect()
	end
end)

-- RemoteEvents fired before we connect are lost, so join notices hold until this lands
local promptClientReadyRemote = require(modules.References.promptClientReadyRemote) :: any
promptClientReadyRemote:fireServer()


return PromptController
