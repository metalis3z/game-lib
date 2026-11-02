-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Mutex = require(ReplicatedStorage.Shared.Modules.Mutex)
local Signal = require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage:WaitForChild("Shared").Modules.DefaultStats.Types.Interface)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Settings = require(ReplicatedStorage.Shared.Settings)
local t = require(ReplicatedStorage.Packages.t)
local Seal = require(ReplicatedStorage.Shared.Utils.Collections).Seal
local v2 = {}
local v3 = {
    field = Signal.new(),
    peerField = Signal.new(),
    profile = Signal.new(),
    peerProfile = Signal.new(),
    ready = Signal.new(),
    peerReady = Signal.new(),
    dropped = Signal.new()
}

v2.FieldChanged = v3.field
v2.PeerFieldChanged = v3.peerField
v2.ProfileChanged = v3.profile
v2.PeerProfileChanged = v3.peerProfile
v2.ProfileReady = v3.ready
v2.PeerProfileReady = v3.peerReady
v2.ProfileDropped = v3.dropped

local LocalPlayer = Players.LocalPlayer
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = false
local v8 = t.strict(t.instanceIsA("Player"))
local v9 = t.strict(t.table)
local v10 = t.strict(t.optional(t.table))
local v11 = t.strict(t.string)
local v12 = t.strict(t.callback)

local function guardFor(v13) -- line 44 | captures: Mutex, v5
    local v14 = v5[v13] or Mutex.new()
    v5[v13] = v14
    return v14
end

local function sealUnlessExempt(v15, v16) -- line 52 | captures: Settings, Seal
    if Settings.StatsNoFreeze[v15] == nil and type(v16) == "table" then
        Seal(v16)
    end
end

local function publish(v17, v18) -- line 58 | captures: v3, LocalPlayer, v6
    local v19 = LocalPlayer == v17
    for v20, v21 in v18 do
        if v19 then
            v3.field:Fire(v21.Field, v21.Next, v21.Prior, v21.Raw)
            local v22 = v6[v21.Field]
            if v22 then
                v22:Fire(v21.Next, v21.Prior, v21.Raw)
            end
        else
            v3.peerField:Fire(v17, v21.Field)
        end
    end
    if v19 then
        v3.profile:Fire()
    else
        v3.peerProfile:Fire(v17)
    end
end

