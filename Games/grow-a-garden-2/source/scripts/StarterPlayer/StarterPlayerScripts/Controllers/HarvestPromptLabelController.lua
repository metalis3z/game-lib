--credit to quartz games studio
local t = {
	StartOrder = 11
}
local ProximityPromptService = game:GetService("ProximityPromptService")
local SharedModules = game:GetService("ReplicatedStorage"):WaitForChild("SharedModules")
local SeedData = require(SharedModules:WaitForChild("SeedData"))
local RarityVisuals = require(SharedModules:WaitForChild("RarityVisuals"))
local MutationData = require(SharedModules:WaitForChild("MutationData"))
local WeightFormat = require(SharedModules:WaitForChild("WeightFormat"))
local v1 = nil
local v2 = UDim2.fromOffset(220, 64)
local v3 = Vector2.new(0, -1)
local v4 = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local v5 = Color3.fromRGB(0, 0, 0)
local v6 = Color3.new(255/255, 255/255, 255/255)
local v7 = Color3.new(255/255, 255/255, 255/255)
local t2 = {}
local t3 = {}
local t4 = {}

local function color3ToHex(p1) --[[ color3ToHex | Line: 94 ]]
	return string.format("#%02X%02X%02X", math.floor(p1.R * 255 + 0.5), math.floor(p1.G * 255 + 0.5), (math.floor(p1.B * 255 + 0.5)))
end

local function getMutationColor(p1) --[[ getMutationColor | Line: 103 | Upvalues: t3 (copy), MutationData (copy) ]]
	local v1 = t3[p1]

	if v1 then
		return v1
	end

	local v2 = Color3.new(255/255, 255/255, 255/255)
	local v3 = MutationData.GetMutation(p1)

	if v3 and v3.Gradient then
		local Keypoints = v3.Gradient.Color.Keypoints

		if Keypoints[1] then
			v2 = Keypoints[1].Value
		end
	end

	t3[p1] = v2

	return v2
end

local function splitMutations(p1) --[[ splitMutations | Line: 124 ]]
	if type(p1) ~= "string" or p1 == "" then
		return {}
	end

	local t = {}

	for v1 in string.gmatch(p1, "[^%+%,]+") do
		local v2 = string.gsub(v1, "^%s*(.-)%s*$", "%1")

		if v2 ~= "" then
			table.insert(t, v2)
		end
	end

	return t
end

local function buildMutationsRichText(p1) --[[ buildMutationsRichText | Line: 137 | Upvalues: color3ToHex (copy), v6 (copy), t3 (copy), MutationData (copy) ]]
	local v1 = string.format("<font color=\"%s\"> + </font>", color3ToHex(v6))
	local t = {}

	for v3, v4 in p1 do
		local v2
		local v5 = t3[v4]

		if v5 then
			v2 = v5
		else
			local v62 = Color3.new(255/255, 255/255, 255/255)
			local v7 = MutationData.GetMutation(v4)

			if v7 and v7.Gradient then
				local Keypoints = v7.Gradient.Color.Keypoints

				if Keypoints[1] then
					v62 = Keypoints[1].Value
				end
			end

			t3[v4] = v62
			v2 = v62
		end

		table.insert(t, string.format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v2.R * 255 + 0.5), math.floor(v2.G * 255 + 0.5), (math.floor(v2.B * 255 + 0.5))), v4))
	end

	return table.concat(t, v1)
end

local function findFruitModel(p1) --[[ findFruitModel | Line: 151 ]]
	local v1 = p1.Parent

	if not (v1 and v1:IsA("BasePart")) then
		return nil, nil
	end

	local v2 = v1.Parent

	while v2 do
		if v2:IsA("Model") then
			return v2, v1
		end

		v2 = v2.Parent
	end

	return nil, nil
end

local function clearGradient(p1) --[[ clearGradient | Line: 166 ]]
	local UIGradient = p1:FindFirstChildOfClass("UIGradient")

	if not UIGradient then
		return
	end

	UIGradient:Destroy()
end

