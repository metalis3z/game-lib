--credit to leon games studio
local UserInputService = game:GetService("UserInputService")
local v1 = script.Parent
local Frame = v1:FindFirstChild("Frame")
local SelectionPoint = Frame:FindFirstChild("SelectionPoint")
local SelectionBox = Frame:FindFirstChild("SelectionBox")
local DarknessSlider = v1:FindFirstChild("DarknessSlider")
local VisualSlider = DarknessSlider:FindFirstChild("VisualSlider")
local ClickDetection = DarknessSlider:FindFirstChild("ClickDetection")
local CurrentColor = v1:FindFirstChild("CurrentColor")
local CurrentColorValue = v1:FindFirstChild("CurrentColorValue")
local v2 = 0
local v3 = 1
local v4 = 0
local v5 = false
local v6 = false

local function Clamp01(p1) --[[ Clamp01 | Line: 29 ]]
	return math.clamp(p1, 0, 1)
end

local function RelativeXY(p1, p2) --[[ RelativeXY | Line: 33 ]]
	local AbsolutePosition = p1.AbsolutePosition
	local AbsoluteSize = p1.AbsoluteSize
	local v1 = if AbsoluteSize.X > 0 then (p2.X - AbsolutePosition.X) / AbsoluteSize.X else 0
	local v2 = if AbsoluteSize.Y > 0 then (p2.Y - AbsolutePosition.Y) / AbsoluteSize.Y else 0

	return math.clamp(v1, 0, 1), math.clamp(v2, 0, 1)
end

local function ComputeBaseColor() --[[ ComputeBaseColor | Line: 42 | Upvalues: v2 (ref), v3 (ref) ]]
	return Color3.fromHSV(v2, v3, 1)
end

local function ComputeFinalColor() --[[ ComputeFinalColor | Line: 47 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
	return Color3.fromHSV(v2, v3, 1 - v4)
end

local function UpdateUI() --[[ UpdateUI | Line: 51 | Upvalues: v2 (ref), v3 (ref), v4 (ref), SelectionPoint (copy), DarknessSlider (copy), VisualSlider (copy), CurrentColor (copy), CurrentColorValue (copy) ]]
	local v1 = Color3.fromHSV(v2, v3, 1)
	local v22 = Color3.fromHSV(v2, v3, 1 - v4)

	SelectionPoint.AnchorPoint = Vector2.new(0.5, 0.5)
	SelectionPoint.Position = UDim2.fromScale(1 - v2, 1 - v3)
	SelectionPoint.BackgroundColor3 = v1
	DarknessSlider.BackgroundColor3 = v1
	VisualSlider.Position = UDim2.fromScale(0.95, v4)
	CurrentColor.BackgroundColor3 = v22
	CurrentColorValue.Value = v22
end

local function SetHueSat(p1, p2) --[[ SetHueSat | Line: 69 | Upvalues: v2 (ref), v3 (ref), UpdateUI (copy) ]]
	v2 = 1 - math.clamp(p1, 0, 1)
	v3 = 1 - math.clamp(p2, 0, 1)
	UpdateUI()
end

local function SetDarkness(p1) --[[ SetDarkness | Line: 76 | Upvalues: v4 (ref), UpdateUI (copy) ]]
	v4 = math.clamp(p1, 0, 1)
	UpdateUI()
end

local function IsPressInput(p1) --[[ IsPressInput | Line: 81 ]]
	return if p1.UserInputType == Enum.UserInputType.MouseButton1 then true else p1.UserInputType == Enum.UserInputType.Touch
end

local function IsMoveInput(p1) --[[ IsMoveInput | Line: 86 ]]
	return if p1.UserInputType == Enum.UserInputType.MouseMovement then true else p1.UserInputType == Enum.UserInputType.Touch
end

SelectionBox.AutoButtonColor = false
SelectionBox.Text = ""
SelectionBox.BackgroundTransparency = 1
SelectionBox.Active = true
ClickDetection.AutoButtonColor = false
ClickDetection.Text = ""
ClickDetection.BackgroundTransparency = 1
ClickDetection.Active = true
SelectionBox.InputBegan:Connect(function(p1) --[[ Line: 103 | Upvalues: v5 (ref), RelativeXY (copy), Frame (copy), v2 (ref), v3 (ref), UpdateUI (copy) ]]
	if if p1.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p1.UserInputType == Enum.UserInputType.Touch then true else false then
		v5 = true

		local v22, v32 = RelativeXY(Frame, Vector2.new(p1.Position.X, p1.Position.Y))

		v2 = 1 - math.clamp(v22, 0, 1)
		v3 = 1 - math.clamp(v32, 0, 1)
		UpdateUI()
	end
end)
ClickDetection.InputBegan:Connect(function(p1) --[[ Line: 110 | Upvalues: v6 (ref), RelativeXY (copy), DarknessSlider (copy), v4 (ref), UpdateUI (copy) ]]
	if if p1.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p1.UserInputType == Enum.UserInputType.Touch then true else false then
		v6 = true

		local _, v2 = RelativeXY(DarknessSlider, Vector2.new(p1.Position.X, p1.Position.Y))

		v4 = math.clamp(v2, 0, 1)
		UpdateUI()
	end
end)
UserInputService.InputChanged:Connect(function(p1) --[[ Line: 117 | Upvalues: v5 (ref), RelativeXY (copy), Frame (copy), v2 (ref), v3 (ref), UpdateUI (copy), v6 (ref), DarknessSlider (copy), v4 (ref) ]]
	if not (if p1.UserInputType == Enum.UserInputType.MouseMovement then true elseif p1.UserInputType == Enum.UserInputType.Touch then true else false) then
		return
	end

	local v22 = Vector2.new(p1.Position.X, p1.Position.Y)

	if v5 then
		local v32, v42 = RelativeXY(Frame, v22)

		v2 = 1 - math.clamp(v32, 0, 1)
		v3 = 1 - math.clamp(v42, 0, 1)
		UpdateUI()
	end

	if not v6 then
		return
	end

	local _, v52 = RelativeXY(DarknessSlider, v22)

	v4 = math.clamp(v52, 0, 1)
	UpdateUI()
end)
UserInputService.InputEnded:Connect(function(p1) --[[ Line: 130 | Upvalues: v5 (ref), v6 (ref) ]]
	if if p1.UserInputType == Enum.UserInputType.MouseButton1 then true else p1.UserInputType == Enum.UserInputType.Touch then
		v5 = false
		v6 = false
	end
end)
UpdateUI()