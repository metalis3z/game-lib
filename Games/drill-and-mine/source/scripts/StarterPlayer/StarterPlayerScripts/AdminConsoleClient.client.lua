-- Admin console UI. F2 toggles the panel. Only visible/active for whitelisted
-- UserIds (gated by the AdminCommands.IsAdmin RemoteFunction). Sends raw text
-- to the server's AdminCommands.RunCommand and prints the response.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminFolder = Remotes:WaitForChild("AdminCommands", 30)
if not AdminFolder then
	warn("[AdminConsoleClient] AdminCommands remote folder missing")
	return
end
local RunCommandFunc = AdminFolder:WaitForChild("RunCommand")
local IsAdminFunc = AdminFolder:WaitForChild("IsAdmin")

-- Confirm admin status BEFORE building the UI -- non-admins never see the panel
-- and the RemoteFunction still rejects them server-side as defense-in-depth.
local okQuery, isAdmin = pcall(function() return IsAdminFunc:InvokeServer() end)
if not okQuery or isAdmin ~= true then return end

local pg = player:WaitForChild("PlayerGui")
local screen = Instance.new("ScreenGui")
screen.Name = "AdminConsole"
screen.ResetOnSpawn = false
screen.IgnoreGuiInset = true
screen.DisplayOrder = 1000
screen.Parent = pg

local frame = Instance.new("Frame")
frame.Name = "Panel"
frame.Size = UDim2.new(0, 620, 0, 320)
frame.Position = UDim2.new(0.5, -310, 1, -340)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Parent = screen

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 80, 95)
stroke.Thickness = 1
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Text = "  Admin Console  —  F2 to toggle"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(220, 220, 230)
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 28)
title.Parent = frame

local output = Instance.new("ScrollingFrame")
output.Name = "Output"
output.Position = UDim2.new(0, 10, 0, 32)
output.Size = UDim2.new(1, -20, 1, -76)
output.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
output.BackgroundTransparency = 0.2
output.BorderSizePixel = 0
output.ScrollBarThickness = 6
output.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 130)
output.CanvasSize = UDim2.new(0, 0, 0, 0)
output.AutomaticCanvasSize = Enum.AutomaticSize.Y
output.Parent = frame

local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 6)
outputCorner.Parent = output

local outputPadding = Instance.new("UIPadding")
outputPadding.PaddingTop = UDim.new(0, 6)
outputPadding.PaddingBottom = UDim.new(0, 6)
outputPadding.PaddingLeft = UDim.new(0, 8)
outputPadding.PaddingRight = UDim.new(0, 8)
outputPadding.Parent = output

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 2)
listLayout.Parent = output

local textbox = Instance.new("TextBox")
textbox.Name = "Input"
textbox.Position = UDim2.new(0, 10, 1, -38)
textbox.Size = UDim2.new(1, -20, 0, 30)
textbox.PlaceholderText = "command … (e.g. givecash matodevv 1000000)"
textbox.Text = ""
textbox.Font = Enum.Font.Code
textbox.TextSize = 14
textbox.TextColor3 = Color3.fromRGB(240, 240, 240)
textbox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
textbox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
textbox.BorderSizePixel = 0
textbox.ClearTextOnFocus = false
textbox.TextXAlignment = Enum.TextXAlignment.Left
textbox.Parent = frame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = textbox

local inputPadding = Instance.new("UIPadding")
inputPadding.PaddingLeft = UDim.new(0, 10)
inputPadding.PaddingRight = UDim.new(0, 10)
inputPadding.Parent = textbox

local lineOrder = 0
local MAX_LINES = 200
local function appendLine(text, color)
	lineOrder = lineOrder + 1
	local label = Instance.new("TextLabel")
	label.Name = "Line"
	label.LayoutOrder = lineOrder
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 0, 16)
	label.AutomaticSize = Enum.AutomaticSize.Y
	label.TextWrapped = true
	label.Font = Enum.Font.Code
	label.TextSize = 13
	label.TextColor3 = color or Color3.fromRGB(210, 210, 210)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = text
	label.Parent = output

	-- Trim history to keep the console from growing unbounded over a long
	-- session. ListLayout's SortOrder=LayoutOrder means the oldest line is
	-- the one with the lowest LayoutOrder still parented.
	local lines = output:GetChildren()
	local count = 0
	for _, c in ipairs(lines) do
		if c:IsA("TextLabel") then count = count + 1 end
	end
	if count > MAX_LINES then
		-- Remove the oldest few in one pass
		table.sort(lines, function(a, b)
			return (a:IsA("TextLabel") and a.LayoutOrder or math.huge) < (b:IsA("TextLabel") and b.LayoutOrder or math.huge)
		end)
		local toRemove = count - MAX_LINES
		for _, c in ipairs(lines) do
			if c:IsA("TextLabel") and toRemove > 0 then
				c:Destroy()
				toRemove = toRemove - 1
			end
		end
	end
end

local COLOR_PROMPT = Color3.fromRGB(120, 180, 255)
local COLOR_OK = Color3.fromRGB(180, 230, 180)
local COLOR_ERR = Color3.fromRGB(255, 110, 110)
local COLOR_INFO = Color3.fromRGB(220, 200, 100)

appendLine("Admin Console ready. Type 'help' for commands.", COLOR_INFO)

local history = {}
local historyIndex = 0

local function runCommand(text)
	if text == "" then return end
	appendLine("> " .. text, COLOR_PROMPT)
	table.insert(history, text)
	historyIndex = #history + 1
	local ok, result = pcall(function() return RunCommandFunc:InvokeServer(text) end)
	if not ok then
		appendLine("ERR " .. tostring(result), COLOR_ERR)
		return
	end
	if type(result) == "string" and result ~= "" then
		-- Multi-line server responses come back joined with newlines; split so
		-- each renders cleanly under the ListLayout instead of one giant blob.
		for line in string.gmatch(result, "[^\n]+") do
			appendLine(line, COLOR_OK)
		end
	end
end

textbox.FocusLost:Connect(function(enterPressed)
	if not enterPressed then return end
	local text = textbox.Text
	textbox.Text = ""
	runCommand(text)
	textbox:CaptureFocus()
end)

-- Up/Down arrow history while the textbox has focus.
UserInputService.InputBegan:Connect(function(inputObj, processed)
	if inputObj.KeyCode == Enum.KeyCode.F2 and not processed then
		frame.Visible = not frame.Visible
		if frame.Visible then
			textbox:CaptureFocus()
		else
			textbox:ReleaseFocus()
		end
		return
	end
	if not textbox:IsFocused() then return end
	if inputObj.KeyCode == Enum.KeyCode.Up then
		if #history == 0 then return end
		historyIndex = math.max(1, historyIndex - 1)
		textbox.Text = history[historyIndex] or ""
		textbox.CursorPosition = #textbox.Text + 1
	elseif inputObj.KeyCode == Enum.KeyCode.Down then
		if #history == 0 then return end
		if historyIndex < #history then
			historyIndex = historyIndex + 1
			textbox.Text = history[historyIndex] or ""
		else
			historyIndex = #history + 1
			textbox.Text = ""
		end
		textbox.CursorPosition = #textbox.Text + 1
	end
end)