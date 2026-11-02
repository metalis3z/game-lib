--!strict
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")

local ItemConfigurations     = require(ReplicatedStorage.Modules.ItemConfigurations)
local RarityConfigurations   = require(ReplicatedStorage.Modules.RarityConfigurations)
local MutationConfigurations = require(ReplicatedStorage.Modules.MutationConfigurations)
local NumberFormatter        = require(ReplicatedStorage.Modules.NumberFormatter)

local ItemsFolder        = ReplicatedStorage:WaitForChild("Items")
local SpawnersFolder     = Workspace:WaitForChild("ItemSpawns")
local Templates          = ReplicatedStorage:WaitForChild("Templates")
local InfoGUI_Template   = Templates:WaitForChild("InfoGUI")

local ITEMS_PER_SPAWNER  = 6
local MAX_RETRIES        = 50
local OVERLAP_PADDING    = 1.5
local MIN_ITEM_RADIUS    = 2
local INCOME_SCALING     = 1.125
local RECYCLE_MIN_TIME   = 30
local RECYCLE_MAX_TIME   = 90

-- Spawner index -> rarity name
local SPAWNER_RARITY = {
    ["1"] = "Common",
    ["2"] = "Uncommon",
    ["3"] = "Rare",
    ["4"] = "Epic",
    ["5"] = "Legendary",
}

local MUTATIONS = {
    {Name = "Neon",    Chance = 100},
    {Name = "Ruby",    Chance = 50 },
    {Name = "Diamond", Chance = 25 },
    {Name = "Golden",  Chance = 10 },
}
local MUTATION_MULTIPLIERS = {Normal=1,Golden=2,Diamond=3,Ruby=4,Neon=5}

local ItemManager = {}

local function getMutation(): string
    for _, m in ipairs(MUTATIONS) do
        if math.random(1, m.Chance) == 1 then return m.Name end
    end
    return "Normal"
end

local function getItemRadius(model: Model): number
    local size = model:GetExtentsSize()
    return math.max(math.max(size.X, size.Z)/2, MIN_ITEM_RADIUS)
end

local function setupItemGUI(target: Instance, level: number?)
    local rootPart: BasePart?
    if target:IsA("Model") then
        if not (target :: Model).PrimaryPart then
            local found = target:FindFirstChild("Handle") or target:FindFirstChildWhichIsA("BasePart")
            if found then (target :: Model).PrimaryPart = found :: BasePart else return end
        end
        rootPart = (target :: Model).PrimaryPart
    elseif target:IsA("Tool") then
        rootPart = target:FindFirstChild("Handle") :: BasePart
    end
    if not rootPart then return end

    local existing = target:FindFirstChild("InfoGUI")
    if existing then existing:Destroy() end

    local infoGui = InfoGUI_Template:Clone()
    infoGui.Name  = "InfoGUI"
    local labelsFrame = infoGui:WaitForChild("TextLabels")
    local lblEarnings = labelsFrame:WaitForChild("Earnings")  :: TextLabel
    local lblRarity   = labelsFrame:WaitForChild("Rarity")    :: TextLabel
    local lblName     = labelsFrame:WaitForChild("Name")      :: TextLabel
    local lblMutation = labelsFrame:WaitForChild("Mutation")  :: TextLabel

    local lblTimer = labelsFrame:FindFirstChild("Timer") :: TextLabel?
    if lblTimer then
        lblTimer.Visible = target:GetAttribute("IsSpawnedItem") == true
        if lblTimer.Visible then lblTimer.Text = "--:--" end
    end

    local itemName     = target:GetAttribute("OriginalName") :: string
    local rarityName   = target:GetAttribute("Rarity")       :: string
    local mutationName = target:GetAttribute("Mutation")     :: string

    lblName.Text = itemName or "?"

    local itemData    = ItemConfigurations.GetItemData(itemName)
    local baseIncome  = itemData and itemData.Income or 0
    local mutMult     = MUTATION_MULTIPLIERS[mutationName] or 1
    local lvl         = level or 1
    lblEarnings.Text  = "+" .. NumberFormatter.Format(baseIncome * mutMult * (INCOME_SCALING ^ (lvl-1))) .. "/s"

    local rarityConfig = RarityConfigurations[rarityName]
    if rarityConfig then
        lblRarity.Text = rarityConfig.DisplayName
        lblRarity.TextColor3 = rarityConfig.TextColor
        local s = lblRarity:FindFirstChild("Stroke") :: UIStroke?
        if s then s.Color = rarityConfig.StrokeColor; s.Thickness = rarityConfig.StrokeThickness end
        local g = lblRarity:FindFirstChild("Gradient") :: UIGradient?
        if g then g.Enabled = rarityConfig.GradientColor ~= nil; if g.Enabled then g.Color = rarityConfig.GradientColor end end
    end

    local mutationConfig = MutationConfigurations[mutationName]
    if mutationConfig then
        lblMutation.Text = mutationConfig.DisplayName
        lblMutation.TextColor3 = mutationConfig.TextColor
        local s = lblMutation:FindFirstChild("Stroke") :: UIStroke?
        if s then s.Color = mutationConfig.StrokeColor; s.Thickness = mutationConfig.StrokeThickness end
        local g = lblMutation:FindFirstChild("Gradient") :: UIGradient?
        if g then g.Enabled = mutationConfig.GradientColor ~= nil; if g.Enabled then g.Color = mutationConfig.GradientColor end end
    end

    infoGui.Adornee = rootPart
    infoGui.Parent  = target
