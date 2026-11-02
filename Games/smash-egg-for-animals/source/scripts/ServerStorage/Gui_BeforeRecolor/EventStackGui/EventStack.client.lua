-- Pile des events en bas à droite : le premier event est tout en bas, les suivants se posent juste au-dessus.
-- Contient : la nuit (toujours là), la chance du serveur, et le HUD de la sorcière (ajouté par WitchEventClient).
-- Gère aussi le fondu noir quand la nuit tombe.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local gui = script.Parent
local stack = gui:WaitForChild("Stack")
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local function clock(seconds)
	seconds = math.max(0, math.ceil(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	return h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
end

local function entry(name, emoji, color)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.fromOffset(150, 54)
	frame.Visible = false
	local function text(str, position, size, textColor, thickness)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = position, size
		label.FontFace = HEAVY
		label.Text = str
		label.TextScaled = true
		label.TextColor3 = textColor
		label.TextXAlignment = Enum.TextXAlignment.Left
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = thickness
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Parent = label
		label.Parent = frame
		return label
	end
	local icon = text(emoji, UDim2.fromOffset(0, 3), UDim2.fromOffset(48, 48), Color3.new(1, 1, 1), 2.5)
	icon.TextXAlignment = Enum.TextXAlignment.Center
	local title = text(string.upper(name), UDim2.fromOffset(54, 5), UDim2.new(1, -54, 0, 15), color, 2)
	local timer = text("00:00", UDim2.fromOffset(54, 20), UDim2.new(1, -54, 0, 30), Color3.new(1, 1, 1), 3)
	frame:GetPropertyChangedSignal("Visible"):Connect(function()
		if frame.Visible then frame.LayoutOrder = -math.floor(os.clock() * 10) end
	end)
	frame.Parent = stack
	return frame, title, timer, icon
end

local night, nightTitle, nightTimer, nightIcon = entry("Night", "🌙", Color3.fromRGB(170, 190, 255))
local luck, luckTitle, luckTimer = entry("Luck", "🍀", Color3.fromRGB(150, 255, 130))
nightIcon.Text = "" -- la nuit a sa propre image
local nightImage = Instance.new("ImageLabel")
nightImage.BackgroundTransparency = 1
nightImage.Image = "rbxassetid://131317614803230"
nightImage.Size = UDim2.fromScale(1, 1)
nightImage.Parent = nightIcon
local nightShown = false -- la nuit garde sa place dans la pile même quand son texte change

-- fondu noir : l'écran devient noir, le serveur déplace tout le monde, puis le noir s'en va aussitôt
local black = Instance.new("Frame")
black.Name = "NightFade"
black.BackgroundColor3 = Color3.new(0, 0, 0)
black.BackgroundTransparency = 1
black.BorderSizePixel = 0
black.Size = UDim2.fromScale(1, 1)
black.ZIndex = 100
black.Visible = false
local fadeGui = Instance.new("ScreenGui") -- par-dessus toutes les autres interfaces
fadeGui.Name = "NightFadeGui"
fadeGui.ResetOnSpawn = false
fadeGui.IgnoreGuiInset = true
fadeGui.DisplayOrder = 1000
fadeGui.Parent = gui.Parent
black.Parent = fadeGui
task.spawn(function()
	ReplicatedStorage:WaitForChild("NightFade").OnClientEvent:Connect(function()
		black.Visible = true
		TweenService:Create(black, TweenInfo.new(0.45), {BackgroundTransparency = 0}):Play()
		task.wait(1.1)
		local out = TweenService:Create(black, TweenInfo.new(0.6), {BackgroundTransparency = 1})
		out:Play()
		out.Completed:Wait()
		black.Visible = false
	end)
end)

-- balancement fluide de l'icône de nuit (à chaque image)
game:GetService("RunService").RenderStepped:Connect(function()
	if night.Visible then nightIcon.Rotation = math.sin(os.clock() * 1.8) * 7 end
end)

while true do
	local now = workspace:GetServerTimeNow()
	local nightEnd, nightAt = ReplicatedStorage:GetAttribute("NightEnd"), ReplicatedStorage:GetAttribute("NightAt")
	if type(nightEnd) == "number" and nightEnd > now then
		nightTitle.Text, nightTimer.Text = "NIGHT ENDS IN", clock(nightEnd - now)
		nightTitle.TextColor3 = Color3.fromRGB(255, 225, 120)
		night.Visible = true
	elseif type(nightAt) == "number" then
		nightTitle.Text, nightTimer.Text = "NIGHT IN", clock(nightAt - now)
		nightTitle.TextColor3 = Color3.fromRGB(170, 190, 255)
		night.Visible = true
	end
	if not nightShown and night.Visible then nightShown = true end

	local luckEnd, mult = ReplicatedStorage:GetAttribute("LuckEnd"), ReplicatedStorage:GetAttribute("LuckMultiplier")
	if type(luckEnd) == "number" and luckEnd > now and type(mult) == "number" then
		luckTitle.Text, luckTimer.Text = mult .. "X SERVER LUCK", clock(luckEnd - now)
		luck.Visible = true
	else
		luck.Visible = false
	end
	task.wait(0.2)
end
