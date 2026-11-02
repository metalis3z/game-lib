-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	MediaKey = t.string,
	CommentId = t.string
}

t2.ClientCommentRecord = t.strictInterface({
	Id = t2.CommentId,
	UserId = t.number,
	CreatedAt = t.number,
	Message = t.string,
	ImageAssetId = t.optional(t.number),
	LikeCount = t.number,
	LikedByViewer = t.boolean
})
t2.PersistedCommentRecord = t.strictInterface({
	I = t2.CommentId,
	U = t.number,
	T = t.number,
	M = t.string,
	A = t.optional(t.number),
	L = t.number
})
t2.PersistedCommentPayload = t.strictInterface({
	V = t.number,
	U = t.number,
	N = t.number,
	C = t.array(t2.PersistedCommentRecord)
})
t2.CommentCountPayload = t.strictInterface({
	V = t.number,
	U = t.number,
	C = t.map(t2.MediaKey, t.number)
})
t2.CommentCountEnvelope = t.interface({
	V = t.number,
	U = t.number,
	C = t.table
})
t2.CommentPageRequest = t.strictInterface({
	MediaKey = t2.MediaKey,
	Cursor = t.optional(t.number),
	PageSize = t.optional(t.number)
})
t2.CommentPageResult = t.strictInterface({
	Ok = t.boolean,
	TotalCreatedCount = t.optional(t.number),
	Comments = t.optional(t.array(t2.ClientCommentRecord)),
	NextCursor = t.optional(t.number),
	Error = t.optional(t.string)
})
t2.CommentCountsRequest = t.strictInterface({
	MediaKeys = t.array(t2.MediaKey)
})
t2.CommentCountsResult = t.strictInterface({
	Ok = t.boolean,
	CountsByMediaKey = t.optional(t.map(t2.MediaKey, t.number)),
	Loaded = t.optional(t.boolean),
	Stale = t.optional(t.boolean),
	Error = t.optional(t.string)
})
t2.PostCommentRequest = t.strictInterface({
	MediaKey = t2.MediaKey,
	Message = t.optional(t.string),
	ImageAssetId = t.optional(t.number)
})
t2.PostCommentResult = t.strictInterface({
	Ok = t.boolean,
	Comment = t.optional(t2.ClientCommentRecord),
	Pending = t.optional(t.boolean),
	Error = t.optional(t.string)
})
t2.SetCommentLikeRequest = t.strictInterface({
	MediaKey = t2.MediaKey,
	CommentId = t2.CommentId,
	Liked = t.boolean
})
t2.SetCommentLikeResult = t.strictInterface({
	Ok = t.boolean,
	CommentId = t.optional(t2.CommentId),
	LikeCount = t.optional(t.number),
	Liked = t.optional(t.boolean),
	Delta = t.optional(t.number),
	Error = t.optional(t.string)
})

return t2