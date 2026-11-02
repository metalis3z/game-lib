-- AdminLogger - Log TOUTES les commandes admin via Conch + AdminSystem
local RS           = game:GetService("ReplicatedStorage")
local HttpService  = game:GetService("HttpService")
local Players      = game:GetService("Players")

local WEBHOOK = "https://discord.com/api/webhooks/REDACTED"

-- Charger le Config pour vérifier les admins
local Config = {
    Roles = {Lead = {}, Dev = {}, Tester = {}},
    GroupId = 335019207,
    MinGroupRank = 255
}
local ok, cfg = pcall(require, game.ServerScriptService.Services.CommandsService.Config)
if ok and cfg then
    Config = cfg
end

-- Catégories de commandes pour le formatage
local SPAWN = {
    spawnbrainrot=1, spawnglobalbrainrot=1, spawnbrainrotforplayer=1,
    spawnfakeinbase=1, spawnfakebrainrot=1, globalspawnfakeinbase=1,
    spawnrandomserverbrainrot=1, spawnramdommutations=1, spawnrandomog=1,
    spawnluckyblock=1, spawngloballuckyblock=1, spawnluckyblockrandommutation=1,
    spawnluckyblockrandommutations=1, spawnbrainrotcanoe=1,
    spawnbrainrotalltraits=1, spawnbrainrotglobalalltraits=1,
    Spawninboatglobal=1, Globalfakebrainrot=1,
    spawnfakeinbaseforplayer=1, spawnfakebrainrotforplayer=1,
}
local GIVE = {
    addbrainrot=1, addluckyblock=1, addspins=1, globaladdspins=1,
    addluck=1, addgloballuck=1, setmoney=1, setgoldcoins=1, setrebirth=1,
    givemoney=1, giveitem=1, givepernamentitem=1, addrecipe=1,
    addcraftingmachineglobal=1, addtosammysbase=1,
}

-- Fonction pour vérifier si un joueur est admin
local function isAdmin(player)
    if not player then return false end
    
    -- Vérifier les rôles dans le Config
    for role, users in pairs(Config.Roles) do
        for _, userId in ipairs(users) do
            if tonumber(userId) and player.UserId == tonumber(userId) then
                return true, role
            elseif tostring(player.Name) == tostring(userId) then
                return true, role
            end
        end
    end
    
    -- Vérifier le rang du groupe
    if Config.GroupId and Config.MinGroupRank then
        local success, rank = pcall(function()
            return player:GetRankInGroup(Config.GroupId)
        end)
        if success and rank >= Config.MinGroupRank then
            return true, "Lead"
        end
    end
    
    return false, nil
end

-- Queue Discord (rate limit 1 msg / 0.5s)
local queue, sending = {}, false
local function flush()
    if sending or #queue == 0 then return end
    sending = true
    pcall(HttpService.PostAsync, HttpService, WEBHOOK,
        HttpService:JSONEncode(table.remove(queue, 1)),
        Enum.HttpContentType.ApplicationJson)
    task.wait(0.5)
    sending = false
    if #queue > 0 then task.spawn(flush) end
end

local function sendLog(adminName, cmdName, details, cmdType)
    -- cmdType: 1=SPAWN, 2=GIVE, 3=OTHER
    local color, emoji, typeStr
    if cmdType == 1 then
        color, emoji, typeStr = 0x57F287, "🐾", "SPAWN"
    elseif cmdType == 2 then
        color, emoji, typeStr = 0x5865F2, "🎁", "GIVE"
    else
        color, emoji, typeStr = 0xFEE75C, "⚡", "OTHER"
    end

    local fields = {
        {name="👤 Admin",   value=adminName,                                    inline=true},
        {name="📂 Type",    value=emoji.." "..typeStr,                          inline=true},
        {name="⏰ Heure",   value=os.date("%H:%M:%S"),                          inline=true},
    }
    if details and details ~= "" then
        table.insert(fields, {name="📋 Détails", value=details, inline=false})
    end

    table.insert(queue, {
        username="GYK Admin Logs 🛡️",
        embeds={{
            title = emoji.."  `"..cmdName.."`",
            color = color, fields = fields,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        }}
    })
    task.spawn(flush)
    print("[AdminLogger]", adminName, "->", cmdName)
end

