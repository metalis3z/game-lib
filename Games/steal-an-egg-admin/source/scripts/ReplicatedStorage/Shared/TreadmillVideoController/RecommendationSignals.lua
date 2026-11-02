-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RecommendationService = game:GetService("RecommendationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
require(script.Parent.RecommendationFeedSource)
local RecommendationFlags = require(script.Parent.RecommendationFlags)
local v1 = Log.new()
local v2
local v3 = {}

local function resolveDepartureIntent(v4, v5, v6) -- line 14
    if v4.Ended or v4.Engaged then
        return Enum.RecommendationDepartureIntent.Positive
    end
    if v6 ~= nil and v6 >= 0.8 then
        return Enum.RecommendationDepartureIntent.Positive
    end
    if v5 < 3 then
        return Enum.RecommendationDepartureIntent.Negative
    end
    if v6 ~= nil and v6 < 0.25 then
        return Enum.RecommendationDepartureIntent.Negative
    end
    return Enum.RecommendationDepartureIntent.Neutral
end

local function logAction(v7, v8, v9) -- line 44 | captures: RecommendationService, RecommendationFlags, v1
    if not RecommendationFlags.Enabled:Get() then
        return
    end
    local v10, v11 = pcall(function() -- line 49 | captures: v7, v8, v9, RecommendationService
        RecommendationService:LogActionEvent(v8, v7.ItemId, v7.TracingId, v9)
    end)
    if not v10 then
        v1:AtWarning():Log((("Failed to log treadmill recommendation action: %*"):format(v11)))
    end
end

function v3.HasActiveView() -- line 56 | captures: v2
    return v2 ~= nil
end

function v3.EndView(v12) -- line 60 | captures: v2, RecommendationService, RecommendationFlags, v1, resolveDepartureIntent
    local v13 = v2
    v2 = nil
    if v13 ~= nil and RecommendationFlags.Enabled:Get() then
        local v14 = os.clock() - v13.StartedAt
        local v15 = resolveDepartureIntent(v13, v14, v12)
        local v16, v17 = pcall(function() -- line 69 | captures: v13, v14, v15, RecommendationService
            RecommendationService:LogImpressionEvent(Enum.RecommendationImpressionType.View, v13.Item.ItemId, v13.Item.TracingId, {
                Weight = 1,
                Duration = v14,
                ItemPosition = v13.Item.ItemPosition,
                DepartureIntent = v15
            })
        end)
        if not v16 then
            v1:AtWarning():Log((("Failed to log treadmill recommendation impression: %*"):format(v17)))
        end
    end
end

function v3.BeginView(v18) -- line 76 | captures: v2, v3
    v3.EndView(nil)
    v2 = {
        Ended = false,
        Engaged = false,
        Item = v18,
        StartedAt = os.clock()
    }
end

function v3.MarkEnded() -- line 80 | captures: v2
    local v19 = v2
    if v19 ~= nil then
        v19.Ended = true
    end
end

function v3.NotifyLikeResult(v20, v21) -- line 86 | captures: v2, logAction
    local v22 = v2
    local v23
    if v22 == nil then
        v23 = true
    elseif v22.Item.MediaKey == v20 then
        if v21 then
            v22.Engaged = true
        end
        v23 = false
    else
        v23 = true
    end
    if v23 then
        return
    end
    local v24 = if v21 then Enum.RecommendationActionType.AddReaction else Enum.RecommendationActionType.RemoveReaction
    logAction(v22.Item, v24, { ReactionType = "Like" })
end

function v3.NotifyCommentPosted(v25) -- line 102 | captures: v2, logAction
    local v26 = v2
    if v26 ~= nil and v26.Item.MediaKey == v25 then
        v26.Engaged = true
        logAction(v26.Item, Enum.RecommendationActionType.Comment, nil)
    end
end

function v3.NotifyShared() -- line 110 | captures: v2, logAction
    local v27 = v2
    if v27 ~= nil then
        v27.Engaged = true
        logAction(v27.Item, Enum.RecommendationActionType.Share, nil)
    end
end

return v3
