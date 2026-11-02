-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local SchemaFields = require(ReplicatedStorage.Library.Modules.DefaultStats.Types.SchemaFields)
local t2 = {
	TreadmillMediaBucketType = t.union(t.literal("Brainrot"), t.literal("Funny"), t.literal("Satisfying"), t.literal("WeirdOrHorror"), t.literal("Music")),
	VideoBackgroundMusic = t.strictInterface({
		SoundId = t.string,
		Volume = t.number
	})
}

t2.VideoMediaEntry = t.strictInterface({
	Kind = t.literal("Video"),
	ReleaseVersion = t.number,
	BucketType = t2.TreadmillMediaBucketType,
	Video = t.string,
	CoverImage = t.optional(t.string),
	Music = t.optional(t2.VideoBackgroundMusic),
	Size = t.optional(t.UDim2),
	Volume = t.optional(t.number)
})
t2.MusicImageMediaEntry = t.strictInterface({
	Kind = t.literal("MusicImage"),
	ReleaseVersion = t.number,
	BucketType = t2.TreadmillMediaBucketType,
	Image = t.string,
	SoundId = t.string,
	Volume = t.number
})
t2.TreadmillMediaEntry = t.union(t2.VideoMediaEntry, t2.MusicImageMediaEntry)
t2.TreadmillMediaEntries = t.array(t2.TreadmillMediaEntry)
t2.TreadmillMediaFeedState = SchemaFields.TreadmillMediaFeedState

return t2