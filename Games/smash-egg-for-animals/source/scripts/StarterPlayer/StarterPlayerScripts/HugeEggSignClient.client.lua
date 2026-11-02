-- Panneau "??? Huge Egg" au-dessus de l'entrée des zones (workspace.HugeEggSign) : lettres arc-en-ciel, une vague les traverse
-- toutes les 3 secondes (chaque lettre saute un peu, l'une après l'autre), et le temps avant le prochain Huge Egg
-- (ReplicatedStorage.HugeEggAt, posé par NightServer).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local TITLE = "??? Huge Egg"
local FONT = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
local COLORS = {
	Color3.fromRGB(190, 60, 255), Color3.fromRGB(150, 70, 255), Color3.fromRGB(90, 90, 255), -- ??? violets
	Color3.fromRGB(255, 255, 255), -- espace
	Color3.fromRGB(40, 120, 255), Color3.fromRGB(40, 190, 255), Color3.fromRGB(40, 220, 180), Color3.fromRGB(70, 220, 70), -- Huge
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(255, 200, 30), Color3.fromRGB(255, 130, 30), Color3.fromRGB(255, 50, 50), -- Egg
}
local WAVE_PERIOD = 3     -- une vague toutes les 3 s
local LETTER_DELAY = 0.07 -- décalage entre deux lettres
local JUMP = 0.22         -- hauteur du saut (fraction de la hauteur de la ligne)
local JUMP_TIME = 0.45

local function clock(seconds)
	seconds = math.max(0, math.ceil(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	return h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
end

local boards = {} -- {Letters = {...}, Timer = label}
local function build(sg)
	sg:ClearAllChildren()
	local titleRow = Instance.new("Frame")
	titleRow.BackgroundTransparency = 1
	titleRow.Position = UDim2.fromScale(0.03, 0.1)
	titleRow.Size = UDim2.fromScale(0.94, 0.52)
	titleRow.Parent = sg
	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = titleRow
	local letters = {}
	local n = utf8.len(TITLE)
	local i = 0
	for _, code in utf8.codes(TITLE) do
		i += 1
		local char = utf8.char(code)
		local holder = Instance.new("Frame") -- la lettre bouge dans son emplacement, sans décaler les autres
		holder.BackgroundTransparency = 1
		holder.Size = UDim2.fromScale(char == " " and 0.035 or 0.085, 1)
		holder.LayoutOrder = i
		holder.Parent = titleRow
		local l = Instance.new("TextLabel")
		l.BackgroundTransparency = 1
		l.Size = UDim2.fromScale(1, 1)
		l.FontFace = FONT
		l.Text = char
		l.TextScaled = true
		l.TextColor3 = COLORS[i] or Color3.new(1, 1, 1)
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 5
		stroke.Color = Color3.fromRGB(20, 10, 40)
		stroke.Parent = l
		l.Parent = holder
		table.insert(letters, {Label = l, Index = i})
	end
	local timer = Instance.new("TextLabel")
	timer.BackgroundTransparency = 1
	timer.Position = UDim2.fromScale(0.15, 0.6)
	timer.Size = UDim2.fromScale(0.7, 0.3)
	timer.FontFace = FONT
	timer.TextScaled = true
	timer.TextColor3 = Color3.new(1, 1, 1)
	timer.Text = "Spawns In: --:--"
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 4
	stroke.Color = Color3.fromRGB(30, 20, 60)
	stroke.Parent = timer
	timer.Parent = sg
	table.insert(boards, {Letters = letters, Timer = timer})
end

local sign = workspace:WaitForChild("HugeEggSign", 30)
if not sign then return end
local board = sign:WaitForChild("Board", 30)
for _, sg in board:GetChildren() do if sg:IsA("SurfaceGui") then build(sg) end end

local nextText = 0
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	for _, b in boards do
		for _, letter in b.Letters do
			-- la vague : chaque lettre saute à son tour, une fois toutes les 3 s
			local local_t = (t - letter.Index * LETTER_DELAY) % WAVE_PERIOD
			local k = local_t < JUMP_TIME and math.sin(local_t / JUMP_TIME * math.pi) or 0
			letter.Label.Position = UDim2.fromScale(0, -JUMP * k)
			letter.Label.Rotation = k * (letter.Index % 2 == 0 and 6 or -6)
		end
	end
	if t >= nextText then
		nextText = t + 0.25
		local at = ReplicatedStorage:GetAttribute("HugeEggAt")
		local text = type(at) == "number" and ("Spawns In: " .. clock(at - workspace:GetServerTimeNow())) or "Spawns In: --:--"
		for _, b in boards do b.Timer.Text = text end
	end
end)
