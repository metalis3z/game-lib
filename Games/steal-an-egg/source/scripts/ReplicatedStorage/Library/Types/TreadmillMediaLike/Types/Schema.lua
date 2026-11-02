-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	MediaKey = t.string,
	CountsByMediaLikeKey = t.map(t.string, t.number),
	LikerUserIds = t.array(t.integer)
}

t2.LikerUserIdsByMediaLikeKey = t.map(t.string, t2.LikerUserIds)
t2.MemberUserIdSet = t.map(t.string, t.boolean)
t2.MembersByMediaLikeKey = t.map(t.string, t2.MemberUserIdSet)
t2.MemberBucketsByMediaLikeKey = t.map(t.string, t.map(t.string, t2.MemberUserIdSet))
t2.MemberCountsByMediaLikeKey = t.map(t.string, t.number)
t2.OldestMemberBucketByMediaLikeKey = t.map(t.string, t.number)
t2.LikedTreadmillMedia = t.map(t.string, t.boolean)
t2.LikeSnapshot = t.strictInterface({
	CountsByMediaLikeKey = t2.CountsByMediaLikeKey,
	LikedTreadmillMedia = t2.LikedTreadmillMedia
})
t2.FriendLikeSnapshot = t.strictInterface({
	FriendLikeUserIdsByMediaLikeKey = t2.LikerUserIdsByMediaLikeKey
})
t2.FriendLikeSnapshotRequest = t.strictInterface({
	MediaKeys = t.optional(t.array(t2.MediaKey))
})
t2.LikeToggleResult = t.strictInterface({
	Ok = t.boolean,
	Liked = t.optional(t.boolean),
	Delta = t.optional(t.number),
	Count = t.optional(t.number),
	Error = t.optional(t.string)
})
t2.LikeToggleRequest = t.strictInterface({
	MediaKey = t2.MediaKey,
	Liked = t.boolean
})
t2.AggregateShardPayload = t.strictInterface({
	Version = t.number,
	UpdatedAt = t.number,
	Counts = t2.CountsByMediaLikeKey
})
t2.MemberShardPayload = t.strictInterface({
	Version = t.number,
	UpdatedAt = t.number,
	MembersByMediaLikeKey = t.optional(t2.MembersByMediaLikeKey),
	MemberBucketsByMediaLikeKey = t.optional(t2.MemberBucketsByMediaLikeKey),
	MemberCountsByMediaLikeKey = t.optional(t2.MemberCountsByMediaLikeKey),
	OldestMemberBucketByMediaLikeKey = t.optional(t2.OldestMemberBucketByMediaLikeKey)
})

return t2