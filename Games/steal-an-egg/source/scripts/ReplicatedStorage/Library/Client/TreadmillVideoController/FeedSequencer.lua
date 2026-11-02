-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CRC32 = require(ReplicatedStorage.Library.Functions.CRC32)
local Shuffle = require(ReplicatedStorage.Library.Functions.Shuffle)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local TreadmillMediaCatalog = require(ReplicatedStorage.Directory.TreadmillMediaCatalog)
local TreadmillMediaIdentity = require(ReplicatedStorage.Library.Modules.TreadmillMediaIdentity)

require(script.Parent.Types.Interface)

local t = {
	"Funny",
	"Brainrot",
	"Satisfying",
	"Funny",
	"Satisfying",
	"WeirdOrHorror",
	"Funny",
	"Brainrot",
	"Satisfying",
	"Funny",
	"Music"
}
local v1 = #t
local v2 = Log.new()
local t2 = {}

local function createEmptyBucketIndices() --[[ createEmptyBucketIndices | Line: 52 ]]
	return {
		Brainrot = {},
		Funny = {},
		Satisfying = {},
		WeirdOrHorror = {},
		Music = {}
	}
end

local function normalizeFeedIndex(p1) --[[ normalizeFeedIndex | Line: 62 ]]
	return math.max(0, (math.floor(p1)))
end

local function normalizeReleaseVersion(p1) --[[ normalizeReleaseVersion | Line: 66 ]]
	return math.max(0, (math.floor(p1)))
end

local function normalizeSeed(p1, p2) --[[ normalizeSeed | Line: 70 | Upvalues: CRC32 (copy) ]]
	if p1 > 0 then
		return math.floor(p1)
	end

	return CRC32((("TreadmillMediaFeed/%*"):format(p2)))
end

local function bucketForFeedIndex(p1) --[[ bucketForFeedIndex | Line: 77 | Upvalues: v1 (copy), t (copy) ]]
	return t[(p1 - 1) % v1 + 1] or t[1]
end

local function createBucketOrder(p1, p2, p3, p4) --[[ createBucketOrder | Line: 82 | Upvalues: CRC32 (copy), Shuffle (copy) ]]
	return Shuffle(table.clone(p1), (Random.new(CRC32((("%*/%*/%*"):format(p4, p2, p3))))))
end

local function createBucketOrders(p1, p2, p3) --[[ createBucketOrders | Line: 93 | Upvalues: CRC32 (copy), Shuffle (copy) ]]
	local t = {}

	t.Brainrot = Shuffle(table.clone(p1.Brainrot), (Random.new(CRC32((("%*/%*/Brainrot"):format(p3, p2))))))
	t.Funny = Shuffle(table.clone(p1.Funny), (Random.new(CRC32((("%*/%*/Funny"):format(p3, p2))))))
	t.Satisfying = Shuffle(table.clone(p1.Satisfying), (Random.new(CRC32((("%*/%*/Satisfying"):format(p3, p2))))))
	t.WeirdOrHorror = Shuffle(table.clone(p1.WeirdOrHorror), (Random.new(CRC32((("%*/%*/WeirdOrHorror"):format(p3, p2))))))
	t.Music = Shuffle(table.clone(p1.Music), (Random.new(CRC32((("%*/%*/Music"):format(p3, p2))))))

	return t
end

local function takeNextFromBucket(p1, p2, p3) --[[ takeNextFromBucket | Line: 117 ]]
	local v1 = p2[p3]
	local v2 = p1[p3][v1]

	if v2 == nil then
		return nil
	end

	p2[p3] = v1 + 1

	return v2
end

local function takeNextFromFallbackBucket(p1, p2, p3, p4) --[[ takeNextFromFallbackBucket | Line: 131 ]]
	if p4 == p3 then
		return nil
	end

	local v1 = p2[p4]
	local v2 = p1[p4][v1]

	if v2 == nil then
		return nil
	end

	p2[p4] = v1 + 1

	return v2
end

