-- LocalScript : AdminPanel
-- StarterGui > AdminPanel
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService  = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local ACModules   = ReplicatedStorage:WaitForChild("ACModules")
local Remotes     = require(ACModules:WaitForChild("Remotes"))

-- Stop if not admin
local isAdmin = Remotes.IsAdmin:InvokeServer()
if not isAdmin then return end

-- ============================================================
--  GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name           = "ACPanel"
screenGui.ResetOnSpawn   = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent         = localPlayer.PlayerGui

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size             = UDim2.new(0, 480, 0, 560)
mainFrame.Position         = UDim2.new(0.5, -240, 0.5, -280)
mainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 20)
mainFrame.BorderSizePixel  = 0
mainFrame.Visible          = false
mainFrame.Parent           = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color     = Color3.fromRGB(80, 40, 180)
stroke.Thickness = 1.5

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size             = UDim2.new(1, 0, 0, 44)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 12, 60)
titleBar.BorderSizePixel  = 0
titleBar.Parent           = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size               = UDim2.new(1, -60, 1, 0)
titleLabel.Position           = UDim2.new(0, 16, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text               = "🛡️  AntiCheat — Admin Panel"
titleLabel.TextColor3         = Color3.fromRGB(200, 160, 255)
titleLabel.Font               = Enum.Font.GothamBold
titleLabel.TextSize           = 15
titleLabel.TextXAlignment     = Enum.TextXAlignment.Left
titleLabel.Parent             = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size             = UDim2.new(0, 30, 0, 30)
closeBtn.Position         = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Text             = "✕"
closeBtn.TextColor3       = Color3.new(1,1,1)
closeBtn.Font             = Enum.Font.GothamBold
closeBtn.TextSize         = 14
closeBtn.BorderSizePixel  = 0
closeBtn.Parent           = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

-- Content
local content = Instance.new("Frame")
content.Size                = UDim2.new(1, -24, 1, -60)
content.Position            = UDim2.new(0, 12, 0, 52)
content.BackgroundTransparency = 1
content.Parent              = mainFrame

-- Tabs
local tabBar = Instance.new("Frame")
tabBar.Size                 = UDim2.new(1, 0, 0, 34)
tabBar.BackgroundTransparency = 1
tabBar.Parent               = content
local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding       = UDim.new(0, 6)
tabLayout.Parent        = tabBar

local function makeTab(label)
	local btn = Instance.new("TextButton")
	btn.Size             = UDim2.new(0, 140, 1, 0)
	btn.BackgroundColor3 = Color3.fromRGB(30, 20, 55)
	btn.Text             = label
	btn.TextColor3       = Color3.fromRGB(160, 130, 220)
	btn.Font             = Enum.Font.GothamSemibold
	btn.TextSize         = 13
	btn.BorderSizePixel  = 0
	btn.Parent           = tabBar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	return btn
end

local tabBans    = makeTab("📋 Active Bans")
local tabAll     = makeTab("📜 History")
local tabActions = makeTab("⚡ Actions")

-- Scrollable list
local listFrame = Instance.new("ScrollingFrame")
listFrame.Size                   = UDim2.new(1, 0, 1, -90)
listFrame.Position               = UDim2.new(0, 0, 0, 40)
listFrame.BackgroundTransparency = 1
listFrame.ScrollBarThickness     = 4
listFrame.ScrollBarImageColor3   = Color3.fromRGB(120, 60, 220)
listFrame.CanvasSize             = UDim2.new(0, 0, 0, 0)
listFrame.AutomaticCanvasSize    = Enum.AutomaticSize.Y
listFrame.Parent                 = content
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent  = listFrame

-- Actions zone
local actionZone = Instance.new("Frame")
actionZone.Size                 = UDim2.new(1, 0, 1, -90)
actionZone.Position             = UDim2.new(0, 0, 0, 40)
actionZone.BackgroundTransparency = 1
actionZone.Visible              = false
actionZone.Parent               = content

local function makeInput(parent, placeholder, yPos)
	local bg = Instance.new("Frame")
	bg.Size             = UDim2.new(1, 0, 0, 38)
	bg.Position         = UDim2.new(0, 0, 0, yPos)
	bg.BackgroundColor3 = Color3.fromRGB(22, 15, 45)
	bg.BorderSizePixel  = 0
	bg.Parent           = parent
	Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", bg).Color        = Color3.fromRGB(60, 30, 120)
	local inp = Instance.new("TextBox")
	inp.Size                = UDim2.new(1, -16, 1, 0)
	inp.Position            = UDim2.new(0, 8, 0, 0)
	inp.BackgroundTransparency = 1
	inp.PlaceholderText     = placeholder
	inp.PlaceholderColor3   = Color3.fromRGB(90, 70, 130)
	inp.Text                = ""
	inp.TextColor3          = Color3.fromRGB(220, 200, 255)
	inp.Font                = Enum.Font.Gotham
	inp.TextSize            = 13
	inp.TextXAlignment      = Enum.TextXAlignment.Left
	inp.ClearTextOnFocus    = false
	inp.Parent              = bg
	return inp
end

local inputBanName   = makeInput(actionZone, "Player username", 0)
local inputBanReason = makeInput(actionZone, "Ban reason...", 46)

local banBtn = Instance.new("TextButton")
banBtn.Size             = UDim2.new(1, 0, 0, 38)
banBtn.Position         = UDim2.new(0, 0, 0, 100)
banBtn.BackgroundColor3 = Color3.fromRGB(160, 30, 30)
banBtn.Text             = "🔨  Ban this player"
banBtn.TextColor3       = Color3.new(1,1,1)
banBtn.Font             = Enum.Font.GothamBold
banBtn.TextSize         = 14
banBtn.BorderSizePixel  = 0
banBtn.Parent           = actionZone
Instance.new("UICorner", banBtn).CornerRadius = UDim.new(0, 8)

local inputUnbanName   = makeInput(actionZone, "Username to unban", 158)
local inputUnbanReason = makeInput(actionZone, "Unban reason...", 204)

local unbanBtn = Instance.new("TextButton")
unbanBtn.Size             = UDim2.new(1, 0, 0, 38)
unbanBtn.Position         = UDim2.new(0, 0, 0, 258)
unbanBtn.BackgroundColor3 = Color3.fromRGB(20, 120, 60)
unbanBtn.Text             = "✅  Unban this player"
unbanBtn.TextColor3       = Color3.new(1,1,1)
unbanBtn.Font             = Enum.Font.GothamBold
unbanBtn.TextSize         = 14
unbanBtn.BorderSizePixel  = 0
unbanBtn.Parent           = actionZone
Instance.new("UICorner", unbanBtn).CornerRadius = UDim.new(0, 8)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size                = UDim2.new(1, 0, 0, 30)
statusLabel.Position            = UDim2.new(0, 0, 0, 306)
statusLabel.BackgroundTransparency = 1
statusLabel.Text                = ""
statusLabel.TextColor3          = Color3.fromRGB(100, 220, 120)
statusLabel.Font                = Enum.Font.Gotham
statusLabel.TextSize            = 13
statusLabel.Parent              = actionZone

-- ============================================================
--  LOGIC
-- ============================================================
local currentMode = "active"

local function setStatus(msg, color)
	statusLabel.Text       = msg
	statusLabel.TextColor3 = color or Color3.fromRGB(100, 220, 120)
end

local function clearList()
	for _, c in ipairs(listFrame:GetChildren()) do
		if c:IsA("Frame") then c:Destroy() end
	end
end

local function makeRow(b)
	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1, -8, 0, 72)
	row.BackgroundColor3 = b.active and Color3.fromRGB(40, 15, 60) or Color3.fromRGB(20, 30, 20)
	row.BorderSizePixel  = 0
	row.Parent           = listFrame
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
	local s = Instance.new("UIStroke", row)
	s.Color     = b.active and Color3.fromRGB(140, 40, 200) or Color3.fromRGB(40, 120, 60)
	s.Thickness = 1

	local dot = Instance.new("Frame")
	dot.Size             = UDim2.new(0, 8, 0, 8)
	dot.Position         = UDim2.new(0, 12, 0.5, -4)
	dot.BackgroundColor3 = b.active and Color3.fromRGB(220, 60, 60) or Color3.fromRGB(60, 200, 100)
	dot.BorderSizePixel  = 0
	dot.Parent           = row
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

	local nameL = Instance.new("TextLabel")
	nameL.Size               = UDim2.new(1, -100, 0, 20)
	nameL.Position           = UDim2.new(0, 28, 0, 8)
	nameL.BackgroundTransparency = 1
	nameL.Text               = "👤 " .. (b.username or "?") .. "  [" .. tostring(b.userId) .. "]"
	nameL.TextColor3         = Color3.fromRGB(220, 200, 255)
	nameL.Font               = Enum.Font.GothamBold
	nameL.TextSize           = 13
	nameL.TextXAlignment     = Enum.TextXAlignment.Left
	nameL.Parent             = row

	local reasonL = Instance.new("TextLabel")
	reasonL.Size             = UDim2.new(1, -28, 0, 18)
	reasonL.Position         = UDim2.new(0, 28, 0, 28)
	reasonL.BackgroundTransparency = 1
	reasonL.Text             = "Reason: " .. (b.reason or "?")
	reasonL.TextColor3       = Color3.fromRGB(180, 150, 220)
	reasonL.Font             = Enum.Font.Gotham
	reasonL.TextSize         = 12
	reasonL.TextXAlignment   = Enum.TextXAlignment.Left
	reasonL.Parent           = row

	local byL = Instance.new("TextLabel")
	byL.Size                 = UDim2.new(1, -28, 0, 16)
	byL.Position             = UDim2.new(0, 28, 0, 48)
	byL.BackgroundTransparency = 1
	local dateStr = b.timestamp and os.date("%d/%m/%Y %H:%M", b.timestamp) or "?"
	byL.Text                 = "By: " .. (b.bannedBy or "?") .. "  •  " .. dateStr
	byL.TextColor3           = Color3.fromRGB(120, 100, 160)
	byL.Font                 = Enum.Font.Gotham
	byL.TextSize             = 11
	byL.TextXAlignment       = Enum.TextXAlignment.Left
	byL.Parent               = row

	if b.active then
		local ub = Instance.new("TextButton")
		ub.Size             = UDim2.new(0, 70, 0, 26)
		ub.Position         = UDim2.new(1, -80, 0.5, -13)
		ub.BackgroundColor3 = Color3.fromRGB(20, 100, 50)
		ub.Text             = "Unban"
		ub.TextColor3       = Color3.new(1,1,1)
		ub.Font             = Enum.Font.GothamSemibold
		ub.TextSize         = 11
		ub.BorderSizePixel  = 0
		ub.Parent           = row
		Instance.new("UICorner", ub).CornerRadius = UDim.new(0, 6)
		ub.MouseButton1Click:Connect(function()
			local ok, msg = Remotes.UnbanPlayer:InvokeServer(b.userId, b.username, "Unbanned via panel", localPlayer.Name)
			if ok then
				row:Destroy()
				setStatus("✅ " .. (b.username or "?") .. " unbanned!", Color3.fromRGB(60, 220, 100))
			else
				setStatus("❌ " .. tostring(msg), Color3.fromRGB(220, 60, 60))
			end
		end)
	end
