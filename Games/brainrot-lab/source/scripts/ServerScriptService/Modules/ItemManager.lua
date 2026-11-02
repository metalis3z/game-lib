--!strict
-- LOCATION: ServerScriptService/Modules/ItemManager

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")

-- [ MODULES ]
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local RarityConfigurations = require(ReplicatedStorage.Modules.RarityConfigurations)
local MutationConfigurations = require(ReplicatedStorage.Modules.MutationConfigurations)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- [ ASSETS ]
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local InfoGUI_Template = Templates:WaitForChild("InfoGUI")
local BrainrotUI_Template = Templates:WaitForChild("Brainrot_UI")
local CollectionZones = Workspace:FindFirstChild("Zones")
local VFXFolder = ReplicatedStorage:FindFirstChild("VFX Mutações")
local Events = ReplicatedStorage:FindFirstChild("Events")

-- [ CONFIGURATION ]
local INCOME_SCALING = 1.125 

local MUTATION_MULTIPLIERS = {
	["Normal"] = 1,
	["Gold"] = 1.2,
	["Golden"] = 2,
	["Diamond"] = 1.45,
	["Ruby"] = 4,
	["Neon"] = 5,
	-- Event mutations
	["Acid"] = 6,
	["Love"] = 6,
	["Brazil"] = 6,
	["Matteo"] = 6,
	["Aquatic"] = 6,
	["Tecnologia"] = 6,
	["Lava"] = 1.2,
	["Hacker"] = 6,
}

local ItemManager = {}

-- [ HELPERS ]

local function getModelFromItem(item): Model?
	if item:IsA("Model") then return item end
	if item:IsA("Folder") then
		return item:FindFirstChildOfClass("Model")
	end
	return nil
end

local function getItemExtents(item: Instance): Vector3
	local model = getModelFromItem(item)
	if model then return model:GetExtentsSize() end
	if item:IsA("Model") then return item:GetExtentsSize() end
	return Vector3.new(2, 2, 2)
end

local function pivotItemTo(item: Instance, cf: CFrame)
	local model = getModelFromItem(item)
	if model then
		model:PivotTo(cf)
	elseif item:IsA("Model") then
		item:PivotTo(cf)
	end
end

local function isInsideAnyZone(position: Vector3): boolean
	if not CollectionZones then return false end
	for _, zonePart in ipairs(CollectionZones:GetChildren()) do
		if zonePart:IsA("BasePart") then
			local relativePos = zonePart.CFrame:PointToObjectSpace(position)
			local size = zonePart.Size

			local inside = math.abs(relativePos.X) <= size.X / 2 and
				math.abs(relativePos.Y) <= size.Y / 2 and
				math.abs(relativePos.Z) <= size.Z / 2

			if inside then return true end
		end
	end
	return false
end

-- [ VISUALS & GUI ]

