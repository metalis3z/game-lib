-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LootPickupClient, time of decompilation: Sun May  3 10:12:02 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Food = require(ReplicatedStorage.Source.Game.Items.Food)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local LootServiceUtils = require(ReplicatedStorage.Source.Features.Loot.LootServiceUtils)
local t1 = {}

t1.__index = t1

local function addTrail(p1) -- line: 71
	local Attachment = Instance.new("Attachment")

	Attachment.Name = "LootTrailAttachment0"
	Attachment.Position = Vector3.new(0, p1.Size.Y * 0.45, 0)
	Attachment.Parent = p1

	local Attachment2 = Instance.new("Attachment")

	Attachment2.Name = "LootTrailAttachment1"
	Attachment2.Position = Vector3.new(0, -p1.Size.Y * 0.45, 0)
	Attachment2.Parent = p1

	local Trail = Instance.new("Trail")

	Trail.Name = "LootTrail"
	Trail.Attachment0 = Attachment
	Trail.Attachment1 = Attachment2
	Trail.Color = ColorSequence.new(Color3.new(1, 1, 1))
	Trail.WidthScale = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(1, 0)
	})
	Trail.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(1, 1)
	})
	Trail.Lifetime = 0.2
	Trail.LightEmission = 1
	Trail.FaceCamera = true
	Trail.Parent = p1
end
local function addBillboard(p2, p3) -- line: 101
	local BillboardGui = Instance.new("BillboardGui")

	BillboardGui.Name = "LootBillboard"
	BillboardGui.Adornee = p2
	BillboardGui.AlwaysOnTop = true
	BillboardGui.LightInfluence = 0
	BillboardGui.Size = UDim2.fromScale(5, 1.5)
	BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
	BillboardGui.Parent = p2

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "TextLabel"
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.BuilderSansExtraBold
	TextLabel.Position = UDim2.fromScale(0.5, 0.5)
	TextLabel.Size = UDim2.fromScale(1, 1)
	TextLabel.Text = p3.name
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.TextStrokeTransparency = 0
	TextLabel.Parent = BillboardGui
end
local function configureModel(p4, p5) -- line: 126
	-- upvalues: addTrail (copy)
	for _, v33 in p4:GetDescendants() do
		if v33:IsA("BasePart") then
			v33.Anchored = true
			v33.CanCollide = false
			v33.CanQuery = false
			v33.CanTouch = v33 == p5
		end
	end

	p5.CanQuery = true
	p5.CanTouch = true

	local Highlight = Instance.new("Highlight")

	Highlight.Name = "LootHighlight"
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.FillTransparency = 1
	Highlight.OutlineColor = Color3.new(1, 1, 1)
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = p4
	Highlight.Parent = p4
	addTrail(p5)
end
local function getCurveOffset(vector3: Vector3, vector3_2: Vector3) -- line: 142
	local vector3_3 = Vector3.new(vector3_2.X - vector3.X, 0, vector3_2.Z - vector3.Z)

	if vector3_3.Magnitude <= 0.01 then
		return (Vector3.new(0, 0, 0))
	end

	local Unit = Vector3.new(-vector3_3.Z, 0, vector3_3.X).Unit
	local v39 = math.min(vector3_3.Magnitude * 0.35, 6)
	local v40 = not (math.random() < 0.5) and 1 or -1

	return Unit * v39 * v40
end
local function createRuntimePickup(p6) -- line: 154
	-- upvalues: ReplicatedStorage (copy), Food (copy)
	local Assets = ReplicatedStorage:WaitForChild("Assets")

	if Food.getFood(p6.id) then
		local p6modelName = Assets:WaitForChild("Food"):FindFirstChild(p6.modelName)

		assert(p6modelName and p6modelName:IsA("BasePart"), string.format("Food mesh '%s' not found", p6.modelName))

		local clone = p6modelName:Clone()
		local Model = Instance.new("Model")

		clone.Parent = Model
		Model.PrimaryPart = clone

		return Model, clone
	end

	local p6modelName = Assets:WaitForChild("Loot"):FindFirstChild(p6.modelName)

	assert(p6modelName and p6modelName:IsA("Model"), string.format("Loot model '%s' not found", p6.modelName))

	local clone = p6modelName:Clone()
	local v48 = clone.PrimaryPart or clone:FindFirstChild("Root")

	assert(v48 and v48:IsA("BasePart"), string.format("Loot model '%s' is missing a root part", p6.modelName))
	clone.PrimaryPart = v48

	return clone, v48
