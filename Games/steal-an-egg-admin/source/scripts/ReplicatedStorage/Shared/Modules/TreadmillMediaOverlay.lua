-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local t = require(ReplicatedStorage.Packages.t)

local function typecheckAssertion(v1) -- line 11
    return function(v2) -- line 12 | captures: v1
        local v3, v4 = v1(v2)
        assert(v3, v4)
        return v2
    end
end

local function typecheckChecker(v5) -- line 19
    return function(v6) -- line 20 | captures: v5
        local v7, v8 = pcall(v5, v6)
        if v7 then
            return v7, nil
        end
        return v7, (tostring(v8))
    end
end

require(ReplicatedStorage.Shared.Globals.Constants)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillMediaCatalog = require(ReplicatedStorage.Data.TreadmillMediaCatalog)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Media = require(ReplicatedStorage.Shared.TreadmillVideoController.Media)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local v9 = {
    Brainrot = true,
    Funny = true,
    Satisfying = true,
    WeirdOrHorror = true,
    Music = true
}
local boolean = t.boolean
local v10 = FastFlags.Replicated("Game.TreadmillDynamicMedia.Enabled", function(v11) -- line 44 | captures: boolean
    local v12, v13 = boolean(v11)
    assert(v12, v13)
    return v11
end, true)
local v14 = 0
local v15 = {}
local v16 = {}
local v17 = {}
local v18 = {}
local v19
local v20 = {}
for v21, v22 in ipairs(Media) do
    if v22.Disabled == true then
        v20[TreadmillMediaIdentity.GetMediaKey(v22)] = true
    end
end
local v23 = { Changed = Signal.new() }

local function sanitizeAddition(v24) -- line 64 | captures: v9
    if type(v24) == "table" and v24.Kind == "Video" then
        local Video = v24.Video
        if type(Video) == "string" then
            local MediaKey = v24.MediaKey
            if type(MediaKey) == "string" and v24.MediaKey ~= "" then
                local BucketType = v24.BucketType
                if type(BucketType) == "string" and v9[v24.BucketType] == true then
                    local Duration = v24.Duration
                    if type(Duration) == "number" and not (v24.Duration <= 0) then
                        local AddedAt = v24.AddedAt
                        if type(AddedAt) == "number" then
                            local AddedBy = v24.AddedBy
                            if type(AddedBy) == "number" then
                                if v24.CoverImage == nil then
                                    return {
                                        Kind = "Video",
                                        MediaKey = v24.MediaKey,
                                        Video = v24.Video,
                                        CoverImage = v24.CoverImage,
                                        BucketType = v24.BucketType,
                                        Duration = v24.Duration,
                                        AddedAt = v24.AddedAt,
                                        AddedBy = v24.AddedBy
                                    }
                                end
                                local CoverImage = v24.CoverImage
                                if type(CoverImage) == "string" then
                                    return {
                                        Kind = "Video",
                                        MediaKey = v24.MediaKey,
                                        Video = v24.Video,
                                        CoverImage = v24.CoverImage,
                                        BucketType = v24.BucketType,
                                        Duration = v24.Duration,
                                        AddedAt = v24.AddedAt,
                                        AddedBy = v24.AddedBy
                                    }
                                end
                                return nil
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function compareAdditions(v25, v26) -- line 94
    if v25.AddedAt == v26.AddedAt then
        return v25.MediaKey < v26.MediaKey
    end
    return v25.AddedAt < v26.AddedAt
end

local function applySanitizedSnapshot(v27) -- line 103 | captures: v14, v15, v16, v17, TreadmillMediaCatalog, v18, v23
    v14 = v27.Revision
    v15 = v27.Additions
    v17 = {}
    for v28 in pairs(v27.Exclusions) do
        v17[v28] = true
    end
    v16 = {}
    for v29, v30 in ipairs(v15) do
        v16[v30.MediaKey] = v30
    end
    for v31, v32 in ipairs(v15) do
        local v33 = TreadmillMediaCatalog.CURRENT_RELEASE_VERSION + v31
        local v34 = v18[v32.MediaKey]
        if v34 == nil then
            v18[v32.MediaKey] = {
                Kind = "Video",
                ReleaseVersion = v33,
                BucketType = v32.BucketType,
                Video = v32.Video,
                CoverImage = v32.CoverImage,
                Duration = v32.Duration
            }
        else
            v34.ReleaseVersion = v33
        end
    end
    v23.Changed:Fire()
