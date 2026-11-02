--credit to leon games studio
local t = {
	StartOrder = 10
}
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local SharedModules = ReplicatedStorage:WaitForChild("SharedModules")
local SeedData = require(SharedModules:WaitForChild("SeedData"))
local RarityVisuals = require(SharedModules:WaitForChild("RarityVisuals"))
local MutationData = require(SharedModules:WaitForChild("MutationData"))
local WeightFormat = require(SharedModules:WaitForChild("WeightFormat"))
local ScreenResolution = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("ScreenResolution"))
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v1 = nil
local v2 = nil
local v3 = Color3.new(255/255, 255/255, 255/255)
local v4 = Color3.fromRGB(60, 220, 80)
local v5 = Color3.fromRGB(255, 255, 255)
local v6 = Color3.fromRGB(0, 0, 0)
local v7 = Vector2.new(220, 64)
local v8 = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local Gardens = Workspace:WaitForChild("Gardens")
local Fruits = ReplicatedStorage:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits")

local function isSingleHarvestPlant(p1) --[[ isSingleHarvestPlant | Line: 110 | Upvalues: Fruits (copy) ]]
	local v1 = p1:GetAttribute("SeedName")

	if type(v1) ~= "string" then
		return false
	end

	return Fruits:FindFirstChild(v1) == nil
end

local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local t2 = {}
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = 0
local v21 = 0
local v22 = 0
local t3 = {}
local v23 = false
local t4 = {}
local v24 = nil
local v25 = 0
local v26 = nil
local v27 = nil
local v28 = nil
local v29 = nil
local v30 = 0
local v31 = 0
local v32 = 0
local v33 = 0
local v34 = 0
local v35 = 0

local function resetTimerBaseline() --[[ resetTimerBaseline | Line: 189 | Upvalues: v29 (ref) ]]
	v29 = nil
end

local function getPointerLocation() --[[ getPointerLocation | Line: 200 | Upvalues: v17 (ref), GuiService (copy), UserInputService (copy) ]]
	local v1 = v17

	if v1 then
		local v2 = GuiService:GetGuiInset()

		return Vector2.new(v1.Position.X + v2.X, v1.Position.Y + v2.Y)
	end

	if UserInputService.MouseEnabled then
		return UserInputService:GetMouseLocation()
	end

	return nil
end

local function formatGrowTime(p1) --[[ formatGrowTime | Line: 214 ]]
	if p1 <= 0 then
		return ""
	end

	if p1 < 60 then
		if p1 == math.floor(p1) then
			return string.format("%ds", p1)
		end

		return string.format("%.1fs", p1)
	end

	local t = {
		{ "y", 31104000 },
		{ "mo", 2592000 },
		{ "w", 604800 },
		{ "d", 86400 },
		{ "h", 3600 },
		{ "m", 60 },
		{ "s", 1 }
	}

	for i = 1, #t - 1 do
		local v1 = t[i][1]
		local v2 = t[i][2]

		if v2 <= p1 then
			local v3 = math.floor(p1 / v2)

			return string.format("%d%s %d%s", v3, v1, math.floor((p1 - v3 * v2) / t[i + 1][2]), t[i + 1][1])
		end
	end

	return string.format("%dm %ds", math.floor(p1 / 60), (math.floor(p1 % 60)))
end

local t5 = {
	Fruits = true,
	FruitSpawnLocations = true
}

local function IsExcludedFromHeight(p1, p2) --[[ IsExcludedFromHeight | Line: 268 | Upvalues: t5 (copy) ]]
	local v1 = p1.Parent

	while v1 and v1 ~= p2 do
		if t5[v1.Name] then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

