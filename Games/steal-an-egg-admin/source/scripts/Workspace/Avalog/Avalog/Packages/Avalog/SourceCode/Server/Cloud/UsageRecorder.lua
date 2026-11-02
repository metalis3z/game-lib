-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local Parent = script.Parent.Parent.Parent.Parent
require(Parent.SourceCode.Shared.Types)
local Sift = require(Parent.Parent.Sift)
local v1 = {
    ServerStartTime = os.time(),
    Sessions = {}
}

function v1.Start(v2) -- line 28 | captures: Players
    Players.PlayerAdded:Connect(function(v3) -- line 29 | captures: v2
        v2:_NewSession(v3.UserId)
    end)
    for v4, v5 in Players:GetPlayers() do
        v2:_NewSession(v5.UserId)
    end
    Players.PlayerRemoving:Connect(function(v6) -- line 36 | captures: v2
        local v7 = v2:_FindLastSession(v6.UserId)
        if v7 ~= nil then
            v7.EndTime = os.time()
            v2:RecordMenuToggle(v6.UserId, false)
        end
    end)
end

function v1._NewSession(v8, v9) -- line 45
    if v8:_FindLastSession(v9) ~= nil then
        return
    end
    local Sessions = v8.Sessions
    local v10 = {
        UserId = v9,
        StartTime = os.time(),
        MenuSessions = {}
    }
    table.insert(Sessions, v10)
end

function v1._FindLastSession(v11, v12) -- line 57
    local v13 = #v11.Sessions
    for v14 = v13, 1, -1 do
        local v15 = v11.Sessions[v14]
        if v15.UserId == v12 then
            return v15
        end
    end
end

function v1.RecordMenuToggle(v16, v17, v18) -- line 67
    local v19 = v16:_FindLastSession(v17)
    if v19 == nil then
        return
    end
    if v18 then
        local MenuSessions = v19.MenuSessions
        local v20 = { StartTime = os.time() }
        table.insert(MenuSessions, v20)
    else
        local v21 = v19.MenuSessions[#v19.MenuSessions]
        if v21 == nil or v21.EndTime ~= nil then
            return
        end
        v21.EndTime = os.time()
    end
end

function v1.CompileSnapshot(v22) -- line 89 | captures: Sift
    local v23 = {}
    local GameId = game.GameId
    v23.experienceId = tostring(GameId)
    local PlaceId = game.PlaceId
    v23.placeId = tostring(PlaceId)
    v23.jobId = game.JobId
    v23.uptime = os.time() - v22.ServerStartTime
    v23.totalMenuOpens = Sift.Array.reduce(v22.Sessions, function(v24, v25) -- line 95
        return v24 + #v25.MenuSessions
    end, 0)
    v23.totalMenuTime = Sift.Array.reduce(v22.Sessions, function(v26, v27) -- line 98 | captures: Sift
        return v26 +
            Sift.Array.reduce(v27.MenuSessions, function(v28, v29) -- line 100
                if v29.StartTime and v29.EndTime then
                    return v28 + (v29.EndTime - v29.StartTime)
                end
                return v28
            end, 0)
    end, 0)
    v23.totalUserSessions = #v22.Sessions
    v23.totalUserPlaytime = Sift.Array.reduce(v22.Sessions, function(v30, v31) -- line 109
        if v31.StartTime and v31.EndTime then
            return v30 + (v31.EndTime - v31.StartTime)
        end
        return v30
    end, 0)
    return v23
end

function v1.Destroy(v32) -- line 121
end

return v1
