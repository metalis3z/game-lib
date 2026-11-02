
local UserInputService = game:GetService("UserInputService")
local NotificationController = require(game.ReplicatedStorage.Controllers.NotificationController)
local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local KeybindManager = {}
KeybindManager.__index = KeybindManager

local bindingLock = false

local function getKeyLabel(button, callerName, actionName)
	if typeof(button) ~= "Instance" then
		warn(string.format(
			"[KeybindManager] %s — expected a GuiObject Instance for action '%s', got %s (value: %s). Check the script calling this method.",
			callerName or "getKeyLabel", tostring(actionName), typeof(button), tostring(button)))
		return nil
	end
	local keyFrame = button:FindFirstChild("Key")
	if not keyFrame then
		warn(string.format(
			"[KeybindManager] %s — No 'Key' Frame found on button '%s' for action '%s'.",
			callerName or "getKeyLabel", button:GetFullName(), tostring(actionName)))
		return nil
	end
	if isMobile then keyFrame.Visible = false end
	local textButton = keyFrame:FindFirstChildOfClass("TextButton")
	if not textButton then
		warn(string.format(
			"[KeybindManager] %s — No TextButton found inside 'Key' Frame on '%s' for action '%s'.",
			callerName or "getKeyLabel", button:GetFullName(), tostring(actionName)))
		return nil
	end
	return textButton
end

function KeybindManager.new(saveKeyRemote, _ignoredSynchronizer)
	local self = setmetatable({}, KeybindManager)
	self._saveKeyRemote = saveKeyRemote
	self._keyCodes      = {}
	self._connections   = {}
	self._callbacks     = {}
	self._labelMap      = {}
	self._pendingLabels = nil
	local bindable = game.ReplicatedStorage:WaitForChild("ResetKeys")
	local conn = bindable.Event:Connect(function()
		self:ClearAllKeybinds()
	end)
	table.insert(self._connections, conn)
	return self
end

function KeybindManager:Register(actionName, keyCodeName, callback)
	self._callbacks[actionName] = callback
	self._keyCodes[actionName] = keyCodeName and Enum.KeyCode[keyCodeName] or nil
end

function KeybindManager:StartListening()
	local conn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		for actionName, keyCode in pairs(self._keyCodes) do
			if keyCode and input.KeyCode == keyCode then
				local cb = self._callbacks[actionName]
				if cb then cb() end
			end
		end
	end)
	table.insert(self._connections, conn)
end

function KeybindManager:SyncKeybinds(keybindsData, labelMap)
	for actionName in pairs(self._callbacks) do
		local keyName = keybindsData and keybindsData[actionName] or nil
		self._keyCodes[actionName] = keyName and Enum.KeyCode[keyName] or nil
		if labelMap and labelMap[actionName] then
			labelMap[actionName].Text = keyName or "KEY"
		end
	end
end

function KeybindManager:WireRebindButton(actionName, textButton, keyLabel)
	if isMobile then return end
	textButton.Activated:Connect(function()
		if bindingLock then return end
		bindingLock = true
		keyLabel.Text = "..."
		local rebindConn
		rebindConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
			task.wait()
			if input.KeyCode == Enum.KeyCode.Escape then
				self._saveKeyRemote:FireServer(actionName, nil)
				self._keyCodes[actionName] = nil
				keyLabel.Text = "KEY"
				rebindConn:Disconnect()
				bindingLock = false
				return
			end
			self._saveKeyRemote:FireServer(actionName, input.KeyCode.Name)
			self._keyCodes[actionName] = input.KeyCode
			keyLabel.Text = input.KeyCode.Name
			rebindConn:Disconnect()
			bindingLock = false
		end)
	end)
end

function KeybindManager:WireRebindButtonAuto(actionName, button)
	local keyLabel = getKeyLabel(button, "WireRebindButtonAuto", actionName)
	if not keyLabel then return end
	self:WireRebindButton(actionName, keyLabel, keyLabel)
end

function KeybindManager:WireRebindButtons(map)
	for actionName, button in pairs(map) do
		self:WireRebindButtonAuto(actionName, button)
	end
end

function KeybindManager:BuildLabelMap(map)
	local labelMap = {}
	for actionName, button in pairs(map) do
		local keyLabel = getKeyLabel(button, "BuildLabelMap", actionName)
		if keyLabel then labelMap[actionName] = keyLabel end
	end
	return labelMap
end

function KeybindManager:LoadFromSynchronizer(channelOrIndex, labelMap)
	if self._pendingLabels then
		labelMap = labelMap or {}
		for k, v in pairs(self._pendingLabels) do
			if not labelMap[k] then labelMap[k] = v end
		end
		self._pendingLabels = nil
	end
	self._labelMap = labelMap or {}

	local index
	if typeof(channelOrIndex) == "table" and channelOrIndex.GetTable then
		local channelTable = channelOrIndex:GetTable() or {}
		local saved = channelTable.keybinds or {}
		for actionName in pairs(self._callbacks) do
			local keyName = saved[actionName]
			self._keyCodes[actionName] = keyName and Enum.KeyCode[keyName] or nil
			if self._labelMap[actionName] then
				self._labelMap[actionName].Text = keyName or "KEY"
			end
		end
		channelOrIndex:OnChanged("keybinds", function(newData)
			self:SyncKeybinds(newData, self._labelMap)
		end)
		return
	elseif typeof(channelOrIndex) == "Instance" and channelOrIndex:IsA("Player") then
		index = channelOrIndex.UserId
	elseif typeof(channelOrIndex) == "number" then
		index = channelOrIndex
	else
		index = game.Players.LocalPlayer.UserId
	end

	local selfRef = self
	Synchronizer:WaitAndCall(index, function(channel)
		local channelTable = channel:GetTable() or {}
		local saved = channelTable.keybinds or {}

		for actionName in pairs(selfRef._callbacks) do
			local keyName = saved[actionName]
			selfRef._keyCodes[actionName] = keyName and Enum.KeyCode[keyName] or nil
			if selfRef._labelMap[actionName] then
				selfRef._labelMap[actionName].Text = keyName or "KEY"
			end
		end

		channel:OnChanged("keybinds", function(newData)
			selfRef:SyncKeybinds(newData, selfRef._labelMap)
		end)
	end)
end

function KeybindManager:RegisterButton(actionName, button, callback)
	local keyLabel = getKeyLabel(button, "RegisterButton", actionName)
	self:Register(actionName, nil, callback)
	if keyLabel then
		self:WireRebindButton(actionName, keyLabel, keyLabel)
		self._pendingLabels = self._pendingLabels or {}
		self._pendingLabels[actionName] = keyLabel
	end
end

function KeybindManager:ClearAllKeybinds()
	for actionName in pairs(self._callbacks) do
		self._keyCodes[actionName] = nil
		self._saveKeyRemote:FireServer(actionName, nil)
		local label = self._labelMap and self._labelMap[actionName]
		if label then label.Text = "KEY" end
	end
end

function KeybindManager:Destroy()
	for _, conn in ipairs(self._connections) do
		conn:Disconnect()
	end
	self._connections = {}
end

return KeybindManager