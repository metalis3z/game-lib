-- UpdateClient : mise à jour en direct (commande admin Live Update, voir ServerScriptService.UpdateServer)
--  * remplace les LocalScripts du joueur par leur nouvelle version (sans quitter le serveur)
--  * affiche un petit bandeau "UPDATE INSTALLED!"
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerScripts = player:WaitForChild("PlayerScripts")
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local appliedRemote = remotes:WaitForChild("LiveUpdateApplied")
local clientFolder = ReplicatedStorage:WaitForChild("LiveUpdateClient", 30)

local rgb = Color3.fromRGB
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)

local gui = Instance.new("ScreenGui")
gui.Name = "UpdateGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 60
gui.Parent = player:WaitForChild("PlayerGui")

local HIDDEN, SHOWN = UDim2.new(0.5, 0, 0, -90), UDim2.new(0.5, 0, 0, 14)
local banner = Instance.new("Frame")
banner.AnchorPoint = Vector2.new(0.5, 0)
banner.Position = HIDDEN
banner.Size = UDim2.fromOffset(380, 70)
banner.BackgroundColor3 = Color3.new(1, 1, 1)
banner.BorderSizePixel = 0
banner.Visible = false
banner.Parent = gui
local g = Instance.new("UIGradient")
g.Rotation = 90
g.Color = ColorSequence.new(rgb(140, 240, 90), rgb(40, 180, 50))
g.Parent = banner
local stroke = Instance.new("UIStroke")
stroke.Thickness = 4
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = banner
local studs = Instance.new("ImageLabel")
studs.BackgroundTransparency = 1
studs.Image = "rbxassetid://7447638591"
studs.ScaleType = Enum.ScaleType.Tile
studs.TileSize = UDim2.fromOffset(24, 24)
studs.ImageTransparency = 0.25
studs.Size = UDim2.fromScale(1, 1)
studs.Parent = banner
local function label(text, y, h, font, size)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position = UDim2.fromOffset(10, y)
	l.Size = UDim2.new(1, -20, 0, h)
	l.Text = text
	l.FontFace = font
	l.TextScaled = true
	l.TextColor3 = Color3.new(1, 1, 1)
	l.ZIndex = 2
	local s = Instance.new("UIStroke")
	s.Thickness = size
	s.Parent = l
	l.Parent = banner
	return l
end
label("UPDATE INSTALLED!", 6, 34, HEAVY, 3)
label("The game was updated live. Have fun!", 42, 20, BOLD, 2)

local token = 0
local function showBanner()
	token += 1
	local my = token
	banner.Visible = true
	TweenService:Create(banner, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = SHOWN}):Play()
	task.delay(5, function()
		if token ~= my then return end
		local t = TweenService:Create(banner, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = HIDDEN})
		t:Play()
		t.Completed:Once(function() if token == my then banner.Visible = false end end)
	end)
end

appliedRemote.OnClientEvent:Connect(function(names)
	-- nouvelles versions des LocalScripts : l'ancienne s'arrête, la nouvelle démarre
	for _, name in type(names) == "table" and names or {} do
		if name ~= script.Name and clientFolder then
			local newVersion = clientFolder:WaitForChild(name, 10)
			if newVersion then
				local old = playerScripts:FindFirstChild(name)
				if old then old:Destroy() end
				newVersion:Clone().Parent = playerScripts
			end
		end
	end
	showBanner()
end)