local function GetMeters(p1) --[[ GetMeters | Line: 283 | Upvalues: t5 (copy) ]]
	local v1 = p1:GetAttribute("Height")

	if v1 then
		return v1
	end

	local v2 = (-1 / 0)
	local v3 = (1 / 0)

	for v5, v6 in p1:GetDescendants() do
		local v4

		if v6:IsA("BasePart") then
			local v7 = v6.Parent

			while true do
				if not v7 or v7 == p1 then
					v4 = false

					break
				end

				if t5[v7.Name] then
					v4 = true

					break
				end

				v7 = v7.Parent
			end

			if not v4 then
				local Position = (v6.CFrame * CFrame.new(0, v6.Size.Y / 2, 0)).Position

				if v2 < Position.Y then
					v2 = Position.Y
				end

				local Y = (v6.CFrame * CFrame.new(0, -v6.Size.Y / 2, 0)).Position.Y

				if Y < v3 then
					v3 = Y
				end
			end
		end
	end

	if v2 == (-1 / 0) then
		return nil
	end

	local v8 = math.round(v2 - v3)

	p1:SetAttribute("Height", v8)

	return v8
end

local function gatherPlantsFolders() --[[ gatherPlantsFolders | Line: 315 | Upvalues: Gardens (copy) ]]
	local t = {}

	if not Gardens then
		return t
	end

	for v1, v2 in Gardens:GetChildren() do
		if v2:IsA("Model") then
			local Plants = v2:FindFirstChild("Plants")

			if Plants and Plants:IsA("Folder") then
				table.insert(t, Plants)
			end
		end
	end

	return t
end

local function ensurePlotsResolved() --[[ ensurePlotsResolved | Line: 328 | Upvalues: v24 (ref), v25 (ref), gatherPlantsFolders (copy), t4 (ref) ]]
	local v1 = os.clock()

	if v24 and v1 - v25 < 1 then
		return
	end

	v25 = v1

	local v2 = gatherPlantsFolders()

	t4 = v2

	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Include
	v3.FilterDescendantsInstances = v2
	v24 = v3

	if #v2 ~= 0 then
		return
	end

	v25 = 0
end

local function findHovered() --[[ findHovered | Line: 354 | Upvalues: v24 (ref), Workspace (copy), v17 (ref), GuiService (copy), UserInputService (copy) ]]
	local v1 = v24

	if not v1 then
		return nil, nil
	end

	local CurrentCamera = Workspace.CurrentCamera

	if not CurrentCamera then
		return nil, nil
	end

	local v2 = v17
	local v3

	if v2 then
		local v4 = GuiService:GetGuiInset()

		v3 = Vector2.new(v2.Position.X + v4.X, v2.Position.Y + v4.Y)
	else
		v3 = if UserInputService.MouseEnabled then UserInputService:GetMouseLocation() else nil
	end

	if not v3 then
		return nil, nil
	end

	local v7 = CurrentCamera:ViewportPointToRay(v3.X, v3.Y)
	local Origin = v7.Origin
	local sum = 1000
	local v8 = nil

	while sum > 0 do
		local v9 = Workspace:Raycast(Origin, v7.Direction * sum, v1)

		if not v9 then
			return nil, nil
		end

		local v10 = v9.Instance

		if v10 and (v10:IsA("BasePart") and v10.Transparency < 1) then
			v8 = v9

			break
		end

		local v11 = (v9.Position - Origin).Magnitude + 0.01

		Origin = Origin + v7.Direction * v11
		sum = sum - v11
		v8 = nil
	end

	if not v8 then
		return nil, nil
	end

	local v12 = v8.Instance
	local v13 = nil

	while v12 do
		local v14 = v12.Parent

		if v12:IsA("Model") and (v14 and v14:IsA("Folder")) then
			if v14.Name == "Fruits" and not v13 then
				v13 = v12
			elseif v14.Name == "Plants" then
				return v12, v13
			end
		end

		v12 = v14
	end

	return nil, nil
end

