--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(script.Parent.Core_Network)
local Data = require(script.Parent.Core_PlayerData)
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetItemUtil = require(ReplicatedStorage.Library.Util.AssetItemUtil)

local TextService = game:GetService("TextService")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")

local CommentStore = DataStoreService:GetDataStore("TreadmillComments_v1")
local GlobalLikesStore = DataStoreService:GetDataStore("GlobalTreadmillLikes_v1")

local globalCountsCache: { [string]: number } = {}
local commentCache: { [string]: { any } } = {}

local function getGlobalCount(mediaKey: string): number
	if globalCountsCache[mediaKey] == nil then
		local success, count = pcall(function()
			return GlobalLikesStore:GetAsync(mediaKey)
		end)
		globalCountsCache[mediaKey] = (success and typeof(count) == "number") and count or 0
	end
	return globalCountsCache[mediaKey]
end

local function getMediaComments(mediaKey: string)
	if not commentCache[mediaKey] then
		local success, result = pcall(function()
			return CommentStore:GetAsync(mediaKey)
		end)
		commentCache[mediaKey] = (success and typeof(result) == "table") and result or {}
	end
	return commentCache[mediaKey]
end

local Compatibility = {}

function Compatibility.Init()
	local function copy(source)
		local result = {}
		for key, value in pairs(source or {}) do
			result[key] = value
		end
		return result
	end

	Network.BindFunction("Experiments:Get", function()
		return {}
	end)
	Network.BindFunction("ClientCharacter: Sync", function()
		return true
	end)
	Network.BindFunction("ServerLuck:GetState", function()
		return {Multiplier = 1}
	end)

	Network.BindFunction("Treadmills: RequestCommentCounts", function(player, data)
		local mediaKeys = (typeof(data) == "table" and data.MediaKeys) or {}
		local counts = {}

		for _, mediaKey in ipairs(mediaKeys) do
			if typeof(mediaKey) == "string" then
				local comments = getMediaComments(mediaKey)
				counts[mediaKey] = #comments
			end
		end

		return {
			Ok = true,
			CountsByMediaKey = counts,
			Loaded = true,
			Stale = false,
		}
	end)

	Network.BindFunction("Treadmills: RequestCommentPage", function(player, data)
		local mediaKey = if typeof(data) == "table" then data.MediaKey else nil
		if typeof(mediaKey) ~= "string" then
			return { Ok = false, Error = "InvalidMediaKey" }
		end

		local rawComments = getMediaComments(mediaKey)
		local formattedComments = {}

		for _, comment in ipairs(rawComments) do
			local commentId = comment.Id or comment.CommentId or comment.I or HttpService:GenerateGUID(false)
			local userId = comment.UserId or comment.AuthorUserId or comment.U or player.UserId

			local clientRecord = {
				Id = commentId,
				UserId = userId,
				CreatedAt = comment.CreatedAt or comment.T or os.time(),
				Message = comment.Message or comment.M or "",
				LikeCount = comment.LikeCount or comment.L or 0,
				LikedByViewer = comment.LikedByViewer == true,
			}

			local imageId = comment.ImageAssetId or comment.A
			if typeof(imageId) == "number" then
				clientRecord.ImageAssetId = imageId
			end

			table.insert(formattedComments, clientRecord)
		end

		return {
			Ok = true,
			TotalCreatedCount = #formattedComments,
			Comments = formattedComments,
		}
	end)

	Network.BindFunction("Treadmills: RequestPostComment", function(player, data)
		if typeof(data) ~= "table" or typeof(data.MediaKey) ~= "string" or typeof(data.Message) ~= "string" then
			return { Ok = false, Error = "InvalidData" }
		end

		local mediaKey = data.MediaKey
		local rawMessage = string.sub(data.Message, 1, 200)

		if #rawMessage == 0 then
			return { Ok = false, Error = "EmptyMessage" }
		end

		local filteredMessage = rawMessage
		local filterSuccess, filterResult = pcall(function()
			return TextService:FilterStringAsync(rawMessage, player.UserId)
		end)

		if filterSuccess and filterResult then
			local stringSuccess, broadcastString = pcall(function()
				return filterResult:GetNonChatStringForBroadcastAsync()
			end)
			if stringSuccess then
				filteredMessage = broadcastString
			end
		end

		local commentId = HttpService:GenerateGUID(false)
		local now = os.time()

		local savedComment = {
			Id = commentId,
			UserId = player.UserId,
			MediaKey = mediaKey,
			Message = filteredMessage,
			CreatedAt = now,
			LikeCount = 0,
			LikedByViewer = false,
			ImageAssetId = data.ImageAssetId,
		}

		local comments = getMediaComments(mediaKey)
		table.insert(comments, 1, savedComment)

		task.spawn(function()
			pcall(function()
				CommentStore:SetAsync(mediaKey, comments)
			end)
		end)

		local clientComment = {
			Id = commentId,
			UserId = player.UserId,
			CreatedAt = now,
			Message = filteredMessage,
			LikeCount = 0,
			LikedByViewer = false,
		}

		if typeof(data.ImageAssetId) == "number" then
			clientComment.ImageAssetId = data.ImageAssetId
		end

		return {
			Ok = true,
			Comment = clientComment,
			Pending = false,
		}
	end)

	Network.BindFunction("Treadmills: RequestSetCommentLike", function(player, data)
		if typeof(data) ~= "table" or typeof(data.MediaKey) ~= "string" or typeof(data.CommentId) ~= "string" then
			return { Ok = false, Error = "InvalidData" }
		end

		local mediaKey = data.MediaKey
		local commentId = data.CommentId
		local liked = data.Liked == true

		local comments = getMediaComments(mediaKey)
		local targetComment = nil

		for _, comment in ipairs(comments) do
			if comment.Id == commentId or comment.CommentId == commentId or comment.I == commentId then
				targetComment = comment
				break
			end
		end

		if not targetComment then
			return { Ok = false, Error = "CommentNotFound" }
		end

		local delta = liked and 1 or -1
		targetComment.LikeCount = math.max((targetComment.LikeCount or targetComment.L or 0) + delta, 0)

		task.spawn(function()
			pcall(function()
				CommentStore:SetAsync(mediaKey, comments)
			end)
		end)

		return {
			Ok = true,
			CommentId = commentId,
			Liked = liked,
			Delta = delta,
			LikeCount = targetComment.LikeCount,
		}
	end)

	Network.BindFunction("OfflineAssets: GetSummary", function()
		return {
			ClaimableAmount = 0,
			ReservedAmount = 0,
			TotalAmount = 0,
			IsMultiplierPurchasePending = false,
		}
	end)
	Network.BindFunction("OfflineAssets: IsStatePending", function()
		return false
	end)
	Network.BindFunction("OfflineAssets: Redeem", function()
		return {
			BaseAmount = 0,
			AwardedAmount = 0,
			ClaimedByUid = {},
		}
	end)
	Network.BindFunction("Treadmills: RequestFriendLikeSnapshot", function()
		return {}
	end)
	Network.BindFunction("Treadmills: RequestLikeSnapshot", function(player)
		local profile = Data.Get(player)
		local userLikes = (profile and profile.LikedMedia) or {}

		for mediaKey in pairs(userLikes) do
			getGlobalCount(mediaKey)
		end

		return {
			CountsByMediaLikeKey = globalCountsCache,
			LikedTreadmillMedia = userLikes,
		}
	end)

	Network.BindFunction("Treadmills: RequestSetMediaLike", function(player, mediaKey, targetLiked)
		if typeof(mediaKey) ~= "string" then
			return { Ok = false, Error = "Invalid media key." }
		end

		local profile = Data.Get(player)
		if not profile then
			return { Ok = false, Error = "Player data is still loading." }
		end

		local likedMedia = copy(profile.LikedMedia or {})
		local currentlyLiked = likedMedia[mediaKey] == true

		if targetLiked == currentlyLiked then
			return {
				Ok = true,
				Liked = currentlyLiked,
				Count = getGlobalCount(mediaKey),
			}
		end

		local delta = targetLiked and 1 or -1
		likedMedia[mediaKey] = if targetLiked then true else nil

		Data.Update(player, {
			LikedMedia = likedMedia,
		})

		local currentCount = getGlobalCount(mediaKey)
		local updatedCount = math.max(currentCount + delta, 0)
		globalCountsCache[mediaKey] = updatedCount

		task.spawn(function()
			local success, newCount = pcall(function()
				return GlobalLikesStore:IncrementAsync(mediaKey, delta)
			end)
			if success and typeof(newCount) == "number" then
				globalCountsCache[mediaKey] = math.max(newCount, 0)
			end
		end)

		return {
			Ok = true,
			Liked = targetLiked == true,
			Count = updatedCount,
		}
	end)
	Network.BindFunction("Analytics:ReportAfkTeleport", function()
		return true
	end)
	Network.BindFunction("Analytics:RequestAfkTeleportFlush", function()
		return true
	end)
	Network.BindFunction("GroupReward: ClaimReward", function(player, isMember)
		local profile = Data.Get(player)
		if not profile then
			return false, "Your data is still loading."
		end
		if profile.ClaimedGroupReward == true then
			return false, "You already claimed this reward!"
		end
		if not isMember then
			return false, "You must join the group to claim this reward!"
		end
		local rewardAmount = 10000
		Data.Update(player, {
			ClaimedGroupReward = true,
			SpeedPower = (tonumber(profile.SpeedPower) or 0) + rewardAmount,
		})
		return true, nil, rewardAmount
	end)
	local function isClaimable(profile, category)
		return profile.Index and profile.Index[category] == true
			and not (profile.IndexClaimedCategories and profile.IndexClaimedCategories[category] == true)
	end

	Network.BindFunction("Index: RequestClaim", function(player, category)
		local profile = Data.Get(player)
		if not profile then
			return false, "Your data is still loading."
		end
		if typeof(category) ~= "string" or not Assets.Directory[category] then
			return false, "Invalid pet."
		end
		if not isClaimable(profile, category) then
			return false, "That reward is not claimable."
		end

		local cash = AssetItemUtil.GetIndexMoneyRewardAmount(category)
		local speed = AssetItemUtil.GetIndexSpeedRewardAmount(category) or 0

		local claimed = copy(profile.IndexClaimedCategories or {})
		claimed[category] = true

		Data.AddMoney(player, cash)
		Data.Update(player, {
			SpeedPower = (tonumber(profile.SpeedPower) or 10) + speed,
			IndexClaimedCategories = claimed,
		})

		return true, nil, {{Category = category}}
	end)

	Network.BindFunction("Index: RequestClaimAll", function(player)
		local profile = Data.Get(player)
		if not profile then
			return false, "Your data is still loading."
		end

		local claimed = copy(profile.IndexClaimedCategories or {})
		local claimedData = {}
		local totalCash = 0
		local totalSpeed = 0

		for category in pairs(profile.Index or {}) do
			if isClaimable(profile, category) and Assets.Directory[category] then
				totalCash += AssetItemUtil.GetIndexMoneyRewardAmount(category)
				totalSpeed += AssetItemUtil.GetIndexSpeedRewardAmount(category) or 0
				claimed[category] = true
				table.insert(claimedData, {Category = category})
			end
		end

		if #claimedData == 0 then
			return false, "Nothing to claim."
		end

		Data.AddMoney(player, totalCash)
		Data.Update(player, {
			SpeedPower = (tonumber(profile.SpeedPower) or 10) + totalSpeed,
			IndexClaimedCategories = claimed,
		})

		return true, nil, claimedData
	end)
	Network.BindFunction("Index: RequestClaimLimitedEggReward", function()
		return false, "Limited rewards are not configured."
	end)
	Network.BindFunction("Index: RequestEquipAreaBat", function()
		return false, "Area bats are not configured."
	end)
	Network.BindFunction("FuseMachine: AcknowledgeInfo", function()
		return true
	end)
	Network.BindFunction("FuseMachine: InsertMob", function()
		return false, "The fuse machine is not configured."
	end)
	Network.BindFunction("FuseMachine: RemoveMob", function()
		return false, "The fuse machine is not configured."
	end)
	Network.BindFunction("FuseMachine: StartFuse", function()
		return false, "The fuse machine is not configured."
	end)
	Network.BindFunction("FuseMachine: CompleteReveal", function()
		return false, "The fuse machine is not configured."
	end)
	Network.BindFunction("Products: Request Prompt Purchase", function()
		return false, "Purchases are not configured."
	end)
	Network.BindFunction("Products: Request Server Test", function()
		return false
	end)
	Network.BindFunction("Products: Whitelist Purchase", function()
		return false
	end)
	Network.BindFunction("Gifting: Send Request", function()
		return false, "Gifting is not configured."
	end)
	Network.BindFunction("Gifting: Response", function()
		return false
	end)

	for _, name in ipairs({
		"Server: Trading: Decline",
		"Server: Trading: Message",
		"Server: Trading: Reject",
		"Server: Trading: Request",
		"Server: Trading: Set Confirmed",
		"Server: Trading: Set Item",
		"Server: Trading: Set Ready",
		}) do
		Network.BindFunction(name, function()
			return false, "Trading is not configured."
		end)
	end
end

return Compatibility