end

local function refreshList()
	clearList()
	local bans = Remotes.GetBans:InvokeServer()
	if not bans then return end
	local count = 0
	for _, b in ipairs(bans) do
		local show = (currentMode == "active" and b.active) or (currentMode == "all")
		if show then
			makeRow(b)
			count += 1
		end
	end
	if count == 0 then
		local empty = Instance.new("TextLabel")
		empty.Size                = UDim2.new(1, 0, 0, 40)
		empty.BackgroundTransparency = 1
		empty.Text                = "No results."
		empty.TextColor3          = Color3.fromRGB(100, 80, 140)
		empty.Font                = Enum.Font.Gotham
		empty.TextSize            = 13
		empty.Parent              = listFrame
	end
end

local function setTab(mode)
	currentMode = mode
	listFrame.Visible  = mode ~= "actions"
	actionZone.Visible = mode == "actions"
	local active   = Color3.fromRGB(80, 30, 160)
	local inactive = Color3.fromRGB(30, 20, 55)
	tabBans.BackgroundColor3    = mode == "active"  and active or inactive
	tabAll.BackgroundColor3     = mode == "all"     and active or inactive
	tabActions.BackgroundColor3 = mode == "actions" and active or inactive
	if mode ~= "actions" then refreshList() end
end

tabBans.MouseButton1Click:Connect(function() setTab("active") end)
tabAll.MouseButton1Click:Connect(function() setTab("all") end)
tabActions.MouseButton1Click:Connect(function() setTab("actions") end)

