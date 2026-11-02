-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Globals.Constants)
local TreadmillMediaComments = require(ReplicatedStorage.Shared.Types.TreadmillMediaComments)
local Log = require(ReplicatedStorage.Packages.Log)
local RecommendationSignals = require(ReplicatedStorage.Shared.TreadmillVideoController.RecommendationSignals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillMediaCommentsConfig = require(ReplicatedStorage.Shared.Modules.TreadmillMediaCommentsConfig)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local Schema = TreadmillMediaComments.Schema
require(script.Types.Interface)
local v1 = Log.new()
local v2 = {}
local v3 = {}
local v4 = false
local v5 = false
local v6 = {}
local v7 = { CommentCountChanged = Signal.new() }

local function getInvokeError(v8) -- line 25
    if typeof(v8) == "string" then
        return v8
    end
    return "RequestFailed"
end

local function setCachedCommentCount(v9, v10) -- line 31 | captures: v2, v7
    local v11 = math.floor(v10)
    local v12 = math.max(0, v11)
    local v13 = v2[v9]
    if v13 ~= nil then
        v12 = math.max(v13, v12)
    end
    if v13 ~= v12 then
        v2[v9] = v12
        v7.CommentCountChanged:Fire(v9, v12)
    end
end

local function refreshCommentCountCache() -- line 43 | captures: v2, v3, v6, v7
    for v14, v15 in v3 do
        local v16 = {}
        for v17, v18 in v15 do
            v16[v18] = v6[v18] or 0
        end
        local v19 = v7.RequestCommentCounts(v15)
        if v19.Ok then
            if v19.Loaded then
                for v20, v21 in v19.CountsByMediaKey do
                    if (v6[v20] or 0) == v16[v20] then
                        local v22 = math.floor(v21)
                        local v23 = math.max(0, v22)
                        local v24 = v2[v20]
                        if v24 ~= nil then
                            v23 = math.max(v24, v23)
                        end
                        if v24 ~= v23 then
                            v2[v20] = v23
                            v7.CommentCountChanged:Fire(v20, v23)
                        end
                    end
                end
            else
                return "unloaded"
            end
        else
            return "failed"
        end
    end
    return "loaded"
end

local function startCommentCountRefreshLoop() -- line 83 | captures: v4, v5, refreshCommentCountCache
    task.spawn(function() -- line 84 | captures: v4, v5, refreshCommentCountCache
        while true do
            if v5 then
                if refreshCommentCountCache() == "loaded" then
                    v4 = true
                end
            else
                break
            end
            local v25 = if v4 then 180 else 2
            task.wait(v25)
        end
    end)
end

function v7.StartCommentCountCache(v26) -- line 99 | captures: v4, v5, TreadmillMediaCommentsConfig, t, v3, refreshCommentCountCache
    t.strict(t.table)(v26)
    if v5 then
        return
    end
    v5 = true
    local v27 = {}
    local v28 = {}
    for v29, v30 in v26 do
        t.strict(t.string)(v30)
        if not v27[v30] then
            v27[v30] = true
            table.insert(v28, v30)
            if TreadmillMediaCommentsConfig.COMMENT_COUNT_KEYS_PER_REQUEST <= #v28 then
                table.insert(v3, v28)
                v28 = {}
            end
        end
    end
    if #v28 > 0 then
        table.insert(v3, v28)
    end
    task.spawn(function() -- line 127 | captures: v4, v5, refreshCommentCountCache
        while true do
            if v5 then
                if refreshCommentCountCache() == "loaded" then
                    v4 = true
                end
            else
                break
            end
            local v31 = if v4 then 180 else 2
            task.wait(v31)
        end
    end)
end

function v7.GetCachedCommentCount(v32) -- line 142 | captures: t, v2
    t.strict(t.string)(v32)
    return v2[v32]
end

function v7.ReconcileCommentCount(v33, v34) -- line 147 | captures: t, v2, v6, v7
    t.strict(t.string)(v33)
    t.strict(t.number)(v34)
    v6[v33] = (v6[v33] or 0) + 1
    local v35 = math.floor(v34)
    local v36 = math.max(0, v35)
    local v37 = v2[v33]
    if v37 ~= nil then
        v36 = math.max(v37, v36)
    end
    if v37 ~= v36 then
        v2[v33] = v36
        v7.CommentCountChanged:Fire(v33, v36)
    end
end

function v7.RequestCommentPage(v38, v39, v40) -- line 164 | captures: Remotes, t, TryCall, Schema, v1
    t.strict(t.string)(v38)
    t.strict(t.optional(t.number))(v39)
    t.strict(t.optional(t.number))(v40)
    local v41, v42 = TryCall(function() -- line 172 | captures: v38, v39, v40, Remotes
        return Remotes.Treadmill.AskReplyPage:InvokeServer({
            MediaKey = v38,
            Cursor = v39,
            PageSize = v40
        })
    end)
    if v41 then
        if Schema.CommentPageResult(v42) then
            if v42.Ok then
                local v43 = {
                    Ok = true,
                    TotalCreatedCount = v42.TotalCreatedCount or 0
                }
                v43.Comments = v42.Comments or {}
                v43.NextCursor = v42.NextCursor
                return v43
            end
            return {
                Ok = false,
                Error = v42.Error or "RequestFailed"
            }
        end
        v1:AtWarning():Log("Rejected invalid treadmill comment page response")
        return {
            Ok = false,
            Error = "InvalidResponse"
        }
    end
    v1:AtWarning():Log((("Failed treadmill comment page request: %*"):format(v42)))
    local v44 = { Ok = false }
    if typeof(v42) ~= "string" then
        v42 = "RequestFailed"
    end
    v44.Error = v42
    return v44
end

function v7.RequestCommentCounts(v45) -- line 203 | captures: Remotes, t, TryCall, Schema, v1
    t.strict(t.table)(v45)
    local v46, v47 = TryCall(function() -- line 207 | captures: v45, Remotes
        return Remotes.Treadmill.AskReplyCounts:InvokeServer({ MediaKeys = v45 })
    end)
    if v46 then
        if Schema.CommentCountsResult(v47) then
            if v47.Ok then
                local v48 = { Ok = true }
                v48.CountsByMediaKey = v47.CountsByMediaKey or {}
                v48.Loaded = v47.Loaded == true
                v48.Stale = v47.Stale == true
                return v48
            end
            local v49 = { Ok = false }
            v49.CountsByMediaKey = {}
            v49.Loaded = v47.Loaded == true
            v49.Stale = v47.Stale ~= false
            v49.Error = v47.Error or "RequestFailed"
            return v49
        end
        v1:AtWarning():Log("Rejected invalid treadmill comment counts response")
        return {
            Ok = false,
            Loaded = false,
            Stale = true,
            Error = "InvalidResponse",
            CountsByMediaKey = {}
        }
    end
    v1:AtWarning():Log((("Failed treadmill comment counts request: %*"):format(v47)))
    local v50 = {
        Ok = false,
        Loaded = false,
        Stale = true
    }
    v50.CountsByMediaKey = {}
    if typeof(v47) ~= "string" then
        v47 = "RequestFailed"
    end
    v50.Error = v47
    return v50
end

function v7.PostComment(v51, v52, v53) -- line 256 | captures: RecommendationSignals, Remotes, t, TryCall, Schema, v1
    t.strict(t.string)(v51)
    t.strict(t.string)(v52)
    t.strict(t.optional(t.number))(v53)
    local v54, v55 = TryCall(function() -- line 264 | captures: v51, v52, v53, Remotes
        return Remotes.Treadmill.AskPostReply:InvokeServer({
            MediaKey = v51,
            Message = v52,
            ImageAssetId = v53
        })
    end)
    if v54 then
        if Schema.PostCommentResult(v55) then
            local v56, v57, v58
            if v55.Ok then
                if v55.Comment == nil then
                    v58 = true
                else
                    RecommendationSignals.NotifyCommentPosted(v51)
                    v56 = {
                        Ok = true,
                        Comment = v55.Comment
                    }
                    v57 = v55.Pending == true
                    v58 = false
                end
            else
                v58 = true
            end
            if v58 then
                return {
                    Ok = false,
                    Error = v55.Error or "RequestFailed"
                }
            end
            v56.Pending = v57
            return v56
        end
        v1:AtWarning():Log("Rejected invalid treadmill post comment response")
        return {
            Ok = false,
            Error = "InvalidResponse"
        }
    end
    v1:AtWarning():Log((("Failed treadmill post comment request: %*"):format(v55)))
    local v59 = { Ok = false }
    if typeof(v55) ~= "string" then
        v55 = "RequestFailed"
    end
    v59.Error = v55
    return v59
end

function v7.SetCommentLike(v60, v61, v62) -- line 291 | captures: Remotes, t, TryCall, Schema, v1
    t.strict(t.string)(v60)
    t.strict(t.string)(v61)
    t.strict(t.boolean)(v62)
    local v63, v64 = TryCall(function() -- line 299 | captures: v60, v61, v62, Remotes
        return Remotes.Treadmill.AskReplyFavour:InvokeServer({
            MediaKey = v60,
            CommentId = v61,
            Liked = v62
        })
    end)
    if v63 then
        if Schema.SetCommentLikeResult(v64) then
            if v64.Ok then
                local v65 = {
                    Ok = true,
                    CommentId = v64.CommentId or v61
                }
                v65.Liked = v64.Liked == true
                v65.Delta = v64.Delta or 0
                v65.LikeCount = v64.LikeCount or 0
                return v65
            end
            return {
                Ok = false,
                Error = v64.Error or "RequestFailed",
                CommentId = v64.CommentId or v61,
                LikeCount = v64.LikeCount
            }
        end
        v1:AtWarning():Log("Rejected invalid treadmill comment like response")
        return {
            Ok = false,
            Error = "InvalidResponse",
            CommentId = v61
        }
    end
    v1:AtWarning():Log((("Failed treadmill comment like request: %*"):format(v64)))
    local v66 = { Ok = false }
    if typeof(v64) ~= "string" then
        v64 = "RequestFailed"
    end
    v66.Error = v64
    v66.CommentId = v61
    return v66
end

return v7
