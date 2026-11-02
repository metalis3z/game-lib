--[[
	WindowManager (ModuleScript, client only)

	A clean menu / window controller:
	  * only one window is shown at a time (opening one closes the other)
	  * optional "stack" mode: Open(name, true) pushes a sub-window, Back() returns to the previous one
	  * pop-in / pop-out animation by tweening a UIScale (no Position math, works with any layout)
	  * optional background blur while a window is open
	  * optional HUD hiding while a window is open (restores the exact previous state)
	  * gamepad B (or any keys you choose) closes the top window
	  * helpers to wire buttons, auto-bind HUD buttons by name and hook up "Close" buttons

	Credits / ideas taken from:
	  - Brainrot Lab  FrameManager + UIInitializer  (one-open-at-a-time, "ShopButton" -> "Shop" auto-binding)
	  - +1 NeeDoh Escape HUDButtonController       (UIScale pop animation, closing flags)
	  - +1 Drill & Mine FrameAnimator               (blur only enabled while open, HUD slides away)
	  - Murderers vs Sheriffs WindowService         (window stack with Back)
	  - Work at a Pizza Place Window                (gamepad B closes the window)
	  - Smash Egg For Animals WindowOpenFx          (reuse the frame's existing UIScale, cancel safely on fast re-open)

	Usage (LocalScript):
		local WindowManager = require(ReplicatedStorage.Modules.WindowManager)
		local gui = Players.LocalPlayer.PlayerGui:WaitForChild("Main")

		local windows = WindowManager.new({
			BlurSize = 16,                                   -- 0 = no blur
			Hud = { gui.HUD.Left, gui.HUD.Right },           -- hidden while a window is open
		})

		-- register every child of a Frames folder, hook their "Close" buttons
		windows:RegisterFolder(gui.Frames)

		-- or register one by one
		windows:Register("Shop", gui.Frames.Shop, {
			OnOpen = function() print("shop opened") end,
			KeepHud = true,                                  -- keep the HUD visible for this one
		})

		-- HUD buttons named "ShopButton", "InventoryButton"... toggle the matching window
		windows:AutoBindButtons(gui.HUD, "Button")

		windows:BindButton(gui.HUD.SettingsIcon, "Settings", "Toggle")
		windows:Open("Confirm", true)   -- push on top of the current window; Back() returns
		windows.Changed:Connect(function(openName) print("now open:", openName) end)
]]

local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")
local Lighting = game:GetService("Lighting")

local WindowManager = {}
WindowManager.__index = WindowManager

local DEFAULT_OPEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local DEFAULT_CLOSE_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local BLUR_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local instanceCount = 0

local function isShown(obj: Instance): boolean
	if obj:IsA("LayerCollector") then
		return obj.Enabled
	end
	return (obj :: GuiObject).Visible
end

local function setShown(obj: Instance, shown: boolean)
	if obj:IsA("LayerCollector") then
		obj.Enabled = shown
	else
		(obj :: GuiObject).Visible = shown
	end
end

--[[
	options (all optional):
		OpenInfo   : TweenInfo   pop-in tween
		CloseInfo  : TweenInfo   pop-out tween
		StartScale : number      scale the window starts from / shrinks to (default 0.8)
		BlurSize   : number      background blur size while open (default 0 = off)
		Hud        : {Instance}  ScreenGuis or GuiObjects hidden while a window is open
		CloseKeys  : {KeyCode}   keys that close the top window (default { ButtonB })
]]
function WindowManager.new(options: { [string]: any }?)
	local opts = options or {}
	instanceCount += 1

	local self = setmetatable({}, WindowManager)
	self._windows = {}
	self._stack = {}
	self._openInfo = opts.OpenInfo or DEFAULT_OPEN_INFO
	self._closeInfo = opts.CloseInfo or DEFAULT_CLOSE_INFO
	self._startScale = opts.StartScale or 0.8
	self._hud = opts.Hud or {}
	self._hudSnapshot = nil
	self._closeKeys = opts.CloseKeys or { Enum.KeyCode.ButtonB }
	self._actionName = "WindowManagerBack_" .. instanceCount
	self._actionBound = false
	self._connections = {}

	self._changedEvent = Instance.new("BindableEvent")
	self.Changed = self._changedEvent.Event -- fires (openWindowName: string?)

	self._blurSize = opts.BlurSize or 0
	if self._blurSize > 0 then
		local blur = Instance.new("BlurEffect")
		blur.Name = "WindowManagerBlur"
		blur.Size = 0
		blur.Enabled = false -- an enabled blur costs a full-screen pass even at size 0
		blur.Parent = Lighting
		self._blur = blur
	end

	return self
end

-- Register a GuiObject as a window. config: { OnOpen, OnClose, KeepHud }
function WindowManager:Register(name: string, gui: GuiObject, config: { [string]: any }?)
	local cfg = config or {}

	-- Reuse a UIScale the designer already put on the frame (only one UIScale per parent is applied).
	local scale = gui:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "WindowScale"
		scale.Parent = gui
	end

	local entry = {
		name = name,
		gui = gui,
		scale = scale,
		baseScale = scale.Scale,
		onOpen = cfg.OnOpen,
		onClose = cfg.OnClose,
		keepHud = cfg.KeepHud == true,
		shown = false,
		tween = nil,
	}
	gui.Visible = false
	self._windows[name] = entry
	return entry
end

-- Register every GuiObject child of a folder/frame, using the child's name. Hooks a descendant
-- button called closeButtonName (default "Close") to close that window.
function WindowManager:RegisterFolder(container: Instance, closeButtonName: string?)
	local closeName = closeButtonName or "Close"
	for _, child in container:GetChildren() do
		if child:IsA("GuiObject") then
			self:Register(child.Name, child)
			local close = child:FindFirstChild(closeName, true)
			if close and close:IsA("GuiButton") then
				self:BindButton(close, child.Name, "Close")
			end
		end
	end
end

local function playScale(entry, info: TweenInfo, target: number, onDone: (() -> ())?)
	if entry.tween then
		entry.tween:Cancel()
	end
	local tween = TweenService:Create(entry.scale, info, { Scale = target })
	entry.tween = tween
	tween.Completed:Connect(function(state)
		-- ignore tweens that were cancelled by a newer open/close
		if state == Enum.PlaybackState.Completed and entry.tween == tween then
			entry.tween = nil
			if onDone then
				onDone()
			end
		end
	end)
	tween:Play()
end

function WindowManager:_show(entry)
	if entry.shown then
		return
	end
	entry.shown = true
	entry.gui.Visible = true
	entry.scale.Scale = entry.baseScale * self._startScale
	playScale(entry, self._openInfo, entry.baseScale)
	if entry.onOpen then
		task.spawn(entry.onOpen)
	end
end

function WindowManager:_hide(entry)
	if not entry.shown then
		return
	end
	entry.shown = false
	playScale(entry, self._closeInfo, entry.baseScale * self._startScale, function()
		entry.gui.Visible = false
		entry.scale.Scale = entry.baseScale
	end)
	if entry.onClose then
		task.spawn(entry.onClose)
	end
end

function WindowManager:_refresh()
	local top = self._stack[#self._stack]

	-- Blur
	if self._blur then
		local blur = self._blur
		if top then
			blur.Enabled = true
		end
		if self._blurTween then
			self._blurTween:Cancel()
		end
		local tween = TweenService:Create(blur, BLUR_INFO, { Size = top and self._blurSize or 0 })
		self._blurTween = tween
		tween.Completed:Connect(function(state)
			if state == Enum.PlaybackState.Completed and #self._stack == 0 then
				blur.Enabled = false
			end
		end)
		tween:Play()
	end

	-- HUD: snapshot once when hiding, restore exactly when showing again
	local hideHud = top ~= nil and not top.keepHud
	if hideHud and not self._hudSnapshot then
		local snapshot = {}
		for _, obj in self._hud do
			snapshot[obj] = isShown(obj)
			setShown(obj, false)
		end
		self._hudSnapshot = snapshot
	elseif not hideHud and self._hudSnapshot then
		for obj, wasShown in self._hudSnapshot do
			if obj.Parent then
				setShown(obj, wasShown)
			end
		end
		self._hudSnapshot = nil
	end

	-- Gamepad / key "back" action, only bound while something is open
	if top and not self._actionBound then
		ContextActionService:BindActionAtPriority(self._actionName, function(_, inputState)
			if inputState ~= Enum.UserInputState.Begin then
				return Enum.ContextActionResult.Pass
			end
			self:Back()
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, table.unpack(self._closeKeys))
		self._actionBound = true
	elseif not top and self._actionBound then
		ContextActionService:UnbindAction(self._actionName)
		self._actionBound = false
	end

	self._changedEvent:Fire(top and top.name or nil)
end

-- Open a window. push = true keeps the current window in a stack so Back() returns to it.
function WindowManager:Open(name: string, push: boolean?)
	local entry = self._windows[name]
	if not entry then
		warn("[WindowManager] unknown window: " .. tostring(name))
		return
	end
	local top = self._stack[#self._stack]
	if top == entry then
		return
	end

	local index = table.find(self._stack, entry)
	if index then
		table.remove(self._stack, index)
	end

	if push then
		if top then
			self:_hide(top)
		end
	else
		for i = #self._stack, 1, -1 do
			self:_hide(self._stack[i])
		end
		table.clear(self._stack)
	end

	table.insert(self._stack, entry)
	self:_show(entry)
	self:_refresh()
end

-- Close a window (default: the top one). If it was the top of a stack, the previous window comes back.
function WindowManager:Close(name: string?)
	local entry = if name then self._windows[name] else self._stack[#self._stack]
	if not entry then
		return
	end
	local index = table.find(self._stack, entry)
	if not index then
		return
	end

	local wasTop = index == #self._stack
	table.remove(self._stack, index)
	self:_hide(entry)

	if wasTop then
		local newTop = self._stack[#self._stack]
		if newTop then
			self:_show(newTop)
		end
	end
	self:_refresh()
end

function WindowManager:Back()
	self:Close(nil)
end

function WindowManager:CloseAll()
	for i = #self._stack, 1, -1 do
		self:_hide(self._stack[i])
	end
	table.clear(self._stack)
	self:_refresh()
end

function WindowManager:Toggle(name: string)
	if self:IsOpen(name) then
		self:Close(name)
	else
		self:Open(name)
	end
end

function WindowManager:IsOpen(name: string): boolean
	local top = self._stack[#self._stack]
	return top ~= nil and top.name == name
end

function WindowManager:GetOpen(): string?
	local top = self._stack[#self._stack]
	return top and top.name or nil
end

-- action: "Toggle" (default) | "Open" | "Close" | "Back"
function WindowManager:BindButton(button: GuiButton, name: string?, action: string?)
	local mode = action or "Toggle"
	local connection = button.Activated:Connect(function()
		if mode == "Open" then
			self:Open(name :: string)
		elseif mode == "Close" then
			self:Close(name)
		elseif mode == "Back" then
			self:Back()
		else
			self:Toggle(name :: string)
		end
	end)
	table.insert(self._connections, connection)
	return connection
end

-- Every GuiButton under container whose name ends with suffix toggles the window with the rest
-- of the name ("ShopButton" -> "Shop"). Buttons without a matching window are ignored.
function WindowManager:AutoBindButtons(container: Instance, suffix: string?)
	local ending = suffix or "Button"
	for _, descendant in container:GetDescendants() do
		if descendant:IsA("GuiButton") then
			local name = descendant.Name
			if ending ~= "" and string.sub(name, -#ending) == ending then
				name = string.sub(name, 1, #name - #ending)
			end
			if self._windows[name] then
				self:BindButton(descendant, name, "Toggle")
			end
		end
	end
end

function WindowManager:Destroy()
	self:CloseAll()
	if self._actionBound then
		ContextActionService:UnbindAction(self._actionName)
		self._actionBound = false
	end
	for _, connection in self._connections do
		connection:Disconnect()
	end
	table.clear(self._connections)
	if self._blur then
		self._blur:Destroy()
	end
	self._changedEvent:Destroy()
end

return WindowManager