local function takeNextPatternMedia(p1, p2, p3) --[[ takeNextPatternMedia | Line: 143 ]]
	local v1 = p2[p3]
	local v2 = p1[p3][v1]
	local v3

	if v2 == nil then
		v3 = nil
	else
		p2[p3] = v1 + 1
		v3 = v2
	end

	if not v3 then
		if p3 == "Brainrot" then
			v3 = nil
		else
			local Brainrot = p2.Brainrot
			local v4 = p1.Brainrot[Brainrot]

			if v4 == nil then
				v3 = nil
			else
				p2.Brainrot = Brainrot + 1
				v3 = v4
			end
		end

		if not v3 then
			if p3 == "Funny" then
				v3 = nil
			else
				local Funny = p2.Funny
				local v5 = p1.Funny[Funny]

				if v5 == nil then
					v3 = nil
				else
					p2.Funny = Funny + 1
					v3 = v5
				end
			end

			if not v3 then
				if p3 == "Satisfying" then
					v3 = nil
				else
					local Satisfying = p2.Satisfying
					local v6 = p1.Satisfying[Satisfying]

					if v6 == nil then
						v3 = nil
					else
						p2.Satisfying = Satisfying + 1
						v3 = v6
					end
				end

				if not v3 then
					if p3 == "WeirdOrHorror" then
						v3 = nil
					else
						local WeirdOrHorror = p2.WeirdOrHorror
						local v7 = p1.WeirdOrHorror[WeirdOrHorror]

						if v7 == nil then
							v3 = nil
						else
							p2.WeirdOrHorror = WeirdOrHorror + 1
							v3 = v7
						end
					end

					if not v3 and p3 == "Music" then
						v3 = nil
					elseif not v3 then
						local Music = p2.Music
						local v8 = p1.Music[Music]

						if v8 == nil then
							v3 = nil
						else
							p2.Music = Music + 1
							v3 = v8
						end
					end
				end
			end
		end
	end

	assert(v3 ~= nil, "Expected unseen treadmill media while sequence is incomplete")

	return v3
end

local function generatePatternOrder(p1, p2, p3, p4, p5) --[[ generatePatternOrder | Line: 158 | Upvalues: createBucketOrders (copy), v1 (copy), t (copy), takeNextPatternMedia (copy) ]]
	local v12 = createBucketOrders(p1, p3, p4)
	local v2 = table.create(p2)
	local t2 = {
		Brainrot = 1,
		Funny = 1,
		Satisfying = 1,
		WeirdOrHorror = 1,
		Music = 1
	}

	for i = 1, p2 do
		v2[i] = takeNextPatternMedia(v12, t2, t[(p5 + i - 1 - 1) % v1 + 1] or t[1])
	end

	return v2
end

local function generateFullPass(p1, p2) --[[ generateFullPass | Line: 181 | Upvalues: CRC32 (copy), generatePatternOrder (copy) ]]
	local v1 = CRC32((("TreadmillMediaPass/%*/%*"):format(p1.Seed, p2)))

	return generatePatternOrder(p1.BucketIndices, p1.TotalMediaCount, v1, "TreadmillMediaPassBucket", p2 * p1.TotalMediaCount + 1)
end

local function resolveFullMediaIndex(p1, p2) --[[ resolveFullMediaIndex | Line: 193 | Upvalues: CRC32 (copy), generatePatternOrder (copy) ]]
	local v2 = math.floor((p2 - 1) / p1.TotalMediaCount)

	if p1.CachedPassNumber ~= v2 then
		local v3 = CRC32((("TreadmillMediaPass/%*/%*"):format(p1.Seed, v2)))

		p1.CachedPassOrder = generatePatternOrder(p1.BucketIndices, p1.TotalMediaCount, v3, "TreadmillMediaPassBucket", v2 * p1.TotalMediaCount + 1)
		p1.CachedPassNumber = v2
	end

	return p1.CachedPassOrder[(p2 - 1) % p1.TotalMediaCount + 1]
end

