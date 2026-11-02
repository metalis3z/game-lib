local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local mapsFolder = ReplicatedStorage:FindFirstChild("Maps")
local mapVoteModel = Workspace:FindFirstChild("MapVote")
local mapBoards = mapVoteModel and mapVoteModel:FindFirstChild("MapBoards")
local mapVotePads = mapVoteModel and mapVoteModel:FindFirstChild("MapVotePads")
local votingStatus = mapVoteModel and mapVoteModel:FindFirstChild("VotingStatus")
local mapVoteEvent = ReplicatedStorage.Remotes:FindFirstChild("MapVoteEvent")

local VOTING_TIME = 15
local RANDOM_MAP_OPTION = true
local currentCandidates = {}
local votes = {}
local playerVotes = {}
local lastVoteTime = {}
local DEFAULT_THUMBNAIL = "rbxassetid://4562931890"
local ANTI_SPAM_TIME = 1
local RECENTLY_PLAYED_LIMIT = 4
local recentlyPlayedMaps = {}
local votingCallbacks = {OnVotingStarted = {}, OnVotingEnded = {}}

local function getVotingPower(player)
    return 1
end

local function getMapWeight(map)
    local weightValue = map:FindFirstChild("Weight")
    if weightValue and weightValue:IsA("NumberValue") and weightValue.Value > 0 then
        return weightValue.Value
    end
    return 1
end

local function getMapWaveLimit(map)
    -- Check MapValues folder first
    local mapValues = map:FindFirstChild("MapValues")
    if mapValues then
        local waveLimitValue = mapValues:FindFirstChild("WaveLimit")
        if waveLimitValue then
            if waveLimitValue:IsA("IntValue") then
                return waveLimitValue.Value
            elseif waveLimitValue:IsA("StringValue") then
                local n = tonumber(waveLimitValue.Value)
                if n and n > 0 then return n end
            end
        end
        -- Also check MaxWave in MapValues
        local maxWaveValue = mapValues:FindFirstChild("MaxWave")
        if maxWaveValue and maxWaveValue:IsA("IntValue") then
            return maxWaveValue.Value
        end
    end
    
    -- Check direct children as fallback
    local waveLimitValue = map:FindFirstChild("WaveLimit")
    if waveLimitValue then
        if waveLimitValue:IsA("IntValue") then
            return waveLimitValue.Value
        elseif waveLimitValue:IsA("StringValue") then
            local n = tonumber(waveLimitValue.Value)
            if n and n > 0 then return n end
        end
    end
    
    -- Check MaxWave as fallback
    local maxWaveValue = map:FindFirstChild("MaxWave")
    if maxWaveValue and maxWaveValue:IsA("IntValue") then
        return maxWaveValue.Value
    end
    
    return nil
end

local function getCandidateCount()
    local boardCount = 0
    if mapBoards then
        for _, obj in mapBoards:GetChildren() do
            if obj:IsA("BasePart") or obj:IsA("Model") then
                boardCount = boardCount + 1
            end
        end
    end
    local mapCount = mapsFolder and #mapsFolder:GetChildren() or 0
    if RANDOM_MAP_OPTION then
        return math.min(boardCount, mapCount + 1)
    else
        return math.min(boardCount, mapCount)
    end
end

local function isRecentlyPlayed(map)
    for i, v in recentlyPlayedMaps do
        if v == map.Name then return true end
    end
    return false
end

