local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

-- Library Requires
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

print("ItemDisplay loading...")

local AddDebris = require(ReplicatedStorage.Library.Functions.AddDebris)
print("AddDebris ok")
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
print("AssetColorUtil ok")
local Assets = require(ReplicatedStorage.Directory.Assets)
print("Assets ok")
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
print("Personalities ok")
local AssetInvertedModelPresentation = require(ReplicatedStorage.Library.Modules.AssetInvertedModelPresentation)
print("AssetInvertedModelPresentation ok")
local AssetModels = require(ReplicatedStorage.Library.Modules.AssetModels)
print("AssetModels ok")
local Asserts = require(ReplicatedStorage.Library.Asserts)
print("Asserts ok")
local ExpRetry = require(ReplicatedStorage.Library.Functions.ExpRetry)
print("ExpRetry ok")
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
print("AssetItem ok")
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
print("Mutations ok")
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
print("Simple ok")
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
print("AssetGenerationUtil ok")
local AssetSoundUtil = require(ReplicatedStorage.Library.Util.AssetSoundUtil)
print("AssetSoundUtil ok")
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
print("BBFromModelVisibleOnly ok")
local Physics = require(ReplicatedStorage.Library.Modules.Physics)
print("Physics ok")
local SpecialLuckyBlockAsset = require(ReplicatedStorage.Library.Util.SpecialLuckyBlockAsset)
print("SpecialLuckyBlockAsset ok")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
print("Constants ok")
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
print("Log ok")

print("ItemDisplay fully loaded")

local logger = Log.new()
local MAX_BILLBOARD_SIZE = Vector2.new(70, 30)
local DataBillboardTemplate = ReplicatedStorage.Assets.Extra.Data

local AssetItemModule = {}

--==============================--
-- Helper Functions
--==============================--

local function getDisplayScale(scale)
	if type(scale) == "number" then
		return math.max(scale, 0)
	end
	return 1
end

local function getModelScale(category, scale)
	local effectiveScale = (type(scale) == "number") and math.max(scale, 0) or 1
	return effectiveScale * Assets.Directory[category].BaseModelScale
end

local function getDisplayWeight(category, scale)
	local modelWeight = tonumber(Assets.Directory[category].ModelWeight) or 1
	local effectiveScale = (type(scale) == "number") and math.max(scale, 0) or 1
	return modelWeight * effectiveScale
end

local function applyModelScale(model, category, scale)
	local effectiveScale = (type(scale) == "number") and math.max(scale, 0) or 1
	local targetScale = effectiveScale * Assets.Directory[category].BaseModelScale
	model:ScaleTo(targetScale)
	return targetScale
end

local function getOrderedDisplayMutations(mutationsList, baseMutation)
	local orderedList = {}
	local seen = {}

	local function addMutation(mutationName)
		if mutationName ~= nil and mutationName ~= "" and not seen[mutationName] then
			seen[mutationName] = true
			table.insert(orderedList, mutationName)
		end
	end

	addMutation(baseMutation)

	if mutationsList then
		for _, mutation in ipairs(mutationsList) do
			addMutation(mutation)
		end
	end

	return orderedList
end

