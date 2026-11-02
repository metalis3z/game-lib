local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Animals    = require(ReplicatedStorage.Datas.Animals)
local Mutations  = require(ReplicatedStorage.Datas.Mutations)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local PlotService  = require(ServerScriptService.Services.PlotService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local MSG_TYPE = "SpawnLuckyBlockRandomMutation"

-- Poids des mutations
local MUTATION_WEIGHTS = {
    Normal = 40, Gold = 50, Diamond = 25,
    Rainbow = 10, Radioactive = 8, Candy = 6,
    Galaxy = 5, Cursed = 4, Lava = 3,
    YinYang = 2, Bloodrot = 2, Divine = 1,
}

local function getRandomMutation(rng)
    local total = 0
    for _, w in pairs(MUTATION_WEIGHTS) do total += w end
    local r = (rng and rng:NextNumber() or math.random()) * total
    local cumul = 0
    for name, weight in pairs(MUTATION_WEIGHTS) do
        cumul += weight
        if r <= cumul then return name end
    end
    return "Gold"
end

-- Liste des lucky blocks disponibles (pour random)
local LB_LIST = {
    "Secret Lucky Block", "Brainrot God Lucky Block", "Mythic Lucky Block",
    "Heart Lucky Block", "Premium Heart Lucky Block", "Festive Lucky Block",
    "Premium Festive Lucky Block", "Leprechaun Lucky Block", "Premium Leprechaun Lucky Block",
	"Los Lucky Blocks", "Taco og Lucky Block", "OG Lucky Block", "Los Taco Blocks",
    "Spooky Lucky Block", "Admin Lucky Block",
}

local function getRandomLuckyBlock(rng)
    local idx = rng and math.floor(rng:NextNumber() * #LB_LIST) + 1 or math.random(#LB_LIST)
    return LB_LIST[math.clamp(idx, 1, #LB_LIST)]
end

local function giveLuckyBlock(player, lbName, mutation)
    local ch = Synchronizer:Get(player)
    if not ch then return false end

    local freePodium = PlotService.getFreePodium(player)
    if not freePodium then
        -- File d'attente
        local pending = ch:Get("PendingSpinRewards") or {}
        table.insert(pending, {
            Index    = lbName,
            Mutation = mutation,
            Timer    = LuckyBlocks[lbName] and 0 or nil,
        })
        ch:Set("PendingSpinRewards", pending)
        NotificationService.Notify(player,
            string.format("🎲 Base pleine ! <b>%s</b> [%s] sera donné dès qu'un podium se libère.", lbName, mutation), 7)
        return true
    end

    local podiumIndex = tonumber(freePodium.Name)
    if not podiumIndex then return false end

    local AnimalPodiums = ch:Get("AnimalPodiums") or {}
    AnimalPodiums[podiumIndex] = {
        Index       = lbName,
        LastCollect = os.time(),
        Mutation    = mutation,
        Traits      = nil,
        Timer       = LuckyBlocks[lbName] and 0 or nil,
    }
    ch:Set("AnimalPodiums", AnimalPodiums)
    ch:Set("AnimalAddedOrRemoved", true)
    return true
end

-- Handler cross-server
local function registerHandler()
    if not _G.MessagingHub then return end
    _G.MessagingHub.Register(MSG_TYPE, function(data)
        if typeof(data) ~= "table" then return end
        local Probability = tonumber(data.Probability)
        local Seed = data.Seed
        if not Probability or not Seed then return end

        -- Tirage unique par serveur
        local serverSeed = Seed + tonumber(game.JobId:sub(1,8), 16) % 100000
        local rng = Random.new(serverSeed)
        if rng:NextNumber() > Probability then return end

        -- Lucky block et mutation aléatoires pour CE serveur
        local lbName   = data.LuckyBlock or getRandomLuckyBlock(rng)
        local mutation = data.Mutation or getRandomMutation(rng)

        -- Donner à tous les joueurs du serveur
        for _, player in ipairs(Players:GetPlayers()) do
            local ok = pcall(giveLuckyBlock, player, lbName, mutation)
            if ok then
                NotificationService.Success(player,
                    string.format("🎲 Lucky Block <b>%s</b> [<font color=\"#ffd13b\">%s</font>] ajouté à ta base !",
                        lbName, mutation))
            end
        end
    end)
end

task.spawn(function()
    while not _G.MessagingHub do task.wait(0.5) end
    registerHandler()
end)

-- MODULE
local module = function(Conch, Config)
    Conch.register("spawnluckyblockrandommutations", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return
                { kind = "argument", type = "LuckyBlock", name = "Lucky Block", optional = true },
                { kind = "argument", type = "number",     name = "Amount",      optional = true }
        end,
        callback = function(lbName, amount)
            amount = math.clamp(tonumber(amount) or 1, 1, 1000)

            -- Vérifier le lucky block si spécifié
            if lbName and lbName ~= "" and not Animals[lbName] then
                return false, "Lucky Block '" .. tostring(lbName) .. "' introuvable"
            end

            local probability = math.min(1, amount / math.max(1, amount * 2))
            local seed = math.random(1, 2^30)

            -- Spawn sur CE serveur aussi
            local serverRng = Random.new(seed + tonumber(game.JobId:sub(1,8), 16) % 100000)
            if serverRng:NextNumber() <= probability then
                local lb  = lbName ~= "" and lbName or getRandomLuckyBlock(serverRng)
                local mut = getRandomMutation(serverRng)
                for _, player in ipairs(Players:GetPlayers()) do
                    pcall(giveLuckyBlock, player, lb, mut)
                    NotificationService.Success(player,
                        string.format("🎲 Lucky Block <b>%s</b> [<font color=\"#ffd13b\">%s</font>] ajouté !",
                            lb, mut))
                end
            end

            -- Broadcaster
            if _G.MessagingHub then
                _G.MessagingHub.Publish(MSG_TYPE, {
                    LuckyBlock  = lbName ~= "" and lbName or nil,
                    Probability = probability,
                    Seed        = seed,
                })
            end

            local lb_display = (lbName ~= "" and lbName) or "Random Lucky Block"
            return string.format("✅ %s [mutation random] → ~%d serveurs (%.1f%%)",
                lb_display, amount, probability * 100)
        end,
    })
end

return module