end

function ItemManager.GiveItemToPlayer(player: Player, itemName: string, mutation: string, rarity: string, level: number?)
    local mutFolder  = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
    local template   = mutFolder and mutFolder:FindFirstChild(itemName)
    if not template and mutation ~= "Normal" then
        template = ItemsFolder.Normal:FindFirstChild(itemName)
    end
    if not template then
        warn("[ItemManager] No template for:", itemName, mutation)
        return
    end

    local lvl  = level or 1
    local tool = Instance.new("Tool")
    tool.Name  = mutation ~= "Normal" and (mutation.." "..itemName) or itemName
    tool.CanBeDropped  = false
    tool.RequiresHandle = true
    tool:SetAttribute("OriginalName", itemName)
    tool:SetAttribute("Mutation",     mutation)
    tool:SetAttribute("Rarity",       rarity)
    tool:SetAttribute("Level",        lvl)

    local cloneModel = template:Clone() :: Model
    tool.Grip = CFrame.Angles(0, math.rad(180), 0)

    local handle = cloneModel.PrimaryPart or cloneModel:FindFirstChildWhichIsA("BasePart")
    if not handle then
        handle = Instance.new("Part"); handle.Size = Vector3.new(1,1,1); handle.Transparency = 1; handle.Parent = cloneModel
    end
    handle.Name = "Handle"

    for _, p in ipairs(cloneModel:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Massless = true; p.CanCollide = false; p.Anchored = false
            if p ~= handle then
                local w = Instance.new("WeldConstraint"); w.Part0 = handle; w.Part1 = p; w.Parent = handle
            end
        end
    end
    for _, child in ipairs(cloneModel:GetChildren()) do child.Parent = tool end

    -- Discovery tracking
    local DataManager = require(script.Parent.Parent.Handlers.DataManager)
    local data = DataManager.get(player)
    if data then
        if not data.DiscoveredItems then data.DiscoveredItems = {} end
        local key = mutation .. "_" .. itemName
        if not data.DiscoveredItems[key] then
            data.DiscoveredItems[key] = true
            local refresh = game:GetService("ReplicatedStorage").Events:FindFirstChild("RefreshIndex")
            if refresh then refresh:FireClient(player) end
        end
    end

    setupItemGUI(tool, lvl)
    tool.Parent = player:WaitForChild("Backpack")
end

function ItemManager.SpawnVisualItem(parentPart: BasePart, itemName: string, mutation: string, rarity: string, level: number)
    local mutFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
    local template  = mutFolder and mutFolder:FindFirstChild(itemName)
    if not template and mutation ~= "Normal" then
        template = ItemsFolder.Normal:FindFirstChild(itemName)
    end
    if not template then return end

    local model = template:Clone() :: Model
    model.Name  = "VisualItem"
    model:SetAttribute("OriginalName", itemName)
    model:SetAttribute("Mutation",     mutation)
    model:SetAttribute("Rarity",       rarity)
    model:SetAttribute("Level",        level)

    for _, p in ipairs(model:GetDescendants()) do
        if p:IsA("BasePart") then p.Anchored = true; p.CanCollide = false end
    end

    local extents = model:GetExtentsSize()
    model:PivotTo(parentPart.CFrame + Vector3.new(0, extents.Y/2, 0))
    model.Parent = parentPart
    setupItemGUI(model, level)
end

function ItemManager.SpawnForPart(spawnerPart: BasePart)
    local rarityName = SPAWNER_RARITY[spawnerPart.Name]
    if not rarityName then return end
    local possibleItems = ItemConfigurations.GetItemsByRarity(rarityName)
    if #possibleItems == 0 then return end

    local existingPositions = {}
    local currentCount = 0
    for _, child in ipairs(spawnerPart:GetChildren()) do
        if child:GetAttribute("IsSpawnedItem") == true and child:IsA("Model") then
            currentCount += 1
            local origin = child:GetPivot().Position
            table.insert(existingPositions, {Pos=origin, Radius=getItemRadius(child :: Model)})
        end
    end

    local toSpawn = ITEMS_PER_SPAWNER - currentCount
    if toSpawn <= 0 then return end

    local sz  = spawnerPart.Size
    local scf = spawnerPart.CFrame

    for _ = 1, toSpawn do
        local randomItem = possibleItems[math.random(1, #possibleItems)]
        local mutation   = getMutation()
        local mutFolder  = ItemsFolder:FindFirstChild(mutation)
        local template   = mutFolder and mutFolder:FindFirstChild(randomItem)
        if not template then
            local nf = ItemsFolder:FindFirstChild("Normal")
            if nf then template = nf:FindFirstChild(randomItem) end
        end
        if not template then continue end

        local temp      = template:Clone() :: Model
        local newRadius = getItemRadius(temp)
        local extents   = temp:GetExtentsSize()
        temp:Destroy()

        local finalCF: CFrame? = nil
        for _ = 1, MAX_RETRIES do
            local xL = sz.X/2 - newRadius
            local zL = sz.Z/2 - newRadius
            if xL < 0 then xL = 0 end
            if zL < 0 then zL = 0 end
            local rx = math.random(-math.floor(xL*10), math.floor(xL*10))/10
            local rz = math.random(-math.floor(zL*10), math.floor(zL*10))/10
            local topY = sz.Y/2
            local testPos = scf:PointToWorldSpace(Vector3.new(rx, topY, rz))
            local overlap = false
            for _, e in ipairs(existingPositions) do
                local fd = (Vector3.new(testPos.X,0,testPos.Z)-Vector3.new(e.Pos.X,0,e.Pos.Z)).Magnitude
                if fd < newRadius+e.Radius+OVERLAP_PADDING then overlap=true; break end
            end
            if not overlap then
                finalCF = CFrame.new(testPos)*scf.Rotation*CFrame.Angles(0,math.rad(math.random(0,360)),0)
                break
            end
        end

        if finalCF then
            local newItem = template:Clone() :: Model
            newItem.Name  = "SpawnedItem"
            newItem:SetAttribute("IsSpawnedItem", true)
            newItem:SetAttribute("OriginalName",  randomItem)
            newItem:SetAttribute("Rarity",        rarityName)
            newItem:SetAttribute("Mutation",      mutation)
            newItem:SetAttribute("Level",         1)
            -- Make spawned brainrot fully static so cars/players can pass
            -- through without knocking it around.
            for _, part in ipairs(newItem:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                    part.CanCollide = false
                    part.CanTouch = false
                end
            end
            newItem.Parent = spawnerPart

            local yOff = extents.Y/2
            newItem:PivotTo(finalCF + Vector3.new(0, yOff, 0))
            table.insert(existingPositions, {Pos=finalCF.Position, Radius=newRadius})
            setupItemGUI(newItem, 1)

            local lifeTime = math.random(RECYCLE_MIN_TIME, RECYCLE_MAX_TIME)
            newItem:SetAttribute("ExpiresAt", workspace:GetServerTimeNow() + lifeTime)

            task.delay(lifeTime, function()
                if newItem and newItem.Parent then
                    newItem:Destroy()
                    ItemManager.SpawnForPart(spawnerPart)
                end
            end)

            if newItem.PrimaryPart then
                local prompt = Instance.new("ProximityPrompt")
                prompt.ObjectText     = randomItem
                prompt.ActionText     = "Pick Up"
                prompt.KeyboardKeyCode = Enum.KeyCode.E
                prompt.RequiresLineOfSight = false
                prompt.HoldDuration   = 0
                prompt.MaxActivationDistance = 8
                prompt.Style = Enum.ProximityPromptStyle.Custom
                prompt.Parent = newItem.PrimaryPart

                prompt.Triggered:Connect(function(player: Player)
                    if not newItem or not newItem.Parent then return end
                    -- Route through CarrySystem so item visually welds to head
                    -- and is only converted to a tool when the player reaches
                    -- the CollectionZone. Fallback to direct give if CarrySystem
                    -- isn't available for some reason.
                    local CarrySystem = _G.__CarrySystem
                    if CarrySystem then
                        local ok = CarrySystem.AddItemToCarry(player, randomItem, mutation, rarityName)
                        if not ok then
                            local notif = game:GetService("ReplicatedStorage").Events:FindFirstChild("ShowNotification")
                            if notif then notif:FireClient(player, "Carry Full!", "Error") end
                            return
                        end
                    else
                        ItemManager.GiveItemToPlayer(player, randomItem, mutation, rarityName, 1)
                    end
                    newItem:Destroy()
                    ItemManager.SpawnForPart(spawnerPart)
                end)
            end
        end
    end
end

function ItemManager.SpawnAllItems()
    for _, spawner in ipairs(SpawnersFolder:GetChildren()) do
        if spawner:IsA("BasePart") then
            ItemManager.SpawnForPart(spawner :: BasePart)
        end
    end
end

return ItemManager
