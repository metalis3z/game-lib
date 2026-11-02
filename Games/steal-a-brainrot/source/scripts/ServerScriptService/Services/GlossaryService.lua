
local GlossaryService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local OpenRemote = Net:RemoteEvent("GlossaryService/Open")
local CloseRemote = Net:RemoteEvent("GlossaryService/Close")

-- Counts how many of each animal currently exist across all online players' bases,
-- broken down by mutation ("Default" = no mutation). This powers the "X Exist"
-- label in the Glossary UI.
local function computeExistCounts()
    local counts = {}

    for _, player in ipairs(Players:GetPlayers()) do
        local channel = Synchronizer:Get(player)
        if channel then
            local ok, animalPodiums = pcall(function()
                return channel:Get("AnimalPodiums")
            end)

            if ok and animalPodiums then
                for _, podium in pairs(animalPodiums) do
                    if type(podium) == "table" and podium.Index then
                        local entry = counts[podium.Index]
                        if not entry then
                            entry = { mutations = {} }
                            counts[podium.Index] = entry
                        end

                        local mutationKey = podium.Mutation or "Default"
                        entry.mutations[mutationKey] = (entry.mutations[mutationKey] or 0) + 1
                    end
                end
            end
        end
    end

    return counts
end

-- Exposed to clients via RemoteFunction so the Glossary UI can show real exist counts
-- instead of always falling back to 0 (previously this RemoteFunction did not exist).
local GetAnimalExistsRemote = ReplicatedStorage:FindFirstChild("GetAnimalExists")
if not GetAnimalExistsRemote then
    GetAnimalExistsRemote = Instance.new("RemoteFunction")
    GetAnimalExistsRemote.Name = "GetAnimalExists"
    GetAnimalExistsRemote.Parent = ReplicatedStorage
end

GetAnimalExistsRemote.OnServerInvoke = function(_player)
    local ok, result = pcall(computeExistCounts)
    if ok then
        return result
    end
    warn("[GlossaryService] Failed to compute exist counts:", result)
    return {}
end

function GlossaryService.GetExistCount(animal: string, mutation: string?)
    local counts = computeExistCounts()
    local entry = counts[animal]
    if not entry then
        return 0
    end
    return entry.mutations[mutation or "Default"] or 0
end

function GlossaryService.Open(player: Player)
    OpenRemote:FireClient(player)
end

function GlossaryService.Close(player: Player)
    CloseRemote:FireClient(player)
end

return GlossaryService