local function setupItemGUI(target: Instance, level: number?, rebirths: number?, isVip: boolean?)
	local rootPart: BasePart?
	local guiParent: Instance = target

	if target:IsA("Model") then
		rootPart = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
	elseif target:IsA("Tool") then
		rootPart = target:FindFirstChild("Handle") :: BasePart
	elseif target:IsA("Folder") then
		local innerModel = getModelFromItem(target)
		if innerModel then
			rootPart = innerModel.PrimaryPart or innerModel:FindFirstChildWhichIsA("BasePart")
			guiParent = innerModel
		end
	end

	if not rootPart then return end
	if guiParent:FindFirstChild("InfoGUI") then guiParent.InfoGUI:Destroy() end

	local infoGui = InfoGUI_Template:Clone()
	infoGui.Name = "InfoGUI"
	local labelsFrame = infoGui:WaitForChild("TextLabels")

	local lblEarnings = labelsFrame:WaitForChild("Earnings") :: TextLabel
	local lblRarity = labelsFrame:WaitForChild("Rarity") :: TextLabel
	local lblName = labelsFrame:WaitForChild("Name") :: TextLabel
	local lblMutation = labelsFrame:WaitForChild("Mutation") :: TextLabel

	local itemName = target:GetAttribute("OriginalName") or "Unknown"
	local rarityName = target:GetAttribute("Rarity") or "Common"
	local mutationName = target:GetAttribute("Mutation") or "Normal"

	lblName.Text = itemName

	local itemData = ItemConfigurations.GetItemData(itemName)
	local baseIncome = itemData and itemData.Income or 0

	local reb = rebirths or 0
	local rebMult = 1 + (reb * 0.5) 
	local vipMult = isVip and 1.5 or 1 

	local ingredientBonus = target:GetAttribute("IngredientBonus") or 1
	local totalIncome = baseIncome * (MUTATION_MULTIPLIERS[mutationName] or 1) * (INCOME_SCALING ^ ((level or 1) - 1)) * rebMult * vipMult * ingredientBonus

	lblEarnings.Text = "+" .. NumberFormatter.Format(totalIncome) .. "/s"

	local rarityConfig = RarityConfigurations[rarityName]
	if rarityConfig then
		lblRarity.Text = rarityConfig.DisplayName
		lblRarity.TextColor3 = rarityConfig.TextColor
		local stroke = lblRarity:FindFirstChild("UIStroke") or lblRarity:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = rarityConfig.StrokeColor; stroke.Thickness = rarityConfig.StrokeThickness end
		local gradient = lblRarity:FindFirstChild("UIGradient") or lblRarity:FindFirstChildOfClass("UIGradient")
		if gradient then gradient.Color = rarityConfig.GradientColor end
	end

	local mutationConfig = MutationConfigurations[mutationName]
	if mutationConfig and mutationName ~= "Normal" then
		lblMutation.Text = mutationConfig.DisplayName
		lblMutation.TextColor3 = mutationConfig.TextColor
		local stroke = lblMutation:FindFirstChild("UIStroke") or lblMutation:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = mutationConfig.StrokeColor; stroke.Thickness = mutationConfig.StrokeThickness end
		local gradient = lblMutation:FindFirstChild("UIGradient") or lblMutation:FindFirstChildOfClass("UIGradient")
		if gradient then gradient.Color = mutationConfig.GradientColor end
	else
		lblMutation.Text = ""
	end

	infoGui.Adornee = rootPart

	-- Position the GUI above the model based on its bounding box height
	local modelForBB = getModelFromItem(target) or (target:IsA("Model") and target or nil)
	if modelForBB then
		local bbCFrame, bbSize = modelForBB:GetBoundingBox()
		local rootPos = rootPart.Position
		local modelTopOffset = bbCFrame.Position.Y + bbSize.Y / 2 - rootPos.Y
		infoGui.StudsOffset = Vector3.new(0, modelTopOffset - 0.9, 0)
	end

	infoGui.Parent = guiParent
end

