local v1 = Vector2.new(1310, 910)

game:GetService("RunService")

local CollectionService = game:GetService("CollectionService")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 100)
local CurrentCamera = workspace.CurrentCamera

local function getBox(p1) --[[ getBox | Line: 50 ]]
	return math.min(p1.X, p1.Y)
end

local function getScreenRatio() --[[ getScreenRatio | Line: 55 | Upvalues: CurrentCamera (copy), v1 (copy) ]]
	local ViewportSize = CurrentCamera.ViewportSize
	local v12 = math.min(ViewportSize.X, ViewportSize.Y)
	local v2 = v1

	return v12 / math.min(v2.X, v2.Y)
end

local function v2(p1, p2, p3) --[[ tagRecursive | Line: 61 | Upvalues: CollectionService (copy), v2 (copy) ]]
	if p1:IsA(p2) then
		CollectionService:AddTag(p1, p3)
	end

	for v1, v22 in p1:GetChildren() do
		v2(v22, p2, p3)
	end

	p1.ChildAdded:Connect(function(p1) --[[ Line: 68 | Upvalues: v2 (ref), p2 (copy), p3 (copy) ]]
		v2(p1, p2, p3)
	end)
end

local function getInstancePosition(p1) --[[ getInstancePosition | Line: 74 ]]
	if p1:IsA("Part") then
		return p1.Position
	end

	if p1:IsA("Model") then
		local v1, _ = p1:GetBoundingBox()

		return v1.Position
	end

	return Vector3.new(0, 0, 0)
end

local t = {}

setmetatable(t, {
	__mode = "k"
})
CollectionService:GetInstanceAddedSignal("ScreenGui"):Connect(function(p1) --[[ Line: 90 | Upvalues: v2 (copy) ]]
	if p1.Name == "AdminPanel" then return end -- UI importada: no escalar sus UIStroke (se veían enormes)
	v2(p1, "UIStroke", "ScreenStroke")
end)
CollectionService:GetInstanceAddedSignal("ScreenStroke"):Connect(function(p1) --[[ Line: 95 | Upvalues: t (copy), CurrentCamera (copy), v1 (copy) ]]
	t[p1] = p1.Thickness

	local ViewportSize = CurrentCamera.ViewportSize
	local v2 = math.min(ViewportSize.X, ViewportSize.Y)
	local v3 = v1

	p1.Thickness = math.max(1, (math.ceil(t[p1] * (v2 / math.min(v3.X, v3.Y)) * 0.9 + 0.1 * t[p1])))
end)

local function updateScreenGuiStrokes() --[[ updateScreenGuiStrokes | Line: 101 | Upvalues: t (copy), CurrentCamera (copy), v1 (copy) ]]
	for v12, v2 in t do
		if v12.Parent then
			local ViewportSize = CurrentCamera.ViewportSize
			local v3 = math.min(ViewportSize.X, ViewportSize.Y)
			local v4 = v1

			v12.Thickness = v2 * (v3 / math.min(v4.X, v4.Y)) * 0.9 + 0.1 * v2

			continue
		end

		t[v12] = nil
	end
end

local GuiService = game:GetService("GuiService")

CollectionService:GetInstanceAddedSignal("UITextSizeConstraint"):Connect(function(p1) --[[ Line: 119 | Upvalues: GuiService (copy) ]]
	if not GuiService:IsTenFootInterface() then
		return
	end

	p1.MaxTextSize = p1.MaxTextSize * 2
end)
CollectionService:GetInstanceAddedSignal("UICorner"):Connect(function(p1) --[[ Line: 125 ]]
	if not game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled then
		return
	end

	p1.CornerRadius = UDim.new(p1.CornerRadius.Scale, (math.min(p1.CornerRadius.Offset, 3)))
end)
task.delay(0.5, function() --[[ Line: 133 | Upvalues: v2 (copy), PlayerGui (copy) ]]
	v2(PlayerGui, "ScreenGui", "ScreenGui")
	v2(PlayerGui, "UITextSizeConstraint", "UITextSizeConstraint")
end)

return {
	SetUp = function(p1) --[[ SetUp | Line: 143 ]] end
}