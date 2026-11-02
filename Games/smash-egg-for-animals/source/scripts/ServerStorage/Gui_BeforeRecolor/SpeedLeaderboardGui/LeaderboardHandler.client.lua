-- Affiche le classement du meilleur speed (top 99) sur le panneau Workspace.SpeedLeaderboard : rang, tête, @nom, speed.
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gui = script.Parent
local data = ReplicatedStorage:WaitForChild("SpeedLeaderboard")
local SpeedConfig = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local player = Players.LocalPlayer
local rgb = Color3.fromRGB
local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUD = "rbxassetid://7447638591"
local MEDALS = {{rgb(255, 226, 90), rgb(240, 160, 20)}, {rgb(236, 240, 250), rgb(150, 160, 185)}, {rgb(240, 170, 110), rgb(176, 96, 50)}}
local ROW = 62

task.spawn(function() -- le panneau peut arriver après le joueur (streaming)
	gui.Adornee = workspace:WaitForChild("SpeedLeaderboard"):WaitForChild("Board")
end)

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function label(parent, text, position, size, color, thickness, align)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = text, Position = position, Size = size, FontFace = MONT, TextScaled = true, TextColor3 = color, ZIndex = 3,
		TextXAlignment = align or Enum.TextXAlignment.Center}, parent)
	new("UIStroke", {Thickness = thickness}, l)
	return l
end
local function studs(parent, tint)
	return new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Image = STUD, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(34, 34), Size = UDim2.fromScale(1, 1), ImageTransparency = 0.2, ImageColor3 = tint}, parent)
end

local root = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = rgb(255, 255, 255), BorderSizePixel = 0}, gui)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 255, 255), rgb(222, 226, 238))}, root)
studs(root, rgb(236, 238, 246))
-- bandeau du titre
local header = new("Frame", {Position = UDim2.fromOffset(14, 14), Size = UDim2.new(1, -28, 0, 96), BackgroundColor3 = rgb(255, 255, 255), BorderSizePixel = 0}, root)
new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(40, 150, 255)), ColorSequenceKeypoint.new(0.5, rgb(90, 230, 255)), ColorSequenceKeypoint.new(1, rgb(40, 150, 255))})}, header)
new("UIStroke", {Thickness = 5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, header)
studs(header, rgb(70, 190, 255))
new("ImageLabel", {Name = "Icon", BackgroundTransparency = 1, Image = "rbxassetid://80184389303970", ScaleType = Enum.ScaleType.Fit, Position = UDim2.fromOffset(12, 8), Size = UDim2.fromOffset(80, 80), ZIndex = 4}, header)
label(header, "TOP SPEED", UDim2.fromOffset(20, 6), UDim2.new(1, -40, 0, 56), rgb(255, 255, 255), 5)
local timer = label(header, "Updates every 5 minutes", UDim2.fromOffset(20, 62), UDim2.new(1, -40, 0, 26), rgb(255, 255, 255), 3)
-- liste
local list = new("ScrollingFrame", {Position = UDim2.fromOffset(14, 124), Size = UDim2.new(1, -28, 1, -138), BackgroundColor3 = rgb(255, 255, 255), BorderSizePixel = 0,
	CanvasSize = UDim2.new(), ScrollBarThickness = 0, ScrollBarImageColor3 = rgb(0, 0, 0), ScrollingDirection = Enum.ScrollingDirection.Y}, root)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(232, 233, 240), rgb(198, 200, 212))}, list)
new("UIStroke", {Thickness = 4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, list)
local empty = label(root, "No one yet... be the first!", UDim2.new(0, 40, 0.5, 0), UDim2.new(1, -80, 0, 44), rgb(255, 255, 255), 4)

local function render()
	for _, child in list:GetChildren() do
		if child:IsA("Frame") then child:Destroy() end
	end
	local ok, entries = pcall(function() return HttpService:JSONDecode(data.Value) end)
	entries = ok and entries or {}
	empty.Visible = #entries == 0
	for index, entry in entries do
		local medal = MEDALS[index]
		local mine = entry.UserId == player.UserId
		local row = new("Frame", {Position = UDim2.fromOffset(8, 8 + (index - 1) * (ROW + 6)), Size = UDim2.new(1, -16, 0, ROW), BackgroundColor3 = rgb(255, 255, 255), BorderSizePixel = 0}, list)
		new("UIGradient", {Rotation = 90, Color = medal and ColorSequence.new(medal[1], medal[2]) or (mine and ColorSequence.new(rgb(150, 235, 255), rgb(60, 150, 240)) or ColorSequence.new(rgb(92, 88, 122), rgb(60, 58, 84)))}, row)
		new("UIStroke", {Thickness = 3.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, row)
		studs(row, medal and medal[2] or (mine and rgb(90, 180, 245) or rgb(74, 70, 100)))
		label(row, "#" .. index, UDim2.fromOffset(6, 10), UDim2.fromOffset(76, ROW - 20), rgb(255, 255, 255), 3.5)
		local head = new("ImageLabel", {Position = UDim2.fromOffset(88, 5), Size = UDim2.fromOffset(ROW - 10, ROW - 10), BackgroundColor3 = rgb(255, 255, 255), BorderSizePixel = 0, ZIndex = 3,
			Image = "rbxthumb://type=AvatarHeadShot&id=" .. entry.UserId .. "&w=150&h=150"}, row)
		new("UIStroke", {Thickness = 3}, head)
		label(row, "@" .. tostring(entry.Name), UDim2.fromOffset(152, 12), UDim2.new(1, -420, 0, ROW - 24), rgb(255, 255, 255), 3, Enum.TextXAlignment.Left)
		label(row, SpeedConfig.Format(entry.Speed or 0), UDim2.new(1, -262, 0, 10), UDim2.fromOffset(250, ROW - 20), rgb(150, 255, 130), 3.5, Enum.TextXAlignment.Right)
	end
	list.CanvasSize = UDim2.fromOffset(0, 16 + #entries * (ROW + 6))
end
data:GetPropertyChangedSignal("Value"):Connect(render)
render()

-- défilement automatique : la liste descend lentement jusqu'en bas puis remonte, pour voir tout le classement.
-- Si le joueur fait défiler lui-même (molette / doigt), on lui laisse la main quelques secondes.
task.spawn(function()
	local direction, pausedUntil, expected = 1, os.clock() + 3, 0
	while true do
		local dt = task.wait(0.03)
		local maxY = math.max(0, list.AbsoluteCanvasSize.Y - list.AbsoluteWindowSize.Y)
		local y = list.CanvasPosition.Y
		if maxY > 0 then
			if math.abs(y - expected) > 2 then pausedUntil = os.clock() + 6 end
			if os.clock() >= pausedUntil then
				y += direction * 45 * dt
				if y >= maxY then
					y, direction, pausedUntil = maxY, -1, os.clock() + 2.5
				elseif y <= 0 then
					y, direction, pausedUntil = 0, 1, os.clock() + 2.5
				end
				list.CanvasPosition = Vector2.new(0, y)
			end
		end
		expected = list.CanvasPosition.Y
	end
end)

-- compte à rebours avant la prochaine mise à jour
task.spawn(function()
	while true do
		local nextUpdate = data:GetAttribute("NextUpdate")
		if nextUpdate then
			local left = math.max(0, math.floor(nextUpdate - workspace:GetServerTimeNow()))
			timer.Text = string.format("Next update in %d:%02d", left // 60, left % 60)
		end
		task.wait(1)
	end
end)