local function refreshContent(p1) --[[ refreshContent | Line: 419 | Upvalues: v11 (ref), v28 (ref), t2 (copy), MutationData (copy), v3 (copy), RarityVisuals (copy) ]]
	if not v11 then
		return
	end

	if v28 then
		v28()
		v28 = nil
	end

	local v1 = p1:GetAttribute("SeedName")
	local v2 = if type(v1) == "string" then v1 else nil
	local v32 = if v2 then t2[v2] else nil
	local v4 = if v32 then if type(v32.Rarity) == "string" then v32.Rarity else "Common" else "Common"
	local v5 = p1:GetAttribute("Mutation")

	v11.Text = v2 or "?"

	local UIGradient = v11:FindFirstChildOfClass("UIGradient")

	if UIGradient then
		UIGradient:Destroy()
	end

	local v6

	if type(v5) ~= "string" or v5 == "" then
		v6 = { v11 }
		v28 = RarityVisuals.ApplyToLabels(v6, v4)

		return
	end

	local v7 = MutationData.GetMutation(v5)

	if v7 and v7.Gradient then
		v11.TextColor3 = v3
		v7.Gradient:Clone().Parent = v11
	else
		v6 = { v11 }
		v28 = RarityVisuals.ApplyToLabels(v6, v4)
	end
end

local function detachPlantListeners() --[[ detachPlantListeners | Line: 466 | Upvalues: v26 (ref), v27 (ref) ]]
	if v26 then
		v26:Disconnect()
		v26 = nil
	end

	if not v27 then
		return
	end

	v27:Disconnect()
	v27 = nil
end

local function attachPlantListeners(p1) --[[ attachPlantListeners | Line: 471 | Upvalues: v26 (ref), v27 (ref), v18 (ref), refreshContent (copy), v22 (ref) ]]
	if v26 then
		v26:Disconnect()
		v26 = nil
	end

	if not v27 then
		v26 = p1:GetAttributeChangedSignal("Mutation"):Connect(function() --[[ Line: 477 | Upvalues: v18 (ref), p1 (copy), refreshContent (ref) ]]
			if v18 ~= p1 then
				return
			end

			refreshContent(p1)
		end)
		v27 = p1.AncestryChanged:Connect(function(p13, p23) --[[ Line: 485 | Upvalues: v18 (ref), p1 (copy), v22 (ref) ]]
			if v18 ~= p1 or p23 then
				return
			end

			v22 = 0
		end)

		return
	end

	v27:Disconnect()
	v27 = nil
	v26 = p1:GetAttributeChangedSignal("Mutation"):Connect(function() --[[ Line: 477 | Upvalues: v18 (ref), p1 (copy), refreshContent (ref) ]]
		if v18 ~= p1 then
			return
		end

		refreshContent(p1)
	end)
	v27 = p1.AncestryChanged:Connect(function(p13, p23) --[[ Line: 485 | Upvalues: v18 (ref), p1 (copy), v22 (ref) ]]
		if v18 ~= p1 or p23 then
			return
		end

		v22 = 0
	end)
end

local function applyHoverState(p1) --[[ applyHoverState | Line: 492 | Upvalues: v18 (ref), v22 (ref), refreshContent (copy), attachPlantListeners (copy) ]]
	if p1 then
		if p1 == v18 then
			if v22 ~= 0 then
				return
			end

			v22 = 1
		elseif v18 then
			v18 = p1
			refreshContent(p1)
			attachPlantListeners(p1)
		else
			v18 = p1
			refreshContent(p1)
			attachPlantListeners(p1)
			v22 = 1
		end
	else
		if not v18 then
			return
		end

		v22 = 0
	end
end

local function clearGradient() --[[ clearGradient | Line: 523 | Upvalues: v11 (ref) ]]
	if not v11 then
		return
	end

	local UIGradient = v11:FindFirstChildOfClass("UIGradient")

	if not UIGradient then
		return
	end

	UIGradient:Destroy()
end