local function attachBrainrotUI(item: Instance, itemName: string, rarity: string, mutation: string, level: number, rebirths: number?, isVip: boolean?)
	local model = getModelFromItem(item)
	if not model then return end
	local rootPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
	if not rootPart then return end

	-- Remove existing Brainrot_UI if present
	local existing = model:FindFirstChild("Brainrot_UI")
	if existing then existing:Destroy() end

	local ui = BrainrotUI_Template:Clone()
	ui.Name = "Brainrot_UI"
	ui.Adornee = rootPart

	local frame = ui:FindFirstChild("Frame")
	if not frame then ui.Parent = model return end

	local lblTitle = frame:FindFirstChild("Title") :: TextLabel
	local lblEarn = frame:FindFirstChild("Earn") :: TextLabel
	local lblPrice = frame:FindFirstChild("Price") :: TextLabel
	local lblRarity = frame:FindFirstChild("Rarity") :: TextLabel
	local lblType = frame:FindFirstChild("Type") :: TextLabel
	local mutationsFrame = frame:FindFirstChild("Mutations")

	-- Set Title (brainrot name)
	if lblTitle then
		lblTitle.Text = itemName
	end

	-- Calculate income for Earn label
	local itemData = ItemConfigurations.GetItemData(itemName)
	local baseIncome = itemData and itemData.Income or 0
	local mutMult = MUTATION_MULTIPLIERS[mutation] or 1
	local levelMult = INCOME_SCALING ^ ((level or 1) - 1)
	local reb = rebirths or 0
	local rebMult = 1 + (reb * 0.5)
	local vipMult = isVip and 1.5 or 1
	local ingredientBonus = item:GetAttribute("IngredientBonus") or 1
	local totalIncome = baseIncome * mutMult * levelMult * rebMult * vipMult * ingredientBonus

	if lblEarn then
		lblEarn.Text = "$" .. NumberFormatter.Format(totalIncome) .. "/s"
	end

	-- Hide Price label for slot brainrots (only conveyor brainrots show purchase price)
	if lblPrice then
		lblPrice.Visible = false
	end

	-- Set Rarity text and color
	if lblRarity then
		local rarityConfig = RarityConfigurations[rarity]
		if rarityConfig then
			lblRarity.Text = rarityConfig.DisplayName
			lblRarity.TextColor3 = rarityConfig.TextColor
			local stroke = lblRarity:FindFirstChildOfClass("UIStroke")
			if stroke then stroke.Color = rarityConfig.StrokeColor; stroke.Thickness = rarityConfig.StrokeThickness end
			local gradient = lblRarity:FindFirstChildOfClass("UIGradient")
			if gradient then gradient.Color = rarityConfig.GradientColor end
		else
			lblRarity.Text = rarity
		end
	end

	-- Set Type (mutation name or empty)
	if lblType then
		if mutation and mutation ~= "Normal" then
			lblType.Text = mutation
		else
			lblType.Text = ""
		end
	end

	-- Hide ALL mutation icons initially, then show the correct one
	if mutationsFrame then
		for _, icon in ipairs(mutationsFrame:GetChildren()) do
			if icon:IsA("ImageLabel") then
				icon.Visible = false
			end
		end
		-- Show the mutation icon if the brainrot has a mutation
		if mutation and mutation ~= "Normal" then
			local icon = mutationsFrame:FindFirstChild(mutation)
			if icon and icon:IsA("ImageLabel") then
				icon.Visible = true
			end
		end
		-- Show applied ingredient icons
		local appliedStr = item:GetAttribute("AppliedIngredients") or ""
		if appliedStr ~= "" then
			for iconName in string.gmatch(appliedStr, "[^,]+") do
				local icon = mutationsFrame:FindFirstChild(iconName)
				if icon and icon:IsA("ImageLabel") then
					icon.Visible = true
				end
			end
		end
	end

	-- Position the GUI above the model based on its bounding box height
	local bbCFrame, bbSize = model:GetBoundingBox()
	local rootPos = rootPart.Position
	local modelTopOffset = bbCFrame.Position.Y + bbSize.Y / 2 - rootPos.Y
	ui.StudsOffset = Vector3.new(0, modelTopOffset + 8, 0)

	ui.Parent = model
end

local function applyMutationVFX(item: Instance, mutation: string)
	local model = getModelFromItem(item)
	if not model then return end
	local brainrot = model:FindFirstChild("Brainrot")
	local mesh = brainrot and brainrot:FindFirstChild("Mesh")
	if not mesh or not mesh:IsA("BasePart") then return end

	local mutationLower = string.lower(mutation)
	local applied = false
	if VFXFolder then
		for _, emitter in ipairs(VFXFolder:GetChildren()) do
			if emitter:IsA("ParticleEmitter") then
				local nameLower = string.lower(emitter.Name)
				if nameLower == mutationLower or nameLower:match("^" .. mutationLower .. "%d+$") then
					emitter:Clone().Parent = mesh
					applied = true
				end
			end
		end
	end

	-- Fallback: use the mutation's ApplyVFX module if no VFX Mutações emitter exists
	if not applied then
		local mutationsFolder = Events and Events:FindFirstChild("Mutations")
		local mutFolder = mutationsFolder and mutationsFolder:FindFirstChild(mutation)
		local mutModule = mutFolder and mutFolder:FindFirstChild(mutation)
		if mutModule then
			local ok, result = pcall(require, mutModule)
			if ok and result and result.ApplyVFX then
				result.ApplyVFX(model)
			end
		end
	end
end

local function applyMutationTexture(item: Instance, itemTemplate: Instance, mutation: string)
	local textures = itemTemplate:FindFirstChild("Textures")
	local mutTex = textures and textures:FindFirstChild(mutation)
	if not mutTex then return end
	local mutModel = getModelFromItem(item)
	local brainrot = mutModel and mutModel:FindFirstChild("Brainrot")
	local mesh = brainrot and brainrot:FindFirstChild("Mesh")
	if mesh and mesh:IsA("MeshPart") then
		if mutTex:IsA("StringValue") and mutTex.Value ~= "" then
			mesh.TextureID = mutTex.Value
		elseif mutTex:IsA("SurfaceAppearance") then
			for _, sa in ipairs(mesh:GetChildren()) do
				if sa:IsA("SurfaceAppearance") then sa:Destroy() end
			end
			mutTex:Clone().Parent = mesh
		end
	end
