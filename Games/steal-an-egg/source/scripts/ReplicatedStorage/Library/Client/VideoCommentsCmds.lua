local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Schema = require(ReplicatedStorage.Library.Types.TreadmillMediaComments).Schema
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local TreadmillMediaCommentsConfig = require(ReplicatedStorage.Library.Modules.TreadmillMediaCommentsConfig)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)

require(script.Types.Interface)

local Treadmills = Constants.NETWORK_MAP.Treadmills
local logger = Log.new()

local CommentService = {
	CommentCountChanged = Signal.new(),
}

local commentCountCache: { [string]: number } = {}
local mediaKeyChunks: { { string } } = {}
local localMutationVersions: { [string]: number } = {}

local isRefreshLoopActive = false
local hasInitialLoadSucceeded = false

local function getInvokeError(err: unknown): string
	if typeof(err) == "string" then
		return err
	end
	return "RequestFailed"
end

local function setCachedCommentCount(mediaKey: string, count: number)
	local sanitizedCount = math.max(0, math.floor(count))
	local currentCount = commentCountCache[mediaKey]

	if currentCount ~= nil then
		sanitizedCount = math.max(currentCount, sanitizedCount)
	end

	if currentCount ~= sanitizedCount then
		commentCountCache[mediaKey] = sanitizedCount
		CommentService.CommentCountChanged:Fire(mediaKey, sanitizedCount)
	end
end

local function refreshCommentCountCache(): string
	for _, chunk in mediaKeyChunks do
		local initialVersions = {}

		for _, mediaKey in chunk do
			initialVersions[mediaKey] = localMutationVersions[mediaKey] or 0
		end

		local response = CommentService.RequestCommentCounts(chunk)

		if not response.Ok then
			return "failed"
		end

		if not response.Loaded then
			return "unloaded"
		end

		for mediaKey, count in response.CountsByMediaKey do
			-- Ensure no optimistic mutation occurred while request was in flight
			if (localMutationVersions[mediaKey] or 0) == initialVersions[mediaKey] then
				setCachedCommentCount(mediaKey, count)
			end
		end
	end

	return "loaded"
end

local function startCommentCountRefreshLoop()
	task.spawn(function()
		while isRefreshLoopActive do
			if refreshCommentCountCache() == "loaded" then
				hasInitialLoadSucceeded = true
			end

			task.wait(if hasInitialLoadSucceeded then 180 else 2)
		end
	end)
end

function CommentService.StartCommentCountCache(mediaKeys: { string })
	Asserts.table(mediaKeys)

	if isRefreshLoopActive then
		return
	end

	isRefreshLoopActive = true

	local seenKeys = {}
	local currentChunk = {}

	for _, mediaKey in mediaKeys do
		Asserts.string(mediaKey)

		if not seenKeys[mediaKey] then
			seenKeys[mediaKey] = true
			table.insert(currentChunk, mediaKey)

			if #currentChunk >= TreadmillMediaCommentsConfig.COMMENT_COUNT_KEYS_PER_REQUEST then
				table.insert(mediaKeyChunks, currentChunk)
				currentChunk = {}
			end
		end
	end

	if #currentChunk > 0 then
		table.insert(mediaKeyChunks, currentChunk)
	end

	startCommentCountRefreshLoop()
end

function CommentService.GetCachedCommentCount(mediaKey: string): number?
	Asserts.string(mediaKey)
	return commentCountCache[mediaKey]
end

function CommentService.ReconcileCommentCount(mediaKey: string, count: number)
	Asserts.string(mediaKey)
	Asserts.number(count)

	localMutationVersions[mediaKey] = (localMutationVersions[mediaKey] or 0) + 1
	setCachedCommentCount(mediaKey, count)
end

function CommentService.RequestCommentPage(mediaKey: string, cursor: number?, pageSize: number?)
	Asserts.string(mediaKey)
	Asserts.optional.number(cursor)
	Asserts.optional.number(pageSize)

	local success, response = wcall(function()
		return Network.Invoke(Treadmills.REQUEST_COMMENT_PAGE, {
			MediaKey = mediaKey,
			Cursor = cursor,
			PageSize = pageSize,
		})
	end)

	if success then
		if not Schema.CommentPageResult(response) then
			logger:AtWarning():Log("Rejected invalid treadmill comment page response")
			return {
				Ok = false,
				Error = "InvalidResponse",
			}
		end

		if not response.Ok then
			return {
				Ok = false,
				Error = response.Error or "RequestFailed",
			}
		end

		return {
			Ok = true,
			TotalCreatedCount = response.TotalCreatedCount or 0,
			Comments = response.Comments or {},
			NextCursor = response.NextCursor,
		}
	end

	logger:AtWarning():Log((("Failed treadmill comment page request: %*"):format(response)))

	return {
		Ok = false,
		Error = getInvokeError(response),
	}