local function computeSuppression() --[[ computeSuppression | Line: 530 | Upvalues: t3 (copy), Workspace (copy), ScreenResolution (copy), v17 (ref), GuiService (copy), UserInputService (copy) ]]
	if next(t3) == nil then
		return false
	end

	local CurrentCamera = Workspace.CurrentCamera

	if not CurrentCamera then
		return false
	end

	local v1 = 150 * ScreenResolution.GetResolutionScale()
	local v2 = v1 * v1
	local v3 = v17
	local v4

	if v3 then
		local v5 = GuiService:GetGuiInset()

		v4 = Vector2.new(v3.Position.X + v5.X, v3.Position.Y + v5.Y)
	else
		v4 = if UserInputService.MouseEnabled then UserInputService:GetMouseLocation() else nil
	end

	if not v4 then
		return false
	end

	for v8 in t3 do
		local v9 = v8.Parent

		if v9 and v9:IsA("BasePart") then
			local v10, v11 = CurrentCamera:WorldToViewportPoint(v9.Position)

			if v11 then
				local v12 = v4.X - v10.X
				local v13 = v4.Y - v10.Y

				if v12 * v12 + v13 * v13 <= v2 then
					return true
				end
			end
		end
	end

	return false
end

local function onRenderStep(p1) --[[ onRenderStep | Line: 566 | Upvalues: v20 (ref), ensurePlotsResolved (copy), findHovered (copy), v19 (ref), applyHoverState (copy), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v16 (ref), v23 (ref), computeSuppression (copy), v22 (ref), v21 (ref), v18 (ref), v26 (ref), v27 (ref), v28 (ref), v29 (ref), v1 (ref), v2 (ref), WeightFormat (copy), v34 (ref), v35 (ref), v30 (ref), v31 (ref), v32 (ref), v33 (ref), formatGrowTime (copy), Fruits (copy), GetMeters (copy), Workspace (copy), v17 (ref), GuiService (copy), UserInputService (copy), v7 (copy) ]]
	v20 = v20 + p1

	if v20 >= 0.1 then
		v20 = 0
		ensurePlotsResolved()

		local v110, v24 = findHovered()

		if v110 then
			v19 = v24
		end

		applyHoverState(v110)
	end

	if not (v10 and (v11 and (v12 and (v13 and (v14 and (v15 and v16)))))) then
		return
	end

	v23 = computeSuppression()

	local v3 = if v23 then 0 else v22
	local v4 = p1 / 0.1

	if v21 < v3 then
		v21 = math.min(v3, v21 + v4)
	elseif v3 < v21 then
		v21 = math.max(v3, v21 - v4)
	end

	local v72 = 1 - v21

	v11.TextTransparency = v72
	v12.Transparency = v72
	v13.TextTransparency = v72
	v14.Transparency = v72
	v15.TextTransparency = v72
	v16.Transparency = v72
	v10.Visible = v21 > 0

	if v21 == 0 and (v22 == 0 and v18) then
		v18 = nil
		v19 = nil

		if v26 then
			v26:Disconnect()
			v26 = nil
		end

		if v27 then
			v27:Disconnect()
			v27 = nil
		end

		if v28 then
			v28()
			v28 = nil
		end

		if v11 then
			local UIGradient = v11:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Destroy()
			end
		end

		v29 = nil
		v13.Text = ""
		v15.Text = ""
	else
		if not (v18 and v21 > 0) then
			return
		end

		local v102 = v18:GetAttribute("UserId")
		local v112 = v18:GetAttribute("PlantId")
		local v122 = if v1 and (type(v102) == "number" and type(v112) == "string") then v1:GetPlantGrowthData(v102, v112) else nil

		if v19 then
			v13.Text = ""
			v13.Visible = false

			local v132 = v2:CalculateFruitWeight(v19)

			v15.Text = if v132 then ("\226\154\150\239\184\143 %*"):format((WeightFormat.FormatGrams(v132))) else "\226\154\150\239\184\143 ?"
			v15.Visible = true
			v29 = nil
		elseif v122 and (type(v122.MaxAge) == "number" and (type(v122.CurrentAge) == "number" and (type(v122.StableGrowthAmount) == "number" and (v122.StableGrowthAmount > 0 and v122.CurrentAge < v122.MaxAge)))) then
			if v29 ~= v18 or (v122.CurrentAge ~= v34 or v122.StableGrowthAmount ~= v35) then
				v29 = v18
				v30 = v122.CurrentAge
				v31 = v122.MaxAge
				v32 = v122.StableGrowthAmount
				v33 = os.clock()
				v34 = v122.CurrentAge
				v35 = v122.StableGrowthAmount
			end

			v13.Text = formatGrowTime((v31 - math.min(v30 + (os.clock() - v33) * v32, v31)) / v32)
			v13.Visible = true
			v15.Visible = false
		else
			local v172, v182, v192, v202, v212, v222, v232

			v13.Text = ""
			v13.Visible = false
			v172 = nil
			v182 = v18:GetAttribute("SeedName")
			v192 = if type(v182) == "string" then Fruits:FindFirstChild(v182) == nil else false

			if v192 then
				v202 = v2:CalculatePlantWeight(v18)

				if type(v202) == "number" then
					v212 = ("\226\154\150\239\184\143 %*"):format((WeightFormat.FormatGrams(v202)))
					v172 = v212
				end
			end

			if not v172 then
				v222 = GetMeters(v18)

				if v222 then
					v232 = ("\240\159\147\143 %*ft"):format((math.round(v222)))
					v172 = v232
				else
					v172 = "\240\159\147\143 10ft"
				end
			end

			v15.Text = v172
			v15.Visible = true
			v29 = nil
		end

		local CurrentCamera = Workspace.CurrentCamera
		local v262 = v17
		local v272

		if v262 then
			local v282 = GuiService:GetGuiInset()

			v272 = Vector2.new(v262.Position.X + v282.X, v262.Position.Y + v282.Y)
		else
			v272 = if UserInputService.MouseEnabled then UserInputService:GetMouseLocation() else nil
		end

		if not (CurrentCamera and v272) then
			return
		end

		local v312 = math.min(v11.TextBounds.X, v7.X)
		local X3 = (if v13.Visible then v13 else v15).TextBounds.X
		local v342 = math.max(v312, (math.min(X3, v7.X)))
		local v352 = v342 / 2
		local v36 = if v17 then 42 else 28

		if v272.X + v36 + v342 <= CurrentCamera.ViewportSize.X then
			v10.AnchorPoint = Vector2.new(0.5, 0.5)
			v10.Position = UDim2.fromOffset(v272.X + v36 + v352, v272.Y)

			return
		end

		v10.AnchorPoint = Vector2.new(0.5, 0.5)
		v10.Position = UDim2.fromOffset(v272.X - v36 - v352, v272.Y)
	end
