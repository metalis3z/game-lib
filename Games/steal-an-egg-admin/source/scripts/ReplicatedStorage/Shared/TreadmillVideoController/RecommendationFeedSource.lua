-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RecommendationService = game:GetService("RecommendationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local RecommendationFlags = require(script.Parent.RecommendationFlags)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local TreadmillMediaOverlay = require(ReplicatedStorage.Shared.Modules.TreadmillMediaOverlay)
require(script.Parent.Types.Interface)
local v1 = Log.new()
local v2
local v3 = {}
local v4 = {}
local v5 = 0
local v6
local v7 = 0
local v8 = false
local v9 = 0
local v10 = {}

local function buildMediaIndexMap(v11) -- line 21 | captures: v2, v3, TreadmillMediaIdentity
    if v2 == v11 then
        return
    end
    v2 = v11
    v3 = {}
    for v12, v13 in ipairs(v11) do
        local v14 = TreadmillMediaIdentity.GetMediaKey(v13)
        if v3[v14] == nil then
            v3[v14] = v12
        end
    end
end

local function appendCurrentPage(v15) -- line 35 | captures: v3, v4, TreadmillMediaOverlay
    local v16 = v15:GetCurrentPage()
    for v17, v18 in ipairs(v16) do
        local v19 = v3[v18.ReferenceId]
        if v19 ~= nil and not TreadmillMediaOverlay.IsExcluded(v18.ReferenceId) then
            local v20 = v4
            local v21 = {
                MediaIndex = v19,
                MediaKey = v18.ReferenceId,
                ItemId = v18.ItemId,
                TracingId = v18.TracingId,
                ItemPosition = #v4 + 1
            }
            table.insert(v20, v21)
        end
    end
end

local function generateListAsync() -- line 51 | captures: v4, v5, v6, v7, RecommendationService, Constants, RecommendationFlags, v1, appendCurrentPage
    if not Constants.IS_STUDIO and RecommendationFlags.Enabled:Get() then
        local v22, v23 = pcall(function() -- line 56 | captures: v4, v5, v6, v7, RecommendationService, RecommendationFlags, appendCurrentPage
            local v24 = RecommendationService:GenerateItemListAsync({
                LocationId = "TreadmillFeed",
                ConfigName = RecommendationFlags.ConfigName:Get(),
                PageSize = RecommendationFlags.PageSize:Get()
            })
            v4 = {}
            v5 = 0
            v6 = v24
            v7 = os.clock()
            appendCurrentPage(v24)
        end)
        if v22 then
            v1:AtTrace():Log((("Generated treadmill recommendation list: %* items"):format(#v4)))
            return #v4 > 0
        end
        v1:AtWarning():Log((("Failed to generate treadmill recommendation list: %*"):format(v23)))
    end
    return false
end

local function prefetchNextPageAsync() -- line 73 | captures: v6, v8, v9, Constants, RecommendationFlags, v1, appendCurrentPage
    if Constants.IS_STUDIO or not RecommendationFlags.Enabled:Get() or v8 or not (v6 ~= nil) or v6.IsFinished or os.clock() < v9 then
        return
    end
    v8 = true
    task.spawn(function() -- line 78 | captures: v6, v8, v9, RecommendationFlags, v1, appendCurrentPage
        local v25, v26 = pcall(function() -- line 80 | captures: v6, appendCurrentPage
            v6:AdvanceToNextPageAsync()
            appendCurrentPage(v6)
        end)
        v8 = false
        if not v25 then
            v9 = os.clock() + RecommendationFlags.FailureCooldownSeconds:Get()
            v1:AtWarning():Log((("Failed to advance treadmill recommendation page: %*"):format(v26)))
        end
    end)
end

local function maybePrefetch() -- line 91 | captures: v4, v5, RecommendationFlags, prefetchNextPageAsync
    if #v4 - v5 <= RecommendationFlags.PrefetchMargin:Get() then
        prefetchNextPageAsync()
    end
end

local function isSessionUsable() -- line 97 | captures: v4, v7, RecommendationFlags
    if #v4 > 0 then
        return os.clock() - v7 < RecommendationFlags.StaleSeconds:Get()
    end
    return false
end

function v10.PrefetchFeed(v27) -- line 106 | captures: v4, v7, v8, v9, Constants, RecommendationFlags, buildMediaIndexMap, generateListAsync
    buildMediaIndexMap(v27)
    local v28, v29
    if Constants.IS_STUDIO then
        v29 = true
    elseif RecommendationFlags.Enabled:Get() then
        if #v4 > 0 then
            v28 = os.clock() - v7 < RecommendationFlags.StaleSeconds:Get()
        else
            v28 = false
        end
        v29 = false
    else
        v29 = true
    end
    if v29 then
        return
    end
    if v28 or v8 or os.clock() < v9 then
        return
    end
    v8 = true
    task.spawn(function() -- line 121 | captures: v8, v9, RecommendationFlags, generateListAsync
        local v30 = generateListAsync()
        if not v30 then
            task.wait(RecommendationFlags.FetchRetryDelaySeconds:Get())
            v30 = generateListAsync()
        end
        v8 = false
        if not v30 then
            v9 = os.clock() + RecommendationFlags.FailureCooldownSeconds:Get()
        end
    end)
end

function v10.GetReadyItem() -- line 133 | captures: v4, v5, v7, Constants, RecommendationFlags, TreadmillMediaOverlay, prefetchNextPageAsync
    local v31, v32
    if Constants.IS_STUDIO then
        v32 = true
    elseif RecommendationFlags.Enabled:Get() then
        if #v4 > 0 then
            v31 = os.clock() - v7 < RecommendationFlags.StaleSeconds:Get()
        else
            v31 = false
        end
        v32 = false
    else
        v32 = true
    end
    if v32 then
        return nil
    end
    if v31 then
        if v5 == 0 then
            v5 = 1
        end
        local v33 = #v4
        local v34 = v5
        for v35 = v34, v33 do
            local v36 = v4[v35]
            if not (v36 == nil or TreadmillMediaOverlay.IsExcluded(v36.MediaKey)) then
                v5 = v35
                if #v4 - v5 <= RecommendationFlags.PrefetchMargin:Get() then
                    prefetchNextPageAsync()
                end
                return v36
            end
        end
        if #v4 - v5 <= RecommendationFlags.PrefetchMargin:Get() then
            prefetchNextPageAsync()
        end
    end
    return nil
end

function v10.Next() -- line 169 | captures: v4, v5, RecommendationFlags, TreadmillMediaOverlay, prefetchNextPageAsync
    if #v4 ~= 0 then
        local v37 = #v4
        for v38 = 1, v37 do
            v5 += 1
            if #v4 < v5 then
                v5 = 1
            end
            local v39 = v4[v5]
            if not (v39 == nil or TreadmillMediaOverlay.IsExcluded(v39.MediaKey)) then
                if #v4 - v5 <= RecommendationFlags.PrefetchMargin:Get() then
                    prefetchNextPageAsync()
                end
                return v39
            end
        end
        if #v4 - v5 <= RecommendationFlags.PrefetchMargin:Get() then
            prefetchNextPageAsync()
        end
    end
    return nil
end

function v10.Previous() -- line 196 | captures: v4, v5, TreadmillMediaOverlay
    if #v4 == 0 then
        return nil, false
    end
    local v40 = v5 - 1
    for v41 = v40, 1, -1 do
        local v42 = v4[v41]
        if v42 ~= nil and not TreadmillMediaOverlay.IsExcluded(v42.MediaKey) then
            v5 = v41
            return v42, true
        end
    end
    local v43 = v5
    local v44 = #v4
    v5 = math.clamp(v43, 1, v44)
    return v4[v5], false
end

function v10.PeekAhead(v45) -- line 213 | captures: v4, v5, TreadmillMediaOverlay
    local v46 = {}
    local v47 = 0
    while true do
        local v48, v49
        if #v46 < v45 then
            v48 = v47 + 1
            local v50 = v4[v5 + v48]
            if v50 == nil then
                v49 = true
            else
                if not TreadmillMediaOverlay.IsExcluded(v50.MediaKey) then
                    local MediaIndex = v50.MediaIndex
                    table.insert(v46, MediaIndex)
                end
                v49 = false
            end
        else
            v49 = true
        end
        if v49 then
            break
        end
        v47 = v48
    end
    return v46
end

TreadmillMediaOverlay.Changed:Connect(function() -- line 230 | captures: v2
    v2 = nil
end)
RecommendationFlags.Enabled.Changed:Connect(function() -- line 233 | captures: v4, v5, v6, v7, RecommendationFlags
    if RecommendationFlags.Enabled:Get() then
        return
    end
    v4 = {}
    v5 = 0
    v6 = nil
    v7 = 0
end)
RecommendationFlags.ConfigName.Changed:Connect(function() -- line 242 | captures: v2, v7, RecommendationFlags, v10
    v7 = 0
    local v51 = math.random() * RecommendationFlags.ConfigSwapSpreadSeconds:Get()
    task.delay(v51, function() -- line 245 | captures: v2, v10
        local v52 = v2
        if v52 ~= nil then
            v10.PrefetchFeed(v52)
        end
    end)
end)
return v10