local function exportState(p1) --[[ exportState | Line: 203 ]]
	return {
		AlgorithmVersion = 5,
		Seed = p1.Seed,
		CurrentIndex = p1.CurrentIndex,
		HasSwappedRight = p1.HasSwappedRight,
		ReleaseTrackingInitialized = p1.ReleaseTrackingInitialized,
		FullFeedReleaseVersion = p1.FullFeedReleaseVersion,
		CompletedReleaseVersion = p1.CompletedReleaseVersion,
		PendingReleaseVersion = p1.PendingReleaseVersion,
		PendingCurrentMediaKey = p1.PendingCurrentMediaKey,
		SeenPendingMediaKeys = table.clone(p1.SeenPendingMediaKeys)
	}
end

local function statesEqual(p1, p2) --[[ statesEqual | Line: 218 ]]
	if p1.Seed ~= p2.Seed or (p1.CurrentIndex ~= p2.CurrentIndex or (p1.AlgorithmVersion ~= p2.AlgorithmVersion or (p1.HasSwappedRight ~= p2.HasSwappedRight or (p1.ReleaseTrackingInitialized ~= p2.ReleaseTrackingInitialized or (p1.FullFeedReleaseVersion ~= p2.FullFeedReleaseVersion or (p1.CompletedReleaseVersion ~= p2.CompletedReleaseVersion or (p1.PendingReleaseVersion ~= p2.PendingReleaseVersion or p1.PendingCurrentMediaKey ~= p2.PendingCurrentMediaKey))))))) then
		return false
	end

	for k, v in pairs(p1.SeenPendingMediaKeys) do
		if v ~= p2.SeenPendingMediaKeys[k] then
			return false
		end
	end

	for k, v in pairs(p2.SeenPendingMediaKeys) do
		if v ~= p1.SeenPendingMediaKeys[k] then
			return false
		end
	end

	return true
end

local function rebuildFullFeedCatalog(p1, p2) --[[ rebuildFullFeedCatalog | Line: 246 | Upvalues: createEmptyBucketIndices (copy) ]]
	local v1 = createEmptyBucketIndices()
	local count = 0

	for i, v in ipairs(p1.MediaEntries) do
		if v.ReleaseVersion <= p2 then
			table.insert(v1[v.BucketType], i)
			count = count + 1
		end
	end

	assert(if count > 0 then true else false, (("Treadmill full feed release %* must not be empty"):format(p2)))
	p1.BucketIndices = v1
	p1.TotalMediaCount = count
	p1.CachedPassNumber = nil
	p1.CachedPassOrder = {}
end

local function buildDeltaOrder(p1) --[[ buildDeltaOrder | Line: 262 | Upvalues: createEmptyBucketIndices (copy), TreadmillMediaIdentity (copy), CRC32 (copy), generatePatternOrder (copy) ]]
	local v1 = createEmptyBucketIndices()
	local t = {}
	local count = 0

	for i, v in ipairs(p1.MediaEntries) do
		if v.ReleaseVersion > p1.CompletedReleaseVersion and v.ReleaseVersion <= p1.PendingReleaseVersion then
			t[TreadmillMediaIdentity.GetMediaKey(v)] = i
			table.insert(v1[v.BucketType], i)
			count = count + 1
		end
	end

	p1.DeltaMediaIndexByKey = t
	p1.DeltaPosition = 0
	p1.DeltaCurrentMediaIndex = nil

	if count == 0 then
		p1.DeltaOrder = {}

		return
	end

	p1.DeltaOrder = generatePatternOrder(v1, count, CRC32((("TreadmillMediaDelta/%*/%*"):format(p1.Seed, p1.PendingReleaseVersion))), "TreadmillMediaDeltaBucket", 1)

	local PendingCurrentMediaKey = p1.PendingCurrentMediaKey

	if PendingCurrentMediaKey == nil then
		return
	end

	local v3 = t[PendingCurrentMediaKey]

	if v3 == nil then
		p1.PendingCurrentMediaKey = nil
	else
		p1.DeltaCurrentMediaIndex = v3

		for i, v in ipairs(p1.DeltaOrder) do
			if v == v3 then
				p1.DeltaPosition = i

				return
			end
		end
	end
end