end

function v23.SanitizeSnapshot(v35) -- line 133 | captures: sanitizeAddition, compareAdditions
    if type(v35) == "table" then
        local Revision = v35.Revision
        if type(Revision) == "number" and not (v35.Revision < 0) then
            local v36 = {}
            local v37 = {}
            local Additions = v35.Additions
            if type(Additions) == "table" then
                for v38, v39 in ipairs(v35.Additions) do
                    local v40 = sanitizeAddition(v39)
                    if v40 ~= nil and not v37[v40.MediaKey] then
                        v37[v40.MediaKey] = true
                        table.insert(v36, v40)
                    end
                end
            end
            table.sort(v36, compareAdditions)
            local v41 = {}
            local Exclusions = v35.Exclusions
            if type(Exclusions) == "table" then
                for v42, v43 in pairs(v35.Exclusions) do
                    if type(v42) == "string" and type(v43) == "table" then
                        local v44 = {}
                        local At = v43.At
                        if type(At) == "number" then
                            v44.At = v43.At
                        else
                            v44.At = 0
                        end
                        local By = v43.By
                        if type(By) == "number" then
                            v44.By = v43.By
                        else
                            v44.By = 0
                        end
                        v41[v42] = v44
                    end
                end
            end
            local v45 = {}
            local Revision = v35.Revision
            v45.Revision = math.floor(Revision)
            v45.Additions = v36
            v45.Exclusions = v41
            return v45
        end
    end
    return nil
end

function v23.ApplySnapshot(v46) -- line 178 | captures: v14, v19, v10, v23, applySanitizedSnapshot
    local v47 = v23.SanitizeSnapshot(v46)
    if v47 ~= nil then
        v19 = v47
        if v10:Get() and v47.Revision ~= v14 then
            applySanitizedSnapshot(v47)
        end
    end
end

function v23.ApplyTo(v48) -- line 189 | captures: v15, TreadmillMediaIdentity, v18
    if #v15 == 0 then
        return 0
    end
    local v49 = {}
    for v50, v51 in ipairs(v48) do
        v49[TreadmillMediaIdentity.GetMediaKey(v51)] = true
    end
    local v52 = 0
    for v53, v54 in ipairs(v15) do
        if not v49[v54.MediaKey] then
            v49[v54.MediaKey] = true
            local v55 = v18[v54.MediaKey]
            table.insert(v48, v55)
            v52 += 1
        end
    end
    return v52
end

function v23.IsExcluded(v56) -- line 209 | captures: v17, v10, v20
    if v20[v56] then
        return true
    end
    if v10:Get() then
        return v17[v56] == true
    end
    return false
end

function v23.GetCurrentReleaseVersion() -- line 219 | captures: v15, TreadmillMediaCatalog
    return TreadmillMediaCatalog.CURRENT_RELEASE_VERSION + #v15
end

function v23.GetRevision() -- line 222 | captures: v14
    return v14
end

function v23.GetAdditionByKey(v57) -- line 225 | captures: v16
    return v16[v57]
end

function v23.GetAdditions() -- line 228 | captures: v15
    return v15
end

function v23.GetEntryByKey(v58) -- line 231 | captures: v18
    return v18[v58]
end

function v23.GetReplicationSnapshot() -- line 234 | captures: v19
    return v19
end

v10.Changed:Connect(function() -- line 237 | captures: v14, v19, v10, applySanitizedSnapshot
    local v59 = v19
    if v10:Get() and v59 ~= nil and v59.Revision ~= v14 then
        applySanitizedSnapshot(v59)
    end
end)

if RunService:IsClient() then
    require(ReplicatedStorage.Shared.Remotes).Treadmill.OverlaySnapshot.OnClientEvent:Connect(function(v60) -- line 244 | captures: v23
        v23.ApplySnapshot(v60)
    end)
end
return v23