end

local function buildGui() --[[ buildGui | Line: 782 | Upvalues: PlayerGui (copy), v9 (ref), v7 (copy), v10 (ref), v8 (copy), v11 (ref), v6 (copy), v12 (ref), v4 (copy), v13 (ref), v14 (ref), v5 (copy), v15 (ref), v16 (ref) ]]
	local PlantHoverTooltip = Instance.new("ScreenGui")

	PlantHoverTooltip.Name = "PlantHoverTooltip"
	PlantHoverTooltip.DisplayOrder = -1
	PlantHoverTooltip.IgnoreGuiInset = true
	PlantHoverTooltip.ResetOnSpawn = false
	PlantHoverTooltip.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	PlantHoverTooltip.Enabled = true
	PlantHoverTooltip.Parent = PlayerGui
	v9 = PlantHoverTooltip

	local Frame = Instance.new("Frame")

	Frame.Name = "Frame"
	Frame.AnchorPoint = Vector2.new(0, 0.5)
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.fromOffset(v7.X, v7.Y)
	Frame.Position = UDim2.fromOffset(0, 0)
	Frame.Visible = false
	Frame.Parent = PlantHoverTooltip
	v10 = Frame

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 2)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame

	local Name = Instance.new("TextLabel")

	Name.Name = "Name"
	Name.BackgroundTransparency = 1
	Name.BorderSizePixel = 0
	Name.FontFace = v8
	Name.LayoutOrder = 1
	Name.Size = UDim2.new(1, 0, 0.55, 0)
	Name.Text = ""
	Name.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Name.TextScaled = true
	Name.TextSize = 24
	Name.TextTransparency = 1
	Name.TextWrapped = true
	Name.TextXAlignment = Enum.TextXAlignment.Center
	Name.TextYAlignment = Enum.TextYAlignment.Center
	Name.Parent = Frame
	v11 = Name

	local UIStroke = Instance.new("UIStroke")

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Color = v6
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 2
	UIStroke.Transparency = 1
	UIStroke.Parent = Name
	v12 = UIStroke

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new(v6)
	UIGradient.Parent = UIStroke

	local Timer = Instance.new("TextLabel")

	Timer.Name = "Timer"
	Timer.BackgroundTransparency = 1
	Timer.BorderSizePixel = 0
	Timer.FontFace = v8
	Timer.LayoutOrder = 2
	Timer.Size = UDim2.new(1, 0, 0.4, 0)
	Timer.Text = ""
	Timer.TextColor3 = v4
	Timer.TextScaled = true
	Timer.TextSize = 20
	Timer.TextTransparency = 1
	Timer.TextWrapped = true
	Timer.TextXAlignment = Enum.TextXAlignment.Center
	Timer.TextYAlignment = Enum.TextYAlignment.Center
	Timer.Parent = Frame
	v13 = Timer

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke2.Color = v6
	UIStroke2.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke2.Thickness = 2
	UIStroke2.Transparency = 1
	UIStroke2.Parent = Timer
	v14 = UIStroke2

	local Meters = Instance.new("TextLabel")

	Meters.Name = "Meters"
	Meters.BackgroundTransparency = 1
	Meters.BorderSizePixel = 0
	Meters.FontFace = v8
	Meters.LayoutOrder = 2
	Meters.Size = UDim2.new(1, 0, 0.4, 0)
	Meters.Text = ""
	Meters.TextColor3 = v5
	Meters.TextScaled = true
	Meters.TextSize = 20
	Meters.TextTransparency = 1
	Meters.TextWrapped = true
	Meters.TextXAlignment = Enum.TextXAlignment.Center
	Meters.TextYAlignment = Enum.TextYAlignment.Center
	Meters.Visible = false
	Meters.Parent = Frame
	v15 = Meters

	local UIStroke3 = Instance.new("UIStroke")

	UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke3.Color = v6
	UIStroke3.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke3.Thickness = 2
	UIStroke3.Transparency = 1
	UIStroke3.Parent = Meters
	v16 = UIStroke3
