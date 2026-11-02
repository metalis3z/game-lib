--!strict
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace         = game:GetService("Workspace")

local DataManager  = require(script.Parent.DataManager)
local SaveService  = require(ServerScriptService.Modules.SaveService)

local Templates    = ReplicatedStorage:WaitForChild("Templates")
local PlotTemplate = Templates:WaitForChild("Plot")
local PlotsFolder  = Workspace:WaitForChild("Plots")
local Events       = ReplicatedStorage:WaitForChild("Events")

local SlotManager  -- lazy
local UpgradeConfig = require(ReplicatedStorage.Modules.UpgradesConfiguration)

-- Calculate plot upgrade price for a given level using the formula from config
local function getPlotUpgradePrice(level: number): number
	local cfg = UpgradeConfig.Upgrades.BasePlot
	if not cfg then return 0 end
	return math.floor(cfg.BaseCost * (cfg.PriceMultiplier ^ level))
end

local MAX_LEVEL = 2

local occupiedPlots   : {[Player]: number} = {}
local activePlotModels: {[Player]: Model}  = {}

local function getFreePlotIndex(): number?
    for i = 1, 5 do
        local taken = false
        for _, idx in pairs(occupiedPlots) do if idx == i then taken=true; break end end
        if not taken then return i end
    end
    return nil
end

local function initializePlotVisuals(plotModel: Model)
    for _, part in ipairs(plotModel:GetDescendants()) do
        if part:IsA("BasePart") then
            part:SetAttribute("OriginalTransparency", part.Transparency)
            part:SetAttribute("OriginalCanCollide",   part.CanCollide)
        end
    end
end

local function setFloorVisibility(plotModel: Model, floorName: string, visible: boolean)
    local floor = plotModel:FindFirstChild(floorName)
    if not floor then return end
    for _, part in ipairs(floor:GetDescendants()) do
        if part:IsA("BasePart") then
            if visible then
                part.Transparency = part:GetAttribute("OriginalTransparency") or 0
                local oc = part:GetAttribute("OriginalCanCollide")
                part.CanCollide = (oc == nil) and true or oc
            else
                part.Transparency = 1
                part.CanCollide   = false
            end
        end
    end
end

local function updatePlotVisuals(player: Player, baseLevel: number)
    local plotModel = activePlotModels[player]
    if not plotModel then return end

    setFloorVisibility(plotModel, "Floor1", true)
    setFloorVisibility(plotModel, "Floor2", baseLevel >= 1)
    setFloorVisibility(plotModel, "Floor3", baseLevel >= 2)

    plotModel:SetAttribute("BaseLevel",    baseLevel)
    plotModel:SetAttribute("BaseMaxLevel", MAX_LEVEL)

    for _, floor in ipairs(plotModel:GetChildren()) do
        if floor:IsA("Model") and floor.Name:match("Floor%d+") then
            local buyFloor = floor:FindFirstChild("BuyFloor")
            if buyFloor then
                local guiPart = buyFloor:FindFirstChild("GUIPart")
                if guiPart then
                    guiPart:SetAttribute("CurrentLevel", baseLevel)
                    guiPart:SetAttribute("MaxLevel",     MAX_LEVEL)
                    guiPart:SetAttribute("Price",        getPlotUpgradePrice(baseLevel) or 0)
                    guiPart:SetAttribute("OwnerId",      player.UserId)
                end
            end
        end
    end
end

local function spawnPlot(player: Player)
    local index = getFreePlotIndex()
    if not index then warn("[PlotManager] No free plots for "..player.Name); return end
    occupiedPlots[player] = index

    local locator = PlotsFolder:FindFirstChild(tostring(index))
    if not locator then warn("[PlotManager] Locator "..index.." not found"); return end

    local newPlot = PlotTemplate:Clone()
    newPlot.Name  = "Plot_"..player.Name
    newPlot.Parent = Workspace

    local locCF = locator:IsA("BasePart") and locator.CFrame
        or (locator:IsA("Model") and locator.PrimaryPart and locator.PrimaryPart.CFrame)
    if locCF then
        if newPlot.PrimaryPart then newPlot:SetPrimaryPartCFrame(locCF)
        else newPlot:PivotTo(locCF) end
    end

    local spawnPart = newPlot:FindFirstChild("Spawn")
    if spawnPart then
        local plotGui = spawnPart:FindFirstChildWhichIsA("BillboardGui")
        if plotGui then plotGui.Enabled = false end
    end

    initializePlotVisuals(newPlot)
    activePlotModels[player] = newPlot

    local data = DataManager.get(player)
    local baseLevel = (data and type(data.BaseLevel) == "number") and data.BaseLevel or 0
    updatePlotVisuals(player, baseLevel)

    if not SlotManager then SlotManager = require(ServerScriptService.Handlers.SlotManager) end
    SlotManager.MonitorPlot(player, newPlot)

    task.delay(0.5, function()
        SaveService.RestoreSlots(player, newPlot)
    end)

    print("[PlotManager] Spawned plot "..index.." for "..player.Name)