local function completeDelta(p1) --[[ completeDelta | Line: 305 | Upvalues: rebuildFullFeedCatalog (copy) ]]
	p1.CompletedReleaseVersion = p1.PendingReleaseVersion
	p1.PendingReleaseVersion = 0
	p1.PendingCurrentMediaKey = nil
	p1.SeenPendingMediaKeys = {}
	p1.DeltaOrder = {}
	p1.DeltaMediaIndexByKey = {}
	p1.DeltaCurrentMediaIndex = nil
	p1.DeltaPosition = 0
	p1.CurrentIndex = 0
	p1.FullFeedReleaseVersion = p1.CurrentReleaseVersion
	rebuildFullFeedCatalog(p1, p1.FullFeedReleaseVersion)
end

local function takeNextDeltaMedia(p1) --[[ takeNextDeltaMedia | Line: 319 | Upvalues: TreadmillMediaIdentity (copy) ]]
	local v2 = p1.DeltaPosition + 1

	if p1.DeltaCurrentMediaIndex == nil then
		v2 = 0

		for i, v in ipairs(p1.DeltaOrder) do
			if not p1.SeenPendingMediaKeys[TreadmillMediaIdentity.GetMediaKey(p1.MediaEntries[v])] then
				v2 = i

				break
			end
		end
	end

	if v2 < 1 or #p1.DeltaOrder < v2 then
		return nil
	end

	local v4 = p1.DeltaOrder[v2]
	local v5 = TreadmillMediaIdentity.GetMediaKey(p1.MediaEntries[v4])

	p1.DeltaPosition = v2
	p1.DeltaCurrentMediaIndex = v4
	p1.PendingCurrentMediaKey = v5
	p1.SeenPendingMediaKeys[v5] = true

	return v4
end

local function takePreviousDeltaMedia(p1) --[[ takePreviousDeltaMedia | Line: 345 | Upvalues: TreadmillMediaIdentity (copy) ]]
	for i = p1.DeltaPosition - 1, 1, -1 do
		local v1 = p1.DeltaOrder[i]
		local v2 = TreadmillMediaIdentity.GetMediaKey(p1.MediaEntries[v1])

		if p1.SeenPendingMediaKeys[v2] then
			p1.DeltaPosition = i
			p1.DeltaCurrentMediaIndex = v1
			p1.PendingCurrentMediaKey = v2

			return v1
		end
	end

	return nil
end

local function startDelta(p1) --[[ startDelta | Line: 359 | Upvalues: buildDeltaOrder (copy), takeNextDeltaMedia (copy), completeDelta (copy) ]]
	p1.PendingReleaseVersion = p1.CurrentReleaseVersion
	p1.PendingCurrentMediaKey = nil
	p1.SeenPendingMediaKeys = {}
	buildDeltaOrder(p1)

	local v1 = takeNextDeltaMedia(p1)

	if v1 ~= nil then
		return v1
	end

	completeDelta(p1)

	return v1
end

local function takeNextFullMedia(p1) --[[ takeNextFullMedia | Line: 371 | Upvalues: CRC32 (copy), generatePatternOrder (copy) ]]
	p1.CurrentIndex = p1.CurrentIndex + 1

	if p1.FullFeedReleaseVersion == p1.CurrentReleaseVersion and p1.CurrentIndex >= p1.TotalMediaCount then
		p1.CompletedReleaseVersion = math.max(p1.CompletedReleaseVersion, p1.FullFeedReleaseVersion)
	end

	local CurrentIndex = p1.CurrentIndex
	local v2 = math.floor((CurrentIndex - 1) / p1.TotalMediaCount)

	if p1.CachedPassNumber ~= v2 then
		local v3 = CRC32((("TreadmillMediaPass/%*/%*"):format(p1.Seed, v2)))

		p1.CachedPassOrder = generatePatternOrder(p1.BucketIndices, p1.TotalMediaCount, v3, "TreadmillMediaPassBucket", v2 * p1.TotalMediaCount + 1)
		p1.CachedPassNumber = v2
	end

	return p1.CachedPassOrder[(CurrentIndex - 1) % p1.TotalMediaCount + 1]
end

