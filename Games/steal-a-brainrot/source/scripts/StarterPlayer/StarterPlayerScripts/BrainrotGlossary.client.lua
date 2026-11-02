-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not game:GetService("RunService"):IsStudio() then
	return
end

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Animals = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Animals"))
local t = {
	Common = Color3.fromRGB(169, 169, 169),
	Rare = Color3.fromRGB(0, 150, 255),
	Epic = Color3.fromRGB(150, 0, 200),
	Legendary = Color3.fromRGB(255, 215, 0),
	Mythic = Color3.fromRGB(255, 0, 100),
	["Brainrot God"] = Color3.fromRGB(255, 50, 50),
	Secret = Color3.fromRGB(255, 0, 255),
	OG = Color3.fromRGB(0, 255, 150),
	Ascended = Color3.fromRGB(255, 140, 0),
	Meme = Color3.fromRGB(0, 255, 255),
	Admin = Color3.fromRGB(255, 0, 0),
	Quack = Color3.fromRGB(255, 200, 0),
	Taco = Color3.fromRGB(0, 200, 100),
	Spooky = Color3.fromRGB(100, 0, 100),
	Festive = Color3.fromRGB(0, 200, 0),
	["St Patrick\'s"] = Color3.fromRGB(0, 150, 0),
	Easter = Color3.fromRGB(255, 100, 200),
	Valentines = Color3.fromRGB(255, 50, 150)
}
local list = {}

for k, v in pairs(Animals) do
	if not v.HideFromIndex then
		table.insert(list, {
			name = v.DisplayName or k,
			rarity = v.Rarity or "Unknown",
			price = v.Price or 0,
			exitCount = v.RoadWeight or 0
		})
	end
end

table.sort(list, function(p1, p2) --[[ Line: 51 ]]
	return p1.name < p2.name
end)

local BrainrotGlossaryGui = Instance.new("ScreenGui")

BrainrotGlossaryGui.Name = "BrainrotGlossaryGui"
BrainrotGlossaryGui.ResetOnSpawn = false
BrainrotGlossaryGui.Parent = PlayerGui

local GlossaryToggle = Instance.new("TextButton")

GlossaryToggle.Name = "GlossaryToggle"
GlossaryToggle.Size = UDim2.new(0, 120, 0, 40)
GlossaryToggle.Position = UDim2.new(0, 10, 0, 10)
GlossaryToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
GlossaryToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
GlossaryToggle.Text = "Glossar"
GlossaryToggle.TextSize = 18
GlossaryToggle.Font = Enum.Font.GothamBold

local UICorner = Instance.new("UICorner")

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = GlossaryToggle
GlossaryToggle.Parent = BrainrotGlossaryGui

local GlossaryFrame = Instance.new("Frame")

GlossaryFrame.Name = "GlossaryFrame"
GlossaryFrame.Size = UDim2.new(0, 550, 0, 400)
GlossaryFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
GlossaryFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
GlossaryFrame.BorderSizePixel = 0
GlossaryFrame.Visible = false

local UICorner2 = Instance.new("UICorner")

UICorner2.CornerRadius = UDim.new(0, 12)
UICorner2.Parent = GlossaryFrame
GlossaryFrame.Parent = BrainrotGlossaryGui

local TitleBar = Instance.new("Frame")

TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = GlossaryFrame

local UICorner3 = Instance.new("UICorner")

UICorner3.CornerRadius = UDim.new(0, 12)
UICorner3.Parent = TitleBar

local Title = Instance.new("TextLabel")

Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Brainrot Glossar (" .. #list .. " Eintraege)"
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")

CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold

local UICorner4 = Instance.new("UICorner")

UICorner4.CornerRadius = UDim.new(0, 6)
UICorner4.Parent = CloseButton
CloseButton.Parent = TitleBar

local SearchBox = Instance.new("TextBox")

SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -20, 0, 30)
SearchBox.Position = UDim2.new(0, 10, 0, 50)
SearchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderText = "Suche Brainrot..."
SearchBox.Text = ""
SearchBox.TextSize = 14
SearchBox.Font = Enum.Font.Gotham

local UICorner5 = Instance.new("UICorner")

UICorner5.CornerRadius = UDim.new(0, 6)
UICorner5.Parent = SearchBox
SearchBox.Parent = GlossaryFrame

local BrainrotList = Instance.new("ScrollingFrame")