end

function CommentService.RequestCommentCounts(mediaKeys: { string })
	Asserts.table(mediaKeys)

	local success, response = wcall(function()
		return Network.Invoke(Treadmills.REQUEST_COMMENT_COUNTS, {
			MediaKeys = mediaKeys,
		})
	end)

	if success then
		if not Schema.CommentCountsResult(response) then
			return {
				Ok = false,
				Loaded = false,
				Stale = true,
				Error = "InvalidResponse",
				CountsByMediaKey = {},
			}
		end

		if response.Ok then
			return {
				Ok = true,
				CountsByMediaKey = response.CountsByMediaKey or {},
				Loaded = response.Loaded == true,
				Stale = response.Stale == true,
			}
		end

		return {
			Ok = false,
			Loaded = response.Loaded == true,
			Stale = response.Stale ~= false,
			Error = response.Error or "RequestFailed",
			CountsByMediaKey = {},
		}
	end

	logger:AtWarning():Log((("Failed treadmill comment counts request: %*"):format(response)))

	return {
		Ok = false,
		Loaded = false,
		Stale = true,
		Error = getInvokeError(response),
		CountsByMediaKey = {},
	}
end

function CommentService.PostComment(mediaKey: string, message: string, imageAssetId: number?)
	Asserts.string(mediaKey)
	Asserts.string(message)
	Asserts.optional.number(imageAssetId)

	local success, response = wcall(function()
		return Network.Invoke(Treadmills.REQUEST_POST_COMMENT, {
			MediaKey = mediaKey,
			Message = message,
			ImageAssetId = imageAssetId,
		})
	end)

	if success then
		local success, errMsg = Schema.PostCommentResult(response)
		print("Schema Valid:", success, "Validation Error:", errMsg)
		if not Schema.PostCommentResult(response) then
			logger:AtWarning():Log("Rejected invalid treadmill post comment response")
			return {
				Ok = false,
				Error = "InvalidResponse",
			}
		end

		if response.Ok and response.Comment ~= nil then
			return {
				Ok = true,
				Comment = response.Comment,
				Pending = response.Pending == true,
			}
		end

		return {
			Ok = false,
			Error = response.Error or "RequestFailed",
		}
	end

	logger:AtWarning():Log((("Failed treadmill post comment request: %*"):format(response)))

	return {
		Ok = false,
		Error = getInvokeError(response),
	}
end

function CommentService.SetCommentLike(mediaKey: string, commentId: string, liked: boolean)
	Asserts.string(mediaKey)
	Asserts.string(commentId)
	Asserts.boolean(liked)

	local success, response = wcall(function()
		return Network.Invoke(Treadmills.REQUEST_SET_COMMENT_LIKE, {
			MediaKey = mediaKey,
			CommentId = commentId,
			Liked = liked,
		})
	end)

	if success then
		if not Schema.SetCommentLikeResult(response) then
			logger:AtWarning():Log("Rejected invalid treadmill comment like response")
			return {
				Ok = false,
				Error = "InvalidResponse",
				LikeCount = nil,
				CommentId = commentId,
			}
		end

		if not response.Ok then
			return {
				Ok = false,
				Error = response.Error or "RequestFailed",
				CommentId = response.CommentId or commentId,
				LikeCount = response.LikeCount,
			}
		end

		return {
			Ok = true,
			CommentId = response.CommentId or commentId,
			Liked = response.Liked == true,
			Delta = response.Delta or 0,
			LikeCount = response.LikeCount or 0,
		}
	end

	logger:AtWarning():Log((("Failed treadmill comment like request: %*"):format(response)))

	return {
		Ok = false,
		Error = getInvokeError(response),
		CommentId = commentId,
		LikeCount = nil,
	}
end

return CommentService