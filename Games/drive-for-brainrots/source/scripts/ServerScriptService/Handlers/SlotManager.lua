--!strict
local Players           = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")

local DataManager        = require(script.Parent.DataManager)
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local NumberFormatter    = require(ReplicatedStorage.Modules.NumberFormatter)

local Templates               = ReplicatedStorage:WaitForChild("Templates")
local UpgradeGUI_Template     = Templates:WaitForChild("UpgradeGUI")
local CollectGUI_Template     = Templates:WaitForChild("CollectGUI")
local Events                  = ReplicatedStorage:WaitForChild("Events")

local ItemManager  -- lazy

local UPGRADE_COST_MULTIPLIER = 1.5
local INTERACTION_COOLDOWN    = 0.6
local INCOME_SCALING          = 1.125
local INCOME_TICK             = 1

local MUTATION_MULTIPLIERS = {
    Normal=1, Golden=2, Diamond=3, Ruby=4, Neon=5,
}

local slotData: {[Player]: {[string]: {[string]: any}}} = {}

local SlotManager = {}

local function ensureItemManager()
    if not ItemManager then
        ItemManager = require(ServerScriptService.Modules.ItemManager)
    end
    return ItemManager
end

local function getUpgradeCost(baseIncome: number, level: number): number
    return math.floor(baseIncome * 20 * (UPGRADE_COST_MULTIPLIER ^ (level-1)))
end

local function getSlotData(player: Player, floorName: string, slotName: string): any
    if not slotData[player] then slotData[player] = {} end
    if not slotData[player][floorName] then slotData[player][floorName] = {} end
    if not slotData[player][floorName][slotName] then
        slotData[player][floorName][slotName] = {Item=nil, Level=1, Stored=0}
    end
    return slotData[player][floorName][slotName]
end

local function updateSlotVisuals(player: Player, floorName: string, slotName: string, slotModel: Model)
    local sd       = getSlotData(player, floorName, slotName)
    local itemData = sd.Item
    local level    = sd.Level or 1
    local stored   = sd.Stored or 0

    -- CollectGUI
    local collectPart = slotModel:FindFirstChild("CollectTouch") :: BasePart
    if collectPart then
        local gui = collectPart:FindFirstChild("CollectGUI") :: SurfaceGui
        if not gui then
            gui = CollectGUI_Template:Clone()
            gui.Name   = "CollectGUI"
            gui.Parent = collectPart
        end
        local frame = gui:FindFirstChild("CollectFrame")
        local label = frame and frame:FindFirstChild("Price") :: TextLabel
        if itemData then
            gui.Enabled = true
            if label then label.Text = "$"..NumberFormatter.Format(math.floor(stored)) end
        else
            gui.Enabled = false
        end
    end

    -- UpgradeGUI
    local upgradePart = slotModel:FindFirstChild("UpgradePart") :: BasePart
    if upgradePart then
        local gui = upgradePart:FindFirstChild("UpgradeGUI") :: SurfaceGui
        if not gui then
            gui = UpgradeGUI_Template:Clone()
            gui.Name   = "UpgradeGUI"
            gui.Parent = upgradePart
            gui:SetAttribute("SlotName",  slotName)
            gui:SetAttribute("FloorName", floorName)
            gui:SetAttribute("OwnerId",   player.UserId)
        end
        if itemData then
            gui.Enabled = true
            local button = gui:FindFirstChild("UpgradeButton") :: TextButton
            if button then
                local itemConf = ItemConfigurations.GetItemData(itemData.Name)
                local baseInc  = itemConf and itemConf.Income or 10
                local cost     = getUpgradeCost(baseInc, level)
                local lvlLabel = button:FindFirstChild("Levels")  :: TextLabel
                local pricLbl  = button:FindFirstChild("Price")   :: TextLabel
                if lvlLabel then lvlLabel.Text = "Level "..level.." > "..(level+1) end
                if pricLbl  then pricLbl.Text  = "$"..NumberFormatter.Format(cost) end
            end
        else
            gui.Enabled = false
        end
    end

    -- Visual item on Spawn part
    local spawnPart = slotModel:FindFirstChild("Spawn") :: BasePart
    if spawnPart then
        local existing = spawnPart:FindFirstChild("VisualItem")
        if existing then existing:Destroy() end
        if itemData then
            ensureItemManager()
            ItemManager.SpawnVisualItem(spawnPart, itemData.Name, itemData.Mutation, itemData.Rarity, level)
        end
        local prompt = spawnPart:FindFirstChildWhichIsA("ProximityPrompt") :: ProximityPrompt
        if prompt then
            prompt.ActionText = itemData and "Pick Up / Swap" or "Place Item"
        end
    end
end