BrainrotList.Name = "BrainrotList"
BrainrotList.Size = UDim2.new(1, -20, 1, -95)
BrainrotList.Position = UDim2.new(0, 10, 0, 90)
BrainrotList.BackgroundTransparency = 1
BrainrotList.BorderSizePixel = 0
BrainrotList.ScrollBarThickness = 6
BrainrotList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
BrainrotList.AutomaticCanvasSize = Enum.AutomaticSize.Y
BrainrotList.CanvasSize = UDim2.new(0, 0, 0, 0)
BrainrotList.Parent = GlossaryFrame

local UIListLayout = Instance.new("UIListLayout")

UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.Parent = BrainrotList

local function createEntry(p1) --[[ createEntry | Line: 171 | Upvalues: t (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, -10, 0, 50)
	Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Frame.BorderSizePixel = 0

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Frame

	local NameLabel = Instance.new("TextLabel")

	NameLabel.Name = "NameLabel"
	NameLabel.Size = UDim2.new(0.4, -5, 1, 0)
	NameLabel.Position = UDim2.new(0, 10, 0, 0)
	NameLabel.BackgroundTransparency = 1
	NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameLabel.Text = p1.name
	NameLabel.TextSize = 14
	NameLabel.Font = Enum.Font.GothamBold
	NameLabel.TextXAlignment = Enum.TextXAlignment.Left
	NameLabel.Parent = Frame

	local RarityLabel = Instance.new("TextLabel")

	RarityLabel.Name = "RarityLabel"
	RarityLabel.Size = UDim2.new(0.2, -5, 1, 0)
	RarityLabel.Position = UDim2.new(0.4, 0, 0, 0)
	RarityLabel.BackgroundTransparency = 1
	RarityLabel.TextColor3 = t[p1.rarity] or Color3.fromRGB(255, 255, 255)
	RarityLabel.Text = p1.rarity
	RarityLabel.TextSize = 12
	RarityLabel.Font = Enum.Font.Gotham
	RarityLabel.TextXAlignment = Enum.TextXAlignment.Center
	RarityLabel.Parent = Frame

	local PriceLabel = Instance.new("TextLabel")

	PriceLabel.Name = "PriceLabel"
	PriceLabel.Size = UDim2.new(0.2, -5, 1, 0)
	PriceLabel.Position = UDim2.new(0.6, 0, 0, 0)
	PriceLabel.BackgroundTransparency = 1
	PriceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	PriceLabel.Text = tostring(p1.price)
	PriceLabel.TextSize = 12
	PriceLabel.Font = Enum.Font.Gotham
	PriceLabel.TextXAlignment = Enum.TextXAlignment.Right
	PriceLabel.Parent = Frame

	local ExitLabel = Instance.new("TextLabel")

	ExitLabel.Name = "ExitLabel"
	ExitLabel.Size = UDim2.new(0.2, -5, 1, 0)
	ExitLabel.Position = UDim2.new(0.8, 0, 0, 0)
	ExitLabel.BackgroundTransparency = 1
	ExitLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
	ExitLabel.Text = tostring(p1.exitCount)
	ExitLabel.TextSize = 12
	ExitLabel.Font = Enum.Font.Gotham
	ExitLabel.TextXAlignment = Enum.TextXAlignment.Right
	ExitLabel.Parent = Frame

	return Frame
end

for i, v in ipairs(list) do
	createEntry(v).Parent = BrainrotList
end

local v1 = false

GlossaryToggle.MouseButton1Click:Connect(function() --[[ Line: 241 | Upvalues: v1 (ref), GlossaryFrame (copy) ]]
	v1 = not v1
	GlossaryFrame.Visible = v1
end)
CloseButton.MouseButton1Click:Connect(function() --[[ Line: 246 | Upvalues: v1 (ref), GlossaryFrame (copy) ]]
	v1 = false
	GlossaryFrame.Visible = false
end)
SearchBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 252 | Upvalues: SearchBox (copy), BrainrotList (copy) ]]
	local v1 = string.lower(SearchBox.Text)

	for i, v in ipairs(BrainrotList:GetChildren()) do
		if v:IsA("Frame") then
			local NameLabel = v:FindFirstChild("NameLabel")

			if NameLabel then
				v.Visible = if v1 == "" then true elseif string.find(string.lower(NameLabel.Text), v1, 1, true) == nil then false else true
			end
		end
	end
end)
print("Brainrot Glossar mit Exit Count geladen! Eintraege: " .. #list)