local function processCommand(player, cmdName, args)
    if not player or not player.Parent then return end -- pas de warn si pas de joueur
    
    -- Vérifier si le joueur est admin
    local isAdm, role = isAdmin(player)
    if not isAdm then return end
    
    args = args or {}
    cmdName = string.lower(tostring(cmdName or ""))
    
    -- Déterminer le type de commande
    local isSpawn = SPAWN[cmdName] ~= nil
    local isGive  = GIVE[cmdName] ~= nil
    local cmdType = isSpawn and 1 or (isGive and 2 or 3)

    -- Récupérer le vrai nom de l'animal si applicable
    local animalKey = args.brainrot or args.luckyblock or args.animal or
                      (type(args[1])=="string" and args[1]) or ""
    local animalDisplay = animalKey
    if animalKey ~= "" then
        local ok2, Animals = pcall(function() return require(RS.Datas.Animals) end)
        if ok2 and Animals and Animals[animalKey] then
            animalDisplay = Animals[animalKey].DisplayName or animalKey
        end
    end

    local lines = {}
    table.insert(lines, "👤 **Rôle:** "..(role or "Unknown"))
    if animalDisplay ~= "" then table.insert(lines, "🐾 **Animal:** "..animalDisplay) end
    local mut = args.mutation or (type(args[2])=="string" and args[2]) or ""
    if mut ~= "" and mut ~= "Normal" then table.insert(lines, "✨ **Mutation:** "..mut) end
    local target = args.player or (type(args[3])=="string" and args[3]) or ""
    if target ~= "" then table.insert(lines, "🎯 **Cible:** "..target) end
    local amount = tonumber(args.amount) or tonumber(args[4])
    if amount and amount > 1 then table.insert(lines, "🔢 **x"..amount) end
    if args.traits and type(args.traits)=="table" and #args.traits>0 then
        table.insert(lines, "🏷️ **Traits:** "..table.concat(args.traits,", "))
    end
    
    -- Ajouter les arguments bruts si pas de détails spécifiques
    if #lines == 1 and type(args) == "table" then
        local argStr = ""
        for k, v in pairs(args) do
            if type(v) == "string" or type(v) == "number" then
                argStr = argStr .. tostring(k) .. "=" .. tostring(v) .. ", "
            end
        end
        if argStr ~= "" then
            table.insert(lines, "📋 **Args:** " .. argStr:sub(1, -3))
        end
    end

    local adminName = player.DisplayName.." (@"..player.Name..")"
    sendLog(adminName, cmdName, table.concat(lines, "\n"), cmdType)
end

-- ══ HOOK 1: Conch on_command_run ══
local Conch = require(RS.Packages.Conch)

-- Fonction pour extraire le player du contexte Conch
local function getPlayerFromContext(ctx)
    -- Méthode 1: ctx.player ou ctx.executor
    local cp = rawget(ctx, "player") or rawget(ctx, "executor")
    if cp then
        if type(cp) == "string" then
            return Players:FindFirstChild(cp)
        elseif typeof(cp) == "Instance" and cp:IsA("Player") then
            return cp
        end
    end
    
    -- Méthode 2: ctx.user -> Conch.get_player()
    local user = rawget(ctx, "user")
    if user and Conch.get_player then
        local plr = Conch.get_player(user)
        if plr then return plr end
    end
    
    -- Méthode 3: Parcourir les joueurs et trouver celui avec ce user
    if user then
        for _, plr in ipairs(Players:GetPlayers()) do
            local u = Conch.get_user and Conch.get_user(plr)
            if u == user then
                return plr
            end
        end
    end
    
    return nil
end

-- Fonction pour extraire le nom de la commande
local function getCommandName(ctx)
    local cmd = rawget(ctx, "name") or rawget(ctx, "command") or rawget(ctx, "cmd")
    if type(cmd) == "string" and cmd ~= "" then
        return cmd
    end
    
    -- Essayer de parser le contexte
    local s = tostring(ctx)
    cmd = s:match('"name":"([^"]+)"') or s:match('"command":"([^"]+)"') or ""
    return cmd
end

-- Fonction pour extraire les arguments
local function getArguments(ctx)
    local args = rawget(ctx, "args") or rawget(ctx, "arguments") or rawget(ctx, "params") or {}
    return args
end

Conch.on_command_run(function(ctx)
    task.spawn(function()
        local player = getPlayerFromContext(ctx)
        if not player then
            -- Debug: afficher le contexte si pas de player trouvé
            print("[AdminLogger] Pas de player trouvé, ctx:", tostring(ctx))
            return
        end
        
        local cmd = getCommandName(ctx)
        if cmd == "" then
            print("[AdminLogger] Pas de commande trouvée pour", player.Name)
            return
        end
        
        local args = getArguments(ctx)
        
        print("[AdminLogger] Commande reçue:", player.Name, "->", cmd)
        processCommand(player, cmd, args)
    end)
end)

-- ══ HOOK 2: AdminSystem.ExecuteCommand (panel admin custom) ══
task.spawn(function()
    local AdminSystem = RS:FindFirstChild("AdminSystem")
    if AdminSystem then
        local EC = AdminSystem:FindFirstChild("ExecuteCommand")
        if EC then
            EC.OnServerEvent:Connect(function(player, command, args)
                print("[AdminLogger] AdminSystem cmd:", player.Name, "->", tostring(command))
                task.spawn(processCommand, player, tostring(command or ""), args or {})
            end)
            print("[AdminLogger] ✅ Hook AdminSystem actif")
        else
            warn("[AdminLogger] ExecuteCommand non trouvé dans AdminSystem")
        end
    else
        warn("[AdminLogger] AdminSystem non trouvé")
    end
end)

print("[AdminLogger] ✅ Actif - Logging TOUTES les commandes admin (Conch + AdminSystem)")
print("[AdminLogger] Admins configurés:", #Config.Roles.Lead or 0, "Leads")
