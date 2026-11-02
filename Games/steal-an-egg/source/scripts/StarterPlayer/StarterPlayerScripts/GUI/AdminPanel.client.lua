-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local ParseNumberSmart = require(ReplicatedStorage.Library.Functions.ParseNumberSmart)
local Assets = require(ReplicatedStorage.Directory.Assets)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Directory = Assets.Directory

-- Adjust this path to wherever your ProductIds/GamepassIds module actually lives.
local MonetizationIds = require(ReplicatedStorage.PurchaseIdConfig)
local ADMIN_PANEL_GAMEPASS_ID = MonetizationIds.GamepassIds.AdminPanel

require(ReplicatedStorage.Library.Types.AssetItem)

local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local AdminPanel = Constants.NETWORK_MAP.AdminPanel
local v1 = UDim2.fromOffset(900, 600)
local v2 = Log.new()
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local v3 = nil
local t = {}
local v4 = "Assets"
local v5 = false

-- Categories that must never appear in the Give Pet / asset selection grid.
local EXCLUDED_ASSET_CATEGORIES = {
	["Strawberry Elephant"] = true,
	["Phoenix"] = true,
	["Unicorn"] = true,
}

local function clearGradients(p1) --[[ clearGradients | Line: 86 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("UIGradient") then
			v:Destroy()
		end
	end
end

local function roundToStep(p1, p2) --[[ roundToStep | Line: 94 ]]
	return math.round(p1 / p2) * p2
end

local function formatWalkSpeedDisplay(p1) --[[ formatWalkSpeedDisplay | Line: 98 ]]
	local v2 = string.format("%.1f", math.round(p1 / 0.1) * 0.1)

	if string.sub(v2, -2) == ".0" then
		return string.sub(v2, 1, #v2 - 2)
	end

	return v2
end

local function formatSpeedPowerDisplay(p1) --[[ formatSpeedPowerDisplay | Line: 108 ]]
	return string.format("%.0f", (math.round(p1)))
end

local function parseNumericInput(p1) --[[ parseNumericInput | Line: 112 | Upvalues: ParseNumberSmart (copy) ]]
	local v1 = ParseNumberSmart(p1)

	if typeof(v1) == "number" then
		return v1
	end

	return tonumber(p1)
end

local function trimText(p1) --[[ trimText | Line: 121 ]]
	return string.match(p1, "^%s*(.-)%s*$") or ""
end

local function parseOptionalNumberInput(p1) --[[ parseOptionalNumberInput | Line: 125 | Upvalues: ParseNumberSmart (copy) ]]
	local v1 = string.match(p1, "^%s*(.-)%s*$") or ""

	if v1 == "" then
		return nil, true
	end

	local v2 = ParseNumberSmart(v1)
	local v3 = if typeof(v2) == "number" then v2 else tonumber(v1)

	return v3, v3 ~= nil
end

local function updateSliderVisual(p1, p2) --[[ updateSliderVisual | Line: 135 ]]
	local Step = p1.Step
	local v2 = math.clamp(math.round(p2 / Step) * Step, p1.MinValue, p1.MaxValue)
	local v6 = math.clamp((v2 - p1.MinValue) / math.max(p1.MaxValue - p1.MinValue, 0.0001), 0, 1)

	p1.CurrentValue = v2
	p1.Fill.Size = UDim2.fromScale(v6, 1)
	p1.Knob.Position = UDim2.fromScale(v6, 0.5)
	p1.ValueLabel.Text = p1.FormatDisplay(v2)
	p1.Input.Text = p1.FormatInput(v2)
end

local function createSliderControl(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ createSliderControl | Line: 147 ]]
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = ("%*Label"):format(p2)
	TextLabel.Size = UDim2.fromOffset(190, 18)
	TextLabel.Position = UDim2.fromOffset(690, p4)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = p3
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 15
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = p1

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Name = ("%*Value"):format(p2)
	TextLabel2.Size = UDim2.fromOffset(190, 16)
	TextLabel2.Position = UDim2.fromOffset(690, p4 + 18)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = "0"
	TextLabel2.TextColor3 = Color3.fromRGB(145, 232, 181)
	TextLabel2.TextSize = 13
	TextLabel2.Font = Enum.Font.Gotham
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = p1

	local TextButton = Instance.new("TextButton")

	TextButton.Name = ("%*Track"):format(p2)
	TextButton.Size = UDim2.fromOffset(124, 16)
	TextButton.Position = UDim2.fromOffset(690, p4 + 40)
	TextButton.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
	TextButton.BorderSizePixel = 0
	TextButton.Text = ""
	TextButton.AutoButtonColor = false
	TextButton.Parent = p1

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = TextButton

	local Fill = Instance.new("Frame")

	Fill.Name = "Fill"
	Fill.Size = UDim2.fromScale(0, 1)
	Fill.BackgroundColor3 = Color3.fromRGB(36, 114, 84)
	Fill.BorderSizePixel = 0
	Fill.Parent = TextButton

	local UICorner2 = Instance.new("UICorner")

	UICorner2.CornerRadius = UDim.new(1, 0)
	UICorner2.Parent = Fill

	local Knob = Instance.new("Frame")

	Knob.Name = "Knob"
	Knob.AnchorPoint = Vector2.new(0.5, 0.5)
	Knob.Size = UDim2.fromOffset(14, 14)
	Knob.Position = UDim2.fromScale(0, 0.5)
	Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Knob.BorderSizePixel = 0
	Knob.Parent = TextButton

	local UICorner3 = Instance.new("UICorner")

	UICorner3.CornerRadius = UDim.new(1, 0)
	UICorner3.Parent = Knob

	local TextBox = Instance.new("TextBox")

	TextBox.Name = ("%*Input"):format(p2)
	TextBox.Size = UDim2.fromOffset(58, 28)
	TextBox.Position = UDim2.fromOffset(822, p4 + 34)
	TextBox.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
	TextBox.BorderSizePixel = 0
	TextBox.Text = "0"
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextSize = 15
	TextBox.Font = Enum.Font.Gotham
	TextBox.ClearTextOnFocus = false
	TextBox.Parent = p1

	local UICorner4 = Instance.new("UICorner")

	UICorner4.CornerRadius = UDim.new(0, 6)
	UICorner4.Parent = TextBox

	return {
		Label = TextLabel,
		TrackButton = TextButton,
		Fill = Fill,
		Knob = Knob,
		Input = TextBox,
		ValueLabel = TextLabel2,
		MinValue = p5,
		MaxValue = p6,
		Step = p7,
		CurrentValue = p5,
		FormatDisplay = p8,
		FormatInput = p9
	}
end

local function createLabelInput(p1, p2, p3, p4) --[[ createLabelInput | Line: 249 ]]
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = ("%*Label"):format(p2)
	TextLabel.Size = UDim2.fromOffset(190, 18)
	TextLabel.Position = UDim2.fromOffset(690, p4)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = p3
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 14
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = p1

	local TextBox = Instance.new("TextBox")

	TextBox.Name = ("%*Input"):format(p2)
	TextBox.Size = UDim2.fromOffset(190, 32)
	TextBox.Position = UDim2.fromOffset(690, p4 + 20)
	TextBox.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
	TextBox.BorderSizePixel = 0
	TextBox.Text = ""
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.PlaceholderColor3 = Color3.fromRGB(156, 168, 188)
	TextBox.TextSize = 15
	TextBox.Font = Enum.Font.Gotham
	TextBox.ClearTextOnFocus = false
	TextBox.Parent = p1

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = TextBox

	return TextLabel, TextBox
end

local function buildRarityChancePercentById() --[[ buildRarityChancePercentById | Line: 287 ]]
	return {}
end

local function buildAssetRows() --[[ buildAssetRows | Line: 300 | Upvalues: Directory (copy), Personalities (copy), AssetGenerationUtil (copy) ]]
	local list = {}
	local t = {}

	for k, v in pairs(Directory) do
		-- Skip categories that must never be selectable/grantable.
		local displayName = v.DisplayName or k
		if EXCLUDED_ASSET_CATEGORIES[k] or EXCLUDED_ASSET_CATEGORIES[displayName] then
			continue
		end

		local v1 = v.DropWeight or 0
		local Rarity = v.Rarity

		if Rarity then
			local v2 = Rarity.DisplayName or (Rarity._id or "Unknown")
			local v3 = Rarity._id or v2
			local v5 = AssetGenerationUtil.GetRateWithoutRebirth((Personalities.CreateNewItemData({
				Scale = 1,
				Personality = "Normal",
				HasBeenFirstPlaced = false,
				Category = k,
				Mutations = {}
			})))

			t[v3] = (t[v3] or 0) + v1
			table.insert(list, {
				InRarityDropChancePercent = 0,
				Id = k,
				DisplayName = v.DisplayName or k,
				Icon = v.Icon or "",
				RarityId = v3,
				RarityName = v2,
				RarityNumber = Rarity.RarityNumber or 0,
				RarityGradient = Rarity.Gradient,
				MoneyPerSecond = v5,
				DropWeight = v1
			})
		end
	end

	for i, v in ipairs(list) do
		local v6 = t[v.RarityId] or 0

		if v6 > 0 then
			v.InRarityDropChancePercent = v.DropWeight / v6 * 100
		end
	end

	table.sort(list, function(p1, p2) --[[ Line: 341 ]]
		if p1.RarityNumber == p2.RarityNumber then
			if p1.MoneyPerSecond == p2.MoneyPerSecond then
				return p1.DisplayName < p2.DisplayName
			end

			return p1.MoneyPerSecond > p2.MoneyPerSecond
		end

		return p1.RarityNumber > p2.RarityNumber
	end)

	return list, {}
end

local function buildMutationNames() --[[ buildMutationNames | Line: 354 | Upvalues: Mutations (copy) ]]
	local t = {}

	for k, v in pairs((Mutations.GetMutations())) do
		if v.DropWeight > 0 then
			table.insert(t, k)
		end
	end

	table.sort(t)

	return t
end

local function createAdminPanel() --[[ createAdminPanel | Line: 366 | Upvalues: PlayerGui (copy), v1 (copy), createLabelInput (copy), createSliderControl (copy), formatWalkSpeedDisplay (copy), TreadmillUtil (copy), formatSpeedPowerDisplay (copy) ]]
	local AdminPanel = Instance.new("ScreenGui")

	AdminPanel.Name = "AdminPanel"
	AdminPanel.ResetOnSpawn = false
	AdminPanel.IgnoreGuiInset = true
	AdminPanel.Parent = PlayerGui

	local Toggle = Instance.new("TextButton")

	Toggle.Name = "Toggle"
	Toggle.Size = UDim2.fromOffset(150, 40)
	Toggle.AnchorPoint = Vector2.new(0, 0.5)
	Toggle.Position = UDim2.new(0, 12, 0.75, 0)
	Toggle.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
	Toggle.BorderSizePixel = 0
	Toggle.Text = "Admin"
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.TextSize = 20
	Toggle.Font = Enum.Font.GothamBold
	Toggle.Parent = AdminPanel

	local Panel = Instance.new("Frame")

	Panel.Name = "Panel"
	Panel.AnchorPoint = Vector2.new(0.5, 0.5)
	Panel.Size = v1
	Panel.Position = UDim2.fromScale(0.5, 0.5)
	Panel.BackgroundColor3 = Color3.fromRGB(18, 24, 35)
	Panel.BorderSizePixel = 0
	Panel.Visible = false
	Panel.Parent = AdminPanel

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Panel
	Instance.new("UIDragDetector").Parent = Panel

	local Title = Instance.new("TextLabel")

	Title.Name = "Title"
	Title.Size = UDim2.new(1, -60, 0, 42)
	Title.Position = UDim2.fromOffset(18, 8)
	Title.BackgroundTransparency = 1
	Title.Text = "Admin Asset Grant"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 25
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Panel

	local CloseButton = Instance.new("TextButton")

	CloseButton.Name = "CloseButton"
	CloseButton.Size = UDim2.fromOffset(34, 34)
	CloseButton.Position = UDim2.new(1, -42, 0, 8)
	CloseButton.BackgroundColor3 = Color3.fromRGB(117, 38, 46)
	CloseButton.BorderSizePixel = 0
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 22
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.Parent = Panel

	local UICorner2 = Instance.new("UICorner")

	UICorner2.CornerRadius = UDim.new(0, 6)
	UICorner2.Parent = CloseButton

	local AssetTabButton = Instance.new("TextButton")

	AssetTabButton.Name = "AssetTabButton"
	AssetTabButton.Size = UDim2.fromOffset(94, 32)
	AssetTabButton.Position = UDim2.fromOffset(456, 18)
	AssetTabButton.BackgroundColor3 = Color3.fromRGB(36, 114, 84)
	AssetTabButton.BorderSizePixel = 0
	AssetTabButton.Text = "Assets"
	AssetTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	AssetTabButton.TextSize = 14
	AssetTabButton.Font = Enum.Font.GothamBold
	AssetTabButton.Parent = Panel

	local UICorner3 = Instance.new("UICorner")

	UICorner3.CornerRadius = UDim.new(0, 7)
	UICorner3.Parent = AssetTabButton

	local EggTabButton = Instance.new("TextButton")

	EggTabButton.Name = "EggTabButton"
	EggTabButton.Size = UDim2.fromOffset(94, 32)
	EggTabButton.Position = UDim2.fromOffset(558, 18)
	EggTabButton.BackgroundColor3 = Color3.fromRGB(37, 47, 66)
	EggTabButton.BorderSizePixel = 0
	EggTabButton.Text = "Eggs"
	EggTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	EggTabButton.TextSize = 14
	EggTabButton.Font = Enum.Font.GothamBold
	EggTabButton.Parent = Panel

	local UICorner4 = Instance.new("UICorner")

	UICorner4.CornerRadius = UDim.new(0, 7)
	UICorner4.Parent = EggTabButton

	local AssetList = Instance.new("ScrollingFrame")

	AssetList.Name = "AssetList"
	AssetList.Size = UDim2.fromOffset(430, 520)
	AssetList.Position = UDim2.fromOffset(16, 60)
	AssetList.BackgroundColor3 = Color3.fromRGB(25, 33, 47)
	AssetList.BorderSizePixel = 0
	AssetList.ScrollBarThickness = 7
	AssetList.CanvasSize = UDim2.fromOffset(0, 0)
	AssetList.Parent = Panel

	local UICorner5 = Instance.new("UICorner")

	UICorner5.CornerRadius = UDim.new(0, 8)
	UICorner5.Parent = AssetList

	local MutationList = Instance.new("ScrollingFrame")

	MutationList.Name = "MutationList"
	MutationList.Size = UDim2.fromOffset(220, 300)
	MutationList.Position = UDim2.fromOffset(456, 60)
	MutationList.BackgroundColor3 = Color3.fromRGB(25, 33, 47)
	MutationList.BorderSizePixel = 0
	MutationList.ScrollBarThickness = 7
	MutationList.CanvasSize = UDim2.fromOffset(0, 0)
	MutationList.Parent = Panel

	local UICorner6 = Instance.new("UICorner")

	UICorner6.CornerRadius = UDim.new(0, 8)
	UICorner6.Parent = MutationList

	local SelectedLabel = Instance.new("TextLabel")

	SelectedLabel.Name = "SelectedLabel"
	SelectedLabel.Size = UDim2.fromOffset(220, 50)
	SelectedLabel.Position = UDim2.fromOffset(456, 368)
	SelectedLabel.BackgroundTransparency = 1
	SelectedLabel.Text = "Selected: None"
	SelectedLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
	SelectedLabel.TextSize = 16
	SelectedLabel.Font = Enum.Font.Gotham
	SelectedLabel.TextWrapped = true
	SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
	SelectedLabel.TextYAlignment = Enum.TextYAlignment.Top
	SelectedLabel.Parent = Panel

	local MutationSelectionLabel = Instance.new("TextLabel")

	MutationSelectionLabel.Name = "MutationSelectionLabel"
	MutationSelectionLabel.Size = UDim2.fromOffset(220, 50)
	MutationSelectionLabel.Position = UDim2.fromOffset(456, 420)
	MutationSelectionLabel.BackgroundTransparency = 1
	MutationSelectionLabel.Text = "Mutations: None"
	MutationSelectionLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
	MutationSelectionLabel.TextSize = 16
	MutationSelectionLabel.Font = Enum.Font.Gotham
	MutationSelectionLabel.TextWrapped = true
	MutationSelectionLabel.TextXAlignment = Enum.TextXAlignment.Left
	MutationSelectionLabel.TextYAlignment = Enum.TextYAlignment.Top
	MutationSelectionLabel.Parent = Panel

	local ScaleLabel = Instance.new("TextLabel")

	ScaleLabel.Name = "ScaleLabel"
	ScaleLabel.Size = UDim2.fromOffset(190, 20)
	ScaleLabel.Position = UDim2.fromOffset(690, 142)
	ScaleLabel.BackgroundTransparency = 1
	ScaleLabel.Text = "Size Scale"
	ScaleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ScaleLabel.TextSize = 15
	ScaleLabel.Font = Enum.Font.GothamBold
	ScaleLabel.TextXAlignment = Enum.TextXAlignment.Left
	ScaleLabel.Parent = Panel

	local ScaleInput = Instance.new("TextBox")

	ScaleInput.Name = "ScaleInput"
	ScaleInput.Size = UDim2.fromOffset(190, 34)
	ScaleInput.Position = UDim2.fromOffset(690, 166)
	ScaleInput.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
	ScaleInput.BorderSizePixel = 0
	ScaleInput.Text = "1"
	ScaleInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	ScaleInput.PlaceholderColor3 = Color3.fromRGB(156, 168, 188)
	ScaleInput.TextSize = 17
	ScaleInput.Font = Enum.Font.Gotham
	ScaleInput.ClearTextOnFocus = false
	ScaleInput.Parent = Panel

	local UICorner7 = Instance.new("UICorner")

	UICorner7.CornerRadius = UDim.new(0, 6)
	UICorner7.Parent = ScaleInput

	local v12, v2 = createLabelInput(Panel, "ColorIndex", "Color Index Override", 218)

	v2.PlaceholderText = "blank = roll"

	local v3, v4 = createLabelInput(Panel, "ColorSeed", "Color Seed Override", 274)

	v4.PlaceholderText = "blank = roll"

	local v5, v6 = createLabelInput(Panel, "EyeColor", "Eye Hex Override", 330)

	v6.PlaceholderText = "blank = roll"

	local v7, v8 = createLabelInput(Panel, "Personality", "Personality Override", 386)

	v8.PlaceholderText = "blank = roll"

	local v9 = createSliderControl(Panel, "WalkSpeed", "Walk Speed", 220, 0, 1000, 0.1, formatWalkSpeedDisplay, formatWalkSpeedDisplay)
	local v10 = createSliderControl(Panel, "SpeedPower", "Speed Value", 288, 0, 1e18, 1, TreadmillUtil.FormatSpeedPower, formatSpeedPowerDisplay)
	local GiveButton = Instance.new("TextButton")

	GiveButton.Name = "GiveButton"
	GiveButton.Size = UDim2.fromOffset(190, 46)
	GiveButton.Position = UDim2.fromOffset(690, 446)
	GiveButton.BackgroundColor3 = Color3.fromRGB(36, 114, 84)
	GiveButton.BorderSizePixel = 0
	GiveButton.Text = "Give Selected Asset"
	GiveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	GiveButton.TextSize = 17
	GiveButton.Font = Enum.Font.GothamBold
	GiveButton.Parent = Panel

	local UICorner8 = Instance.new("UICorner")

	UICorner8.CornerRadius = UDim.new(0, 8)
	UICorner8.Parent = GiveButton

	local StatusLabel = Instance.new("TextLabel")

	StatusLabel.Name = "StatusLabel"
	StatusLabel.Size = UDim2.fromOffset(190, 42)
	StatusLabel.Position = UDim2.fromOffset(690, 498)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Text = "Ready."
	StatusLabel.TextWrapped = true
	StatusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
	StatusLabel.TextSize = 15
	StatusLabel.Font = Enum.Font.Gotham
	StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	StatusLabel.TextYAlignment = Enum.TextYAlignment.Top
	StatusLabel.Parent = Panel

	local ResetDataButton = Instance.new("TextButton")

	ResetDataButton.Name = "ResetDataButton"
	ResetDataButton.Size = UDim2.fromOffset(190, 44)
	ResetDataButton.Position = UDim2.fromOffset(690, 546)
	ResetDataButton.BackgroundColor3 = Color3.fromRGB(134, 46, 46)
	ResetDataButton.BorderSizePixel = 0
	ResetDataButton.Text = "Reset Data"
	ResetDataButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	ResetDataButton.TextSize = 17
	ResetDataButton.Font = Enum.Font.GothamBold
	ResetDataButton.Parent = Panel

	local UICorner9 = Instance.new("UICorner")

	UICorner9.CornerRadius = UDim.new(0, 8)
	UICorner9.Parent = ResetDataButton

	return {
		screenGui = AdminPanel,
		panel = Panel,
		title = Title,
		toggleButton = Toggle,
		closeButton = CloseButton,
		assetTabButton = AssetTabButton,
		eggTabButton = EggTabButton,
		assetList = AssetList,
		mutationList = MutationList,
		selectedLabel = SelectedLabel,
		mutationSelectionLabel = MutationSelectionLabel,
		scaleLabel = ScaleLabel,
		scaleInput = ScaleInput,
		colorIndexLabel = v12,
		colorIndexInput = v2,
		colorSeedLabel = v3,
		colorSeedInput = v4,
		eyeColorLabel = v5,
		eyeColorInput = v6,
		personalityLabel = v7,
		personalityInput = v8,
		walkSpeedControl = v9,
		speedPowerControl = v10,
		giveButton = GiveButton,
		resetButton = ResetDataButton,
		statusLabel = StatusLabel
	}
end

local function setupAdminPanel() --[[ setupAdminPanel | Line: 651 | Upvalues: createAdminPanel (copy), v4 (ref), Save (copy), TreadmillUtil (copy), updateSliderVisual (copy), ParseNumberSmart (copy), v3 (ref), t (copy), buildAssetRows (copy), clearGradients (copy), Simple (copy), buildMutationNames (copy), Network (copy), AdminPanel (copy), UserInputService (copy) ]]
	local v1 = createAdminPanel()
	local t2 = {}
	local t3 = {}
	local v2 = false
	local v32 = nil
	local v42 = nil

	local function setStatus(p1, p2) --[[ setStatus | Line: 660 | Upvalues: v1 (copy) ]]
		v1.statusLabel.Text = p1

		if p2 == nil then
			v1.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)

			return
		end

		if p2 then
			v1.statusLabel.TextColor3 = Color3.fromRGB(145, 232, 181)
		else
			v1.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
		end
	end

	local function setSliderControlVisible(p1, p2) --[[ setSliderControlVisible | Line: 671 ]]
		p1.Label.Visible = p2
		p1.ValueLabel.Visible = p2
		p1.TrackButton.Visible = p2
		p1.Input.Visible = p2
	end

	local function setEggOverrideControlsVisible(p1) --[[ setEggOverrideControlsVisible | Line: 678 | Upvalues: v1 (copy) ]]
		v1.colorIndexLabel.Visible = p1
		v1.colorIndexInput.Visible = p1
		v1.colorSeedLabel.Visible = p1
		v1.colorSeedInput.Visible = p1
		v1.eyeColorLabel.Visible = p1
		v1.eyeColorInput.Visible = p1
		v1.personalityLabel.Visible = not p1
		v1.personalityInput.Visible = not p1
	end

	local function applyGrantTabState(p1) --[[ applyGrantTabState | Line: 689 | Upvalues: v4 (ref), v1 (copy) ]]
		v4 = p1

		local v12 = p1 == "Eggs"

		v1.title.Text = if v12 then "Admin Egg Grant" else "Admin Asset Grant"
		v1.assetTabButton.BackgroundColor3 = if v12 then Color3.fromRGB(37, 47, 66) else Color3.fromRGB(36, 114, 84)
		v1.eggTabButton.BackgroundColor3 = if v12 then Color3.fromRGB(36, 114, 84) else Color3.fromRGB(37, 47, 66)
		v1.scaleLabel.Text = if v12 then "Egg Scale Override" else "Size Scale"
		v1.scaleInput.PlaceholderText = if v12 then "blank = roll" else "1 = roll"
		v1.giveButton.Text = if v12 then "Give Selected Egg" else "Give Selected Asset"

		local walkSpeedControl = v1.walkSpeedControl
		local v8 = not v12

		walkSpeedControl.Label.Visible = v8
		walkSpeedControl.ValueLabel.Visible = v8
		walkSpeedControl.TrackButton.Visible = v8
		walkSpeedControl.Input.Visible = v8

		local speedPowerControl = v1.speedPowerControl
		local v9 = not v12

		speedPowerControl.Label.Visible = v9
		speedPowerControl.ValueLabel.Visible = v9
		speedPowerControl.TrackButton.Visible = v9
		speedPowerControl.Input.Visible = v9
		v1.colorIndexLabel.Visible = v12
		v1.colorIndexInput.Visible = v12
		v1.colorSeedLabel.Visible = v12
		v1.colorSeedInput.Visible = v12
		v1.eyeColorLabel.Visible = v12
		v1.eyeColorInput.Visible = v12
		v1.personalityLabel.Visible = not v12
		v1.personalityInput.Visible = not v12

		if v12 and v1.scaleInput.Text == "1" then
			v1.scaleInput.Text = ""

			return
		end

		if v12 then
			return
		end

		if (string.match(v1.scaleInput.Text, "^%s*(.-)%s*$") or "") ~= "" then
			return
		end

		v1.scaleInput.Text = "1"
	end

	local function syncSpeedControlsFromSave(p1) --[[ syncSpeedControlsFromSave | Line: 711 | Upvalues: Save (ref), TreadmillUtil (ref), updateSliderVisual (ref), v1 (copy) ]]
		local v12 = Save.Get()

		if not v12 then
			return
		end

		local v2 = TreadmillUtil.NormalizeSpeedPower(v12.SpeedPower)

		updateSliderVisual(v1.speedPowerControl, v2)

		if not p1 then
			return
		end

		updateSliderVisual(v1.walkSpeedControl, (TreadmillUtil.SpeedPowerToWalkSpeed(v2)))
	end

	local function setSliderValueFromTrack(p1, p2) --[[ setSliderValueFromTrack | Line: 725 | Upvalues: updateSliderVisual (ref) ]]
		updateSliderVisual(p1, p1.MinValue + (p1.MaxValue - p1.MinValue) * math.clamp((p2 - p1.TrackButton.AbsolutePosition.X) / math.max(p1.TrackButton.AbsoluteSize.X, 1), 0, 1))
	end

	local function attachSliderBehavior(p1, p2) --[[ attachSliderBehavior | Line: 732 | Upvalues: v32 (ref), v42 (ref), updateSliderVisual (ref), ParseNumberSmart (ref), v1 (copy) ]]
		p1.TrackButton.MouseButton1Down:Connect(function(p12) --[[ Line: 733 | Upvalues: v32 (ref), p1 (copy), v42 (ref), p2 (copy), updateSliderVisual (ref) ]]
			v32 = p1
			v42 = p2

			local v1 = p1

			updateSliderVisual(v1, v1.MinValue + (v1.MaxValue - v1.MinValue) * math.clamp((p12 - v1.TrackButton.AbsolutePosition.X) / math.max(v1.TrackButton.AbsoluteSize.X, 1), 0, 1))
		end)
		p1.Input.FocusLost:Connect(function(p12) --[[ Line: 739 | Upvalues: p1 (copy), ParseNumberSmart (ref), updateSliderVisual (ref), v1 (ref), p2 (copy) ]]
			if not p12 and p1.Input.Text == p1.FormatInput(p1.CurrentValue) then
				return
			end

			local Text = p1.Input.Text
			local v12 = ParseNumberSmart(Text)
			local v2 = if typeof(v12) == "number" then v12 else tonumber(Text)

			if v2 == nil then
				updateSliderVisual(p1, p1.CurrentValue)
				v1.statusLabel.Text = "Enter a valid number."
				v1.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
			else
				updateSliderVisual(p1, v2)
				p2(p1.CurrentValue)
			end
		end)
	end

	local function updateSelectedAssetState() --[[ updateSelectedAssetState | Line: 756 | Upvalues: t2 (copy), v3 (ref), v1 (copy), v4 (ref) ]]
		for k, v in pairs(t2) do
			v.BackgroundColor3 = if v3 == k then Color3.fromRGB(36, 114, 84) else Color3.fromRGB(37, 47, 66)
		end

		if not v3 then
			v1.selectedLabel.Text = "Selected: None"

			return
		end

		v1.selectedLabel.Text = if v4 == "Eggs" then ("Selected egg: %*"):format(v3) else ("Selected asset: %*"):format(v3)
	end

	local function updateMutationState() --[[ updateMutationState | Line: 772 | Upvalues: t (ref), t3 (copy), v1 (copy) ]]
		local t2 = {}

		for k, v in pairs(t) do
			if v then
				table.insert(t2, k)
			end
		end

		table.sort(t2)

		for k, v in pairs(t3) do
			v.BackgroundColor3 = if t[k] then Color3.fromRGB(126, 73, 153) else Color3.fromRGB(37, 47, 66)
		end

		if #t2 == 0 then
			v1.mutationSelectionLabel.Text = "Mutations: None"
		else
			v1.mutationSelectionLabel.Text = ("Mutations: %*"):format((table.concat(t2, ", ")))
		end
	end

	local v5, v6 = buildAssetRows()
	local v7 = nil
	local sum = 8
	local v8 = nil

	for i, v in ipairs(v5) do
		if v7 ~= v.RarityName then
			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = ("Rarity_%*"):format(v.RarityName)
			TextLabel.Size = UDim2.new(1, -14, 0, 22)
			TextLabel.Position = UDim2.fromOffset(7, sum)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = ("%* (%*)"):format(v.RarityName, (string.format("%.2f%%", v6[v.RarityId] or 0)))
			TextLabel.TextColor3 = Color3.fromRGB(193, 203, 219)
			TextLabel.TextSize = 14
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Parent = v1.assetList
			v7 = v.RarityName
			sum = sum + 24
		end

		local TextButton = Instance.new("TextButton")

		TextButton.Name = v.Id
		TextButton.Size = UDim2.new(1, -14, 0, 44)
		TextButton.Position = UDim2.fromOffset(7, sum)
		TextButton.BackgroundColor3 = Color3.fromRGB(37, 47, 66)
		TextButton.BorderSizePixel = 0
		TextButton.Text = ""
		TextButton.Parent = v1.assetList

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0, 7)
		UICorner.Parent = TextButton

		local Icon = Instance.new("ImageLabel")

		Icon.Name = "Icon"
		Icon.Size = UDim2.fromOffset(34, 34)
		Icon.ScaleType = Enum.ScaleType.Fit
		Icon.Position = UDim2.fromOffset(5, 5)
		Icon.BackgroundTransparency = 1
		Icon.Image = v.Icon
		Icon.Parent = TextButton

		local Name = Instance.new("TextLabel")

		Name.Name = "Name"
		Name.Size = UDim2.new(1, -220, 1, 0)
		Name.Position = UDim2.fromOffset(44, 0)
		Name.BackgroundTransparency = 1
		Name.Text = v.DisplayName
		Name.TextColor3 = Color3.fromRGB(255, 255, 255)
		Name.TextSize = 14
		Name.Font = Enum.Font.GothamBold
		Name.TextXAlignment = Enum.TextXAlignment.Left
		Name.Parent = TextButton
		clearGradients(Name)

		if v.RarityGradient then
			v.RarityGradient:Clone().Parent = Name
		end

		local MoneyPerSecond = Instance.new("TextLabel")

		MoneyPerSecond.Name = "MoneyPerSecond"
		MoneyPerSecond.Size = UDim2.fromOffset(170, 44)
		MoneyPerSecond.AnchorPoint = Vector2.new(1, 0)
		MoneyPerSecond.Position = UDim2.new(1, -6, 0, 0)
		MoneyPerSecond.BackgroundTransparency = 1
		MoneyPerSecond.Text = ("%*/s | %*"):format(Simple.FormatCompact(v.MoneyPerSecond, ".##"), (string.format("%.2f%%", v.InRarityDropChancePercent)))
		MoneyPerSecond.TextColor3 = Color3.fromRGB(145, 232, 181)
		MoneyPerSecond.TextSize = 13
		MoneyPerSecond.Font = Enum.Font.Gotham
		MoneyPerSecond.TextXAlignment = Enum.TextXAlignment.Right
		MoneyPerSecond.Parent = TextButton
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 869 | Upvalues: v3 (ref), v (copy), updateSelectedAssetState (copy) ]]
			v3 = v.Id
			updateSelectedAssetState()
		end)
		t2[v.Id] = TextButton
		sum = sum + 48
	end

	v1.assetList.CanvasSize = UDim2.fromOffset(0, sum + 4)

	local sum2 = 8

	for i, v in ipairs((buildMutationNames())) do
		local TextButton = Instance.new("TextButton")

		TextButton.Name = v
		TextButton.Size = UDim2.new(1, -14, 0, 32)
		TextButton.Position = UDim2.fromOffset(7, sum2)
		TextButton.BackgroundColor3 = Color3.fromRGB(37, 47, 66)
		TextButton.BorderSizePixel = 0
		TextButton.Text = v
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 14
		TextButton.Font = Enum.Font.Gotham
		TextButton.Parent = v1.mutationList

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0, 7)
		UICorner.Parent = TextButton
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 897 | Upvalues: t (ref), v (copy), updateMutationState (copy) ]]
			t[v] = not t[v]
			updateMutationState()
		end)
		t3[v] = TextButton
		sum2 = sum2 + 36
	end

	v1.mutationList.CanvasSize = UDim2.fromOffset(0, sum2 + 4)
	v1.assetTabButton.MouseButton1Click:Connect(function() --[[ Line: 907 | Upvalues: applyGrantTabState (copy), updateSelectedAssetState (copy) ]]
		applyGrantTabState("Assets")
		updateSelectedAssetState()
	end)
	v1.eggTabButton.MouseButton1Click:Connect(function() --[[ Line: 912 | Upvalues: applyGrantTabState (copy), updateSelectedAssetState (copy) ]]
		applyGrantTabState("Eggs")
		updateSelectedAssetState()
	end)
	v1.giveButton.MouseButton1Click:Connect(function() --[[ Line: 917 | Upvalues: v3 (ref), v1 (copy), t (ref), v4 (ref), ParseNumberSmart (ref), Network (ref), AdminPanel (ref) ]]
		if not v3 then
			v1.statusLabel.Text = "Select an asset first."
			v1.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)

			return
		end

		local t2 = {}

		for k, v in pairs(t) do
			if v then
				table.insert(t2, k)
			end
		end

		table.sort(t2)

		if v4 == "Eggs" then
			local v12 = string.match(v1.scaleInput.Text, "^%s*(.-)%s*$") or ""
			local v2, v32

			if v12 == "" then
				v2 = true
				v32 = nil
			else
				local v42 = ParseNumberSmart(v12)
				local v5 = if typeof(v42) == "number" then v42 else tonumber(v12)

				v32 = v5
				v2 = if v5 == nil then false else true
			end

			if not v2 then
				v1.statusLabel.Text = "Enter a valid scale override."
				v1.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)

				return
			end

			local v7 = string.match(v1.colorSeedInput.Text, "^%s*(.-)%s*$") or ""
			local v8, v9

			if v7 == "" then
				v8 = true
				v9 = nil
			else
				local v10 = ParseNumberSmart(v7)
				local v11 = if typeof(v10) == "number" then v10 else tonumber(v7)

				v9 = v11
				v8 = if v11 == nil then false else true
			end

			if not v8 then
				v1.statusLabel.Text = "Enter a valid color seed override."
				v1.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)

				return
			end

			local v13 = string.match(v1.colorIndexInput.Text, "^%s*(.-)%s*$") or ""
			local v14, v15

			if v13 == "" then
				v14 = true
				v15 = nil
			else
				local v16 = ParseNumberSmart(v13)
				local v17 = if typeof(v16) == "number" then v16 else tonumber(v13)

				v15 = v17
				v14 = if v17 == nil then false else true
			end

			if not v14 then
				v1.statusLabel.Text = "Enter a valid color index override."
				v1.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)

				return
			end

			local t3 = {
				assetId = v3
			}

			if v32 ~= nil then
				t3.scale = v32
			end

			if v9 ~= nil then
				t3.colorSeed = v9
			end

			if v15 ~= nil then
				t3.colorIndex = v15
			end

			local v19 = string.match(v1.eyeColorInput.Text, "^%s*(.-)%s*$") or ""

			if v19 ~= "" then
				t3.eyeColor = v19
			end

			if #t2 > 0 then
				t3.mutations = t2
			end

			v1.statusLabel.Text = "Granting egg..."
			v1.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
			Network.Fire(AdminPanel.GIVE_EGG_TO_SELF, t3)
		else
			local v20 = tonumber(v1.scaleInput.Text) or 1
			v20 = math.clamp(v20, 0.01, 10)

			v1.statusLabel.Text = "Granting asset..."
			v1.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)

			local t3 = {
				assetId = v3,
				scale = v20,
				mutations = t2
			}
			local v21 = string.match(v1.personalityInput.Text, "^%s*(.-)%s*$") or ""

			if v21 ~= "" then
				t3.personality = v21
			end

			Network.Fire(AdminPanel.GIVE_ASSET_TO_SELF, t3)
		end
	end)
	attachSliderBehavior(v1.walkSpeedControl, function(p1) --[[ Line: 990 | Upvalues: v8 (ref), v1 (copy), Network (ref), AdminPanel (ref) ]]
		v8 = "WalkSpeed"

		local v3 = string.format("%.1f", math.round(p1 / 0.1) * 0.1)

		v1.statusLabel.Text = ("Setting walk speed to %*..."):format(if string.sub(v3, -2) == ".0" then string.sub(v3, 1, #v3 - 2) else v3)
		v1.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
		Network.Fire(AdminPanel.SET_WALK_SPEED, p1)
	end)
	attachSliderBehavior(v1.speedPowerControl, function(p1) --[[ Line: 996 | Upvalues: v8 (ref), v1 (copy), Network (ref), AdminPanel (ref) ]]
		v8 = "SpeedPower"
		v1.statusLabel.Text = ("Setting speed value to %*..."):format((string.format("%.0f", (math.round(p1)))))
		v1.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
		Network.Fire(AdminPanel.SET_SPEED_POWER, p1)
	end)
	v1.resetButton.MouseButton1Click:Connect(function() --[[ Line: 1002 | Upvalues: v1 (copy), Network (ref), AdminPanel (ref) ]]
		v1.statusLabel.Text = "Resetting your data..."
		v1.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
		Network.Fire(AdminPanel.RESET_SELF_DATA)
	end)
	Network.Fired(AdminPanel.GIVE_RESULT):Connect(function(p1, p2, p3) --[[ Line: 1007 | Upvalues: setStatus (copy) ]]
		setStatus(if p3 and p3 ~= "" then ("%* UID: %*"):format(p2, p3) else p2, p1)
	end)
	Network.Fired(AdminPanel.RESET_RESULT):Connect(function(p1, p2) --[[ Line: 1012 | Upvalues: setStatus (copy) ]]
		setStatus(p2, p1)
	end)
	Network.Fired(AdminPanel.SET_SPEED_RESULT):Connect(function(p1, p2) --[[ Line: 1016 | Upvalues: setStatus (copy), v8 (ref), Save (ref), TreadmillUtil (ref), updateSliderVisual (ref), v1 (copy) ]]
		setStatus(p2, p1)

		if v8 == "SpeedPower" then
			local v12 = Save.Get()

			if not v12 then
				v8 = nil

				return
			end

			local v2 = TreadmillUtil.NormalizeSpeedPower(v12.SpeedPower)

			updateSliderVisual(v1.speedPowerControl, v2)
			updateSliderVisual(v1.walkSpeedControl, (TreadmillUtil.SpeedPowerToWalkSpeed(v2)))
		else
			if v8 ~= "WalkSpeed" then
				v8 = nil

				return
			end

			local v4 = Save.Get()

			if not v4 then
				v8 = nil

				return
			end

			updateSliderVisual(v1.speedPowerControl, (TreadmillUtil.NormalizeSpeedPower(v4.SpeedPower)))
		end

		v8 = nil
	end)

	local function togglePanel() --[[ togglePanel | Line: 1026 | Upvalues: v2 (ref), v1 (copy) ]]
		v2 = not v2
		v1.panel.Visible = v2
	end

	v1.toggleButton.MouseButton1Click:Connect(togglePanel)
	v1.closeButton.MouseButton1Click:Connect(togglePanel)
	UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 1034 | Upvalues: v2 (ref), v1 (copy) ]]
		if p2 then
			return
		end

		if p1.KeyCode ~= Enum.KeyCode.F9 then
			return
		end

		v2 = not v2
		v1.panel.Visible = v2
	end)
	UserInputService.InputChanged:Connect(function(p1, p2) --[[ Line: 1043 | Upvalues: v32 (ref), updateSliderVisual (ref) ]]
		if v32 == nil then
			return
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseMovement and p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local v1 = v32

		updateSliderVisual(v1, v1.MinValue + (v1.MaxValue - v1.MinValue) * math.clamp((p1.Position.X - v1.TrackButton.AbsolutePosition.X) / math.max(v1.TrackButton.AbsoluteSize.X, 1), 0, 1))
	end)
	UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 1058 | Upvalues: v32 (ref), v42 (ref) ]]
		if v32 == nil or v42 == nil then
			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then
			local v1 = v32
			local v2 = v42

			v32 = nil
			v42 = nil
			v2(v1.CurrentValue)
		end
	end)

	local v11 = Save.Get()

	if v11 then
		local v12 = TreadmillUtil.NormalizeSpeedPower(v11.SpeedPower)

		updateSliderVisual(v1.speedPowerControl, v12)
		updateSliderVisual(v1.walkSpeedControl, (TreadmillUtil.SpeedPowerToWalkSpeed(v12)))
	end

	Save.ConnectForDataChanged("SpeedPower", function() --[[ Line: 1078 | Upvalues: Save (ref), TreadmillUtil (ref), updateSliderVisual (ref), v1 (copy) ]]
		local v12 = Save.Get()

		if v12 then
			updateSliderVisual(v1.speedPowerControl, (TreadmillUtil.NormalizeSpeedPower(v12.SpeedPower)))
		end
	end)
	applyGrantTabState("Assets")
	updateSelectedAssetState()
	updateMutationState()
