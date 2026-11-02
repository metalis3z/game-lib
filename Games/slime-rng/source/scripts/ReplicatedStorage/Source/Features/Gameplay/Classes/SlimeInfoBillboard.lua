-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlimeInfoBillboard, time of decompilation: Sun May  3 10:11:21 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local OddsGradients = require(ReplicatedStorage.Source.Game.Items.OddsGradients)
local color3 = Color3.fromRGB(0, 0, 0)
local color3_2 = Color3.fromRGB(43, 43, 43)
local uDim2 = UDim2.fromScale(5.2, 2)
local t1 = {}

t1.__index = t1

function t1.new(p1, s1: string, n1: number, n2: number?) -- line: 72
	-- upvalues: uDim2 (copy), color3_2 (copy), color3 (copy), t1 (copy)
	local BillboardGui = Instance.new("BillboardGui")

	BillboardGui.Name = "SlimeInfoBillboard"
	BillboardGui.Active = false
	BillboardGui.AlwaysOnTop = false
	BillboardGui.LightInfluence = 0
	BillboardGui.MaxDistance = 70
	BillboardGui.Size = uDim2
	BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 4 * (n2 or 1), 0)
	BillboardGui.ClipsDescendants = false
	BillboardGui.Enabled = false
	BillboardGui.Adornee = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart", true)
	BillboardGui.Parent = p1

	local Frame = Instance.new("Frame")

	Frame.Name = "Content"
	Frame.BackgroundTransparency = 1
	Frame.Size = UDim2.fromScale(1, 1)
	Frame.Parent = BillboardGui

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 0)
	UIListLayout.Parent = Frame

	local Frame2 = Instance.new("Frame")

	Frame2.Name = "Odds"
	Frame2.BackgroundTransparency = 1
	Frame2.Size = UDim2.fromScale(0.92, 0.42)
	Frame2.LayoutOrder = 1
	Frame2.Parent = Frame

	local uDim2_2 = UDim2.fromScale(1, 1)
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "TextLabel"
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = uDim2_2
	TextLabel.LayoutOrder = 2
	TextLabel.Font = Enum.Font.BuilderSansExtraBold
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextWrapped = true
	TextLabel.ZIndex = 2
	TextLabel.Parent = Frame2

	local v30 = color3_2
	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v30
	UIStroke.Thickness = 3
	UIStroke.Parent = TextLabel

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Rotation = 90
	UIGradient.Parent = TextLabel

	local uDim2_3 = UDim2.fromScale(0.92, 0.35)
	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Name = "Name"
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Size = uDim2_3
	TextLabel2.LayoutOrder = 2
	TextLabel2.Font = Enum.Font.BuilderSansExtraBold
	TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel2.TextScaled = true
	TextLabel2.TextWrapped = true
	TextLabel2.ZIndex = 2
	TextLabel2.Parent = Frame

	local v35 = color3
	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = v35
	UIStroke2.Thickness = 3
	UIStroke2.Parent = TextLabel2

	local v37 = setmetatable({
		visible = false,
		odds = 0,
		gui = BillboardGui,
		oddsLabel = TextLabel,
		nameLabel = TextLabel2
	}, t1)

	v37:setInfo(s1, n1)

	return v37
end
function t1.setInfo(p2, s2: string, n3: number) -- line: 131
	-- upvalues: Abbreviate (copy), OddsGradients (copy)
	p2.odds = n3
	p2.nameLabel.Text = s2

	local v41 = math.max(n3, 0)
	local v42 = if not (v41 <= 0) then `1 / { Abbreviate((math.ceil(1 / v41))) }` else "1 / 0"

	p2.oddsLabel.Text = v42

	local UIGradient = p2.oddsLabel:FindFirstChildOfClass("UIGradient")

	if UIGradient then
		UIGradient.Color = OddsGradients.getGradient((math.max(n3, 0)))
	end
end
function t1.setVisible(p3, b1: boolean) -- line: 145
	p3.visible = b1
	p3.gui.Enabled = b1
end
function t1.destroy(p4) -- line: 150
	p4.gui:Destroy()
end

return t1
