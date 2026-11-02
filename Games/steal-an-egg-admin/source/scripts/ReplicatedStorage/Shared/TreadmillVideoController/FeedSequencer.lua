-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crc32 = require(ReplicatedStorage.Shared.Utils.Codec).Crc32
local Log = require(ReplicatedStorage.Packages.Log)
local Shuffle = require(ReplicatedStorage.Shared.Utils.Numeric).Shuffle
local TreadmillMediaCatalog = require(ReplicatedStorage.Data.TreadmillMediaCatalog)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
require(script.Parent.Types.Interface)
local v1 = {
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
local v2 = #v1
local v3 = Log.new()
local v4 = {}

local function createEmptyBucketIndices() -- line 26
    return {
        Brainrot = {},
        Funny = {},
        Satisfying = {},
        WeirdOrHorror = {},
        Music = {}
    }
end

local function normalizeFeedIndex(v5) -- line 35
    local v6 = math.floor(v5)
    return (math.max(0, v6))
end

local function normalizeReleaseVersion(v7) -- line 38
    local v8 = math.floor(v7)
    return (math.max(0, v8))
end

local function normalizeSeed(v9, v10) -- line 41 | captures: Crc32
    if v9 > 0 then
        return (math.floor(v9))
    end
    return Crc32((("TreadmillMediaFeed/%*"):format(v10)))
end

local function bucketForFeedIndex(v11) -- line 47 | captures: v1, v2
    return v1[(v11 - 1) % v2 + 1] or v1[1]
end

local function createBucketOrder(v12, v13, v14, v15) -- line 54 | captures: Crc32, Shuffle
    local v16 = table.clone(v12)
    local v17 = Random.new(Crc32((("%*/%*/%*"):format(v15, v13, v14))))
    return Shuffle(v16, v17)
end

local function createBucketOrders(v18, v19, v20) -- line 59 | captures: Crc32, Shuffle
    local v21 = {}
    local v22 = table.clone(v18.Brainrot)
    local v23 = Random.new(Crc32((("%*/%*/Brainrot"):format(v20, v19))))
    v21.Brainrot = Shuffle(v22, v23)
    local v24 = table.clone(v18.Funny)
    local v25 = Random.new(Crc32((("%*/%*/Funny"):format(v20, v19))))
    v21.Funny = Shuffle(v24, v25)
    local v26 = table.clone(v18.Satisfying)
    local v27 = Random.new(Crc32((("%*/%*/Satisfying"):format(v20, v19))))
    v21.Satisfying = Shuffle(v26, v27)
    local v28 = table.clone(v18.WeirdOrHorror)
    local v29 = Random.new(Crc32((("%*/%*/WeirdOrHorror"):format(v20, v19))))
    v21.WeirdOrHorror = Shuffle(v28, v29)
    local v30 = table.clone(v18.Music)
    local v31 = Random.new(Crc32((("%*/%*/Music"):format(v20, v19))))
    v21.Music = Shuffle(v30, v31)
    return v21
end

local function takeNextFromBucket(v32, v33, v34) -- line 78
    local v35 = v33[v34]
    local v36 = v32[v34][v35]
    if v36 == nil then
        return nil
    end
    v33[v34] = v35 + 1
    return v36
end

local function takeNextFromFallbackBucket(v37, v38, v39, v40) -- line 87
    if v40 == v39 then
        return nil
    end
    local v41 = v38[v40]
    local v42 = v37[v40][v41]
    if v42 == nil then
        return nil
    end
    v38[v40] = v41 + 1
    return v42
end

local function takeNextPatternMedia(v43, v44, v45) -- line 99
    local v46 = v44[v45]
    local v47 = v43[v45][v46]
    if v47 ~= nil then
        v44[v45] = v46 + 1
    end
    local v48
    if v47 then
        v48 = v47
    else
        local v49
        if v45 == "Brainrot" then
        else
            local Brainrot = v44.Brainrot
            v49 = v43.Brainrot[Brainrot]
            if v49 ~= nil then
                v44.Brainrot = Brainrot + 1
            end
        end
        if v49 then
            v48 = v49
        else
            local v50
            if v45 == "Funny" then
            else
                local Funny = v44.Funny
                v50 = v43.Funny[Funny]
                if v50 ~= nil then
                    v44.Funny = Funny + 1
                end
            end
            if v50 then
                v48 = v50
            else
                local v51
                if v45 == "Satisfying" then
                else
                    local Satisfying = v44.Satisfying
                    v51 = v43.Satisfying[Satisfying]
                    if v51 ~= nil then
                        v44.Satisfying = Satisfying + 1
                    end
                end
                if v51 then
                    v48 = v51
                else
                    local v52
                    if v45 == "WeirdOrHorror" then
                    else
                        local WeirdOrHorror = v44.WeirdOrHorror
                        v52 = v43.WeirdOrHorror[WeirdOrHorror]
                        if v52 ~= nil then
                            v44.WeirdOrHorror = WeirdOrHorror + 1
                        end
                    end
                    if v52 then
                        v48 = v52
                    elseif v45 == "Music" then
                    else
                        local Music = v44.Music
                        v48 = v43.Music[Music]
                        if v48 ~= nil then
                            v44.Music = Music + 1
                        end
                    end
                end
            end
        end
    end
    local v53 = v48 ~= nil
    assert(v53, "Expected unseen treadmill media while sequence is incomplete")
    return v48
end

local function generatePatternOrder(v54, v55, v56, v57, v58) -- line 188 | captures: v1, v2, createBucketOrders, takeNextPatternMedia
    local v59 = createBucketOrders(v54, v56, v57)
    local v60 = {
        Brainrot = 1,
        Funny = 1,
        Satisfying = 1,
        WeirdOrHorror = 1,
        Music = 1
    }
    local v61 = table.create(v55)
    for v62 = 1, v55 do
        local v63 = v1[(v58 + v62 - 1 - 1) % v2 + 1] or v1[1]
        v61[v62] = takeNextPatternMedia(v59, v60, v63)
    end
    return v61
end

local function generateFullPass(v64, v65) -- line 211 | captures: Crc32, generatePatternOrder
    local v66 = Crc32((("TreadmillMediaPass/%*/%*"):format(v64.Seed, v65)))
    local v67 = v65 * v64.TotalMediaCount + 1
    return (generatePatternOrder(v64.BucketIndices, v64.TotalMediaCount, v66, "TreadmillMediaPassBucket", v67))
end

local function resolveFullMediaIndex(v68, v69) -- line 216 | captures: Crc32, generatePatternOrder
    local v70 = (v69 - 1) / v68.TotalMediaCount
    local v71 = math.floor(v70)
    if v68.CachedPassNumber ~= v71 then
        local v72 = Crc32((("TreadmillMediaPass/%*/%*"):format(v68.Seed, v71)))
        v68.CachedPassOrder = generatePatternOrder(v68.BucketIndices, v68.TotalMediaCount, v72, "TreadmillMediaPassBucket", v71 * v68.TotalMediaCount + 1)
        v68.CachedPassNumber = v71
    end
    return v68.CachedPassOrder[(v69 - 1) % v68.TotalMediaCount + 1]
end

local function exportState(v73) -- line 225
    return {
        AlgorithmVersion = 5,
        Seed = v73.Seed,
        CurrentIndex = v73.CurrentIndex,
        HasSwappedRight = v73.HasSwappedRight,
        ReleaseTrackingInitialized = v73.ReleaseTrackingInitialized,
        FullFeedReleaseVersion = v73.FullFeedReleaseVersion,
        CompletedReleaseVersion = v73.CompletedReleaseVersion,
        PendingReleaseVersion = v73.PendingReleaseVersion,
        PendingCurrentMediaKey = v73.PendingCurrentMediaKey,
        SeenPendingMediaKeys = table.clone(v73.SeenPendingMediaKeys)
    }
end

local function statesEqual(v74, v75) -- line 239
    if v74.Seed == v75.Seed and v74.CurrentIndex == v75.CurrentIndex and v74.AlgorithmVersion == v75.AlgorithmVersion and v74.HasSwappedRight == v75.HasSwappedRight and v74.ReleaseTrackingInitialized == v75.ReleaseTrackingInitialized and v74.FullFeedReleaseVersion == v75.FullFeedReleaseVersion and v74.CompletedReleaseVersion == v75.CompletedReleaseVersion and v74.PendingReleaseVersion == v75.PendingReleaseVersion and v74.PendingCurrentMediaKey == v75.PendingCurrentMediaKey then
        for v76, v77 in pairs(v74.SeenPendingMediaKeys) do
            if v77 ~= v75.SeenPendingMediaKeys[v76] then
                return false
            end
        end
        for v78, v79 in pairs(v75.SeenPendingMediaKeys) do
            if v79 ~= v74.SeenPendingMediaKeys[v78] then
                return false
            end
        end
        return true
    end
    return false
end

local function rebuildFullFeedCatalog(v80, v81) -- line 255 | captures: createEmptyBucketIndices
    local v82 = createEmptyBucketIndices()
    local v83 = 0
    for v84, v85 in ipairs(v80.MediaEntries) do
        if v85.ReleaseVersion <= v81 then
            local v86 = v82[v85.BucketType]
            table.insert(v86, v84)
            v83 += 1
        end
    end
    local v87 = v83 > 0
    local v88 = ("Treadmill full feed release %* must not be empty"):format(v81)
    assert(v87, v88)
    v80.BucketIndices = v82
    v80.TotalMediaCount = v83
    v80.CachedPassNumber = nil
    v80.CachedPassOrder = {}
end

local function buildDeltaOrder(v89) -- line 271 | captures: Crc32, TreadmillMediaIdentity, createEmptyBucketIndices, generatePatternOrder
    local v90 = createEmptyBucketIndices()
    local v91 = {}
    local v92 = 0
    for v93, v94 in ipairs(v89.MediaEntries) do
        if v89.CompletedReleaseVersion < v94.ReleaseVersion and v94.ReleaseVersion <= v89.PendingReleaseVersion then
            v91[TreadmillMediaIdentity.GetMediaKey(v94)] = v93
            local v95 = v90[v94.BucketType]
            table.insert(v95, v93)
            v92 += 1
        end
    end
    v89.DeltaMediaIndexByKey = v91
    v89.DeltaPosition = 0
    v89.DeltaCurrentMediaIndex = nil
    if v92 == 0 then
        v89.DeltaOrder = {}
    else
        local v96 = Crc32((("TreadmillMediaDelta/%*/%*"):format(v89.Seed, v89.PendingReleaseVersion)))
        v89.DeltaOrder = generatePatternOrder(v90, v92, v96, "TreadmillMediaDeltaBucket", 1)
        local PendingCurrentMediaKey = v89.PendingCurrentMediaKey
        if PendingCurrentMediaKey ~= nil then
            local v97 = v91[PendingCurrentMediaKey]
            if v97 == nil then
                v89.PendingCurrentMediaKey = nil
            else
                v89.DeltaCurrentMediaIndex = v97
                for v98, v99 in ipairs(v89.DeltaOrder) do
                    if v99 == v97 then
                        v89.DeltaPosition = v98
                        return
                    end
                end
            end
        end
    end
end

local function completeDelta(v100) -- line 308 | captures: rebuildFullFeedCatalog
    v100.CompletedReleaseVersion = v100.PendingReleaseVersion
    v100.PendingReleaseVersion = 0
    v100.PendingCurrentMediaKey = nil
    v100.SeenPendingMediaKeys = {}
    v100.DeltaOrder = {}
    v100.DeltaMediaIndexByKey = {}
    v100.DeltaCurrentMediaIndex = nil
    v100.DeltaPosition = 0
    v100.CurrentIndex = 0
    v100.FullFeedReleaseVersion = v100.CurrentReleaseVersion
    rebuildFullFeedCatalog(v100, v100.FullFeedReleaseVersion)
end

local function takeNextDeltaMedia(v101) -- line 321 | captures: TreadmillMediaIdentity
    local v102 = #v101.DeltaOrder
    local v103 = v101.DeltaPosition + 1
    if v101.DeltaCurrentMediaIndex == nil then
        v103 = 0
        for v104, v105 in ipairs(v101.DeltaOrder) do
            if not v101.SeenPendingMediaKeys[TreadmillMediaIdentity.GetMediaKey(v101.MediaEntries[v105])] then
                v103 = v104
                break
            end
            v103 = 0
        end
    end
    if v103 < 1 or v102 < v103 then
        return nil
    end
    local v106 = v101.DeltaOrder[v103]
    local v107 = TreadmillMediaIdentity.GetMediaKey(v101.MediaEntries[v106])
    v101.DeltaPosition = v103
    v101.DeltaCurrentMediaIndex = v106
    v101.PendingCurrentMediaKey = v107
    v101.SeenPendingMediaKeys[v107] = true
    return v106
end

local function takePreviousDeltaMedia(v108) -- line 344 | captures: TreadmillMediaIdentity
    local v109 = v108.DeltaPosition - 1
    for v110 = v109, 1, -1 do
        local v111 = v108.DeltaOrder[v110]
        local v112 = TreadmillMediaIdentity.GetMediaKey(v108.MediaEntries[v111])
        if v108.SeenPendingMediaKeys[v112] then
            v108.DeltaPosition = v110
            v108.DeltaCurrentMediaIndex = v111
            v108.PendingCurrentMediaKey = v112
            return v111
        end
    end
    return nil
end

local function startDelta(v113) -- line 360 | captures: buildDeltaOrder, completeDelta, takeNextDeltaMedia
    v113.PendingReleaseVersion = v113.CurrentReleaseVersion
    v113.PendingCurrentMediaKey = nil
    v113.SeenPendingMediaKeys = {}
    buildDeltaOrder(v113)
    local v114 = takeNextDeltaMedia(v113)
    if v114 == nil then
        completeDelta(v113)
    end
    return v114
end

local function takeNextFullMedia(v115) -- line 371 | captures: Crc32, generatePatternOrder
    v115.CurrentIndex += 1
    if v115.FullFeedReleaseVersion == v115.CurrentReleaseVersion and v115.TotalMediaCount <= v115.CurrentIndex then
        local CompletedReleaseVersion = v115.CompletedReleaseVersion
        local FullFeedReleaseVersion = v115.FullFeedReleaseVersion
        v115.CompletedReleaseVersion = math.max(CompletedReleaseVersion, FullFeedReleaseVersion)
    end
    local CurrentIndex = v115.CurrentIndex
    local v116 = (CurrentIndex - 1) / v115.TotalMediaCount
    local v117 = math.floor(v116)
    if v115.CachedPassNumber ~= v117 then
        local v118 = Crc32((("TreadmillMediaPass/%*/%*"):format(v115.Seed, v117)))
        v115.CachedPassOrder = generatePatternOrder(v115.BucketIndices, v115.TotalMediaCount, v118, "TreadmillMediaPassBucket", v117 * v115.TotalMediaCount + 1)
        v115.CachedPassNumber = v117
    end
    return v115.CachedPassOrder[(CurrentIndex - 1) % v115.TotalMediaCount + 1]
end

local function IsReleaseTrackingStateCurrent(v119) -- line 386
    if v119.Seed > 0 and v119.AlgorithmVersion == 5 and v119.HasSwappedRight ~= nil then
        return v119.ReleaseTrackingInitialized
    end
    return false
end

v4.IsReleaseTrackingStateCurrent = IsReleaseTrackingStateCurrent

function v4.ResolveReleaseTrackingState(v120, v121, v122) -- line 396 | captures: Crc32, TreadmillMediaCatalog, v4
    if v4.IsReleaseTrackingStateCurrent(v120) then
        return v120
    end
    local CurrentIndex = v120.CurrentIndex
    local v123 = math.floor(CurrentIndex)
    local v124 = math.max(0, v123)
    local v125 = if v120.Seed > 0 then v120.AlgorithmVersion == 5 else false
    local v126
    if v125 then
        if TreadmillMediaCatalog.BASELINE_MEDIA_COUNT <= v124 then
            v126 = TreadmillMediaCatalog.BASELINE_RELEASE_VERSION
        end
    else
        v126 = 0
    end
    local v127 = {
        AlgorithmVersion = 5,
        ReleaseTrackingInitialized = true,
        PendingReleaseVersion = 0
    }
    local v128 = if v125 then v120.Seed else 0
    if v128 <= 0 then
        v127.Seed = Crc32((("TreadmillMediaFeed/%*"):format(v121)))
    else
        v127.Seed = math.floor(v128)
    end
    if v126 <= 0 then
        v124 = 0
    end
    v127.CurrentIndex = v124
    v127.HasSwappedRight = v122
    if v126 <= 0 then
        v127.FullFeedReleaseVersion = TreadmillMediaCatalog.CURRENT_RELEASE_VERSION
    else
        v127.FullFeedReleaseVersion = TreadmillMediaCatalog.BASELINE_RELEASE_VERSION
    end
    v127.CompletedReleaseVersion = v126
    v127.SeenPendingMediaKeys = {}
    return v127
end

function v4.CreateRuntime(v129, v130, v131) -- line 437 | captures: Crc32, TreadmillMediaCatalog, TreadmillMediaIdentity, v3, createEmptyBucketIndices, rebuildFullFeedCatalog, buildDeltaOrder
    local v132 = #v129 > 0
    assert(v132, "Treadmill media catalog must not be empty")
    local v133 = createEmptyBucketIndices()
    local v134 = {}
    local v135 = TreadmillMediaCatalog.CURRENT_RELEASE_VERSION
    for v136, v137 in ipairs(v129) do
        local v138 = TreadmillMediaCatalog.ResolveEntryReleaseVersion(v137.ReleaseVersion)
        v135 = math.max(v135, v138)
        local v139 = TreadmillMediaIdentity.GetMediaKey(v137)
        local v140 = not v134[v139]
        local v141 = ("Duplicate treadmill media key \"%*\""):format(v139)
        assert(v140, v141)
        v134[v139] = true
        local v142 = v133[v137.BucketType]
        table.insert(v142, v136)
    end
    local v143 = {
        CompletedReleaseVersion = 0,
        CurrentIndex = 0,
        DeltaPosition = 0,
        PendingReleaseVersion = 0,
        ReleaseTrackingInitialized = true,
        BucketIndices = v133,
        CachedPassOrder = {},
        CurrentReleaseVersion = v135,
        DeltaMediaIndexByKey = {}
    }
    v143.DeltaOrder = {}
    v143.FullFeedReleaseVersion = v135
    v143.HasSwappedRight = v130.HasSwappedRight == true
    v143.MediaEntries = v129
    local Seed = v130.Seed
    if Seed <= 0 then
        v143.Seed = Crc32((("TreadmillMediaFeed/%*"):format(v131)))
    else
        v143.Seed = math.floor(Seed)
    end
    v143.SeenPendingMediaKeys = {}
    v143.TotalMediaCount = #v129
    if v130.AlgorithmVersion == 5 then
        local CurrentIndex = v130.CurrentIndex
        local v144 = math.floor(CurrentIndex)
        v143.CurrentIndex = math.max(0, v144)
        if v130.ReleaseTrackingInitialized then
            local FullFeedReleaseVersion = v130.FullFeedReleaseVersion
            local v145 = math.floor(FullFeedReleaseVersion)
            v143.FullFeedReleaseVersion = math.max(0, v145)
            local CompletedReleaseVersion = v130.CompletedReleaseVersion
            local v146 = math.floor(CompletedReleaseVersion)
            local v147 = math.max(0, v146)
            v143.CompletedReleaseVersion = math.min(v147, v135)
            local PendingReleaseVersion = v130.PendingReleaseVersion
            local v148 = math.floor(PendingReleaseVersion)
            v143.PendingReleaseVersion = math.max(0, v148)
            v143.PendingCurrentMediaKey = v130.PendingCurrentMediaKey
            v143.SeenPendingMediaKeys = table.clone(v130.SeenPendingMediaKeys)
        end
        if v143.CompletedReleaseVersion == 0 and v143.FullFeedReleaseVersion ~= v135 then
            v143.CurrentIndex = 0
            v143.FullFeedReleaseVersion = v135
            v143.PendingReleaseVersion = 0
            v143.PendingCurrentMediaKey = nil
            v143.SeenPendingMediaKeys = {}
        end
        if v143.CompletedReleaseVersion > 0 and v143.FullFeedReleaseVersion == 0 then
            v143.FullFeedReleaseVersion = v143.CompletedReleaseVersion
        end
        if v143.PendingReleaseVersion <= v143.CompletedReleaseVersion then
            v143.PendingReleaseVersion = 0
            v143.PendingCurrentMediaKey = nil
            v143.SeenPendingMediaKeys = {}
        elseif v143.PendingReleaseVersion <= v135 then
            buildDeltaOrder(v143)
        else
            v143.PendingReleaseVersion = 0
            v143.PendingCurrentMediaKey = nil
            v143.SeenPendingMediaKeys = {}
        end
    else
        v3:AtTrace():Log("Resetting treadmill media feed state for algorithm version change")
    end
    rebuildFullFeedCatalog(v143, v143.FullFeedReleaseVersion)
    return v143
end

function v4.Next(v149) -- line 514 | captures: Crc32, generatePatternOrder, exportState, completeDelta, takeNextDeltaMedia, startDelta
    v149.HasSwappedRight = true
    if v149.CompletedReleaseVersion < v149.PendingReleaseVersion then
        local v150 = takeNextDeltaMedia(v149)
        if v150 == nil then
            completeDelta(v149)
            return
        end
        return v150, (exportState(v149))
    end
    if v149.CompletedReleaseVersion <= 0 then
        v149.CurrentIndex += 1
        if v149.FullFeedReleaseVersion == v149.CurrentReleaseVersion and v149.TotalMediaCount <= v149.CurrentIndex then
            local CompletedReleaseVersion = v149.CompletedReleaseVersion
            local FullFeedReleaseVersion = v149.FullFeedReleaseVersion
            v149.CompletedReleaseVersion = math.max(CompletedReleaseVersion, FullFeedReleaseVersion)
        end
        local CurrentIndex = v149.CurrentIndex
        local v151 = (CurrentIndex - 1) / v149.TotalMediaCount
        local v152 = math.floor(v151)
        if v149.CachedPassNumber ~= v152 then
            local v153 = Crc32((("TreadmillMediaPass/%*/%*"):format(v149.Seed, v152)))
            v149.CachedPassOrder = generatePatternOrder(v149.BucketIndices, v149.TotalMediaCount, v153, "TreadmillMediaPassBucket", v152 * v149.TotalMediaCount + 1)
            v149.CachedPassNumber = v152
        end
        return v149.CachedPassOrder[(CurrentIndex - 1) % v149.TotalMediaCount + 1], (exportState(v149))
    end
    local v154 = v149.CompletedReleaseVersion < v149.CurrentReleaseVersion
    local v155, v156
    if v154 then
        v155 = startDelta(v149)
        v156 = v155 == nil
    end
    if not v154 or v156 then
        return
    end
    return v155, (exportState(v149))
end

function v4.Current(v157) -- line 544 | captures: Crc32, generatePatternOrder, exportState, completeDelta, takeNextDeltaMedia
    local CompletedReleaseVersion = v157.CompletedReleaseVersion
    if v157.PendingReleaseVersion <= CompletedReleaseVersion then
        local CurrentIndex = v157.CurrentIndex
        local v158 = math.max(CurrentIndex, 1)
        v157.CurrentIndex = v158
        local v159 = (v158 - 1) / v157.TotalMediaCount
        local v160 = math.floor(v159)
        if v157.CachedPassNumber ~= v160 then
            local v161 = Crc32((("TreadmillMediaPass/%*/%*"):format(v157.Seed, v160)))
            v157.CachedPassOrder = generatePatternOrder(v157.BucketIndices, v157.TotalMediaCount, v161, "TreadmillMediaPassBucket", v160 * v157.TotalMediaCount + 1)
            v157.CachedPassNumber = v160
        end
        return v157.CachedPassOrder[(v158 - 1) % v157.TotalMediaCount + 1], (exportState(v157))
    end
    local DeltaCurrentMediaIndex = v157.DeltaCurrentMediaIndex
    if DeltaCurrentMediaIndex == nil then
        local v162 = takeNextDeltaMedia(v157)
        if v162 == nil then
            completeDelta(v157)
            local CurrentIndex = v157.CurrentIndex
            local v163 = math.max(CurrentIndex, 1)
            v157.CurrentIndex = v163
            local v164 = (v163 - 1) / v157.TotalMediaCount
            local v165 = math.floor(v164)
            if v157.CachedPassNumber ~= v165 then
                local v166 = Crc32((("TreadmillMediaPass/%*/%*"):format(v157.Seed, v165)))
                v157.CachedPassOrder = generatePatternOrder(v157.BucketIndices, v157.TotalMediaCount, v166, "TreadmillMediaPassBucket", v165 * v157.TotalMediaCount + 1)
                v157.CachedPassNumber = v165
            end
            return v157.CachedPassOrder[(v163 - 1) % v157.TotalMediaCount + 1], (exportState(v157))
        end
        return v162, (exportState(v157))
    end
    return DeltaCurrentMediaIndex, (exportState(v157))
end

function v4.Previous(v167) -- line 576 | captures: Crc32, generatePatternOrder, exportState, takePreviousDeltaMedia
    if v167.CompletedReleaseVersion < v167.PendingReleaseVersion then
        local DeltaCurrentMediaIndex = v167.DeltaCurrentMediaIndex
        local v168 = DeltaCurrentMediaIndex ~= nil
        assert(v168, "Pending treadmill media delta must have a current media entry")
        local v169 = takePreviousDeltaMedia(v167)
        if v169 == nil then
            return DeltaCurrentMediaIndex, exportState(v167), false
        end
        return v169, exportState(v167), true
    end
    local v170 = v167.CurrentIndex - 1
    local v171 = math.max(v170, 1)
    local v172 = v171 ~= v167.CurrentIndex
    v167.CurrentIndex = v171
    local v173 = (v171 - 1) / v167.TotalMediaCount
    local v174 = math.floor(v173)
    if v167.CachedPassNumber ~= v174 then
        local v175 = Crc32((("TreadmillMediaPass/%*/%*"):format(v167.Seed, v174)))
        v167.CachedPassOrder = generatePatternOrder(v167.BucketIndices, v167.TotalMediaCount, v175, "TreadmillMediaPassBucket", v174 * v167.TotalMediaCount + 1)
        v167.CachedPassNumber = v174
    end
    return v167.CachedPassOrder[(v171 - 1) % v167.TotalMediaCount + 1], exportState(v167), v172
end

function v4.ExportState(v176) -- line 604 | captures: exportState
    return (exportState(v176))
end

function v4.StatesEqual(v177, v178) -- line 607 | captures: statesEqual
    return (statesEqual(v177, v178))
end

function v4.IsLegalTransition(v179, v180, v181, v182) -- line 610 | captures: v4, statesEqual
    if statesEqual(v180, v181) then
        return true
    end
    local v183 = v4.CreateRuntime(v179, v180, v182)
    local v184, v185 = v4.Current(v183)
    _ = v184
    if statesEqual(v185, v181) then
        return true
    end
    if v180.CompletedReleaseVersion < v180.PendingReleaseVersion then
        local v186 = v4.CreateRuntime(v179, v180, v182)
        local v187, v188, v189 = v4.Previous(v186)
        _ = v187
        if v189 then
            if statesEqual(v188, v181) then
                return true
            end
            local v190 = v4.CreateRuntime(v179, v180, v182)
            local v191, v192 = v4.Next(v190)
            _ = v191
            return (statesEqual(v192, v181))
        end
        local v193 = v4.CreateRuntime(v179, v180, v182)
        local v194, v195 = v4.Next(v193)
        _ = v194
        return (statesEqual(v195, v181))
    end
    local v196 = v4.CreateRuntime(v179, v180, v182)
    if v180.PendingReleaseVersion == 0 and v181.PendingReleaseVersion == 0 then
        local CurrentIndex = v181.CurrentIndex
        if not (v180.CurrentIndex <= CurrentIndex) then
            local v197, v198, v199 = v4.Previous(v196)
            if v199 then
                return (statesEqual(v198, v181))
            end
            return false
        end
    end
    local v200, v201 = v4.Next(v196)
    return (statesEqual(v201, v181))
end

return v4