banBtn.MouseButton1Click:Connect(function()
	local name   = inputBanName.Text
	local reason = inputBanReason.Text
	if name == "" then setStatus("❌ Enter a username.", Color3.fromRGB(220,60,60)) return end
	if reason == "" then reason = "Manual ban" end
	local ok, msg = Remotes.BanPlayer:InvokeServer(name, reason)
	if ok then
		setStatus("✅ " .. name .. " banned!", Color3.fromRGB(60,220,100))
		inputBanName.Text = ""; inputBanReason.Text = ""
	else
		setStatus("❌ " .. tostring(msg), Color3.fromRGB(220,60,60))
	end
end)

unbanBtn.MouseButton1Click:Connect(function()
	local name   = inputUnbanName.Text
	local reason = inputUnbanReason.Text
	if name == "" then setStatus("❌ Enter a username.", Color3.fromRGB(220,60,60)) return end
	local bans = Remotes.GetBans:InvokeServer()
	local found
	if bans then
		for _, b in ipairs(bans) do
			if b.username and b.username:lower() == name:lower() and b.active then
				found = b; break
			end
		end
	end
	if not found then setStatus("❌ Player not found in active bans.", Color3.fromRGB(220,60,60)) return end
	local ok, msg = Remotes.UnbanPlayer:InvokeServer(found.userId, found.username, reason ~= "" and reason or "Unbanned via panel", localPlayer.Name)
	if ok then
		setStatus("✅ " .. name .. " unbanned!", Color3.fromRGB(60,220,100))
		inputUnbanName.Text = ""; inputUnbanReason.Text = ""
	else
		setStatus("❌ " .. tostring(msg), Color3.fromRGB(220,60,60))
	end
end)