function t2.IsReleaseTrackingStateCurrent(p1) --[[ IsReleaseTrackingStateCurrent | Line: 386 ]]
	return if p1.Seed > 0 and (p1.AlgorithmVersion == 5 and p1.HasSwappedRight ~= nil) then p1.ReleaseTrackingInitialized else false
end
function t2.ResolveReleaseTrackingState(p1, p2, p3) --[[ ResolveReleaseTrackingState | Line: 393 | Upvalues: t2 (copy), TreadmillMediaCatalog (copy), CRC32 (copy) ]]
	if t2.IsReleaseTrackingStateCurrent(p1) then
		return p1
	end

	local v2 = math.max(0, (math.floor(p1.CurrentIndex)))
	local v3 = if p1.Seed > 0 then if p1.AlgorithmVersion == 5 then true else false else false
	local v4, v5

	if v3 and TreadmillMediaCatalog.BASELINE_MEDIA_COUNT <= v2 then
		v4 = TreadmillMediaCatalog.BASELINE_RELEASE_VERSION
		v5 = v2
	else
		v5 = v2
		v4 = 0
	end

	local t = {
		AlgorithmVersion = 5,
		ReleaseTrackingInitialized = true,
		PendingReleaseVersion = 0,
		PendingCurrentMediaKey = nil
	}
	local v6 = if v3 then p1.Seed else 0

	t.Seed = if v6 > 0 then math.floor(v6) else CRC32((("TreadmillMediaFeed/%*"):format(p2)))
	t.CurrentIndex = if v4 > 0 then v5 else 0
	t.HasSwappedRight = p3
	t.FullFeedReleaseVersion = if v4 > 0 then TreadmillMediaCatalog.BASELINE_RELEASE_VERSION else TreadmillMediaCatalog.CURRENT_RELEASE_VERSION
	t.CompletedReleaseVersion = v4
	t.SeenPendingMediaKeys = {}

	return t
