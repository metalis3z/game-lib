local ReferenceResolution = Vector2.new(1920, 1080)

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 100)
local CurrentCamera = workspace.CurrentCamera

local function GetMinVectorValue(Vector)
	return math.min(Vector.X, Vector.Y)
end

local function GetViewportScale()
	local ViewportSize = CurrentCamera.ViewportSize
	return GetMinVectorValue(ViewportSize) / GetMinVectorValue(ReferenceResolution)
end

local function GetWorldPosition(Instance)
	if Instance:IsA("Part") then
		return Instance.Position
	elseif Instance:IsA("Model") then
		return Instance:GetPivot().Position
	else
		return Vector3.new(0, 0, 0)
	end
end

local function TagUIStrokeRecursive(Root, ClassName, TagName)
	if Root:IsA(ClassName) then
		Root:AddTag(TagName)
	end

	local Children = Root:GetChildren()
	for Index, Child in ipairs(Children) do
		TagUIStrokeRecursive(Child, ClassName, TagName)
	end

	Root.ChildAdded:Connect(function(NewChild)
		TagUIStrokeRecursive(NewChild, ClassName, TagName)
	end)
end

local function UpdateScreenStroke(Stroke)
	if not Stroke:IsA("UIStroke") then
		Stroke:RemoveTag("ScreenStroke")
		Stroke:RemoveTag("UIStroke")
		return
	end

	local OriginalThickness = Stroke:GetAttribute("OriginalThickness")
	if not OriginalThickness then
		OriginalThickness = Stroke.Thickness
		Stroke:SetAttribute("OriginalThickness", OriginalThickness)
	end

	if Stroke:HasTag("ScreenStroke") then
		Stroke.Thickness = OriginalThickness * GetViewportScale()
	end
end

local InitialUIStrokes = CollectionService:GetTagged("UIStroke")
for Index, Stroke in ipairs(InitialUIStrokes) do
	UpdateScreenStroke(Stroke)
end

CollectionService:GetInstanceAddedSignal("UIStroke"):Connect(UpdateScreenStroke)

local ScreenStrokes = CollectionService:GetTagged("ScreenStroke")
for Index, Stroke in ipairs(ScreenStrokes) do
	Stroke:AddTag("UIStroke")
end

CollectionService:GetInstanceAddedSignal("ScreenStroke"):Connect(function(Instance)
	Instance:AddTag("UIStroke")
end)

local ScreenGuis = CollectionService:GetTagged("ScreenGui")
for Index, ScreenGui in ipairs(ScreenGuis) do
	if ScreenGui:IsA("ScreenGui") then
		TagUIStrokeRecursive(ScreenGui, "UIStroke", "ScreenStroke")
	else
		ScreenGui:RemoveTag("ScreenGui")
	end
end

CollectionService:GetInstanceAddedSignal("ScreenGui"):Connect(function(Instance)
	if Instance:IsA("ScreenGui") then
		TagUIStrokeRecursive(Instance, "UIStroke", "ScreenStroke")
	end
end)

CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	local ActiveScreenStrokes = CollectionService:GetTagged("ScreenStroke")
	for Index, Stroke in ipairs(ActiveScreenStrokes) do
		local OriginalThickness = Stroke:GetAttribute("OriginalThickness")
		if OriginalThickness then
			Stroke.Thickness = OriginalThickness * GetViewportScale()
		end
	end
end)

local BillboardStrokeMap = {}

local function CollectBillboardStrokesRecursive(Root, Billboard)
	if Root:IsA("UIStroke") then
		Root:AddTag("UIStroke")
		table.insert(BillboardStrokeMap[Billboard], Root)
	end

	local Children = Root:GetChildren()
	for Index, Child in ipairs(Children) do
		CollectBillboardStrokesRecursive(Child, Billboard)
	end

	Root.ChildAdded:Connect(function(NewChild)
		CollectBillboardStrokesRecursive(NewChild, Billboard)
	end)
end

local function RegisterBillboard(Billboard)
	if not Billboard:IsA("BillboardGui") then
		Billboard:RemoveTag("Billboard")
		return
	end

	BillboardStrokeMap[Billboard] = {}

	Billboard.Destroying:Once(function()
		BillboardStrokeMap[Billboard] = nil
	end)

	CollectBillboardStrokesRecursive(Billboard, Billboard)
end

local ExistingBillboards = CollectionService:GetTagged("Billboard")
for Index, Billboard in ipairs(ExistingBillboards) do
	RegisterBillboard(Billboard)
end

CollectionService:GetInstanceAddedSignal("Billboard"):Connect(RegisterBillboard)

local LastUpdateTime = tick()

RunService.Heartbeat:Connect(function()
	if tick() - LastUpdateTime < 1 then
		return
	end

	LastUpdateTime = tick()
	debug.profilebegin("Update UIStrokes")

	for Billboard, StrokeList in pairs(BillboardStrokeMap) do
		local Target = Billboard.Adornee or Billboard.Parent
		if Target then
			local Position = GetWorldPosition(Target)
			local Distance = (CurrentCamera.CFrame.Position - Position).Magnitude

			if Billboard.MaxDistance >= Distance then
				local DistanceScale = (Billboard:GetAttribute("Distance") or 10) / Distance

				for Index, Stroke in ipairs(StrokeList) do
					if Stroke:IsDescendantOf(Billboard) then
						local OriginalThickness = Stroke:GetAttribute("OriginalThickness")
						if OriginalThickness then
							Stroke.Thickness =
								OriginalThickness * DistanceScale * GetViewportScale()
						end
					end
				end
			end
		end
	end

	debug.profileend()
end)

return {
	TagScreenGui = function(Self, Gui)
		if Gui:IsA("ScreenGui") then
			CollectionService:AddTag(Gui, "ScreenGui")
		end
	end,

	TagBillboardGui = function(Self, Gui)
		if Gui:IsA("BillboardGui") then
			CollectionService:AddTag(Gui, "Billboard")
		end
	end
}