local function refreshContent(p1) --[[ refreshContent | Line: 171 | Upvalues: t2 (copy), splitMutations (copy), v1 (ref), v7 (copy), WeightFormat (copy), MutationData (copy), RarityVisuals (copy), buildMutationsRichText (copy) ]]
	local fruit = p1.fruit
	local v12 = fruit:GetAttribute("CorePartName")
	local v2 = fruit:GetAttribute("SeedName")
	local v3 = if type(v12) == "string" and v12 ~= "" then v12 elseif type(v2) == "string" and v2 ~= "" then v2 else "?"
	local v4 = t2[v3]
	local v5 = if v4 then if type(v4.Rarity) == "string" then v4.Rarity else "Common" else "Common"
	local UIGradient = p1.nameLabel:FindFirstChildOfClass("UIGradient")

	if UIGradient then
		UIGradient:Destroy()
	end

	local v6 = splitMutations(fruit:GetAttribute("Mutation"))
	local v72 = ""
	local v8

	if v1 then
		local v9 = v1:CalculateFruitWeight(fruit)

		v8 = if v9 or not v1.CalculatePlantWeight then v9 else v1:CalculatePlantWeight(fruit)
	else
		v8 = nil
	end

	if v8 then
		local format = string.format
		local v11 = v7

		v72 = format(" <font color=\"%s\">\226\154\150\239\184\143 %s</font>", string.format("#%02X%02X%02X", math.floor(v11.R * 255 + 0.5), math.floor(v11.G * 255 + 0.5), (math.floor(v11.B * 255 + 0.5))), WeightFormat.FormatGrams(v8))
	end

	if #v6 == 1 then
		local v18 = MutationData.GetMutation(v6[1])

		if v18 and v18.Gradient then
			p1.nameLabel.TextColor3 = v7
			p1.nameLabel.Text = v3 .. v72
			v18.Gradient:Clone().Parent = p1.nameLabel
		else
			p1.nameLabel.TextColor3 = v7

			local format = string.format
			local v19 = RarityVisuals.GetStaticColor(v5)

			p1.nameLabel.Text = format("<font color=\"%s\">%s</font>%s", string.format("#%02X%02X%02X", math.floor(v19.R * 255 + 0.5), math.floor(v19.G * 255 + 0.5), (math.floor(v19.B * 255 + 0.5))), v3, v72)
		end
	else
		p1.nameLabel.TextColor3 = v7

		local format = string.format
		local v25 = RarityVisuals.GetStaticColor(v5)

		p1.nameLabel.Text = format("<font color=\"%s\">%s</font>%s", string.format("#%02X%02X%02X", math.floor(v25.R * 255 + 0.5), math.floor(v25.G * 255 + 0.5), (math.floor(v25.B * 255 + 0.5))), v3, v72)
	end

	if #v6 == 0 then
		p1.mutationsLabel.Text = ""
		p1.mutationsLabel.Visible = false
	else
		p1.mutationsLabel.Text = buildMutationsRichText(v6)
		p1.mutationsLabel.Visible = true
	end
end

local function buildBillboard(p1) --[[ buildBillboard | Line: 267 | Upvalues: v3 (copy), v2 (copy), v4 (copy), v5 (copy) ]]
	local HarvestPromptLabel = Instance.new("BillboardGui")

	HarvestPromptLabel.Name = "HarvestPromptLabel"
	HarvestPromptLabel.AlwaysOnTop = true
	HarvestPromptLabel.LightInfluence = 0
	HarvestPromptLabel.ClipsDescendants = false
	HarvestPromptLabel.MaxDistance = 80
	HarvestPromptLabel.SizeOffset = v3
	HarvestPromptLabel.Adornee = p1
	HarvestPromptLabel.Size = v2
	HarvestPromptLabel.Parent = p1

	local Frame = Instance.new("Frame")

	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.fromScale(0.5, 0.5)
	Frame.Size = UDim2.fromScale(1, 1)
	Frame.Parent = HarvestPromptLabel

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 2)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame

	local Name = Instance.new("TextLabel")

	Name.RichText = true
	Name.Name = "Name"
	Name.BackgroundTransparency = 1
	Name.BorderSizePixel = 0
	Name.FontFace = v4
	Name.LayoutOrder = 1
	Name.Size = UDim2.new(1, 0, 0.55, 0)
	Name.Text = ""
	Name.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Name.TextScaled = true
	Name.TextSize = 24
	Name.TextWrapped = true
	Name.TextXAlignment = Enum.TextXAlignment.Center
	Name.TextYAlignment = Enum.TextYAlignment.Center
	Name.Parent = Frame

	local UIStroke = Instance.new("UIStroke")

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Color = v5
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 2
	UIStroke.Parent = Name

	local Mutations = Instance.new("TextLabel")

	Mutations.Name = "Mutations"
	Mutations.BackgroundTransparency = 1
	Mutations.BorderSizePixel = 0
	Mutations.FontFace = v4
	Mutations.LayoutOrder = 2
	Mutations.Size = UDim2.new(1, 0, 0.4, 0)
	Mutations.RichText = true
	Mutations.Text = ""
	Mutations.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Mutations.TextScaled = true
	Mutations.TextSize = 20
	Mutations.TextWrapped = true
	Mutations.TextXAlignment = Enum.TextXAlignment.Center
	Mutations.TextYAlignment = Enum.TextYAlignment.Center
	Mutations.Visible = false
	Mutations.Parent = Frame

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke2.Color = v5
	UIStroke2.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke2.Thickness = 2
	UIStroke2.Parent = Mutations

	return HarvestPromptLabel, Name, Mutations