end

Network.Fired(AdminPanel.ADMIN_STATUS_RESPONSE):Connect(function(p1) --[[ Line: 1088 | Upvalues: v2 (copy), v5 (ref), setupAdminPanel (copy) ]]
	if not p1 then
		v2:AtInfo():Log("Admin panel unavailable for this user")

		return
	end

	if not v5 then
		v5 = true
		v2:AtInfo():Log("Admin status confirmed, initializing admin panel")
		setupAdminPanel()
	end
end)

-- ============================================================
-- Gamepass gate: player must own the AdminPanel gamepass before
-- we even start polling the server for admin status. This is a
-- client-side UX gate only — the server MUST independently verify
-- gamepass ownership (and/or admin status) before responding to
-- CHECK_ADMIN_STATUS or processing any grant/reset/speed remotes.
-- ============================================================

local function playerOwnsAdminPanel(): boolean
	local success, owns = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(Player.UserId, ADMIN_PANEL_GAMEPASS_ID)
	end)

	if not success then
		v2:AtInfo():Log("Failed to check AdminPanel gamepass ownership")

		return false
	end

	return owns == true
end

local function beginServerAdminCheck()
	if not Save.Get() then
		Save.LoadedStats:Wait()
	end

	local v6 = os.clock()

	while not v5 and os.clock() - v6 < 13 do
		Network.Fire(AdminPanel.CHECK_ADMIN_STATUS)
		task.wait(2)
	end
end

if playerOwnsAdminPanel() then
	beginServerAdminCheck()
else
	MarketplaceService:PromptGamePassPurchase(Player, ADMIN_PANEL_GAMEPASS_ID)
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(purchasedPlayer, gamepassId, wasPurchased)
	if purchasedPlayer ~= Player then
		return
	end

	if gamepassId ~= ADMIN_PANEL_GAMEPASS_ID then
		return
	end

	if not wasPurchased then
		return
	end

	beginServerAdminCheck()
end)