end

function t.Init(p1) --[[ Init | Line: 925 | Upvalues: SeedData (copy), t2 (copy) ]]
	for v1, v2 in SeedData do
		if type(v2) == "table" and type(v2.SeedName) == "string" then
			t2[v2.SeedName] = v2
		end
	end
end
function t.Start(p1) --[[ Start | Line: 936 | Upvalues: v1 (ref), v2 (ref), buildGui (copy), ProximityPromptService (copy), t3 (copy), UserInputService (copy), v17 (ref), RunService (copy), onRenderStep (copy) ]]
	v1 = require(script.Parent.PlantVisualizerController)
	v2 = require(script.Parent.FruitVisualizerController)
	buildGui()
	ProximityPromptService.PromptShown:Connect(function(p1) --[[ Line: 949 | Upvalues: t3 (ref) ]]
		if not p1:HasTag("HarvestPrompt") then
			return
		end

		t3[p1] = true
	end)
	ProximityPromptService.PromptHidden:Connect(function(p1) --[[ Line: 954 | Upvalues: t3 (ref) ]]
		if not p1:HasTag("HarvestPrompt") then
			return
		end

		t3[p1] = nil
	end)
	UserInputService.TouchStarted:Connect(function(p1, p2) --[[ Line: 964 | Upvalues: v17 (ref) ]]
		if p2 then
			return
		end

		if v17 ~= nil then
			return
		end

		v17 = p1
	end)
	UserInputService.TouchEnded:Connect(function(p1) --[[ Line: 970 | Upvalues: v17 (ref) ]]
		if p1 ~= v17 then
			return
		end

		v17 = nil
	end)
	RunService:BindToRenderStep("PlantHoverTooltip", Enum.RenderPriority.Camera.Value - 1, onRenderStep)
end

return t