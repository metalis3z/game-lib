-- Settings : bouton engrenage (en haut à droite) et panneau avec deux réglages, Music et Sound effects.
-- Tous les sons du jeu passent par deux SoundGroup créés ici : "Music" (la musique de fond et les musiques des cinématiques)
-- et "SFX" (tout le reste). Les curseurs règlent le volume de ces groupes ; le choix est gardé par SettingsServer.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local openButton = gui:WaitForChild("Open")
local saveRemote = ReplicatedStorage:WaitForChild("SettingsRemotes"):WaitForChild("Save")

---------------------------------------------------------------- groupes de sons
local function group(name)
	local g = SoundService:FindFirstChild(name)
	if not g then
		g = Instance.new("SoundGroup")
		g.Name = name
		g.Parent = SoundService
	end
	return g
end
local groups = {Music = group("Music"), Sfx = group("SFX")}
local MUSIC_NAMES = {Days = true}
local MUSIC_MIN_LENGTH = 25 -- une boucle de plus de 25 s est une musique ; une boucle courte (vent, feu) est un bruitage

local function isMusic(sound)
	return MUSIC_NAMES[sound.Name] or (sound.Looped and sound.TimeLength >= MUSIC_MIN_LENGTH)
end
local function route(sound)
	if sound.SoundGroup and sound.SoundGroup ~= groups.Music and sound.SoundGroup ~= groups.Sfx then return end
	sound.SoundGroup = isMusic(sound) and groups.Music or groups.Sfx
end
local function watch(sound)
	route(sound)
	-- la durée n'est connue qu'une fois le son chargé, et Looped peut changer après coup
	sound.Loaded:Connect(function() route(sound) end)
	sound:GetPropertyChangedSignal("Looped"):Connect(function() route(sound) end)
end
for _, root in {workspace, SoundService, player:WaitForChild("PlayerGui")} do
	for _, d in root:GetDescendants() do if d:IsA("Sound") then watch(d) end end
	root.DescendantAdded:Connect(function(d) if d:IsA("Sound") then watch(d) end end)
end

---------------------------------------------------------------- curseurs
local values = {Music = 1, Sfx = 1}
local dirty = false
local function apply(name, value, fromServer)
	value = math.clamp(value, 0, 1)
	values[name] = value
	groups[name].Volume = value
	local row = main:WaitForChild(name)
	row.Bar.Fill.Size = UDim2.fromScale(value, 1)
	row.Bar.Knob.Position = UDim2.fromScale(value, 0.5)
	row.Value.Text = value <= 0.005 and "OFF" or (math.floor(value * 100 + 0.5) .. "%")
	if not fromServer then dirty = true end
end

local dragging
local function setFromX(name, x)
	local bar = main[name].Bar
	local u = (x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1)
	apply(name, math.floor(math.clamp(u, 0, 1) * 20 + 0.5) / 20) -- par pas de 5 %
end
for name in values do
	main:WaitForChild(name).Bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = name
			setFromX(name, input.Position.X)
		end
	end)
end
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		setFromX(dragging, input.Position.X)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragging = nil
		if dirty then
			dirty = false
			saveRemote:FireServer(values.Music, values.Sfx)
		end
	end
end)

-- valeurs gardées d'une session à l'autre (le serveur les pose en attributs du joueur)
local function fromAttributes()
	local m, s = player:GetAttribute("MusicVolume"), player:GetAttribute("SfxVolume")
	if typeof(m) == "number" then apply("Music", m, true) end
	if typeof(s) == "number" then apply("Sfx", s, true) end
end
apply("Music", 1, true) apply("Sfx", 1, true)
fromAttributes()
player:GetAttributeChangedSignal("MusicVolume"):Connect(function() if not dragging then fromAttributes() end end)
player:GetAttributeChangedSignal("SfxVolume"):Connect(function() if not dragging then fromAttributes() end end)

---------------------------------------------------------------- ouverture, fermeture, taille selon l'écran
local camera = workspace.CurrentCamera
local OPEN_SIZE = openButton.AbsoluteSize.X > 0 and Vector2.new(openButton.Size.X.Offset, openButton.Size.Y.Offset) or Vector2.new(58, 58)
local function fit()
	local size = camera.ViewportSize
	-- même échelle que UIScaler (moyenne des deux rapports, plus grand sur tactile), sans dépasser de l'écran
	local uis = game:GetService("UserInputService")
	local common = math.sqrt((size.X / 1280) * (size.Y / 760)) * ((uis.TouchEnabled and not uis.KeyboardEnabled) and 1.2 or 1)
	common = math.clamp(math.min(common, size.Y * 0.9 / (312 * 1.2), size.X * 0.95 / (480 * 1.2)), 0.55, 1.4)
	main.Fit.Scale = math.clamp(common * 1.2, 0.6, 1.15) -- un peu plus grand : les curseurs doivent rester faciles à attraper au doigt
	openButton.Size = UDim2.fromOffset(math.floor(OPEN_SIZE.X * common + 0.5), math.floor(OPEN_SIZE.Y * common + 0.5))
end
fit()
camera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)

local function setOpen(open)
	if open == main.Visible then return end
	if open then
		local target = main.Fit.Scale
		main.Visible = true
		main.Fit.Scale = target * 0.8
		TweenService:Create(main.Fit, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = target}):Play()
	else
		main.Visible = false
		fit()
	end
end
openButton.Activated:Connect(function() setOpen(not main.Visible) end)
ReplicatedStorage:WaitForChild("UiSignals"):WaitForChild("ToggleSettings").Event:Connect(function() setOpen(not main.Visible) end) -- bouton de la barre du haut
main:WaitForChild("Header"):WaitForChild("Close").Activated:Connect(function() setOpen(false) end)
