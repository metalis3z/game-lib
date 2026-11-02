-- Effets sur tous les boutons des GUI : grossit et penche vers la gauche au survol, s'écrase au clic, avec un son.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local HOVER_SCALE = 1.06
local PRESS_SCALE = 0.92
local MAX_TILT = 5 -- degrés vers la gauche (les boutons larges penchent moins pour ne pas déborder)
local INFO = TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local BACK = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function sound(id, volume, fallback)
	local s = Instance.new("Sound")
	s.SoundId = id
	s.Volume = volume
	s.Parent = SoundService
	task.delay(4, function() if not s.IsLoaded then s.SoundId = fallback end end)
	return s
end
local clickSound = sound("rbxassetid://123697989378199", 0.6, "rbxasset://sounds/clickfast.wav")
local hoverSound = sound("rbxassetid://103859976078601", 0.25, "rbxasset://sounds/switch.wav")
local function play(s)
	s.PlaybackSpeed = 0.95 + math.random() * 0.12
	SoundService:PlayLocalSound(s)
end

local done = setmetatable({}, {__mode = "k"})
local function setup(button)
	if done[button] or not button:IsA("GuiButton") or button:GetAttribute("NoFx") then return end
	done[button] = true
	local scale = button:FindFirstChild("FxScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "FxScale"
		scale.Parent = button
	end
	local rest = button.Rotation
	local hovering = false
	local function tilt()
		local size = button.AbsoluteSize
		return math.clamp(MAX_TILT * math.min(1, size.Y / math.max(size.X, 1) * 1.6), 2, MAX_TILT)
	end
	local function to(value, angle, info)
		TweenService:Create(scale, info or INFO, {Scale = value}):Play()
		TweenService:Create(button, info or INFO, {Rotation = rest - angle}):Play()
	end
	button.MouseEnter:Connect(function() hovering = true; play(hoverSound); to(HOVER_SCALE, tilt()) end)
	button.MouseLeave:Connect(function() hovering = false; to(1, 0, BACK) end)
	button.MouseButton1Down:Connect(function() to(PRESS_SCALE, tilt()) end)
	button.MouseButton1Up:Connect(function() to(hovering and HOVER_SCALE or 1, hovering and tilt() or 0, BACK) end)
	button.Activated:Connect(function()
		play(clickSound)
		if not hovering then -- mobile / manette : petit coup de tête puis retour
			to(PRESS_SCALE, tilt())
			task.delay(0.12, function() if not hovering then to(1, 0, BACK) end end)
		end
	end)
end

for _, d in playerGui:GetDescendants() do setup(d) end
playerGui.DescendantAdded:Connect(function(d) task.defer(setup, d) end)
