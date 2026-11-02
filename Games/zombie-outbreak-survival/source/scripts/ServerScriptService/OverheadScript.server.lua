local Players = game:GetService("Players")
local groupId = 33816915 -- Replace with your actual group ID

-- Emoji mapping for stats
local statEmojis = {
    Level = "🔥",
    Wins = "🏆",
    Kills = "💀",
}

-- Function to get player stats in compact format
local function getPlayerStats(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local level = leaderstats:FindFirstChild("Levels")
        local wins = leaderstats:FindFirstChild("Wins")
        local kills = leaderstats:FindFirstChild("Kills")
        local statsText = {}
        if level then
            table.insert(statsText, statEmojis.Level .. ":" .. tostring(level.Value))
        end
        if wins then
            table.insert(statsText, statEmojis.Wins .. ":" .. tostring(wins.Value))
        end
        if kills then
            table.insert(statsText, statEmojis.Kills .. ":" .. tostring(kills.Value))
        end
        if #statsText > 0 then
            return table.concat(statsText, "/")
        end
    end
    return "No stats"
end

local function updateOverhead(player, character)
    local head = character:FindFirstChild("Head")
    if not head then return end

    -- Remove any previous overheads
    for _, gui in head:GetChildren() do
        if gui:IsA("BillboardGui") and gui.Name == "Tag" then
            gui:Destroy()
        end
    end

    -- Find the BillboardGui template from ServerScriptService
    local tagTemplate = script:FindFirstChild("Tag")
    if not tagTemplate then return end

    local newTag = tagTemplate:Clone()
    newTag.Parent = head
    newTag.Adornee = head

    -- Set PlayerName with emoji
    local playerNameLabel = newTag:FindFirstChild("PlayerName")
    if playerNameLabel then
        playerNameLabel.Text = "👤 " .. player.Name
    end

    -- Set GroupRank with emoji
    local groupRankLabel = newTag:FindFirstChild("GroupRank")
    if groupRankLabel then
        local rank = player:GetRoleInGroup(groupId)
        groupRankLabel.Text = "🎖️ " .. (rank ~= "" and rank or "No Rank")
    end

    -- Set PlayerStats with compact Level/Wins/Kills format
    local playerStatsLabel = newTag:FindFirstChild("PlayerStats")
    if playerStatsLabel then
        playerStatsLabel.Text = getPlayerStats(player)
    end

    -- Auto-update stats when Level, Wins, or Kills change
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local function connectStat(statName)
            local stat = leaderstats:FindFirstChild(statName)
            if stat then
                stat.Changed:Connect(function()
                    if playerStatsLabel then
                        playerStatsLabel.Text = getPlayerStats(player)
                    end
                end)
            end
        end
        connectStat("Levels")
        connectStat("Wins")
        connectStat("Kills")
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        updateOverhead(player, character)
    end)
    -- Listen for leaderstats being added after player joins
    player.ChildAdded:Connect(function(child)
        if child.Name == "leaderstats" then
            if player.Character then
                updateOverhead(player, player.Character)
            end
        end
    end)
end)

-- For players already in game
for _, player in Players:GetPlayers() do
    if player.Character then
        updateOverhead(player, player.Character)
    end
    player.CharacterAdded:Connect(function(character)
        updateOverhead(player, character)
    end)
    player.ChildAdded:Connect(function(child)
        if child.Name == "leaderstats" then
            if player.Character then
                updateOverhead(player, player.Character)
            end
        end
    end)
end