-- Income loop
local function startIncomeLoop()
    task.spawn(function()
        while true do
            task.wait(INCOME_TICK)
            for player, floors in pairs(slotData) do
                if not player or not player.Parent then slotData[player]=nil; continue end
                for floorName, slots in pairs(floors) do
                    for slotName, sd in pairs(slots) do
                        if sd.Item then
                            local itemConf = ItemConfigurations.GetItemData(sd.Item.Name)
                            local baseInc  = itemConf and itemConf.Income or 0
                            local mutMult  = MUTATION_MULTIPLIERS[sd.Item.Mutation] or 1
                            local lvl      = sd.Level or 1
                            local income   = baseInc * mutMult * (INCOME_SCALING^(lvl-1))
                            sd.Stored = (sd.Stored or 0) + income

                            -- Update GUI label
                            local plotModel = Workspace:FindFirstChild("Plot_"..player.Name)
                            if plotModel then
                                local floor      = plotModel:FindFirstChild(floorName)
                                local slotsF     = floor and floor:FindFirstChild("Slots")
                                local slotModel  = slotsF and slotsF:FindFirstChild(slotName)
                                if slotModel then
                                    local cp  = slotModel:FindFirstChild("CollectTouch") :: BasePart
                                    local gui = cp and cp:FindFirstChild("CollectGUI") :: SurfaceGui
                                    local frame = gui and gui:FindFirstChild("CollectFrame")
                                    local lbl = frame and frame:FindFirstChild("Price") :: TextLabel
                                    if lbl then lbl.Text = "$"..NumberFormatter.Format(math.floor(sd.Stored)) end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

function SlotManager.HandleInteraction(player: Player, floorName: string, slotName: string, slotModel: Model)
    ensureItemManager()
    local sd        = getSlotData(player, floorName, slotName)
    local character = player.Character
    local heldTool  = character and character:FindFirstChildWhichIsA("Tool")
    local heldName  = heldTool and heldTool:GetAttribute("OriginalName")
    local isOccupied = sd.Item ~= nil

    if isOccupied then
        if (sd.Stored or 0) > 0 then
            DataManager.addMoney(player, math.floor(sd.Stored))
            local popup = Events:FindFirstChild("ShowCashPopUp")
            if popup then popup:FireClient(player, math.floor(sd.Stored)) end
            sd.Stored = 0
        end
        ItemManager.GiveItemToPlayer(player, sd.Item.Name, sd.Item.Mutation, sd.Item.Rarity, sd.Level)
        if heldTool and heldName then
            sd.Item   = {Name=heldName, Mutation=heldTool:GetAttribute("Mutation") or "Normal", Rarity=heldTool:GetAttribute("Rarity") or "Common"}
            sd.Level  = heldTool:GetAttribute("Level") or 1
            sd.Stored = 0
            heldTool:Destroy()
        else
            sd.Item=nil; sd.Level=1; sd.Stored=0
        end
    else
        if heldTool and heldName then
            sd.Item   = {Name=heldName, Mutation=heldTool:GetAttribute("Mutation") or "Normal", Rarity=heldTool:GetAttribute("Rarity") or "Common"}
            sd.Level  = heldTool:GetAttribute("Level") or 1
            sd.Stored = 0
            heldTool:Destroy()
        else
            local notif = Events:FindFirstChild("ShowNotification")
            if notif then notif:FireClient(player, "Equip an item to place it!", "Error") end
            return
        end
    end
    updateSlotVisuals(player, floorName, slotName, slotModel)
end

function SlotManager.CollectMoney(player: Player, floorName: string, slotName: string, slotModel: Model)
    local sd = getSlotData(player, floorName, slotName)
    if (sd.Stored or 0) <= 0 then return end
    local amount = math.floor(sd.Stored)
    sd.Stored = 0
    DataManager.addMoney(player, amount)
    updateSlotVisuals(player, floorName, slotName, slotModel)
    local popup = Events:FindFirstChild("ShowCashPopUp")
    if popup then popup:FireClient(player, amount) end
end

local lastUpgradeTime: {[string]: number} = {}
function SlotManager.UpgradeItem(player: Player, floorName: string, slotName: string)
    local key = player.Name.."_"..floorName.."_"..slotName
    local now = tick()
    if lastUpgradeTime[key] and now-lastUpgradeTime[key] < 0.5 then return end
    lastUpgradeTime[key] = now

    local sd = getSlotData(player, floorName, slotName)
    if not sd.Item then return end
    local itemConf = ItemConfigurations.GetItemData(sd.Item.Name)
    local baseInc  = itemConf and itemConf.Income or 10
    local cost     = getUpgradeCost(baseInc, sd.Level)

    if DataManager.getMoney(player) < cost then
        local notif = Events:FindFirstChild("ShowNotification")
        if notif then notif:FireClient(player, "Need $"..NumberFormatter.Format(cost), "Error") end
        return
    end

    DataManager.addMoney(player, -cost)
    sd.Level += 1

    local plotModel = Workspace:FindFirstChild("Plot_"..player.Name)
    if plotModel then
        local floor     = plotModel:FindFirstChild(floorName)
        local slotsF    = floor and floor:FindFirstChild("Slots")
        local slotModel = slotsF and slotsF:FindFirstChild(slotName)
        if slotModel then updateSlotVisuals(player, floorName, slotName, slotModel :: Model) end
    end
end

local function setupSingleSlot(player: Player, floorName: string, slotName: string, slotModel: Model)
    local spawnPart   = slotModel:WaitForChild("Spawn", 5)       :: BasePart
    local upgradePart = slotModel:WaitForChild("UpgradePart", 5) :: BasePart
    local collectPart = slotModel:WaitForChild("CollectTouch", 5) :: BasePart
    if not spawnPart or not upgradePart or not collectPart then
        warn("[SlotManager] Missing parts in slot: "..slotName); return
    end

    if not spawnPart:FindFirstChildWhichIsA("ProximityPrompt") then
        local prompt = Instance.new("ProximityPrompt")
        prompt.ActionText = "Place Item"; prompt.ObjectText = "Slot"
        prompt.RequiresLineOfSight = false; prompt.HoldDuration = 0
        prompt.MaxActivationDistance = 8
        prompt.Style = Enum.ProximityPromptStyle.Custom
        prompt.Parent = spawnPart
        local lastTrigger = 0
        prompt.Triggered:Connect(function(trigPlayer: Player)
            if trigPlayer ~= player then return end
            local n = tick()
            if n-lastTrigger < INTERACTION_COOLDOWN then return end
            lastTrigger = n
            SlotManager.HandleInteraction(player, floorName, slotName, slotModel)
        end)
    end

    if not collectPart:GetAttribute("SlotConnected") then
        collectPart:SetAttribute("SlotConnected", true)
        local db = false
        collectPart.Touched:Connect(function(hit)
            if db then return end
            local char = hit.Parent
            if Players:GetPlayerFromCharacter(char) ~= player then return end
            local hum = char:FindFirstChild("Humanoid")
            if not hum then return end
            db = true
            SlotManager.CollectMoney(player, floorName, slotName, slotModel)
            task.wait(0.5); db = false
        end)
    end

    updateSlotVisuals(player, floorName, slotName, slotModel)
end

local function monitorFloor(player: Player, floorModel: Model)
    local slotsFolder = floorModel:WaitForChild("Slots", 5)
    if not slotsFolder then return end
    for _, slot in ipairs(slotsFolder:GetChildren()) do
        if slot:IsA("Model") then setupSingleSlot(player, floorModel.Name, slot.Name, slot :: Model) end
    end
    slotsFolder.ChildAdded:Connect(function(child)
        if child:IsA("Model") then setupSingleSlot(player, floorModel.Name, child.Name, child :: Model) end
    end)
end

function SlotManager.MonitorPlot(player: Player, plot: Model)
    for _, child in ipairs(plot:GetChildren()) do
        if child:IsA("Model") and child.Name:match("Floor%d+") then monitorFloor(player, child :: Model) end
    end
    plot.ChildAdded:Connect(function(child)
        if child:IsA("Model") and child.Name:match("Floor%d+") then monitorFloor(player, child :: Model) end
    end)
end

function SlotManager.GetSlotDataForPlayer(player: Player): any
    return slotData[player]
end

function SlotManager.RestoreSlot(player: Player, floorName: string, slotName: string, slotModel: Model, saved: any)
    if not saved or not saved.Item then return end
    local sd = getSlotData(player, floorName, slotName)
    sd.Item   = {Name=saved.Item.Name, Mutation=saved.Item.Mutation, Rarity=saved.Item.Rarity}
    sd.Level  = saved.Level or 1
    sd.Stored = saved.Stored or 0
    updateSlotVisuals(player, floorName, slotName, slotModel)
end

-- RequestSlotUpgrade remote
local upgradeEvent = ReplicatedStorage.Events:FindFirstChild("RequestSlotUpgrade")
    or Instance.new("RemoteEvent")
upgradeEvent.Name   = "RequestSlotUpgrade"
upgradeEvent.Parent = ReplicatedStorage.Events

upgradeEvent.OnServerEvent:Connect(function(player: Player, floorName, slotName)
    if type(floorName) ~= "string" or type(slotName) ~= "string" then return end
    SlotManager.UpgradeItem(player, floorName, slotName)
end)

Players.PlayerRemoving:Connect(function(player) slotData[player] = nil end)

startIncomeLoop()
print("[SlotManager] Active")
return SlotManager