end

function t1.new(p7, p8, p9: ((...any) -> ...any)) -- line: 194
	-- upvalues: LootServiceUtils (copy), createRuntimePickup (copy), configureModel (copy), addBillboard (copy), getCurveOffset (copy), t1 (copy)
	local v54 = LootServiceUtils.getDefinition(p7.lootId)

	assert(v54, string.format("Missing loot definition for '%s'", p7.lootId))

	local v55, v56 = createRuntimePickup(v54)

	v55.Name = p7.uniqueId
	v55.Parent = p8
	configureModel(v55, v56)
	addBillboard(v56, v54)

	local v57 = math.clamp(0.7 + (p7.restPosition - p7.spawnPosition).Magnitude * 0.045, 0.7, 1.15)
	local v58 = setmetatable({
		progress = 0,
		rotationAngle = 0,
		collectRequested = false,
		destroyed = false,
		uniqueId = p7.uniqueId,
		data = p7,
		definition = v54,
		model = v55,
		root = v56,
		parent = p8,
		baseRotation = v55:GetPivot().Rotation,
		curveOffset = getCurveOffset(p7.spawnPosition, p7.restPosition),
		duration = v57,
		onCollectRequested = p9
	}, t1)

	v58.touchedConn = v56.Touched:Connect(function(part) -- line: 230
		-- upvalues: v58 (copy)
		v58:onTouched(part)
	end)
	v58:update(0)

	return v58
end
function t1.setTransform(p10, vector3: Vector3) -- line: 237
	p10.model:PivotTo(CFrame.new(vector3) * p10.baseRotation * CFrame.Angles(0, p10.rotationAngle, 0))
end
function t1.requestCollect(p11) -- line: 241
	if p11.collectRequested or p11.destroyed then
		return
	end

	p11.collectRequested = true
	task.spawn(function() -- line: 247
		-- upvalues: p11 (copy)
		if not p11.onCollectRequested(p11.uniqueId) and not p11.destroyed then
			p11.collectRequested = false
		end
	end)
end
function t1.onTouched(p12, p13) -- line: 255
	-- upvalues: Players (copy)
	local Character = Players.LocalPlayer.Character

	if not Character then
		return
	end

	if p13:IsDescendantOf(Character) then
		p12:requestCollect()
	end
end
function t1.update(p14, n1: number, n2: number?) -- line: 266
	-- upvalues: Players (copy), MonetizationServiceClient (copy), Products (copy)
	if p14.destroyed then
		return
	end

	local v75

	if p14.progress < 1 then
		p14.progress = math.min(p14.progress + n1 / p14.duration, 1)

		local progress = p14.progress
		local v69 = if not (progress < 0.5) then 1 - math.pow(progress * -2 + 2, 3) / 2 else progress * 4 * progress * progress
		local spawnPosition = p14.data.spawnPosition
		local restPosition = p14.data.restPosition
		local v72 = spawnPosition + Vector3.new(0, 18, 0)
		local v73 = (spawnPosition + restPosition) / 2 + Vector3.new(0, 30, 0) + p14.curveOffset
		local v74 = 1 - v69

		v75 = spawnPosition * v74 * v74 * v74 + v72 * 3 * v74 * v74 * v69 + v73 * 3 * v74 * v69 * v69 + restPosition * v69 * v69 * v69
	else
		v75 = p14.model:GetPivot().Position
	end

	local v76 = nil

	if p14.progress >= 1 then
		local Character = Players.LocalPlayer.Character
		local v78

		if Character == nil then
			v78 = nil
		else
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

			v78 = if not HumanoidRootPart or not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
		end

		if v78 ~= nil and (MonetizationServiceClient:ownsGamepass(Products.autoCollect) or (v78 - v75).Magnitude <= (n2 or 0)) then
			v76 = v78
		end
	end

	if v76 ~= nil then
		v75 = v75:Lerp(v76, (math.clamp(n1 * 10, 0, 1)))

		if (v76 - v75).Magnitude <= 2.5 then
			p14:requestCollect()
		end
	end

	p14.rotationAngle = p14.rotationAngle + n1 * 0.8726646259971648
	p14:setTransform(v75)
end
function t1.destroy(p15) -- line: 309
	if p15.destroyed then
		return
	end

	p15.destroyed = true

	if p15.touchedConn then
		p15.touchedConn:Disconnect()
	end

	p15.model:Destroy()
end

return t1
