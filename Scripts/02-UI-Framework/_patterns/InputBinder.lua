--[[
	InputBinder (ModuleScript, client only)

	Bind keyboard and gamepad keys to UI actions ("G or ButtonY opens the inventory"), with:
	  * an optional condition (only fire while a window is open, while alive, ...)
	  * typing in a TextBox / chat never triggers the action
	  * optional on-screen key hints that show the right key for the player's device
	    (keyboard letter on PC, controller button on gamepad, hidden on touch)
	  * optional mobile touch button created by ContextActionService

	Credits / ideas taken from:
	  - Work at a Pizza Place  Window:RegisterGamepadAction / GamepadActionsEnabled
	    (per-window ContextActionService bindings that are switched on and off with the window,
	     B-button hint shown only for gamepad players)
	  - Work at a Pizza Place  GamepadMainMenu (gamepad-only menu entry point)
	  - Grow a Garden 2 Device module (switch UI hints when LastInputType changes)

	Usage (LocalScript):
		local InputBinder = require(ReplicatedStorage.Modules.InputBinder)
		local binder = InputBinder.new()

		binder:Bind("ToggleInventory", { Enum.KeyCode.G, Enum.KeyCode.ButtonY }, function()
			windows:Toggle("Inventory")
		end, {
			Hint = PlayerGui.Main.HUD.InventoryButton.KeyHint,   -- TextLabel or ImageLabel
			TouchButton = false,
		})

		binder:Bind("ConfirmPurchase", { Enum.KeyCode.Return, Enum.KeyCode.ButtonA }, buy, {
			When = function() return windows:IsOpen("Confirm") end,
		})

		binder:SetEnabled("ToggleInventory", false)  -- e.g. during a cutscene
		binder:Unbind("ConfirmPurchase")
]]

local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local InputBinder = {}
InputBinder.__index = InputBinder

local binderCount = 0

local GAMEPAD_NAMES = {
	[Enum.KeyCode.ButtonA] = "A",
	[Enum.KeyCode.ButtonB] = "B",
	[Enum.KeyCode.ButtonX] = "X",
	[Enum.KeyCode.ButtonY] = "Y",
	[Enum.KeyCode.ButtonL1] = "LB",
	[Enum.KeyCode.ButtonR1] = "RB",
	[Enum.KeyCode.ButtonL2] = "LT",
	[Enum.KeyCode.ButtonR2] = "RT",
	[Enum.KeyCode.ButtonL3] = "LS",
	[Enum.KeyCode.ButtonR3] = "RS",
	[Enum.KeyCode.ButtonStart] = "Menu",
	[Enum.KeyCode.ButtonSelect] = "View",
	[Enum.KeyCode.DPadUp] = "Up",
	[Enum.KeyCode.DPadDown] = "Down",
	[Enum.KeyCode.DPadLeft] = "Left",
	[Enum.KeyCode.DPadRight] = "Right",
}

local function isGamepadKey(keyCode: Enum.KeyCode): boolean
	return GAMEPAD_NAMES[keyCode] ~= nil or string.find(keyCode.Name, "Thumbstick", 1, true) ~= nil
end

local function currentDevice(): string
	local inputType = UserInputService:GetLastInputType()
	if inputType == Enum.UserInputType.Touch then
		return "Touch"
	end
	if string.find(inputType.Name, "Gamepad", 1, true) then
		return "Gamepad"
	end
	if inputType == Enum.UserInputType.None and UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		return "Touch"
	end
	return "PC"
end

function InputBinder.new()
	binderCount += 1
	local self = setmetatable({}, InputBinder)
	self._prefix = "InputBinder" .. binderCount .. "_"
	self._bindings = {}
	self._device = currentDevice()
	self._inputConnection = UserInputService.LastInputTypeChanged:Connect(function()
		local device = currentDevice()
		if device ~= self._device then
			self._device = device
			self:_refreshHints()
		end
	end)
	return self
end