end

local function playBrainrotAnimation(item: Instance, itemTemplate: Instance, animName: string)
	local model = getModelFromItem(item)
	if not model then return end
	local brainrot = model:FindFirstChild("Brainrot")
	local animController = brainrot and brainrot:FindFirstChildOfClass("AnimationController")
	local animator = animController and animController:FindFirstChildOfClass("Animator")
	if not animator then return end

	local anims = itemTemplate:FindFirstChild("Animations")
	local anim = anims and anims:FindFirstChild(animName)
	if not anim or not anim:IsA("Animation") then return end

	for _, tr in ipairs(animator:GetPlayingAnimationTracks()) do
		tr:Stop()
	end

	local ok, track = pcall(function()
		return animator:LoadAnimation(anim)
	end)
	if ok and track then
		track.Looped = true
		track:Play()
	end
end

function ItemManager.RestoreActiveEvents(item: Instance, activeEventsStr: string?)
	if not activeEventsStr or activeEventsStr == "" then return end

	-- Set the ActiveEvent attribute on the item
	item:SetAttribute("ActiveEvent", activeEventsStr)

	-- Parse the event list
	local EventConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("EventConfig"))
	local events = {}
	for ev in string.gmatch(activeEventsStr, "[^,]+") do
		table.insert(events, ev)
	end

	-- Show mutation icons in Brainrot_UI
	local model = getModelFromItem(item)
	local brainrotUI = model and model:FindFirstChild("Brainrot_UI")
	if not brainrotUI then
		brainrotUI = item:FindFirstChild("Brainrot_UI")
	end
	if brainrotUI then
		local uiFrame = brainrotUI:FindFirstChild("Frame")
		if uiFrame then
			local mutationsFolder = uiFrame:FindFirstChild("Mutations")
			if mutationsFolder then
				for _, ev in ipairs(events) do
					local config = EventConfig.Events[ev]
					if config and config.MutationName then
						local icon = mutationsFolder:FindFirstChild(config.MutationName)
						if icon and icon:IsA("ImageLabel") then
							icon.Visible = true
						end
					end
				end
			end
		end
	end

	-- Apply VFX for each mutation
	for _, ev in ipairs(events) do
		local config = EventConfig.Events[ev]
		if config and config.MutationName then
			applyMutationVFX(item, config.MutationName)
		end
	end

	-- Apply highlight with the last mutation's color
	local lastConfig = #events > 0 and EventConfig.Events[events[#events]]
	if lastConfig and model then
		local hl = model:FindFirstChild("EventHighlight")
		if not hl then
			hl = Instance.new("Highlight")
			hl.Name = "EventHighlight"
			hl.FillTransparency = 0.5
			hl.OutlineTransparency = 0.3
			hl.Parent = model
		end
		hl.FillColor = lastConfig.Color
		hl.OutlineColor = lastConfig.OutlineColor
	end

	-- Sync to parent slot
	local parent = item.Parent
	if parent and parent:GetAttribute("Earn") then
		parent:SetAttribute("ActiveEvent", activeEventsStr)
	end
end

