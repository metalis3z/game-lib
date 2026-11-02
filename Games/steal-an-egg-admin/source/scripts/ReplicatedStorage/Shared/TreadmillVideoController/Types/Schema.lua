-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SchemaFields = require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.SchemaFields)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local Brainrot = t.literal("Brainrot")
local Funny = t.literal("Funny")
local Satisfying = t.literal("Satisfying")
local WeirdOrHorror = t.literal("WeirdOrHorror")

v1.TreadmillMediaBucketType = t.union(Brainrot, Funny, Satisfying, WeirdOrHorror, t.literal("Music"))
v1.VideoBackgroundMusic = t.strictInterface({
    SoundId = t.string,
    Volume = t.number
})
v1.VideoMediaEntry = t.strictInterface({
    Kind = t.literal("Video"),
    ReleaseVersion = t.number,
    BucketType = v1.TreadmillMediaBucketType,
    Video = t.string,
    CoverImage = t.optional(t.string),
    Music = t.optional(v1.VideoBackgroundMusic),
    Size = t.optional(t.UDim2),
    Volume = t.optional(t.number),
    Duration = t.optional(t.number),
    Disabled = t.optional(t.boolean)
})
v1.MusicImageMediaEntry = t.strictInterface({
    Kind = t.literal("MusicImage"),
    ReleaseVersion = t.number,
    BucketType = v1.TreadmillMediaBucketType,
    Image = t.string,
    SoundId = t.string,
    Volume = t.number,
    Duration = t.optional(t.number),
    Disabled = t.optional(t.boolean)
})
v1.TreadmillMediaEntry = t.union(v1.VideoMediaEntry, v1.MusicImageMediaEntry)
v1.TreadmillMediaEntries = t.array(v1.TreadmillMediaEntry)
v1.TreadmillMediaFeedState = SchemaFields.TreadmillMediaFeedState
return v1
