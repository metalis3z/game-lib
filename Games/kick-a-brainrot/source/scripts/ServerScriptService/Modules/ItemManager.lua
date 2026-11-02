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
local CollectionZones = Workspace:WaitForChild("Zones")

-- [ CONFIGURATION ]
local INCOME_SCALING = 1.125 

local MUTATION_MULTIPLIERS = {
	["Normal"] = 1,
	["Golden"] = 2,
	["Diamond"] = 3,
	["Ruby"] = 4,
	["Neon"] = 5,
}

local ItemManager = {}

-- [ HELPERS ]

local function isInsideAnyZone(position: Vector3): boolean
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

	if target:IsA("Model") then
		rootPart = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
	elseif target:IsA("Tool") then
		rootPart = target:FindFirstChild("Handle") :: BasePart
	end

	if not rootPart then return end
	if target:FindFirstChild("InfoGUI") then target.InfoGUI:Destroy() end

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

	local totalIncome = baseIncome * (MUTATION_MULTIPLIERS[mutationName] or 1) * (INCOME_SCALING ^ ((level or 1) - 1)) * rebMult * vipMult

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
	if mutationConfig then
		lblMutation.Text = mutationConfig.DisplayName
		lblMutation.TextColor3 = mutationConfig.TextColor
		local stroke = lblMutation:FindFirstChild("UIStroke") or lblMutation:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = mutationConfig.StrokeColor; stroke.Thickness = mutationConfig.StrokeThickness end
		local gradient = lblMutation:FindFirstChild("UIGradient") or lblMutation:FindFirstChildOfClass("UIGradient")
		if gradient then gradient.Color = mutationConfig.GradientColor end
	end

	infoGui.Adornee = rootPart
	infoGui.Parent = target
end

function ItemManager.SpawnVisualItem(parentPart: BasePart, itemName: string, mutation: string, rarity: string, level: number, rebirths: number?, isVip: boolean?)
	local mutationFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
	local itemTemplate = mutationFolder:FindFirstChild(itemName) or ItemsFolder.Normal:FindFirstChild(itemName)

	if not itemTemplate then return end

	local model = itemTemplate:Clone() :: Model
	model.Name = "VisualItem"
	model:SetAttribute("OriginalName", itemName)
	model:SetAttribute("Mutation", mutation)
	model:SetAttribute("Rarity", rarity)
	model:SetAttribute("Level", level)
	model:SetAttribute("IsSpawnedItem", false)

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true; part.CanCollide = false
		end
	end

	local extents = model:GetExtentsSize()
	local offset = Vector3.new(0, extents.Y/2, 0)
	model:PivotTo(parentPart.CFrame + offset)
	model.Parent = parentPart

	setupItemGUI(model, level, rebirths, isVip)
end

function ItemManager.UpdateVisualItem(model: Model, level: number, rebirths: number?, isVip: boolean?)
	if not model then return end
	model:SetAttribute("Level", level)
	setupItemGUI(model, level, rebirths, isVip)
end

-- [ TOOL CREATION ]

function ItemManager.GiveItemToPlayer(player: Player, itemName: string, mutation: string, rarity: string, level: number?, isTemporary: boolean?)
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

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Transparency = 1
	handle.Size = Vector3.new(1, 1, 1)
	handle.CanCollide = false
	handle.Massless = true
	handle.Parent = newTool

	local model = itemTemplate:Clone()
	model.Name = "StackedItem"
	model:SetAttribute("OriginalName", itemName)
	model:SetAttribute("Mutation", mutation)
	model:SetAttribute("Rarity", rarity)
	model:SetAttribute("Level", level or 1)
	model:SetAttribute("IsSpawnedItem", false)

	model.Parent = newTool
	model:PivotTo(handle.CFrame)

	for _, p in ipairs(model:GetDescendants()) do
		if p:IsA("BasePart") then
			p.Anchored = false
			p.CanCollide = false
			p.Massless = true
			local w = Instance.new("WeldConstraint")
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

	setupItemGUI(model, level or 1, rebirths, isVip)

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