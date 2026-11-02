-- Reference copy for study. Game: Smash Egg For Animals (smash-egg-for-animals)
-- Original: StarterPlayer/StarterPlayerScripts/UIEffects.client.lua  (client, 94 lines)
-- Categories: ui-animation 31.1, sound-music 9.3
-- What it does: Compact global button FX: UIScale grow on hover, squash on press, Back-eased return, pitch-randomised sounds, mobile tap fallback, and a sound when big windows open. Comments in French.

-- Effets sur tous les boutons des GUI : grossit au survol, s'écrase au clic, avec un son doux.
-- Un autre son accompagne l'ouverture d'une fenêtre. Pour changer un son : remplacer son identifiant ci-dessous.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local HOVER_SCALE = 1.06
local PRESS_SCALE = 0.92

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
local clickSound = sound("rbxassetid://77120543307812", 0.5, "rbxasset://sounds/clickfast.wav")    -- « ui-bubble-click » : clic rond, comme une bulle
local hoverSound = sound("rbxassetid://15675032796", 0.12, "rbxasset://sounds/switch.wav")         -- « Roblox_UI_Small_Click » : tout petit tic au survol
local openSound = sound("rbxassetid://135869563808171", 0.45, "rbxasset://sounds/clickfast.wav")   -- « UI Popup » : une fenêtre s'ouvre
local function play(s, volume)
	s.PlaybackSpeed = 0.96 + math.random() * 0.08 -- jamais deux fois exactement la même note
	if volume then s.Volume = volume end
	SoundService:PlayLocalSound(s)
end

---------------------------------------------------------------- boutons
local lastClick = 0
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
	local hovering = false
	local function to(value, info)
		TweenService:Create(scale, info or INFO, {Scale = value}):Play()
	end
	button.MouseEnter:Connect(function() hovering = true; play(hoverSound); to(HOVER_SCALE) end)
	button.MouseLeave:Connect(function() hovering = false; to(1, BACK) end)
	button.MouseButton1Down:Connect(function() to(PRESS_SCALE) end)
	button.MouseButton1Up:Connect(function() to(hovering and HOVER_SCALE or 1, BACK) end)
	button.Activated:Connect(function()
		lastClick = os.clock()
		play(clickSound)
		if not hovering then -- mobile / manette : écrase puis retour
			to(PRESS_SCALE)
			task.delay(0.12, function() if not hovering then to(1, BACK) end end)
		end
	end)
end

---------------------------------------------------------------- fenêtres : un son quand un grand panneau apparaît
-- Une fenêtre = un cadre nommé Main, Window ou Panel, posé directement dans un ScreenGui (ou dans son premier cadre) et prévu
-- pour faire au moins 320 x 220. Les voiles plein écran (nuit, alerte, cinématiques) ne comptent pas.
local WINDOW_NAMES = {Main = true, Window = true, Panel = true}
local startedAt = os.clock()
local lastOpen = 0
local watched = setmetatable({}, {__mode = "k"})
local function plannedSize(frame) -- la taille prévue, même si la fenêtre s'ouvre en grossissant depuis zéro
	local parent = frame.Parent
	local around = parent:IsA("GuiObject") and parent.AbsoluteSize or workspace.CurrentCamera.ViewportSize
	local size = frame.Size
	return math.max(frame.AbsoluteSize.X, size.X.Scale * around.X + size.X.Offset), math.max(frame.AbsoluteSize.Y, size.Y.Scale * around.Y + size.Y.Offset)
end
local function watch(frame)
	if watched[frame] or not WINDOW_NAMES[frame.Name] or not (frame:IsA("Frame") or frame:IsA("ImageLabel") or frame:IsA("CanvasGroup")) then return end
	local layer = frame:FindFirstAncestorWhichIsA("ScreenGui")
	local parent = frame.Parent
	if not layer or not parent or (parent ~= layer and parent.Parent ~= layer) then return end
	watched[frame] = true
	frame:GetPropertyChangedSignal("Visible"):Connect(function()
		local now = os.clock()
		if not frame.Visible or not layer.Enabled or now - startedAt < 3 or now - lastOpen < 0.2 then return end
		local x, y = plannedSize(frame)
		if x < 320 or y < 220 then return end
		lastOpen = now
		play(openSound, now - lastClick < 0.2 and 0.28 or 0.45) -- plus discret quand il suit le clic d'un bouton
	end)
end

for _, d in playerGui:GetDescendants() do setup(d) watch(d) end
playerGui.DescendantAdded:Connect(function(d)
	task.defer(function() setup(d) watch(d) end)
end)