local function weightedRandomMap()
    local allMaps = mapsFolder and mapsFolder:GetChildren() or {}
    local weights = {}
    local totalWeight = 0
    for i, map in allMaps do
        if not isRecentlyPlayed(map) then
            local w = getMapWeight(map)
            weights[#weights+1] = {map = map, weight = w}
            totalWeight = totalWeight + w
        end
    end
    if #weights == 0 then
        for i, map in allMaps do
            local w = getMapWeight(map)
            weights[#weights+1] = {map = map, weight = w}
            totalWeight = totalWeight + w
        end
    end
    local pick = math.random() * totalWeight
    local accum = 0
    for i, entry in weights do
        accum = accum + entry.weight
        if pick <= accum then
            return entry.map
        end
    end
    return allMaps[math.random(1, #allMaps)]
end

local function updateBoards()
    if not mapBoards then return end
    for i = 1, #currentCandidates do
        local board = mapBoards:FindFirstChild("Map"..i)
        local candidate = currentCandidates[i]
        if not candidate then continue end
        if board then
            local gui = board:FindFirstChild("MapGui")
            if gui then
                local nameLabel = gui:FindFirstChild("MapName")
                local imageLabel = gui:FindFirstChild("MapImage")
                local creatorLabel = gui:FindFirstChild("CreatorName")
                local descLabel = gui:FindFirstChild("MapDescription")
                local categoryLabel = gui:FindFirstChild("Category")
                local featuredLabel = gui:FindFirstChild("Featured")
                local lastPlayedLabel = gui:FindFirstChild("LastPlayed")
                local waveLimitLabel = gui:FindFirstChild("WaveLimit")
                if candidate.map == "RANDOM" then
                    if nameLabel then nameLabel.Text = "Random Map" end
                    if imageLabel then imageLabel.Image = DEFAULT_THUMBNAIL end
                    if creatorLabel then creatorLabel.Text = "By: ???" end
                    if descLabel then descLabel.Text = "A random map will be chosen!" end
                    if categoryLabel then categoryLabel.Text = "Any" end
                    if featuredLabel then featuredLabel.Visible = false end
                    if lastPlayedLabel then lastPlayedLabel.Text = "" end
                    if waveLimitLabel then waveLimitLabel.Text = "" end
                elseif candidate.map then
                    if nameLabel then nameLabel.Text = candidate.map.Name end
                    
                    local mapValues = candidate.map:FindFirstChild("MapValues")
                    
                    if imageLabel then
                        local thumbValue = mapValues and mapValues:FindFirstChild("Thumbnail")
                        imageLabel.Image = (thumbValue and thumbValue:IsA("StringValue") and thumbValue.Value ~= "") and thumbValue.Value or DEFAULT_THUMBNAIL
                    end
                    if creatorLabel then
                        local creatorValue = mapValues and mapValues:FindFirstChild("Creator")
                        creatorLabel.Text = (creatorValue and creatorValue:IsA("StringValue") and creatorValue.Value ~= "") and ("By: " .. creatorValue.Value) or "By: Unknown"
                    end
                    if descLabel then
                        local descValue = mapValues and mapValues:FindFirstChild("Description")
                        descLabel.Text = (descValue and descValue:IsA("StringValue") and descValue.Value ~= "") and descValue.Value or "No description available."
                    end
                    if categoryLabel then
                        local catValue = mapValues and mapValues:FindFirstChild("Category")
                        categoryLabel.Text = (catValue and catValue:IsA("StringValue") and catValue.Value ~= "") and catValue.Value or "Uncategorized"
                    end
                    if featuredLabel then
                        local featValue = mapValues and mapValues:FindFirstChild("Featured")
                        featuredLabel.Visible = featValue and featValue:IsA("BoolValue") and featValue.Value
                    end
                    if lastPlayedLabel then
                        local lastPlayedValue = candidate.map:FindFirstChild("LastPlayed")
                        lastPlayedLabel.Text = (lastPlayedValue and lastPlayedValue:IsA("StringValue") and lastPlayedValue.Value ~= "") and ("Last played: " .. lastPlayedValue.Value) or ""
                    end
                    if waveLimitLabel then
                        local limit = getMapWaveLimit(candidate.map)
                        waveLimitLabel.Text = limit and ("Wave Limit: " .. tostring(limit)) or ""
                    end
                end
            end
        end
    end
end

local function getTotalVotes()
    local total = 0
    for i = 1, #currentCandidates do
        total = total + (votes[i] or 0)
    end
    return total
end

local function getVotersPerMap()
    local voters = {}
    for i = 1, #currentCandidates do voters[i] = {} end
    for userId, voteIndex in playerVotes do
        local player = Players:GetPlayerByUserId(userId)
        if player and voteIndex >= 1 and voteIndex <= #currentCandidates then
            table.insert(voters[voteIndex], player.Name)
        end
    end
    return voters
end

local function updateVotePads()
    if not mapVotePads then return end
    local totalVotes = getTotalVotes()
    local votersPerMap = getVotersPerMap()
    for i = 1, #currentCandidates do
        local pad = mapVotePads:FindFirstChild("MapVote"..i)
        if pad then
            local gui = pad:FindFirstChild("VotedGui")
            if gui then
                local amount = gui:FindFirstChild("VotedAmount")
                if amount then
                    local count = votes[i] or 0
                    local percent = totalVotes > 0 and math.floor((count / totalVotes) * 100 + 0.5) or 0
                    local names = votersPerMap[i] and #votersPerMap[i] > 0 and ("\n" .. table.concat(votersPerMap[i], ", ")) or ""
                    amount.Text = tostring(count) .. " (" .. tostring(percent) .. "%)" .. names
                end
            end
        end
    end
    mapVoteEvent:FireAllClients("UpdateVotes", votes, totalVotes, playerVotes)
end

local function resetVotes()
    votes = {}
    for i = 1, #currentCandidates do votes[i] = 0 end
    playerVotes = {}
    lastVoteTime = {}
    updateVotePads()
end

local function setStatus(text)
    local gui = votingStatus and votingStatus:FindFirstChild("StatusGui")
    if gui then
        local label = gui:FindFirstChild("Status")
        if label then label.Text = text end
    end
    mapVoteEvent:FireAllClients("Status", text)
end

local function blinkPadColors(color, times, delay)
    if not mapVotePads then return end
    for n = 1, times do
        for i = 1, 4 do
            local pad = mapVotePads:FindFirstChild("MapVote"..i)
            if pad and pad:IsA("BasePart") then pad.Color = color end
        end
        task.wait(delay)
        for i = 1, 4 do
            local pad = mapVotePads:FindFirstChild("MapVote"..i)
            if pad and pad:IsA("BasePart") then pad.Color = Color3.fromRGB(255,255,255) end
        end
        task.wait(delay)
    end
end

local function setPadColors(color)
    if not mapVotePads then return end
    for i = 1, 4 do
        local pad = mapVotePads:FindFirstChild("MapVote"..i)
        if pad and pad:IsA("BasePart") then pad.Color = color end
    end
end

local function registerVote(player, voteIndex)
    if typeof(voteIndex) ~= "number" or voteIndex < 1 or voteIndex > #currentCandidates then
        mapVoteEvent:FireClient(player, "Error", "Invalid vote index!")
        return
    end
    local userId = player.UserId
    local now = os.clock()
    if lastVoteTime[userId] and now - lastVoteTime[userId] < ANTI_SPAM_TIME then
        mapVoteEvent:FireClient(player, "Error", "Please wait before voting again!")
        return
    end
    lastVoteTime[userId] = now

    local previousVote = playerVotes[userId]
    if previousVote == voteIndex then
        mapVoteEvent:FireClient(player, "Error", "You already voted for this map!")
        return
    end
    if previousVote then
        votes[previousVote] = math.max(0, (votes[previousVote] or 1) - 1)
    end
    playerVotes[userId] = voteIndex
    votes[voteIndex] = (votes[voteIndex] or 0) + 1
    updateVotePads()
    mapVoteEvent:FireClient(player, "Success", "Vote registered!")
end

local function fireVotingCallbacks(eventName, ...)
    for i, callback in votingCallbacks[eventName] do
        if typeof(callback) == "function" then callback(...) end
    end
end

local function startVoting()
    local candidateCount = getCandidateCount()
    currentCandidates = {}
    local assignRandomToIndex = RANDOM_MAP_OPTION and candidateCount >= 4 and 4 or nil
    local allMaps = mapsFolder and mapsFolder:GetChildren() or {}
    local availableMaps = {}
    for i, map in allMaps do
        if not isRecentlyPlayed(map) then
            table.insert(availableMaps, map)
        end
    end
    if #availableMaps < candidateCount - (RANDOM_MAP_OPTION and 1 or 0) then
        availableMaps = allMaps
    end
    local usedMaps = {}
    for i = 1, candidateCount do
        if assignRandomToIndex and i == assignRandomToIndex then
            currentCandidates[i] = {map = "RANDOM"}
        else
            local tries, idx = 0, nil
            repeat
                idx = math.random(1, #availableMaps)
                tries = tries + 1
                if tries > 50 then break end
            until not usedMaps[idx]
            usedMaps[idx] = true
            currentCandidates[i] = {map = availableMaps[idx]}
            if not currentCandidates[i].map then
                local fallbackIdx = math.random(1, #allMaps)
                currentCandidates[i].map = allMaps[fallbackIdx]
            end
        end
    end
    for i = 1, candidateCount do
        if not currentCandidates[i] then
            local allMapsList = mapsFolder and mapsFolder:GetChildren() or {}
            currentCandidates[i] = #allMapsList > 0 and {map = allMapsList[math.random(1, #allMapsList)]} or {map = "RANDOM"}
        end
    end
    if RANDOM_MAP_OPTION and not assignRandomToIndex and candidateCount > 0 then
        local foundRandom = false
        for i, candidate in currentCandidates do
            if candidate.map == "RANDOM" then foundRandom = true break end
        end
        if not foundRandom then table.insert(currentCandidates, {map = "RANDOM"}) end
    end
    resetVotes()
    updateBoards()
    setStatus("🟢 Voting started!")
    fireVotingCallbacks("OnVotingStarted", currentCandidates)
    blinkPadColors(Color3.fromRGB(0,255,0), 2, 0.15)
    setPadColors(Color3.fromRGB(0,255,0))
    local padConnections = {}
    for i = 1, #currentCandidates do
        local pad = mapVotePads and mapVotePads:FindFirstChild("MapVote"..i)
        if pad then
            padConnections[i] = pad.Touched:Connect(function(hit)
                local player = Players:GetPlayerFromCharacter(hit.Parent)
                if player then registerVote(player, i) end
            end)
        end
    end
    local remoteConn
    remoteConn = mapVoteEvent.OnServerEvent:Connect(function(player, action, param)
        if action == "Vote" then registerVote(player, param)
        end
    end)
    for t = VOTING_TIME, 1, -1 do
        setStatus("Voting ends in "..t.."s")
        task.wait(1)
    end
    for i = 1, #currentCandidates do
        if padConnections[i] then padConnections[i]:Disconnect() end
    end
    if remoteConn then remoteConn:Disconnect() end
    setStatus("🔴 Voting ended!")
    blinkPadColors(Color3.fromRGB(255,0,0), 2, 0.15)
    setPadColors(Color3.fromRGB(255,0,0))
    task.wait(1)
    updateVotePads()
    fireVotingCallbacks("OnVotingEnded", votes, playerVotes, currentCandidates)
    -- Voting summary
    local summary = "Voting Results:\n"
    local totalVotes = getTotalVotes()
    for i = 1, #currentCandidates do
        local candidate = currentCandidates[i]
        local name = candidate.map == "RANDOM" and "Random Map" or (candidate.map and candidate.map.Name or "Unknown")
        local count = votes[i] or 0
        local percent = totalVotes > 0 and math.floor((count / totalVotes) * 100 + 0.5) or 0
        summary = summary .. name .. ": " .. count .. " votes (" .. percent .. "%)\n"
    end
    setStatus(summary)
    task.wait(2)
end

local function getWinningCandidate()
    local maxVotes = -1
    local winnerIndices = {}
    for i = 1, #currentCandidates do
        if votes[i] > maxVotes then
            maxVotes = votes[i]
            winnerIndices = {i}
        elseif votes[i] == maxVotes then
            table.insert(winnerIndices, i)
        end
    end
    if #winnerIndices == 0 then
        local idx = math.random(1, #currentCandidates)
        return currentCandidates[idx]
    elseif #winnerIndices == 1 then
        return currentCandidates[winnerIndices[1]]
    else
        local randomIndex = winnerIndices[math.random(1, #winnerIndices)]
        return currentCandidates[randomIndex]
    end
end

local function updateLastPlayed(map)
    if not map or typeof(map) ~= "Instance" then return end
    local now = os.date("%Y-%m-%d %H:%M:%S")
    local lastPlayedValue = map:FindFirstChild("LastPlayed")
    if not lastPlayedValue then
        lastPlayedValue = Instance.new("StringValue")
        lastPlayedValue.Name = "LastPlayed"
        lastPlayedValue.Parent = map
    end
    lastPlayedValue.Value = now
end

local function addRecentlyPlayed(map)
    if not map or typeof(map) ~= "Instance" then return end
    table.insert(recentlyPlayedMaps, 1, map.Name)
    while #recentlyPlayedMaps > RECENTLY_PLAYED_LIMIT do
        table.remove(recentlyPlayedMaps)
    end
end

return {
    StartVoting = function()
        startVoting()
        local winner = getWinningCandidate()
        local chosenMap = winner.map
        if chosenMap == "RANDOM" then
            chosenMap = weightedRandomMap()
        end
        updateLastPlayed(chosenMap)
        addRecentlyPlayed(chosenMap)
        local winnerMsg = "🏆 Winning Map: " .. (chosenMap and chosenMap.Name or "Unknown") .. "!\n"
        winnerMsg = winnerMsg .. "Get ready for the next round!"
        setStatus(winnerMsg)
        mapVoteEvent:FireAllClients("Winner", chosenMap and chosenMap.Name or "Unknown")
        task.wait(2)
        return chosenMap
    end,
    GetCandidates = function() return currentCandidates end,
    GetVotersPerMap = getVotersPerMap,
    OnVotingStarted = function(callback) table.insert(votingCallbacks.OnVotingStarted, callback) end,
    OnVotingEnded = function(callback) table.insert(votingCallbacks.OnVotingEnded, callback) end,
    GetRecentlyPlayed = function() return recentlyPlayedMaps end,
    GetVotingPower = getVotingPower
}