local function getAssetDisplayName(baseName, mutationsList, baseMutation)
	local orderedMutations = getOrderedDisplayMutations(mutationsList, baseMutation)

	if #orderedMutations == 0 then
		return baseName
	end

	local displayNames = table.create(#orderedMutations)
	for i, mutation in ipairs(orderedMutations) do
		displayNames[i] = Mutations.GetDisplayName(mutation)
	end

	return ("%s %s"):format(table.concat(displayNames, " + "), baseName)
end

local function formatToolName(baseName, mutationsList, baseMutation, weight)
	return string.format("%s (%.2f kg)", getAssetDisplayName(baseName, mutationsList, baseMutation), weight)
end

local function escapeRichText(text)
	return text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;")
end

local function formatMutationRichText(mutationName)
	local mutationData = Mutations.GetMutation(mutationName)
	if mutationData == nil then
		return nil
	end

	local displayName = Mutations.GetDisplayName(mutationName)
	return ('<font color="#%s">%s</font>'):format(mutationData.Color:ToHex(), escapeRichText(displayName))
end

local function isDroppableBaseMutation(mutationName)
	if type(mutationName) ~= "string" or mutationName == "" then
		return false
	end
	local mutationData = Mutations.GetMutation(mutationName)
	return mutationData ~= nil and mutationData.DropWeight > 0
end

local function resolveBaseMutation(baseMutation, mutationsList)
	if type(baseMutation) == "string" and baseMutation ~= "" then
		local mutationData = Mutations.GetMutation(baseMutation)
		if mutationData and mutationData.DropWeight > 0 then
			return baseMutation
		end
	end

	if type(mutationsList) == "table" then
		for _, mutation in ipairs(mutationsList) do
			if type(mutation) == "string" and mutation ~= "" then
				local mutationData = Mutations.GetMutation(mutation)
				if mutationData and mutationData.DropWeight > 0 then
					return mutation
				end
			end
		end
	end

	return nil
end

local function applyBillboardDisplay(billboard, baseName, mutationsList, baseMutation)
	local displayNameLabel = billboard:FindFirstChild("DisplayName")
	if displayNameLabel then
		displayNameLabel.RichText = true
		displayNameLabel.Text = getAssetDisplayName(baseName, mutationsList, baseMutation)
	end

	local levelLabel = billboard:FindFirstChild("Level")
	if levelLabel then
		levelLabel.Visible = false
		levelLabel.Text = ""
	end
end

local function getDisplayMutationState(instance, itemData)
	local parsedMutations, parsedBaseMutation = AssetSoundUtil.GetMutationStateFromAttributes(instance, "Mutations", "BaseMutation")

	if #parsedMutations > 0 or parsedBaseMutation then
		return parsedMutations, parsedBaseMutation
	end

	if not itemData then
		return {}, nil
	end

	return itemData.Mutations or {}, itemData.BaseMutation
end

local function baseCreateModel(itemData, disableCollisions)
	assert(AssetItem.AssetItemData(itemData))

	local category = itemData.Category
	local scale = itemData.Scale
	local modelTemplate = assert(AssetModels.GetModelTemplate(category), ("couldn't find model for: %s"):format(category)):Clone()

	modelTemplate.PrimaryPart = modelTemplate:FindFirstChild("Segment1", true) or modelTemplate.PrimaryPart
	assert(modelTemplate.PrimaryPart, ('couldn\'t find model primary for: "%s"'):format(category))

	for _, descendant in ipairs(modelTemplate:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Anchored = false
			descendant.CanQuery = descendant.Transparency ~= 1

			if descendant.Transparency == 1 or disableCollisions then
				descendant.CanCollide = false
			end
		end
	end

	local colorFields = AssetColorUtil.ResolveFields(category, itemData.EyeColor, itemData.ColorSeed, itemData.ColorIndex)
	AssetColorUtil.Apply(modelTemplate, category, colorFields.EyeColor, colorFields.ColorSeed, colorFields.ColorIndex)

	for _, mutation in ipairs(Mutations.FilterMutationsForCombo(itemData.Mutations)) do
		Mutations.AddMutationByName(modelTemplate, mutation, nil, colorFields.ColorSeed)
	end

	local actualScale = (type(scale) == "number") and math.max(scale, 0) or 1
	modelTemplate:ScaleTo(actualScale * Assets.Directory[category].BaseModelScale)

	if itemData.Personality == Personalities.Personalities.InvertedModel then
		AssetInvertedModelPresentation.Apply(modelTemplate)
	end

	return modelTemplate
end

local function destroyInstancesClockSliced(instances)
	local startTime = os.clock()

	for i, instance in ipairs(instances) do
		instance:Destroy()
		if i < #instances and os.clock() - startTime >= 0.002 then
			task.wait()
			startTime = os.clock()
		end
	end
end

local function attachDataBillboard(model, category, itemData, specificRate)
	Asserts.string(category)
	if specificRate ~= nil then
		Asserts.number(specificRate)
	end

	local centerPart = model:FindFirstChild("CENTER")
	if not (centerPart and centerPart:IsA("BasePart")) then
		return nil
	end

	if itemData then
		assert(AssetItem.AssetItemData(itemData))
	end

	local billboard = DataBillboardTemplate:Clone()
	billboard.Adornee = centerPart

	-- Dynamically calculate the offset based on the model's visible height
	local boundingCFrame, boundingSize = BBFromModelVisibleOnly(model)
	local topOffset = (boundingSize.Y * 0.5) + 1.5 -- Places it just above the top bounds with a small padding

	billboard.StudsOffset = Vector3.new(0, topOffset, 0)

	if billboard:FindFirstChild("Mutations") then billboard.Mutations:Destroy() end
	if billboard:FindFirstChild("BaseMutation") then billboard.BaseMutation:Destroy() end

	local size = centerPart.Size
	billboard.Size = UDim2.fromScale(
		math.min(MAX_BILLBOARD_SIZE.X, billboard.Size.X.Scale * (size.X / 0.861)), 
		math.min(MAX_BILLBOARD_SIZE.Y, billboard.Size.Y.Scale * (size.Y / 0.767))
	)

	local assetConfig = Assets.Directory[category]
	local displayNameLabel = billboard.DisplayName
	local perSecondLabel = billboard.PerSecond
	local rarityLabel = billboard:FindFirstChild("Rarity")
	local oddsLabel = billboard:FindFirstChild("Odds")

	local defaultData = itemData or {
		BaseMutation = nil,
		Scale = 1,
		HasBeenFirstPlaced = true,
		Category = category,
		Mutations = {},
		Personality = Personalities.Personalities.Normal
	}

	if rarityLabel then
		for _, child in ipairs(rarityLabel:GetChildren()) do
			if child:IsA("UIGradient") then child:Destroy() end
		end
		rarityLabel.Visible = false
		rarityLabel.Text = ""
	end

	if oddsLabel then
		for _, child in ipairs(oddsLabel:GetChildren()) do
			if child:IsA("UIGradient") then child:Destroy() end
		end

		local rarityConfig = assetConfig.Rarity
		if rarityConfig and rarityConfig.Gradient then
			rarityConfig.Gradient:Clone().Parent = oddsLabel
		end

		oddsLabel.Text = rarityConfig.DisplayName
		oddsLabel.Visible = true
	end

	-- Update Billboard Content
	local mutations, baseMutation = getDisplayMutationState(model, itemData)
	if displayNameLabel then
		displayNameLabel.RichText = true
		displayNameLabel.Text = getAssetDisplayName(assetConfig.DisplayName, mutations, baseMutation)
	end

	local levelLabel = billboard:FindFirstChild("Level")
	if levelLabel then
		levelLabel.Visible = false
		levelLabel.Text = ""
	end

	local currentRate = specificRate or 0
	if specificRate == nil then
		local success, result = pcall(AssetGenerationUtil.GetRate, defaultData, 0)
		currentRate = success and result or 0
	end

	if perSecondLabel then
		if currentRate > 0 then
			perSecondLabel.Visible = true
			perSecondLabel.Text = "$" .. Simple.FormatCompact(currentRate) .. "/s"
		else
			perSecondLabel.Visible = false
			perSecondLabel.Text = ""
		end
	end

	billboard.Parent = model
	return billboard, displayNameLabel, perSecondLabel
end

local function ensureToolHandle(tool)
	local handle = tool:FindFirstChild("Handle")
	if handle and handle:IsA("BasePart") then
		return handle
	end

	handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(0.2, 0.2, 0.2)
	handle.Transparency = 1
	handle.CanCollide = false
	handle.CanQuery = false
	handle.CanTouch = false
	handle.Anchored = false
	handle.Massless = true
	handle.Parent = tool

	tool.RequiresHandle = true
	tool.CanBeDropped = false

	return handle
end

local function attachCenteredHandle(tool, model, scaleOffset, attachmentType)
	local scaleMultiplier = scaleOffset or 1
	local primaryPart = assert(model.PrimaryPart, ('model "%s" is missing PrimaryPart'):format(model:GetFullName()))
	local modelPivot = model:GetPivot()
	local handle = ensureToolHandle(tool)
	local targetCFrame

	if attachmentType == "HumanoidRootPart" or attachmentType == "HumanoidRootPartXZBoundsBottomY" then
		local rootPart = model:FindFirstChild("HumanoidRootPart", true)
		assert(rootPart and rootPart:IsA("BasePart"), ('model "%s" is missing HumanoidRootPart'):format(model:GetFullName()))

		if attachmentType == "HumanoidRootPartXZBoundsBottomY" then
			local boundingCFrame, boundingSize = BBFromModelVisibleOnly(model)
			targetCFrame = rootPart.CFrame.Rotation + Vector3.new(rootPart.Position.X, boundingCFrame.Position.Y - boundingSize.Y * 0.5, rootPart.Position.Z)
		else
			targetCFrame = rootPart.CFrame
		end
	else
		local boundingCFrame, boundingSize = BBFromModelVisibleOnly(model)
		targetCFrame = boundingCFrame * CFrame.new(0, boundingSize.Y * -0.5, scaleMultiplier * (boundingSize.Z * 0.1))
	end

	model:PivotTo(handle.CFrame * targetCFrame:ToObjectSpace(modelPivot))

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = primaryPart
	weld.Part1 = handle
	weld.Parent = primaryPart

	return handle
end

--==============================--
-- Module Methods
--==============================--

function AssetItemModule.StripRuntimeRig(model, dontRemoveBones, keepAnimators)
	Asserts.Model(model)

	local rootPart = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart", true)
	local instancesToRemove = {}

	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("Humanoid") or descendant:IsA("AnimationController") or descendant:IsA("Animator") or descendant:IsA("Bone") then
			if descendant:IsA("Bone") and dontRemoveBones then
				continue
			end

			if descendant:IsA("AnimationController") or descendant:IsA("Animator") then
				if not keepAnimators then
					table.insert(instancesToRemove, descendant)
				end
			else
				table.insert(instancesToRemove, descendant)
			end
		end
	end

	destroyInstancesClockSliced(instancesToRemove)

	if rootPart and rootPart:IsA("BasePart") then
		model.PrimaryPart = rootPart
	end
end

AssetItemModule.CreateDataBillboard = attachDataBillboard

function AssetItemModule.SetDataBillboardMoneyPerSecond(billboard, moneyPerSecond)
	Asserts.Instance(billboard)
	Asserts.number(moneyPerSecond)

	local perSecondLabel = billboard:FindFirstChild("PerSecond")
	assert(perSecondLabel and perSecondLabel:IsA("TextLabel"), "Data billboard must expose a PerSecond label")

	if moneyPerSecond > 0 then
		perSecondLabel.Visible = true
		perSecondLabel.Text = "$" .. Simple.FormatCompact(moneyPerSecond) .. "/s"
	else
		perSecondLabel.Visible = false
		perSecondLabel.Text = ""
	end
end

function AssetItemModule.CreateModel(itemData)
	return baseCreateModel(itemData)
end

function AssetItemModule.CreateWanderingAssetModel(ownerUserId, uid, itemData, parent)
	Asserts.number(ownerUserId)
	Asserts.string(uid)
	Asserts.Instance(parent)
	assert(AssetItem.AssetItemData(itemData))

	local model = baseCreateModel(itemData, true)
	model.Name = ("%s_%s"):format(ownerUserId, uid)

	local primaryPart = assert(model.PrimaryPart, ("Asset model %s must have a PrimaryPart"):format(itemData.Category))
	local boundingCFrame, boundingSize = BBFromModelVisibleOnly(model)

	primaryPart.PivotOffset = CFrame.new(0, boundingCFrame.Position.Y - boundingSize.Y * 0.5 - primaryPart.Position.Y, 0)

	for _, descendant in model:GetDescendants() do
		if descendant:IsA("BasePart") then
			descendant.CanCollide = false
			descendant.CanQuery = descendant.Transparency ~= 1
			descendant.CanTouch = false
			descendant.Massless = true
			descendant.Anchored = false
		end
	end

	primaryPart.Anchored = true
	model:SetAttribute("UID", uid)
	model:SetAttribute("OwnerUserId", ownerUserId)
	model.Parent = parent

	return model
end

function AssetItemModule.GetVisibleBounds(itemData)
	assert(AssetItem.AssetItemData(itemData))

	local boundsData = AssetModels.GetVisibleBoundsData(itemData.Category)
	local templateScale = boundsData.TemplateScale
	assert(templateScale > 0, ("Asset model %s scale must be greater than 0"):format(itemData.Category))

	return boundsData.Size / templateScale
end

function AssetItemModule.CreateActiveModelWithHumanoid(uid, itemData)
	return AssetItemModule.CreateActiveModel(uid, itemData)
end

function AssetItemModule.CreateActiveModel(uid, itemData, loadIdleAnimation, dontRemoveBones, keepAnimators)
	Asserts.optional.string(uid)

	local model = baseCreateModel(itemData, true)
	local primaryPart = assert(model.PrimaryPart, "model is missing PrimaryPart")
	primaryPart.Anchored = true

	model:SetAttribute("SpecialLuckyBlockAsset", SpecialLuckyBlockAsset.IsItemData(itemData))

	local assetConfig = Assets.Directory[itemData.Category]
	local idleAnimation = assetConfig.Animations.Idle

	if loadIdleAnimation and idleAnimation then
		assert(idleAnimation, ("missing idle animation for category %s"):format(itemData.Category))

		local existingController = model:FindFirstChildWhichIsA("AnimationController", true)
		if existingController then
			local existingAnimator = existingController:FindFirstChildWhichIsA("Animator")
			if existingAnimator then existingAnimator:Destroy() end
			existingController:Destroy()
		end

		local animController = Instance.new("AnimationController")
		animController.Name = "AnimationController"
		animController.Parent = model:WaitForChild("Model")

		local animator = Instance.new("Animator")
		if Constants.IS_SERVER then
			animator:SetAttribute("ActiveAssetRarity", assetConfig.Rarity._id)
		end
		animator.Parent = animController

		local connection
		connection = model.AncestryChanged:Connect(function(_, newParent)
			if not (newParent and newParent:IsDescendantOf(workspace)) and newParent ~= workspace then
				return
			end
			connection:Disconnect()

			local success, loadedAnim = ExpRetry(function()
				return animator:LoadAnimation(idleAnimation)
			end):await()

			if not success then
				logger:AtError():Log(("Failed to load animation for model %s: %s"):format(model.Name, loadedAnim))
				return
			end

			loadedAnim.Looped = true
			loadedAnim.Priority = Enum.AnimationPriority.Idle
			loadedAnim:Play()
		end)
	else
		AssetItemModule.StripRuntimeRig(model, model:GetAttribute("DontRemoveBones") or dontRemoveBones, keepAnimators)
	end

	if uid then
		model:SetAttribute("UID", uid)
	end

	return model
end

function AssetItemModule.GetNameFromItemData(itemData)
	assert(AssetItem.AssetItemData(itemData))
	local baseName = Assets.Directory[itemData.Category].DisplayName or "Unknown"
	return getAssetDisplayName(baseName, itemData.Mutations, itemData.BaseMutation)
end

function AssetItemModule.GetDataBillboardMaxDistance()
	return DataBillboardTemplate.MaxDistance
end

function AssetItemModule.CreateTool(itemData, uid, parentContainer)
	print("CreateTool called for", uid)
	assert(AssetItem.AssetItemData(itemData))
	Asserts.string(uid)

	local category = itemData.Category
	local scale = itemData.Scale
	local baseMutation = itemData.BaseMutation
	local assetConfig = Assets.Directory[category]
	local modelWeight = tonumber(assetConfig.ModelWeight) or 1
	local actualWeight = modelWeight * (type(scale) == "number" and math.max(scale, 0) or 1)

	local colorFields = AssetColorUtil.ResolveFields(category, itemData.EyeColor, itemData.ColorSeed, itemData.ColorIndex)
	local tool = Instance.new("Tool")
	local mutationsString = table.concat(itemData.Mutations, ", ")

	tool.Name = AssetItemModule.GetNameFromItemData(itemData)
	tool.RequiresHandle = true
	tool.CanBeDropped = false
	tool:SetAttribute("GuardTransparencyExcluded", true)
	tool:SetAttribute("UID", uid)
	tool:SetAttribute("Mutations", mutationsString)
	tool:SetAttribute("BaseMutation", baseMutation)
	tool:SetAttribute("DisplayName", assetConfig.DisplayName or category)
	tool:SetAttribute("Weight", actualWeight)
	tool:SetAttribute("Scale", scale)
	tool:SetAttribute("EyeColor", colorFields.EyeColor)
	tool:SetAttribute("ColorSeed", colorFields.ColorSeed)
	tool:SetAttribute("ColorIndex", colorFields.ColorIndex)
	tool:SetAttribute("Category", assetConfig._id)
	tool:SetAttribute("Favorite", itemData.IsFavorite or false)
	tool:SetAttribute("ItemType", "Asset")
	CollectionService:AddTag(tool, "AssetTool")

	local configuration = Instance.new("Configuration")
	configuration.Name = "Configuration"
	configuration.Parent = tool
	configuration:SetAttribute("mutations", mutationsString)
	configuration:SetAttribute("baseMutation", baseMutation)
	configuration:SetAttribute("displayName", assetConfig.DisplayName or category)
	configuration:SetAttribute("scale", scale)
	configuration:SetAttribute("eyeColor", colorFields.EyeColor)
	configuration:SetAttribute("colorSeed", colorFields.ColorSeed)
	configuration:SetAttribute("colorIndex", colorFields.ColorIndex)
	configuration:SetAttribute("rarity", assetConfig.Rarity._id)
	configuration:SetAttribute("money", itemData.GeneratedMoney or 0)

	local rebirths = 0
	local gamepasses = nil

	if Constants.IS_SERVER then
		local Database = require(ServerScriptService.Core_PlayerData)
		local success, profile = Database.Get(parentContainer)
		if success and profile then
			rebirths = profile.Rebirth or 0
			gamepasses = profile.Gamepasses
		end
	end

	local ratePerSecond = AssetGenerationUtil.GetRate(itemData, rebirths, gamepasses)
	local rateWithoutRebirth = AssetGenerationUtil.GetRateWithoutRebirth(itemData, gamepasses)

	configuration:SetAttribute("perSecond", ratePerSecond)
	configuration:SetAttribute("perSecondDisplay", rateWithoutRebirth)

	local handle = ensureToolHandle(tool)
	local renderModel = nil
	local billboard = nil
	local perSecondLabel = nil

	local function syncToolMutationState()
		local toolMutations = tool:GetAttribute("Mutations")
		local toolBaseMutation = tool:GetAttribute("BaseMutation")

		if configuration:GetAttribute("mutations") ~= toolMutations then
			configuration:SetAttribute("mutations", toolMutations)
		end
		if configuration:GetAttribute("baseMutation") ~= toolBaseMutation then
			configuration:SetAttribute("baseMutation", toolBaseMutation)
		end

		if renderModel then
			if renderModel:GetAttribute("Mutations") ~= toolMutations then
				renderModel:SetAttribute("Mutations", toolMutations)
			end
			if renderModel:GetAttribute("BaseMutation") ~= toolBaseMutation then
				renderModel:SetAttribute("BaseMutation", toolBaseMutation)
			end
		end
	end

	local function destroyToolRender()
		if billboard then
			AddDebris(billboard, 0)
			billboard = nil
			perSecondLabel = nil
		end
		if renderModel then
			AddDebris(renderModel, 0)
			renderModel = nil
		end
	end

	local function ensureToolRender()
		if renderModel and renderModel.Parent == tool and handle.Parent == tool then
			return renderModel
		end

		destroyToolRender()

		local isInvertedModel = itemData.Personality == Personalities.Personalities.InvertedModel
		local renderData = itemData

		if isInvertedModel then
			renderData = table.clone(itemData)
			renderData.Mutations = table.clone(itemData.Mutations)
			renderData.Personality = Personalities.Personalities.Normal
		end

		local model = AssetItemModule.CreateActiveModel(uid, renderData, true, true)
		Physics.DisableAllPhysics(model)
		Physics.SetAnchored(model, false)

		local attachmentTarget = nil
		if category == "Cave Dragon" or category == "Warden" or category == "Eternal Lunar Dragon" then
			attachmentTarget = "HumanoidRootPart"
		elseif category == "Unicorn" then
			attachmentTarget = "HumanoidRootPartXZBoundsBottomY"
		end

		handle = attachCenteredHandle(tool, model, nil, attachmentTarget)

		if isInvertedModel then
			AssetInvertedModelPresentation.Apply(model)
			Physics.SetAnchored(model, false)
		end

		for _, descendant in model:GetDescendants() do
			if descendant:IsA("BasePart") then
				descendant:SetAttribute("KillPartIgnore", true)
			end
		end

		renderModel = model
		model.Parent = tool
		syncToolMutationState()

		return model
	end

	local function updateBillboard()
		local displayName = configuration:GetAttribute("displayName") or ""
		local scaleAttr = configuration:GetAttribute("scale")
		local currentScale = type(scaleAttr) == "number" and scaleAttr or 1
		local baseWeight = tonumber(Assets.Directory[category].ModelWeight) or 1
		local finalWeight = baseWeight * math.max(currentScale, 0)

		local parsedMutations = AssetSoundUtil.ParseMutationsAttribute(tool:GetAttribute("Mutations") or "")
		local parsedBaseMutation = tool:GetAttribute("BaseMutation")

		syncToolMutationState()
		tool:SetAttribute("Weight", finalWeight)
		tool.Name = formatToolName(displayName, parsedMutations, parsedBaseMutation, finalWeight)

		if billboard then
			applyBillboardDisplay(billboard, displayName, parsedMutations, parsedBaseMutation)
		end

		if perSecondLabel then
			local displayRate = configuration:GetAttribute("perSecondDisplay")
			if type(displayRate) ~= "number" then
				displayRate = configuration:GetAttribute("perSecond")
			end
			perSecondLabel.Text = "$" .. Simple.FormatCompact(displayRate) .. "/s"
		end
	end

	local function ensureToolBillboard()
		local model = ensureToolRender()

		if billboard then return end

		local newBillboard, _, newPerSecond = attachDataBillboard(model, category, itemData)
		if newBillboard then
			billboard = newBillboard
			billboard.MaxDistance = billboard.MaxDistance * 2.8
			billboard.Enabled = true
			perSecondLabel = newPerSecond
			updateBillboard()
		end
	end

	-- Tool Event Connections
	local connections = {}

	table.insert(connections, configuration:GetAttributeChangedSignal("perSecondDisplay"):Connect(updateBillboard))
	table.insert(connections, configuration:GetAttributeChangedSignal("perSecond"):Connect(updateBillboard))
	table.insert(connections, configuration:GetAttributeChangedSignal("displayName"):Connect(updateBillboard))
	table.insert(connections, configuration:GetAttributeChangedSignal("scale"):Connect(updateBillboard))

	table.insert(connections, tool:GetAttributeChangedSignal("Mutations"):Connect(function()
		syncToolMutationState()
		if billboard then
			destroyToolRender()
			ensureToolBillboard()
		end
		updateBillboard()
	end))

	table.insert(connections, tool:GetAttributeChangedSignal("BaseMutation"):Connect(function()
		syncToolMutationState()
		if billboard then
			destroyToolRender()
			ensureToolBillboard()
		end
		updateBillboard()
	end))

	table.insert(connections, tool.Equipped:Connect(function()
		ensureToolBillboard()
	end))

	table.insert(connections, tool.Unequipped:Connect(destroyToolRender))

	tool.Destroying:Connect(function()
		for _, connection in ipairs(connections) do
			connection:Disconnect()
		end
		destroyToolRender()
	end)

	tool.Parent = parentContainer:WaitForChild("Backpack")
	print("CreateTool finished for", uid)
	return tool
end

AssetItemModule.GetDisplayScale = getDisplayScale
AssetItemModule.GetModelScale = getModelScale

function AssetItemModule.GetMutationRichTextLine(mutationsList, baseMutation)
	Asserts.table(mutationsList)
	Asserts.optional.string(baseMutation)

	local formattedLines = {}
	local seen = {}

	local function addFormattedMutation(mutationName)
		if not mutationName or mutationName == "" or seen[mutationName] then
			return
		end

		seen[mutationName] = true
		local richText = formatMutationRichText(mutationName)
		if richText then
			table.insert(formattedLines, richText)
		end
	end

	addFormattedMutation(baseMutation)

	for _, mutation in ipairs(mutationsList) do
		addFormattedMutation(mutation)
	end

	if #formattedLines == 0 then
		return nil
	end
	
	print("Done man")
	
	return table.concat(formattedLines, ", ")
end

AssetItemModule.IsDroppableBaseMutation = isDroppableBaseMutation
AssetItemModule.ResolveBaseMutation = resolveBaseMutation
AssetItemModule.ApplyModelScale = applyModelScale
AssetItemModule.ApplyBillboardDisplay = applyBillboardDisplay

return AssetItemModule