end

local function handleCharacterSpawn(player: Player, character: Model)
    local plotModel = activePlotModels[player]
    if plotModel then
        local spawnPart = plotModel:FindFirstChild("Spawn") :: BasePart
        local target    = spawnPart or plotModel.PrimaryPart
        if target then
            local hrp = character:WaitForChild("HumanoidRootPart", 5) :: BasePart
            if hrp then hrp.CFrame = target.CFrame + Vector3.new(0,4,0) end
        end
    end
end

Players.PlayerAdded:Connect(function(player: Player)
    local tries = 0
    repeat task.wait(0.5); tries+=1 until DataManager.get(player) ~= nil or tries > 20
    spawnPlot(player)
    task.delay(1, function() SaveService.RestoreInventory(player) end)
    player.CharacterAdded:Connect(function(char) task.wait(0.1); handleCharacterSpawn(player, char) end)
    if player.Character then task.spawn(handleCharacterSpawn, player, player.Character) end
end)

Players.PlayerRemoving:Connect(function(player: Player)
    if activePlotModels[player] then
        activePlotModels[player]:Destroy()
        activePlotModels[player] = nil
    end
    occupiedPlots[player] = nil
end)

-- Base upgrade
local requestUpgrade = Events:WaitForChild("RequestBaseUpgrade")
requestUpgrade.OnServerEvent:Connect(function(player: Player)
    local data = DataManager.get(player)
    if not data then return end
    local currentLevel = data.BaseLevel or 0
    if currentLevel >= MAX_LEVEL then
        local notif = Events:FindFirstChild("ShowNotification")
        if notif then notif:FireClient(player, "Base already maxed!", "Error") end
        return
    end
    local price = getPlotUpgradePrice(currentLevel) or 0
    local money = DataManager.getMoney(player)
    if money < price then
        local notif = Events:FindFirstChild("ShowNotification")
        if notif then notif:FireClient(player, "Not enough money!", "Error") end
        return
    end
    DataManager.addMoney(player, -price)
    data.BaseLevel = currentLevel + 1
    updatePlotVisuals(player, data.BaseLevel)
    local notif = Events:FindFirstChild("ShowNotification")
    if notif then notif:FireClient(player, "Base upgraded to Floor "..(data.BaseLevel+1).."!", "Info") end
end)

-- KillPart teleport
task.spawn(function()
    local map       = Workspace:FindFirstChild("Map")
    local blackHole = map and map:FindFirstChild("BlackHole")
    local killPart  = blackHole and blackHole:FindFirstChild("KillPart")
    if killPart then
        local debounce: {[Player]: boolean} = {}
        killPart.Touched:Connect(function(hit)
            local char   = hit.Parent
            local player = Players:GetPlayerFromCharacter(char)
            if not player or debounce[player] then return end
            debounce[player] = true
            local hrp       = char:FindFirstChild("HumanoidRootPart") :: BasePart
            local plotModel = activePlotModels[player]
            if hrp and plotModel then
                local target = plotModel:FindFirstChild("Spawn") :: BasePart or plotModel.PrimaryPart
                if target then
                    hrp.CFrame = target.CFrame + Vector3.new(0,5,0)
                    local notif = Events:FindFirstChild("ShowNotification")
                    if notif then notif:FireClient(player, "You fell into the void!", "Error") end
                end
            end
            task.delay(2, function() debounce[player] = nil end)
        end)
        print("[PlotManager] KillPart teleport active")
    end
end)

local PlotManager = {}
function PlotManager.GetPlotModel(player: Player): Model?
    return activePlotModels[player]
end
print("[PlotManager] Active")
return PlotManager