end
function t2.CreateRuntime(p1, p2, p3) --[[ CreateRuntime | Line: 425 | Upvalues: createEmptyBucketIndices (copy), TreadmillMediaCatalog (copy), TreadmillMediaIdentity (copy), CRC32 (copy), v2 (copy), rebuildFullFeedCatalog (copy), buildDeltaOrder (copy) ]]
	assert(if #p1 > 0 then true else false, "Treadmill media catalog must not be empty")

	local v22 = createEmptyBucketIndices()
	local t = {}

	for i, v in ipairs(p1) do
		TreadmillMediaCatalog.ResolveEntryReleaseVersion(v.ReleaseVersion)

		local v3 = TreadmillMediaIdentity.GetMediaKey(v)

		assert(not t[v3], (("Duplicate treadmill media key \"%*\""):format(v3)))
		t[v3] = true
		table.insert(v22[v.BucketType], i)
	end

	local CURRENT_RELEASE_VERSION = TreadmillMediaCatalog.CURRENT_RELEASE_VERSION
	local t2 = {
		CachedPassNumber = nil,
		CompletedReleaseVersion = 0,
		CurrentIndex = 0,
		DeltaCurrentMediaIndex = nil,
		DeltaPosition = 0,
		PendingCurrentMediaKey = nil,
		PendingReleaseVersion = 0,
		ReleaseTrackingInitialized = true,
		BucketIndices = v22,
		CachedPassOrder = {},
		CurrentReleaseVersion = CURRENT_RELEASE_VERSION,
		DeltaMediaIndexByKey = {},
		DeltaOrder = {},
		FullFeedReleaseVersion = CURRENT_RELEASE_VERSION
	}

	t2.HasSwappedRight = if p2.HasSwappedRight == true then true else false
	t2.MediaEntries = p1

	local Seed = p2.Seed

	t2.Seed = if Seed > 0 then math.floor(Seed) else CRC32((("TreadmillMediaFeed/%*"):format(p3)))
	t2.SeenPendingMediaKeys = {}
	t2.TotalMediaCount = #p1

	if p2.AlgorithmVersion ~= 5 then
		v2:AtTrace():Log("Resetting treadmill media feed state for algorithm version change")
		rebuildFullFeedCatalog(t2, t2.FullFeedReleaseVersion)

		return t2
	end

	t2.CurrentIndex = math.max(0, (math.floor(p2.CurrentIndex)))

	if p2.ReleaseTrackingInitialized then
		t2.FullFeedReleaseVersion = math.max(0, (math.floor(p2.FullFeedReleaseVersion)))
		t2.CompletedReleaseVersion = math.min(math.max(0, (math.floor(p2.CompletedReleaseVersion))), CURRENT_RELEASE_VERSION)
		t2.PendingReleaseVersion = math.max(0, (math.floor(p2.PendingReleaseVersion)))
		t2.PendingCurrentMediaKey = p2.PendingCurrentMediaKey
		t2.SeenPendingMediaKeys = table.clone(p2.SeenPendingMediaKeys)
	end

	if t2.CompletedReleaseVersion == 0 and t2.FullFeedReleaseVersion ~= CURRENT_RELEASE_VERSION then
		t2.CurrentIndex = 0
		t2.FullFeedReleaseVersion = CURRENT_RELEASE_VERSION
		t2.PendingReleaseVersion = 0
		t2.PendingCurrentMediaKey = nil
		t2.SeenPendingMediaKeys = {}
	end

	if t2.CompletedReleaseVersion > 0 and t2.FullFeedReleaseVersion == 0 then
		t2.FullFeedReleaseVersion = t2.CompletedReleaseVersion
	end

	if t2.PendingReleaseVersion <= t2.CompletedReleaseVersion or CURRENT_RELEASE_VERSION < t2.PendingReleaseVersion then
		t2.PendingReleaseVersion = 0
		t2.PendingCurrentMediaKey = nil
		t2.SeenPendingMediaKeys = {}
	else
		buildDeltaOrder(t2)
	end

	rebuildFullFeedCatalog(t2, t2.FullFeedReleaseVersion)

	return t2
end
function t2.Next(p1) --[[ Next | Line: 504 | Upvalues: takeNextDeltaMedia (copy), exportState (copy), completeDelta (copy), startDelta (copy), CRC32 (copy), generatePatternOrder (copy) ]]
	p1.HasSwappedRight = true

	if p1.PendingReleaseVersion > p1.CompletedReleaseVersion then
		local v1 = takeNextDeltaMedia(p1)

		if v1 ~= nil then
			return v1, exportState(p1)
		end

		completeDelta(p1)
	end

	if p1.CompletedReleaseVersion > 0 and p1.CompletedReleaseVersion < p1.CurrentReleaseVersion then
		local v2 = startDelta(p1)

		if v2 ~= nil then
			return v2, exportState(p1)
		end
	end

	p1.CurrentIndex = p1.CurrentIndex + 1

	if p1.FullFeedReleaseVersion == p1.CurrentReleaseVersion and p1.CurrentIndex >= p1.TotalMediaCount then
		p1.CompletedReleaseVersion = math.max(p1.CompletedReleaseVersion, p1.FullFeedReleaseVersion)
	end

	local CurrentIndex = p1.CurrentIndex
	local v4 = math.floor((CurrentIndex - 1) / p1.TotalMediaCount)

	if p1.CachedPassNumber ~= v4 then
		local v5 = CRC32((("TreadmillMediaPass/%*/%*"):format(p1.Seed, v4)))

		p1.CachedPassOrder = generatePatternOrder(p1.BucketIndices, p1.TotalMediaCount, v5, "TreadmillMediaPassBucket", v4 * p1.TotalMediaCount + 1)
		p1.CachedPassNumber = v4
	end

	return p1.CachedPassOrder[(CurrentIndex - 1) % p1.TotalMediaCount + 1], exportState(p1)
end
function t2.Current(p1) --[[ Current | Line: 524 | Upvalues: exportState (copy), takeNextDeltaMedia (copy), completeDelta (copy), CRC32 (copy), generatePatternOrder (copy) ]]
	if p1.PendingReleaseVersion > p1.CompletedReleaseVersion then
		local DeltaCurrentMediaIndex = p1.DeltaCurrentMediaIndex

		if DeltaCurrentMediaIndex ~= nil then
			return DeltaCurrentMediaIndex, exportState(p1)
		end

		local v1 = takeNextDeltaMedia(p1)

		if v1 ~= nil then
			return v1, exportState(p1)
		end

		completeDelta(p1)
	end

	local v2 = math.max(p1.CurrentIndex, 1)

	p1.CurrentIndex = v2

	local v4 = math.floor((v2 - 1) / p1.TotalMediaCount)

	if p1.CachedPassNumber ~= v4 then
		local v5 = CRC32((("TreadmillMediaPass/%*/%*"):format(p1.Seed, v4)))

		p1.CachedPassOrder = generatePatternOrder(p1.BucketIndices, p1.TotalMediaCount, v5, "TreadmillMediaPassBucket", v4 * p1.TotalMediaCount + 1)
		p1.CachedPassNumber = v4
	end

	return p1.CachedPassOrder[(v2 - 1) % p1.TotalMediaCount + 1], exportState(p1)
end
function t2.Previous(p1) --[[ Previous | Line: 542 | Upvalues: takePreviousDeltaMedia (copy), exportState (copy), CRC32 (copy), generatePatternOrder (copy) ]]
	if p1.PendingReleaseVersion > p1.CompletedReleaseVersion then
		local DeltaCurrentMediaIndex = p1.DeltaCurrentMediaIndex

		assert(DeltaCurrentMediaIndex ~= nil, "Pending treadmill media delta must have a current media entry")

		local v2 = takePreviousDeltaMedia(p1)

		if v2 == nil then
			return DeltaCurrentMediaIndex, exportState(p1), false
		end

		return v2, exportState(p1), true
	end

	local v4 = math.max(p1.CurrentIndex - 1, 1)
	local isNotCurrentIndex = v4 ~= p1.CurrentIndex

	p1.CurrentIndex = v4

	local v6 = math.floor((v4 - 1) / p1.TotalMediaCount)

	if p1.CachedPassNumber ~= v6 then
		local v7 = CRC32((("TreadmillMediaPass/%*/%*"):format(p1.Seed, v6)))

		p1.CachedPassOrder = generatePatternOrder(p1.BucketIndices, p1.TotalMediaCount, v7, "TreadmillMediaPassBucket", v6 * p1.TotalMediaCount + 1)
		p1.CachedPassNumber = v6
	end

	return p1.CachedPassOrder[(v4 - 1) % p1.TotalMediaCount + 1], exportState(p1), isNotCurrentIndex
end
function t2.ExportState(p1) --[[ ExportState | Line: 561 | Upvalues: exportState (copy) ]]
	return exportState(p1)
end
function t2.StatesEqual(p1, p2) --[[ StatesEqual | Line: 565 | Upvalues: statesEqual (copy) ]]
	return statesEqual(p1, p2)
end
function t2.IsLegalTransition(p1, p2, p3, p4) --[[ IsLegalTransition | Line: 569 | Upvalues: statesEqual (copy), t2 (copy) ]]
	if statesEqual(p2, p3) then
		return true
	end

	local _, v2 = t2.Current((t2.CreateRuntime(p1, p2, p4)))

	if statesEqual(v2, p3) then
		return true
	end

	if p2.PendingReleaseVersion > p2.CompletedReleaseVersion then
		local _2, v4, v5 = t2.Previous((t2.CreateRuntime(p1, p2, p4)))

		if v5 and statesEqual(v4, p3) then
			return true
		end

		local _3, v7 = t2.Next((t2.CreateRuntime(p1, p2, p4)))

		return statesEqual(v7, p3)
	end

	local v8 = t2.CreateRuntime(p1, p2, p4)
	local v9

	if p2.PendingReleaseVersion == 0 and (p3.PendingReleaseVersion == 0 and p3.CurrentIndex < p2.CurrentIndex) then
		local _2, v10, v11 = t2.Previous(v8)

		if not v11 then
			return false
		end

		v9 = v10
	else
		local _2, v12 = t2.Next(v8)

		v9 = v12
	end

	return statesEqual(v9, p3)
end

return t2