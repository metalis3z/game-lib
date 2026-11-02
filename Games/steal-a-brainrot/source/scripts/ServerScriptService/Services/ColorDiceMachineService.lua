local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local workspace = game:GetService("Workspace")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local ColorDiceMachineService = {}

local StealService = nil
local AnimalService = nil

local DICE_COLORS = {"Red", "Blue", "Green", "Yellow", "Purple", "Orange"}

-- RemoteEvents for client communication
local DeliveryRF  = Net:RemoteFunction("ColorDice/Delivery")   -- hitbox: deliver brainrot into machine
local OpenRE      = Net:RemoteEvent("ColorDice/Open")          -- server tells client to open GUI with animal info
local RollRF      = Net:RemoteFunction("ColorDice/Roll")       -- client sends chosen color, server rolls

-- Players currently in the machine: { [player] = { podiumIndex, animalData } }
local PlayersInMachine = {}

-- ============================================================
-- DELIVERY (called from client when HumanoidRootPart touches hitbox)
-- Exactly like FuseMachineService.Delivery
-- ============================================================
DeliveryRF.OnServerInvoke = function(player, hitbox)
    local channel = Synchronizer:Get(player)
    if not channel then return false end

    local stealData = StealService:GetStealData(player)
    if not stealData or not stealData.StolenAnimalData then return false end

    local animalName = stealData.StolenAnimalData.Index
    local podiums = channel:Get("AnimalPodiums") or {}

    -- Verify player owns the brainrot
    local hasAnimal = false
    for _, v in pairs(podiums) do
        if type(v) == "table" and v.Index == animalName then
            hasAnimal = true; break
        end
    end
    if not hasAnimal then return false end

    -- Already has something in machine
    if PlayersInMachine[player] then return false end

    local originalPodiumIndex = stealData.PodiumIndex
    local animalData = {
        Index    = stealData.StolenAnimalData.Index,
        Mutation = stealData.StolenAnimalData.Mutation,
        Traits   = stealData.StolenAnimalData.Traits,
        LastCollect = stealData.StolenAnimalData.LastCollect,
    }

    -- Mark the podium as in-machine (like FuseMachine does with Machine={Type="Fuse"})
    if originalPodiumIndex and podiums[originalPodiumIndex] then
        local entry = podiums[originalPodiumIndex]
        entry.Machine = { Type = "ColorDice" }
        podiums[originalPodiumIndex] = entry
    end
    channel:Set("AnimalPodiums", podiums)
    channel:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

    -- Cancel the steal (removes carry model, clears Stealing attribute)
    -- Pass NO podiumIndex so it doesn't swap anything
    StealService:CancelSteal(player)

    -- Store in machine
    PlayersInMachine[player] = {
        podiumIndex = originalPodiumIndex,
        animalData  = animalData,
    }

    -- Tell client to open the GUI
    Net:RemoteEvent("ColorDice/Open"):FireClient(player, animalData)

    return true
end

-- ============================================================
-- ROLL (client chose a color, server rolls dice)
-- ============================================================
RollRF.OnServerInvoke = function(player, chosenColor)
    local machineData = PlayersInMachine[player]
    if not machineData then return false, "Pas de brainrot dans la machine" end

    -- Validate color
    local valid = false
    for _, c in ipairs(DICE_COLORS) do if c == chosenColor then valid = true; break end end
    if not valid then return false, "Couleur invalide" end

    -- Roll 3 dice
    local results = {}
    for i = 1, 3 do results[i] = DICE_COLORS[math.random(1, #DICE_COLORS)] end

    -- Win = any die matches chosen color
    local won = false
    for _, r in ipairs(results) do if r == chosenColor then won = true; break end end

    local animalData = machineData.animalData
    local podiumIndex = machineData.podiumIndex
    PlayersInMachine[player] = nil

    local channel = Synchronizer:Get(player)
    if not channel then return false, "Pas de channel" end

    local podiums = channel:Get("AnimalPodiums") or {}

    if won then
        -- Clear the Machine flag from original podium (restore it)
        if podiumIndex and podiums[podiumIndex] and type(podiums[podiumIndex]) == "table" then
            podiums[podiumIndex].Machine = nil
            channel:Set("AnimalPodiums", podiums)
            channel:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
        end
        -- Spawn a duplicate (same brainrot + mutation, no traits)
        AnimalService.spawnAnimalInBase(player, animalData.Index, animalData.Mutation, nil)
    else
        -- Lost: remove the podium entry entirely
        if podiumIndex and podiums[podiumIndex] then
            podiums[podiumIndex] = "Empty"
            channel:Set("AnimalPodiums", podiums)
            channel:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
        end
    end

    return true, results, won, animalData.Index
end

Players.PlayerRemoving:Connect(function(player)
    PlayersInMachine[player] = nil
end)

function ColorDiceMachineService:Load()
    StealService  = require(ServerScriptService.Services.StealService)
    AnimalService = require(ServerScriptService.Services.AnimalService)
end
function ColorDiceMachineService:Start() end

return ColorDiceMachineService
