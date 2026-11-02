-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local v1 = {}

local function getUserId(v2) -- line 9 | captures: Players, v1
    if v1[v2] then
        return v1[v2]
    end
    if Players:FindFirstChild(v2) then
        v1[v2] = Players[v2].UserId
        return Players[v2].UserId
    end
    local v3, v4 = pcall(Players.GetUserIdFromNameAsync, Players, v2)
    if v3 then
        v1[v2] = v4
        return v4
    end
    return nil
end

local v5 = {
    DisplayName = "Full Player Name",
    Prefixes = "# integer"
}

function v5.Transform(v6) -- line 28 | captures: Util, Players
    return v6, Util.MakeFuzzyFinder(Players:GetPlayers())(v6)
end

function v5.ValidateOnce(v7) -- line 32 | captures: Players, v1
    local v8
    if v1[v7] then
        v8 = v1[v7]
    elseif Players:FindFirstChild(v7) then
        v1[v7] = Players[v7].UserId
        v8 = Players[v7].UserId
    else
        local v9
        v9, v8 = pcall(Players.GetUserIdFromNameAsync, Players, v7)
        if v9 then
            v1[v7] = v8
        else
            v8 = nil
        end
    end
    return v8 ~= nil, "No player with that name could be found."
end

function v5.Autocomplete(v10, v11) -- line 52 | captures: Util
    return Util.GetNames(v11)
end

function v5.Parse(v12) -- line 55 | captures: Players, v1
    if v1[v12] then
        return v1[v12]
    end
    if Players:FindFirstChild(v12) then
        v1[v12] = Players[v12].UserId
        return Players[v12].UserId
    end
    local v13, v14 = pcall(Players.GetUserIdFromNameAsync, Players, v12)
    if v13 then
        v1[v12] = v14
        return v14
    end
    return nil
end

local function Default(v15) -- line 71
    return v15.Name
end

v5.Default = Default
v5.ArgumentOperatorAliases = {
    me = ".",
    all = "*",
    others = "**",
    random = "?"
}
return function(v16) -- line 76 | captures: Util, v5
    v16:RegisterType("playerId", v5)
    v16:RegisterType("playerIds", Util.MakeListableType(v5, { Prefixes = "# integers" }))
end
