-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

v1[10563114921] = 107778070777162
v1[10650210095] = 135851379034158
v1[10737944401] = 121856883734174

local v2 = {}

v2[10563114921] = 133470009013038
v2[10650210095] = 117867539925583
v2[10737944401] = 99280404043876

local function inUniverse(v3) -- line 16
    return game.GameId == v3
end

local function fillsRole(v4) -- line 20
    local PlaceIds = (nil).PlaceIds
    if PlaceIds == nil then
        return false
    end
    return PlaceIds[v4] == game.PlaceId
end

local function placesFor(v5) -- line 25 | captures: v1, v2
    local v6 = v1[v5]
    if v6 == nil then
        return nil
    end
    return {
        Default = v6,
        NewPlayerServer = v2[v5]
    }
end

local v7 = {}
local GameId = game.GameId
local v8 = v1[GameId]

if v8 == nil then
    v7.PlaceIds = nil
else
    v7.PlaceIds = {
        Default = v8,
        NewPlayerServer = v2[GameId]
    }
end

function v7.GetPlaceIds() -- line 41
    return (nil).PlaceIds
end

function v7.IsDevPlace() -- line 44
    return game.GameId == 10650210095
end

function v7.IsTestPlace() -- line 48
    return game.GameId == 10737944401
end

function v7.IsDefaultPlace() -- line 52
    local PlaceIds = (nil).PlaceIds
    if PlaceIds == nil then
        return false
    end
    return PlaceIds.Default == game.PlaceId
end

function v7.IsNewPlayerServer() -- line 57
    local PlaceIds = (nil).PlaceIds
    if PlaceIds == nil then
        return false
    end
    return PlaceIds.NewPlayerServer == game.PlaceId
end

return v7