end

local function teardownEntry(p1) --[[ teardownEntry | Line: 349 | Upvalues: t4 (copy) ]]
	local v1 = t4[p1]

	if not v1 then
		return
	end

	t4[p1] = nil

	if v1.mutationConn then
		v1.mutationConn:Disconnect()
	end

	if v1.promptAncestryConn then
		v1.promptAncestryConn:Disconnect()
	end

	if v1.fruitAncestryConn then
		v1.fruitAncestryConn:Disconnect()
	end

	if not v1.billboard then
		return
	end

	v1.billboard:Destroy()
end

local function handlePromptShown(p1) --[[ handlePromptShown | Line: 360 | Upvalues: t4 (copy), findFruitModel (copy), buildBillboard (copy), refreshContent (copy), teardownEntry (copy) ]]
	if t4[p1] then
		return
	end

	local v1, v2 = findFruitModel(p1)

	if v1 and v2 then
		local v3, v4, v5 = buildBillboard(v2)
		local t = {
			billboard = v3,
			nameLabel = v4,
			mutationsLabel = v5,
			adornee = v2,
			fruit = v1
		}

		t4[p1] = t
		refreshContent(t)
		t.mutationConn = v1:GetAttributeChangedSignal("Mutation"):Connect(function() --[[ Line: 381 | Upvalues: t4 (ref), p1 (copy), t (copy), refreshContent (ref) ]]
			if t4[p1] == t then
				refreshContent(t)
			end
		end)
		t.promptAncestryConn = p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 389 | Upvalues: teardownEntry (ref), p1 (copy) ]]
			if p2 then
				return
			end

			teardownEntry(p1)
		end)
		t.fruitAncestryConn = v1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 392 | Upvalues: teardownEntry (ref), p1 (copy) ]]
			if p2 then
				return
			end

			teardownEntry(p1)
		end)
	end
end

local function handlePromptHidden(p1) --[[ handlePromptHidden | Line: 397 | Upvalues: teardownEntry (copy) ]]
	teardownEntry(p1)
end

function t.Init(p1) --[[ Init | Line: 403 | Upvalues: SeedData (copy), t2 (copy) ]]
	for v1, v2 in SeedData do
		if type(v2) == "table" and type(v2.SeedName) == "string" then
			t2[v2.SeedName] = v2
		end
	end
end
function t.Start(p1) --[[ Start | Line: 411 | Upvalues: v1 (ref), ProximityPromptService (copy), handlePromptShown (copy), teardownEntry (copy) ]]
	v1 = require(script.Parent.FruitVisualizerController)
	ProximityPromptService.PromptShown:Connect(function(p1) --[[ Line: 416 | Upvalues: handlePromptShown (ref) ]]
		if p1:HasTag("HarvestPrompt") then
			handlePromptShown(p1)
		end
	end)
	ProximityPromptService.PromptHidden:Connect(function(p1) --[[ Line: 421 | Upvalues: teardownEntry (ref) ]]
		if p1:HasTag("HarvestPrompt") then
			teardownEntry(p1)
		end
	end)
end

return t