local function enqueue(v23) -- line 81
    local Priors = v23.Priors
    local Raw = v23.Raw
    local v24 = {}
    for v25, v26 in v23.Written do
        local v27 = {
            Field = v25,
            Next = v26
        }
        v27.Prior = Priors and Priors[v25]
        v27.Raw = Raw and Raw[v25]
        v24[#v24 + 1] = v27
    end
    for v28 in v23.Cleared or {} do
        local v29 = { Field = v28 }
        v29.Prior = Priors and Priors[v28]
        v24[#v24 + 1] = v29
    end
    return v24
end

local function validated(v30) -- line 120 | captures: v8, v9, v10
    v8(v30.Player)
    v9(v30.Written)
    v10(v30.Cleared)
    return v30
end

local function announce(v31) -- line 126 | captures: v4, v8, v9, v10, publish, enqueue
    v8(v31.Player)
    v9(v31.Written)
    v10(v31.Cleared)
    local Player = v31.Player
    if v4[Player] then
        publish(Player, (enqueue(v31)))
    end
end

local function mergeDelta(v32, v33) -- line 135
    local v34 = v32.Inventory or {}
    for v35 in v33.Remove or {} do
        if v34[v35] ~= nil then
            v34[v35] = nil
        end
    end
    for v36, v37 in v33.Set or {} do
        v34[v36] = v37
    end
    return v34
end

local function absorb(v38) -- line 162 | captures: Settings, Seal, v4, v8, v9, v10, publish, enqueue, mergeDelta
    v8(v38.Player)
    v9(v38.Written)
    v10(v38.Cleared)
    local Player = v38.Player
    local v39 = v4[Player]
    if not v39 then
        return
    end
    local Written = v38.Written
    local Cleared = v38.Cleared
    local v40 = {}
    local v41 = {}
    for v42 in Cleared or {} do
        v40[v42] = v39[v42]
        v39[v42] = nil
    end
    for v43, v44 in Written do
        v40[v43] = v39[v43]
        local v45
        if v43 == "Inventory" and typeof(v44) == "table" and v44.__patch == true then
            v45 = mergeDelta(v39, v44)
        else
            v45 = v44
        end
        if Settings.StatsNoFreeze[v43] == nil and type(v45) == "table" then
            Seal(v45)
        end
        v39[v43] = v45
        v41[v43] = v45
    end
    local v46 = {
        Player = Player,
        Written = v41,
        Cleared = Cleared,
        Priors = v40,
        Raw = Written
    }
    publish(Player, (enqueue(v46)))
end

local function acquire(v47) -- line 213 | captures: v7, v1, Remotes, Settings, Seal, v3, LocalPlayer, v4, v8
    v8(v47)
    if v4[v47] then
        return true
    end
    local UserId = v47.UserId
    local v48 = LocalPlayer == v47
    local v49, v50 = pcall(function() -- line 221 | captures: v47, Remotes
        return Remotes.ProfileMirror.FetchProfile:InvokeServer(v47)
    end)
    if v49 then
        if v47 then
            if v50 then
                v1:AtTrace():Log("[SAVE] profile payload received for", UserId, v50)
                if typeof(v50) == "table" then
                    if not v4[v47] then
                        for v51, v52 in v50 do
                            if Settings.StatsNoFreeze[v51] == nil and type(v52) == "table" then
                                Seal(v52)
                            end
                        end
                        v4[v47] = v50
                        local v53 = if v48 then v3.ready else v3.peerReady
                        v7 = v7 or v48
                        v53:Fire(v47)
                    end
                    return true
                end
                warn((("[SAVE] %* profile arrived as %*, which cannot be cached"):format(UserId, (typeof(v50)))))
                if v48 then
                    v47.Character = nil
                    v47:Kick("Something went wrong fetching save. Please rejoin!")
                end
            end
        else
            warn((("[SAVE] %* disconnected mid-request"):format(UserId)))
        end
    else
        warn((("[SAVE] profile request for %* raised: %*"):format(UserId, (tostring(v50)))))
    end
    return false
end

function v2.Prefetch(v54) -- line 267 | captures: Mutex, v4, v5, v8, acquire
    v8(v54)
    local v55 = v5[v54] or Mutex.new()
    v5[v54] = v55
    v55:run(function() -- line 274 | captures: v54, v4, acquire
        while true do
            local v56, v57
            if v54 then
                if v4[v54] then
                    v57 = true
                else
                    acquire(v54)
                    if v54 == nil then
                        v56 = false
                    elseif v4[v54] == nil then
                        v56 = v54.Parent ~= nil
                    else
                        v56 = false
                    end
                    v57 = false
                end
            else
                v57 = true
            end
            if not v57 and v56 then
                task.wait(0.5)
                continue
            end
            break
        end
    end)
end

function v2.Get(v58, v59) -- line 289 | captures: Mutex, LocalPlayer, v4, v5, acquire
    local v60 = v58
    local v61
    if v58 then
        v61 = v58
    else
        v61 = LocalPlayer
        v60 = LocalPlayer
    end
    local v62
    if v61 and v61.Parent then
        if v59 == nil or v59 == true then
            v62 = v4[v61]
        end
    else
        return nil
    end
    if v62 then
        return v62
    end
    local v63 = v5[v61] or Mutex.new()
    v5[v61] = v63
    return v63:run(function() -- line 313 | captures: v60, LocalPlayer, v4, acquire
        if v60 and v60.Parent then
            if not acquire(v60) and v60 == LocalPlayer then
                task.wait(1.05)
                while v60 do
                    if v60.Parent and acquire(v60) then
                        task.wait(1.05)
                        continue
                    end
                    break
                end
            end
            if v60 then
                return v4[v60]
            end
        end
        return nil
    end)
end

function v2.ReadUnguarded(v64) -- line 332 | captures: v2
    return v2.Get(v64, nil)
end

function v2.Cache() -- line 335 | captures: v4
    return v4
end

function v2.FieldSignal(v65) -- line 338 | captures: Signal, v6
    local v66 = v6[v65] or Signal.new()
    v6[v65] = v66
    return v66
end

function v2.WatchFields(v67, v68) -- line 346 | captures: Trove, v2, v9, v11, v12
    local v69 = if typeof(v67) == "string" then { v67 } else v67
    v9(v69)
    v12(v68)
    local v70 = Trove.new()
    for v71, v72 in v69 do
        v11(v72)
        v70:Connect(v2.FieldSignal(v72), v68)
    end
    return v70
end

function v2.ApplyLocalFieldEntry(v73, v74, v75, v76) -- line 365 | captures: Settings, v2, LocalPlayer, absorb
    local v77 = v76 or LocalPlayer
    local v78 = v2.Get(v77)
    local v79 = v78 and v78[v73]
    if not v79 then
        return
    end
    local v80
    if Settings.StatsNoFreeze[v73] then
        v80 = v79
    else
        v80 = table.clone(v79)
    end
    v80[v74] = v75
    local v81 = { Player = v77 }
    local v82 = {}
    v82[v73] = v80
    v81.Written = v82
    absorb(v81)
end

function v2.ApplyLocalField(v83, v84, v85) -- line 390 | captures: LocalPlayer, absorb
    local v86 = {}
    v86.Player = v85 or LocalPlayer
    local v87 = {}
    v87[v83] = v84
    v86.Written = v87
    absorb(v86)
end

function v2.AnnounceLocalField(v88, v89, v90) -- line 402 | captures: LocalPlayer, v4, v8, v9, v10, publish, enqueue
    local v91 = {}
    v91.Player = v90 or LocalPlayer
    local v92 = {}
    v92[v88] = v89
    v91.Written = v92
    v8(v91.Player)
    v9(v91.Written)
    v10(v91.Cleared)
    local Player = v91.Player
    if v4[Player] then
        publish(Player, (enqueue(v91)))
    end
end

function v2.IsLocalDataLoaded() -- line 420 | captures: v7
    return v7
end

Remotes.ProfileMirror.ProfileDelta.OnClientEvent:Connect(function(v93, v94, v95) -- line 423 | captures: LocalPlayer, absorb
    local v96 = {}
    v96.Player = v95 or LocalPlayer
    v96.Written = v93
    v96.Cleared = v94
    absorb(v96)
end)
Players.PlayerAdded:Connect(function(v97) -- line 434 | captures: v2
    task.spawn(v2.Prefetch, v97)
end)
Players.PlayerRemoving:Connect(function(v98) -- line 437 | captures: v3, v4, v5
    if v4[v98] then
        task.delay(5, function() -- line 439 | captures: v98, v3, v4
            v4[v98] = nil
            v3.dropped:Fire(v98)
        end)
    end
    local v99 = v5[v98]
    if v99 then
        v5[v98] = nil
        v99:destroy()
    end
end)
for v100, v101 in Players:GetPlayers() do
    task.spawn(v2.Prefetch, v101)
end
return v2
