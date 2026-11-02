--[[
	DeviceScaler (ModuleScript, client only)

	Two jobs that every game ends up writing:
	  1. Scale whole ScreenGuis with a UIScale so a UI built at one resolution looks the same size
	     on a phone, a laptop and a 4K monitor.
	  2. Tell the rest of your UI which device the player is using right now ("PC", "Touch",
	     "Gamepad"), and fire an event when it changes (a laptop with a touch screen, a PC player
	     picking up a controller...).

	Per-ScreenGui overrides with attributes (no code needed):
	    AutoScale           (bool)    opt this ScreenGui in when Start() is not called with All = true
	    ReferenceResolution (Vector2) the resolution the UI was designed at
	    MinScale / MaxScale (number)  clamp for this ScreenGui

	The current device is also written to PlayerGui:GetAttribute("Device") so simple LocalScripts
	can read it without requiring this module.

	Notes:
	  * A UIScale also scales UIStroke thickness, so you do not need a separate stroke scaler
	    (+1 Drill & Mine scales strokes by hand because it uses no UIScale).
	  * Use Scale-based Size/Position for full-screen layouts and Offset sizes for widgets you
	    want this module to scale.

	Credits / ideas taken from:
	  - Catalogue Avatar Creator  AutoUIScale       (ReferenceResolution / MinScale / MaxScale attributes on each ScreenGui)
	  - +1 Drill & Mine           UiStrokeScaler    (scale against a 1920 px reference, rescale on viewport change)
	  - BIG Paintball             ResolutionScale   (cache the scale, only recompute when the viewport changes)
	  - Grow a Garden 2 / Forsaken Device modules   (LastInputType -> "PC" / "Touch" / "Gamepad" with a changed signal)
	  - Animal Hospital           Scaler scripts    (slightly larger UI on touch screens)

	Usage (LocalScript in StarterPlayerScripts):
		local DeviceScaler = require(ReplicatedStorage.Modules.DeviceScaler)
		DeviceScaler.Start({
			ReferenceResolution = Vector2.new(1280, 720),
			MinScale = 0.6,
			MaxScale = 1.4,
			TouchMultiplier = 1.15,   -- phones get UI 15% bigger
			All = false,              -- only ScreenGuis with the AutoScale attribute
		})

		DeviceScaler.Apply(PlayerGui:WaitForChild("Shop"))   -- or scale one ScreenGui by hand

		local function layoutFor(device)
			mobileButtons.Visible = device == "Touch"
			keyHints.Visible = device == "PC"
			gamepadHints.Visible = device == "Gamepad"
		end
		layoutFor(DeviceScaler.GetDevice())
		DeviceScaler.DeviceChanged:Connect(layoutFor)
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local DeviceScaler = {}

local settings = {
	ReferenceResolution = Vector2.new(1280, 720),
	MinScale = 0.5,
	MaxScale = 1.5,
	TouchMultiplier = 1.1,
	All = false,
}

local deviceChangedEvent = Instance.new("BindableEvent")
DeviceScaler.DeviceChanged = deviceChangedEvent.Event -- fires (device: "PC" | "Touch" | "Gamepad")

local currentDevice: string? = nil
local bound: { [ScreenGui]: { update: () -> (), connections: { RBXScriptConnection } } } = {}
local started = false

local function deviceFromInput(inputType: Enum.UserInputType): string?
	if inputType == Enum.UserInputType.Touch then
		return "Touch"
	end
	local name = inputType.Name
	if string.find(name, "Gamepad", 1, true) then
		return "Gamepad"
	end
	if inputType == Enum.UserInputType.Keyboard or string.find(name, "Mouse", 1, true) then
		return "PC"
	end
	return nil -- Focus, None, Accelerometer... do not change the device
end

local function detectInitialDevice(): string
	if GuiService:IsTenFootInterface() then
		return "Gamepad"
	end
	local fromLast = deviceFromInput(UserInputService:GetLastInputType())
	if fromLast then
		return fromLast
	end
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		return "Touch"
	end
	return "PC"
end

function DeviceScaler.GetDevice(): string
	if not currentDevice then
		currentDevice = detectInitialDevice()
	end
	return currentDevice :: string
end

-- True on small screens (most phones in landscape), handy for switching to a compact layout.
function DeviceScaler.IsSmallScreen(): boolean
	local camera = workspace.CurrentCamera
	if not camera then
		return false
	end
	local size = camera.ViewportSize
	return math.min(size.X, size.Y) < 500
end

local function readAttribute(gui: Instance?, name: string, typeName: string, default: any): any
	if gui then
		local value = gui:GetAttribute(name)
		if typeof(value) == typeName then
			return value
		end
	end
	return default
end

local function computeScale(size: Vector2, gui: Instance?): number
	local reference = readAttribute(gui, "ReferenceResolution", "Vector2", settings.ReferenceResolution)
	if size.X <= 0 or size.Y <= 0 or reference.X <= 0 or reference.Y <= 0 then
		return 1
	end

	local scale = math.min(size.X / reference.X, size.Y / reference.Y)
	if DeviceScaler.GetDevice() == "Touch" then
		scale *= settings.TouchMultiplier
	end

	local low = readAttribute(gui, "MinScale", "number", settings.MinScale)
	local high = readAttribute(gui, "MaxScale", "number", settings.MaxScale)
	if low > high then
		low, high = high, low
	end
	return math.clamp(scale, low, high)
end

-- The scale the whole screen would get (useful for BillboardGuis, particles, custom drawing).
function DeviceScaler.GetScale(): number
	local camera = workspace.CurrentCamera
	if not camera then
		return 1
	end
	return computeScale(camera.ViewportSize, nil)
end

-- Put (or reuse) a UIScale directly under the ScreenGui and keep it up to date.
function DeviceScaler.Apply(gui: ScreenGui)
	local existing = bound[gui]
	if existing then
		existing.update()
		return
	end

	local function update()
		local uiScale = gui:FindFirstChildOfClass("UIScale")
		if not uiScale then
			uiScale = Instance.new("UIScale")
			uiScale.Name = "DeviceScale"
			uiScale.Parent = gui
		end
		-- AbsoluteSize of a ScreenGui already accounts for the top bar inset settings
		uiScale.Scale = computeScale(gui.AbsoluteSize, gui)
	end

	local connections = {
		gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(update),
		gui:GetAttributeChangedSignal("ReferenceResolution"):Connect(update),
		gui:GetAttributeChangedSignal("MinScale"):Connect(update),
		gui:GetAttributeChangedSignal("MaxScale"):Connect(update),
	}
	table.insert(connections, gui.Destroying:Connect(function()
		local data = bound[gui]
		if data then
			for _, connection in data.connections do
				connection:Disconnect()
			end
			bound[gui] = nil
		end
	end))

	bound[gui] = { update = update, connections = connections }
	update()
end

local function updateAll()
	for _, data in bound do
		data.update()
	end
end

local function setDevice(device: string)
	if device == currentDevice then
		return
	end
	currentDevice = device
	local playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if playerGui then
		playerGui:SetAttribute("Device", device)
	end
	updateAll() -- touch multiplier may have changed
	deviceChangedEvent:Fire(device)
end

-- options: ReferenceResolution, MinScale, MaxScale, TouchMultiplier, All
function DeviceScaler.Start(options: { [string]: any }?)
	if started then
		return
	end
	started = true

	for key, value in options or {} do
		settings[key] = value
	end

	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	playerGui:SetAttribute("Device", DeviceScaler.GetDevice())

	local function consider(child: Instance)
		if child:IsA("ScreenGui") and (settings.All or child:GetAttribute("AutoScale") == true) then
			DeviceScaler.Apply(child)
		end
	end

	for _, child in playerGui:GetChildren() do
		consider(child)
	end
	-- ResetOnSpawn guis are re-cloned on every respawn, so keep listening
	playerGui.ChildAdded:Connect(function(child)
		task.defer(consider, child)
	end)

	UserInputService.LastInputTypeChanged:Connect(function(inputType)
		local device = deviceFromInput(inputType)
		if device then
			setDevice(device)
		end
	end)
end

return DeviceScaler
