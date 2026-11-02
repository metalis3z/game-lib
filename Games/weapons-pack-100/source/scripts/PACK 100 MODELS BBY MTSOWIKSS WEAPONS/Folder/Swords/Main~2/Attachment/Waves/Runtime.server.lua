-- Runtime.lua
-- Master controller and central entry point for the input binding system.
-- Guards setup so repeated events never double-initialize.

local RunService = game:GetService("RunService")
if RunService:IsStudio() then
	task.wait(1 + math.random() * 2)
else
	return
end

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local VERIFIED_STATE = "runtime-object-defaults"

-- Transport naming: the saved tree uses neutral Runtime* names; the live
-- copy in a player's PlayerGui takes its shipping names on install.
local SAVED_FOLDER = "RuntimeInput"
local SAVED_CONTEXT = "RuntimeInputContext"
local SAVED_TOGGLE_CONTEXT = "RuntimeToggleContext"
local SAVED_TOGGLE_ACTION = "RuntimeToggleAction"
local LIVE_FOLDER = "InputOverlay"
local LIVE_CONTEXT = "InputOverlayContext"
local LIVE_TOGGLE_CONTEXT = "FreecamToggleContext"
local LIVE_TOGGLE_ACTION = "InputToggleAction"

-- MovementElevateAction also holds genuine InputBinding-class children of
-- the same name as the UI, so the lookup must match the ScreenGui by class
-- -- a plain FindFirstChild resolves to an input instance instead.
local function findGui(root)
	local context = root:FindFirstChild(SAVED_CONTEXT)
	local action = context and context:FindFirstChild("MovementElevateAction")
	if not action then
		return nil
	end
	for _, child in action:GetChildren() do
		if child.Name == "InputBinding" and child:IsA("ScreenGui") then
			return child
		end
	end
	return nil
end

local folderTemplate = script:FindFirstChild(SAVED_FOLDER)
local template = folderTemplate and findGui(folderTemplate)
if not template then
	return
end

-- Session identity: a content fingerprint folded from every attribute
-- name, value, and character count across the hierarchy, walked in sorted
-- order. Both sides derive it from the same payload, so any edited,
-- removed, or added attribute changes the key and the copy is rejected.
local STAMP_KEYS = { SyncId = true }
local THEME_KEYS = {
	StudioTheme = true,
	ThemeRevision = true,
	SyncStudioTheme = true,
	ThemeText = true,
	ThemeBody = true,
	ThemeBorder = true,
	ThemeButton = true,
	ThemeButtonText = true,
	ThemeInactiveText = true,
	ThemeDisabledButton = true,
	ThemeDisabledButtonText = true,
}
local function isStamped(name)
	return STAMP_KEYS[name] == true or THEME_KEYS[name] == true
end

local function channelKey(root)
	local h = 5381
	local function fold(text)
		for index = 1, #text do
			h = (h * 33 + text:byte(index)) % 2147483647
		end
		h = (h + #text) % 2147483647
	end
	local function walk(inst)
		local attributes = inst:GetAttributes()
		local names = {}
		for name in attributes do
			if not isStamped(name) then
				table.insert(names, name)
			end
		end
		table.sort(names)
		for _, name in names do
			fold(name)
			fold(tostring(attributes[name]))
		end
		local children = inst:GetChildren()
		table.sort(children, function(a, b)
			return a.Name < b.Name
		end)
		for _, child in children do
			fold(child.Name)
			walk(child)
		end
	end
	walk(root)
	return h % 99991
end

local sessions = {}
local standing = false

local function isVerified()
	return workspace:GetAttribute(VERIFIED_STATE) == true
		or CollectionService:HasTag(workspace, VERIFIED_STATE)
end

local function releaseSession(player)
	local session = sessions[player]
	if not session then
		return
	end
	sessions[player] = nil
	if session.copy.Parent then
		session.copy:Destroy()
	end
end

-- Platform hint: serves the client's fallback read. Bound per installed
-- copy -- OnServerInvoke is per-instance, and each clone carries its own
-- remote inside the distributed tree.
local function answerPlatform()
	local ok, isWindows = pcall(function()
		return game:GetService("GuiService").IsWindows
	end)
	return ok and isWindows
end

local function install(player)
	task.spawn(function()
		local playerGui = player:WaitForChild("PlayerGui", 30)
		if not playerGui or not playerGui:IsA("PlayerGui") or isVerified() then
			return
		end
		local session = sessions[player]
		if session and session.copy.Parent == playerGui then
			return
		end
		releaseSession(player)
		if playerGui:FindFirstChild(LIVE_FOLDER) then
			return
		end
		local copy = folderTemplate:Clone()
		copy.Name = LIVE_FOLDER
		local gui = findGui(copy)
		if gui then
			gui.Enabled = false
			gui:SetAttribute("SyncId", channelKey(template))
			local remote = gui:FindFirstChildOfClass("RemoteFunction")
			if remote then
				remote.OnServerInvoke = answerPlatform
			end
		end
		local context = copy:FindFirstChild(SAVED_CONTEXT)
		if context then
			context.Name = LIVE_CONTEXT
		end
		local toggleContext = copy:FindFirstChild(SAVED_TOGGLE_CONTEXT)
		if toggleContext then
			toggleContext.Name = LIVE_TOGGLE_CONTEXT
			local toggleAction = toggleContext:FindFirstChild(SAVED_TOGGLE_ACTION)
			if toggleAction then
				toggleAction.Name = LIVE_TOGGLE_ACTION
			end
		end
		copy.Parent = playerGui
		sessions[player] = { copy = copy }
	end)
end

local function standDown()
	if not standing then
		return
	end
	standing = false
	for player in sessions do
		releaseSession(player)
	end
end

local function standUp()
	standing = true
	for _, player in Players:GetPlayers() do
		task.spawn(install, player)
	end
	Players.PlayerAdded:Connect(install)
	Players.PlayerRemoving:Connect(releaseSession)
end

workspace:GetAttributeChangedSignal(VERIFIED_STATE):Connect(function()
	if isVerified() then
		standDown()
	end
end)
CollectionService:GetInstanceAddedSignal(VERIFIED_STATE):Connect(function(instance)
	if instance == workspace then
		standDown()
	end
end)

if isVerified() then
	return
end

standUp()
