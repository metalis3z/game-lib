-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local v1 = {}

local function extractAssetId(v2) -- line 11
    local v3 = string.match(v2, "%d+")
    local v4 = if v3 == nil then false else v3 ~= ""
    local v5 = ("Invalid treadmill media asset id \"%*\""):format(v2)
    assert(v4, v5)
    return v3
end

function v1.GetMediaKey(v6) -- line 17 | captures: t
    t.strict(t.table)(v6)
    if v6.Kind == "Video" then
        local Video = v6.Video
        local v7 = string.match(Video, "%d+")
        local v8 = if v7 == nil then false else v7 ~= ""
        local v9 = ("Invalid treadmill media asset id \"%*\""):format(Video)
        assert(v8, v9)
        return (("Video:%*"):format(v7))
    end
    local Image = v6.Image
    local v10 = string.match(Image, "%d+")
    local v11 = if v10 == nil then false else v10 ~= ""
    local v12 = ("Invalid treadmill media asset id \"%*\""):format(Image)
    assert(v11, v12)
    return (("Image:%*"):format(v10))
end

function v1.BuildMediaKeys(v13) -- line 34 | captures: t, v1
    t.strict(t.table)(v13)
    local v14 = {}
    local v15 = {}
    for v16, v17 in ipairs(v13) do
        local v18 = v1.GetMediaKey(v17)
        if not v15[v18] then
            v15[v18] = true
            table.insert(v14, v18)
        end
    end
    return v14, v15
end

function v1.GetMediaKeyShardIndex(v19, v20) -- line 49 | captures: t
    t.strict(t.string)(v19)
    t.strict(t.intersection(t.integer, t.numberPositive))(v20)
    local v21 = #v19
    local v22 = 0
    for v23 = 1, v21 do
        v22 = (v22 * 33 + string.byte(v19, v23)) % v20
    end
    return v22
end

return v1