function InputBinder:_hintFor(binding)
	local wantGamepad = self._device == "Gamepad"
	for _, keyCode in binding.keys do
		if isGamepadKey(keyCode) == wantGamepad then
			return keyCode
		end
	end
	return nil
end

function InputBinder:_refreshHint(binding)
	local hint = binding.hint
	if not hint then
		return
	end
	local keyCode = if binding.enabled and self._device ~= "Touch" then self:_hintFor(binding) else nil
	if not keyCode then
		hint.Visible = false
		return
	end
	hint.Visible = true
	if hint:IsA("ImageLabel") or hint:IsA("ImageButton") then
		-- Roblox provides the right controller glyph (Xbox / PlayStation) for gamepad keys
		hint.Image = UserInputService:GetImageForKeyCode(keyCode)
	elseif hint:IsA("TextLabel") or hint:IsA("TextButton") then
		if isGamepadKey(keyCode) then
			hint.Text = GAMEPAD_NAMES[keyCode] or keyCode.Name
		else
			-- respects the player's keyboard layout (AZERTY etc.)
			local text = UserInputService:GetStringForKeyCode(keyCode)
			hint.Text = if text ~= "" then string.upper(text) else keyCode.Name
		end
	end
end

function InputBinder:_refreshHints()
	for _, binding in self._bindings do
		self:_refreshHint(binding)
	end
end

function InputBinder:_bindAction(binding)
	local actionName = self._prefix .. binding.name
	ContextActionService:BindActionAtPriority(actionName, function(_, inputState, inputObject)
		if inputState ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end
		if UserInputService:GetFocusedTextBox() then
			return Enum.ContextActionResult.Pass -- typing in chat or a search box
		end
		if binding.when and not binding.when() then
			return Enum.ContextActionResult.Pass
		end
		task.spawn(binding.callback, inputObject)
		return Enum.ContextActionResult.Sink
	end, binding.touchButton, binding.priority, table.unpack(binding.keys))

	if binding.touchButton and binding.touchTitle then
		ContextActionService:SetTitle(actionName, binding.touchTitle)
	end
end

--[[
	options (all optional):
		When        : () -> boolean   only fire when this returns true
		Hint        : GuiObject       TextLabel / ImageLabel that shows the key for the current device
		TouchButton : boolean         let ContextActionService create a mobile button
		TouchTitle  : string          text on that mobile button
		Priority    : number          ContextActionService priority (default Medium)
]]
function InputBinder:Bind(name: string, keys: { Enum.KeyCode }, callback: (InputObject) -> (), options: { [string]: any }?)
	local opts = options or {}
	if self._bindings[name] then
		self:Unbind(name)
	end
	local binding = {
		name = name,
		keys = keys,
		callback = callback,
		when = opts.When,
		hint = opts.Hint,
		touchButton = opts.TouchButton == true,
		touchTitle = opts.TouchTitle,
		priority = opts.Priority or Enum.ContextActionPriority.Medium.Value,
		enabled = true,
	}
	self._bindings[name] = binding
	self:_bindAction(binding)
	self:_refreshHint(binding)
end

function InputBinder:SetEnabled(name: string, enabled: boolean)
	local binding = self._bindings[name]
	if not binding or binding.enabled == enabled then
		return
	end
	binding.enabled = enabled
	if enabled then
		self:_bindAction(binding)
	else
		ContextActionService:UnbindAction(self._prefix .. name)
	end
	self:_refreshHint(binding)
end

function InputBinder:Unbind(name: string)
	local binding = self._bindings[name]
	if not binding then
		return
	end
	ContextActionService:UnbindAction(self._prefix .. name)
	if binding.hint then
		binding.hint.Visible = false
	end
	self._bindings[name] = nil
end

function InputBinder:GetDevice(): string
	return self._device
end

function InputBinder:Destroy()
	for name in self._bindings do
		ContextActionService:UnbindAction(self._prefix .. name)
	end
	table.clear(self._bindings)
	self._inputConnection:Disconnect()
end

return InputBinder