function ItemManager.SpawnVisualItem(parentPart: BasePart, itemName: string, mutation: string, rarity: string, level: number, rebirths: number?, isVip: boolean?, ingredientBonus: number?, appliedIngredients: string?)
	local mutationFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
	local itemTemplate = mutationFolder:FindFirstChild(itemName) or ItemsFolder.Normal:FindFirstChild(itemName)

	if not itemTemplate then return end

	local item = itemTemplate:Clone()
	item.Name = "VisualItem"
	item:SetAttribute("OriginalName", itemName)
	item:SetAttribute("Mutation", mutation)
	item:SetAttribute("Rarity", rarity)
	item:SetAttribute("Level", level)
	item:SetAttribute("IsSpawnedItem", false)
	item:SetAttribute("BrainrotName", itemName)
	item:SetAttribute("IngredientBonus", ingredientBonus or 1)
	item:SetAttribute("AppliedIngredients", appliedIngredients or "")

	local itemData2 = ItemConfigurations.GetItemData(itemName)
	local baseIncome2 = itemData2 and itemData2.Income or 0
	item:SetAttribute("Earn", baseIncome2)

	for _, part in ipairs(item:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true; part.CanCollide = false
		end
	end

	-- Place the item's bottom flush on the TOP surface of the spawn part
	-- Measure the actual offset from the pivot to the bottom of the bounding box
	-- (character models are not centered on their pivot, so we must not assume extents.Y/2)
	pivotItemTo(item, parentPart.CFrame)
	local model = getModelFromItem(item)
	local pivotToBottomOffset = 0
	if model then
		local bbCFrame, bbSize = model:GetBoundingBox()
		local pivotPos = model:GetPivot().Position
		pivotToBottomOffset = bbCFrame.Position.Y - bbSize.Y / 2 - pivotPos.Y
	end
	-- Sink the item slightly into the slot so it looks "glued" to the surface
	local SLOT_SINK = 0.5
	local offset = Vector3.new(0, parentPart.Size.Y/2 - pivotToBottomOffset - SLOT_SINK, 0)
	pivotItemTo(item, parentPart.CFrame + offset)
	item.Parent = parentPart

	-- Apply the mutation's texture (Lava, Gold, Diamond, etc.) so it matches the conveyor
	if mutation and mutation ~= "Normal" then
		applyMutationTexture(item, itemTemplate, mutation)
	end

	-- Apply the mutation's VFX so it stays active in the slot
	if mutation and mutation ~= "Normal" then
		applyMutationVFX(item, mutation)
	end

	attachBrainrotUI(item, itemName, rarity, mutation, level, rebirths, isVip)

	-- Play the idle animation so brainrots animate in place while in the slot
	playBrainrotAnimation(item, itemTemplate, "Idle")
end

function ItemManager.UpdateVisualItem(model: Model, level: number, rebirths: number?, isVip: boolean?)
	if not model then return end
	model:SetAttribute("Level", level)

	-- Update Brainrot_UI Earn label with new level
	-- Use recursive search because Brainrot_UI may be parented to an inner Model
	-- inside a Folder-based VisualItem, not as a direct child of the Folder.
	local brainrotUI = model:FindFirstChild("Brainrot_UI", true)
	if brainrotUI then
		local frame = brainrotUI:FindFirstChild("Frame")
		local lblEarn = frame and frame:FindFirstChild("Earn") :: TextLabel
		if lblEarn then
			local itemName = model:GetAttribute("OriginalName") or "Unknown"
			local mutation = model:GetAttribute("Mutation") or "Normal"
			local itemData = ItemConfigurations.GetItemData(itemName)
			local baseIncome = itemData and itemData.Income or 0
			local mutMult = MUTATION_MULTIPLIERS[mutation] or 1
			local levelMult = INCOME_SCALING ^ (level - 1)
			local reb = rebirths or 0
			local rebMult = 1 + (reb * 0.5)
			local vipMult = isVip and 1.5 or 1
			local ingredientBonus = model:GetAttribute("IngredientBonus") or 1
			local totalIncome = baseIncome * mutMult * levelMult * rebMult * vipMult * ingredientBonus
			lblEarn.Text = "$" .. NumberFormatter.Format(totalIncome) .. "/s"
		end
	end

	-- Also update InfoGUI Earnings label if it exists (e.g. on held tools)
	local infoGUI = model:FindFirstChild("InfoGUI", true)
	if infoGUI then
		local labelsFrame = infoGUI:FindFirstChild("TextLabels")
		local lblEarnings = labelsFrame and labelsFrame:FindFirstChild("Earnings") :: TextLabel
		if lblEarnings then
			local itemName = model:GetAttribute("OriginalName") or "Unknown"
			local mutation = model:GetAttribute("Mutation") or "Normal"
			local itemData = ItemConfigurations.GetItemData(itemName)
			local baseIncome = itemData and itemData.Income or 0
			local mutMult = MUTATION_MULTIPLIERS[mutation] or 1
			local levelMult = INCOME_SCALING ^ (level - 1)
			local reb = rebirths or 0
			local rebMult = 1 + (reb * 0.5)
			local vipMult = isVip and 1.5 or 1
			local ingredientBonus = model:GetAttribute("IngredientBonus") or 1
			local totalIncome = baseIncome * mutMult * levelMult * rebMult * vipMult * ingredientBonus
			lblEarnings.Text = "+" .. NumberFormatter.Format(totalIncome) .. "/s"
		end
	end
end

-- [ TOOL CREATION ]

function ItemManager.GiveItemToPlayer(player: Player, itemName: string, mutation: string, rarity: string, level: number?, isTemporary: boolean?, activeEvent: string?, ingredientBonus: number?, appliedIngredients: string?)
	if not itemName then return end

	local itemConf = ItemConfigurations.GetItemData(itemName)
	local mutationFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder.Normal
	local itemTemplate = mutationFolder:FindFirstChild(itemName) or ItemsFolder.Normal:FindFirstChild(itemName)

	if not itemTemplate then warn("Template missing for: " .. itemName) return end

	if isTemporary then return end

	local newTool = Instance.new("Tool")
	newTool.Name = itemName
	if itemConf then newTool.TextureId = itemConf.ImageId end

	newTool:SetAttribute("IsTemporary", false)
	newTool:SetAttribute("OriginalName", itemName)
	newTool:SetAttribute("Mutation", mutation)
	newTool:SetAttribute("Rarity", rarity)
	newTool:SetAttribute("Level", level or 1)
	newTool:SetAttribute("IsSpawnedItem", false)
	newTool:SetAttribute("BrainrotName", itemName)
	newTool:SetAttribute("ActiveEvent", activeEvent or "")
	newTool:SetAttribute("IngredientBonus", ingredientBonus or 1)
	newTool:SetAttribute("AppliedIngredients", appliedIngredients or "")

	local itemConf2 = ItemConfigurations.GetItemData(itemName)
	local baseIncome2 = itemConf2 and itemConf2.Income or 0
	newTool:SetAttribute("Earn", baseIncome2)

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Transparency = 1
	handle.Size = Vector3.new(1, 1, 1)
	handle.CanCollide = false
	handle.Massless = true
	handle.Parent = newTool

	local item = itemTemplate:Clone()
	item.Name = "StackedItem"
	item:SetAttribute("OriginalName", itemName)
	item:SetAttribute("Mutation", mutation)
	item:SetAttribute("Rarity", rarity)
	item:SetAttribute("Level", level or 1)
	item:SetAttribute("IsSpawnedItem", false)
	item:SetAttribute("BrainrotName", itemName)
	item:SetAttribute("Earn", baseIncome2)
	item:SetAttribute("ActiveEvent", activeEvent or "")
	item:SetAttribute("IngredientBonus", ingredientBonus or 1)
	item:SetAttribute("AppliedIngredients", appliedIngredients or "")

	-- Remove the Humanoid so it doesn't try to control the body while held in hand
	-- (this was causing the brainrot to sink into the ground when the player walked)
	-- The Humanoid is nested inside the inner Model, so we must scan all descendants.
	for _, d in ipairs(item:GetDescendants()) do
		if d:IsA("Humanoid") then
			d:Destroy()
		end
	end

	item.Parent = newTool
	pivotItemTo(item, handle.CFrame)

	-- Remove Motor6D joints to prevent physics conflicts while held
	for _, m in ipairs(item:GetDescendants()) do
		if m:IsA("Motor6D") then m:Destroy() end
	end

	for _, p in ipairs(item:GetDescendants()) do
		if p:IsA("BasePart") then
			p.Anchored = false
			p.CanCollide = false
			p.Massless = true
			local w = Instance.new("Weld")
			w.Part0 = handle
			w.Part1 = p
			w.Parent = p
		end
	end

	local rebirths = 0
	local ls = player:FindFirstChild("leaderstats")
	if ls and ls:FindFirstChild("Rebirths") then
		rebirths = ls.Rebirths.Value
	end

	local PlayerController = require(ServerScriptService.Controllers.PlayerController)
	local isVip = PlayerController:IsVIP(player)

	setupItemGUI(item, level or 1, rebirths, isVip)

	newTool.Parent = player:WaitForChild("Backpack")
end

-- [ PICKUP LOGIC ]
local function onItemPickedUp(player: Player, itemModel: Model)
	if not itemModel or not itemModel.Parent then return end

	local name = itemModel:GetAttribute("OriginalName")
	local mutation = itemModel:GetAttribute("Mutation")
	local rarity = itemModel:GetAttribute("Rarity")
	local level = itemModel:GetAttribute("Level") or 1 

	if name and mutation and rarity then
		-- Skip the carry limit check and just give them the item
		ItemManager.GiveItemToPlayer(player, name, mutation, rarity, level, false)
		itemModel:Destroy()
	end
end

return ItemManager