-- Toast notifications
Remotes.Detected.OnClientEvent:Connect(function(data)
	local toast = Instance.new("Frame")
	toast.Size             = UDim2.new(0, 340, 0, 60)
	toast.Position         = UDim2.new(1, -360, 0, 80)
	toast.BackgroundColor3 = data.color == "red"   and Color3.fromRGB(80,15,15)
		or data.color == "green" and Color3.fromRGB(15,60,30)
		or Color3.fromRGB(60,45,10)
	toast.BorderSizePixel  = 0
	toast.Parent           = screenGui
	Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
	local s2 = Instance.new("UIStroke", toast)
	s2.Color = data.color == "red"   and Color3.fromRGB(200,50,50)
		or data.color == "green" and Color3.fromRGB(50,180,80)
		or Color3.fromRGB(200,160,40)
	local t1 = Instance.new("TextLabel")
	t1.Size=UDim2.new(1,-16,0,22); t1.Position=UDim2.new(0,12,0,6)
	t1.BackgroundTransparency=1; t1.Text=data.title or ""; t1.TextColor3=Color3.new(1,1,1)
	t1.Font=Enum.Font.GothamBold; t1.TextSize=13; t1.TextXAlignment=Enum.TextXAlignment.Left; t1.Parent=toast
	local t2 = Instance.new("TextLabel")
	t2.Size=UDim2.new(1,-16,0,28); t2.Position=UDim2.new(0,12,0,26)
	t2.BackgroundTransparency=1; t2.Text=data.message or ""; t2.TextColor3=Color3.fromRGB(200,180,220)
	t2.Font=Enum.Font.Gotham; t2.TextSize=12; t2.TextXAlignment=Enum.TextXAlignment.Left
	t2.TextWrapped=true; t2.Parent=toast
	task.delay(5, function()
		for i=1,20 do toast.BackgroundTransparency=i/20; task.wait(0.05) end
		toast:Destroy()
	end)
end)

-- Toggle F1 + floating button
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.F1 then
		mainFrame.Visible = not mainFrame.Visible
		if mainFrame.Visible then setTab("active") end
	end
end)

local openBtn = Instance.new("TextButton")
openBtn.Size             = UDim2.new(0, 38, 0, 38)
openBtn.Position         = UDim2.new(1, -50, 0, 10)
openBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 160)
openBtn.Text             = "🛡️"
openBtn.TextSize         = 18
openBtn.Font             = Enum.Font.GothamBold
openBtn.TextColor3       = Color3.new(1,1,1)
openBtn.BorderSizePixel  = 0
openBtn.Parent           = screenGui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)
openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	if mainFrame.Visible then setTab("active") end
end)

print("[AC Panel] ✅ Admin panel loaded — Press F1 to open")