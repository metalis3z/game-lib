-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Player = require(ReplicatedStorage.Shared.Player)
local SettingsCmds = require(ReplicatedStorage.Shared.SettingsCmds)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local Shuffle = require(ReplicatedStorage.Shared.Utils.Numeric).Shuffle
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local v1 = {}
local SeparationLine = Workspace:WaitForChild("__OBJECTS"):WaitForChild("Areas"):WaitForChild("SeparationLine")
local LocalPlayer = Players.LocalPlayer
local v2 = table.clone({ 103006289023289, 1846088038, 9045766074, 1842150151 })
Shuffle(v2, Random.new())
local v3 = 1
local v4 = Audio.CreateMusic("OutdoorMusic", v2[1], false)
local v5 = Audio.CreateMusic("ArenaMusic", 125884818032934, true)
local v6 = Audio.CreateMusic("ChaseMusic", 121669627807766, true)
local v7 = Audio.CreateMusic("SafeZoneMusic", 121669627807766, true)
local v8, v9

if AreaEggResetCycle.NightMusic then
    local v10 = Audio.CreateMusic("ResetNightMusic", AreaEggResetCycle.NightMusic.Id, true)
    v8 = v10
    v9 = v10
end
local v11 = { v4, v5, v6, v7 }

if v9 then
    table.insert(v11, v9)
end
local v12 = {}
local v13 = false
local v14 = false
local v15 = false
local v16 = false
local v17 = false
local v18 = false
local v19 = false
local v20 = SettingsCmds.Allows("Music")
local v21 = HiddenUIHandler.IsHidden()
local v22 = ""
local v23 = 0

local function fade(v24, v25, v26, v27) -- line 52 | captures: Audio, v12
    local v28 = v12[v24]
    if v28 then
        v28:Cancel()
    end
    if v25 > 0 then
        if not v24.IsPlaying then
            v24:Play()
        end
    elseif v27 and not v24.IsPlaying then
        v24:Play()
    end
    local v29 = Audio.Fade(v24, v25, v26, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    v12[v24] = v29
    v29.Completed:Once(function(v30) -- line 66 | captures: v24, v25, v27, v29, v12
        if v12[v24] == v29 then
            v12[v24] = nil
            if v30 == Enum.PlaybackState.Completed and v25 <= 0 and not v27 then
                v24:Pause()
            end
        end
    end)
end

local function treadmillFeedActive() -- line 77 | captures: v19, TreadmillVideoGate
    return v19 and not TreadmillVideoGate.IsVideoPlayerDisabled()
end

local function mode() -- line 84 | captures: v13, v14, v15, v16, v17, v19, v20, v21, TreadmillVideoGate
    if v20 then
        if v17 then
            return "Night"
        end
        if v19 and not TreadmillVideoGate.IsVideoPlayerDisabled() then
            return "Treadmill"
        end
        if v14 then
            return "Silent"
        end
        if v15 then
            if v13 then
                return "Chase"
            end
            return "Arena"
        end
        if v21 then
            return "Silent"
        end
        if v16 then
            return "SafeZone"
        end
        return "Outdoor"
    end
    return "Silent"
end

local function refresh() -- line 115 | captures: v8, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, SoundService, AreaEggResetCycle, TreadmillVideoGate, v4, v5, v6, v7, fade
    local v31
    if v20 then
        if v17 then
            v31 = "Night"
        elseif v19 and not TreadmillVideoGate.IsVideoPlayerDisabled() then
            v31 = "Treadmill"
        elseif v14 then
            v31 = "Silent"
        elseif v15 then
            if v13 then
                v31 = "Chase"
            else
                v31 = "Arena"
            end
        elseif v21 then
            v31 = "Silent"
        elseif v16 then
            v31 = "SafeZone"
        else
            v31 = "Outdoor"
        end
    else
        v31 = "Silent"
    end
    local v32 = v22
    v22 = v31
    local v33
    if v31 == "Chase" or v32 == "Chase" then
        v33 = 0.1
    elseif v31 == "Arena" then
        v33 = 0.4
    else
        v33 = 0.8
    end
    local v34 = if v31 == "Outdoor" then 0.22 else 0
    fade(v4, v34, v33, true)
    local v35 = if v31 == "Arena" then 1.5 else 0
    fade(v5, v35, v33)
    local v36 = if v31 == "Chase" then 0.4 else 0
    fade(v6, v36, v33)
    local v37 = if v31 == "SafeZone" then 0.5 else 0
    fade(v7, v37, v33)
    if v8 then
        local v38 = if v31 == "Night" and v18 then AreaEggResetCycle.NightMusic.Volume else 0
        fade(v8, v38, AreaEggResetCycle.MusicTransitionSeconds)
    end
    local AdminAbuseMusic = SoundService.Music:FindFirstChild("AdminAbuseMusic")
    if not (AdminAbuseMusic and AdminAbuseMusic:IsA("SoundGroup")) then
        return
    end
    if v19 and not TreadmillVideoGate.IsVideoPlayerDisabled() then
        AdminAbuseMusic.Volume = 0
    else
        AdminAbuseMusic.Volume = 1
    end
end

local function updateArena() -- line 202 | captures: v15, GuardAreaGeometry, Player, SeparationLine, LocalPlayer, refresh
    local v39 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v40
    if v39 == nil then
        v40 = false
    else
        v40 = GuardAreaGeometry.IsPastLine(SeparationLine, v39.Position)
    end
    if v15 ~= v40 then
        v15 = v40
        refresh()
    end
end

function v1.EnterSaveZone() -- line 210 | captures: v16, refresh
    if not v16 then
        v16 = true
        refresh()
    end
end

function v1.ExitSaveZone() -- line 216 | captures: v16, refresh
    if v16 then
        v16 = false
        refresh()
    end
end

function v1.HasCustomTreadmill() -- line 222 | captures: v19
    return v19
end

function v1.SetCarryingAreaEgg(v41) -- line 225 | captures: v13, refresh
    if v13 ~= v41 then
        v13 = v41
        refresh()
    end
end

function v1.SetGuardedGameplay(v42) -- line 231 | captures: v14, refresh
    if v14 ~= v42 then
        v14 = v42
        refresh()
    end
end

function v1.SetResetNight(v43, v44) -- line 237 | captures: v17, v18, refresh
    local v45 = v43 and v44 == true
    if v17 == v43 then
        if v18 ~= v45 then
            v17 = v43
            v18 = v45
            refresh()
        end
    else
        v17 = v43
        v18 = v45
        refresh()
    end
end

v4.Ended:Connect(function() -- line 252 | captures: v3, Shuffle, v2, v4
    v3 += 1
    if #v2 < v3 then
        Shuffle(v2, Random.new())
        v3 = 1
    end
    v4.SoundId = ("rbxassetid://%*"):format(v2[v3])
    v4:Play()
end)
SettingsCmds.Changed:Connect(function(v46, v47) -- line 261 | captures: v20, refresh
    if v46 == "Music" then
        v20 = v47
        refresh()
    end
end)
HiddenUIHandler.Changed:Connect(function(v48) -- line 267 | captures: v21, refresh
    v21 = v48
    refresh()
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v49) -- line 271 | captures: v19, refresh
    v19 = v49 ~= nil
    refresh()
end)
TreadmillVideoGate.Changed:Connect(function() -- line 276 | captures: v19, refresh
    if v19 then
        refresh()
    end
end)
RunService.Heartbeat:Connect(function(v50) -- line 281 | captures: v15, v23, GuardAreaGeometry, Player, SeparationLine, LocalPlayer, refresh
    v23 += v50
    if not (v23 >= 0.1) then
        return
    end
    v23 %= 0.1
    local v51 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v52
    if v51 == nil then
        v52 = false
    else
        v52 = GuardAreaGeometry.IsPastLine(SeparationLine, v51.Position)
    end
    if v15 ~= v52 then
        v15 = v52
        refresh()
    end
end)
v4:Play()
local v53 = Player.Optional.HumanoidRootPart(LocalPlayer)
local v54

if v53 == nil then
    v54 = false
else
    v54 = GuardAreaGeometry.IsPastLine(SeparationLine, v53.Position)
end

if v15 ~= v54 then
    refresh()
end
refresh()
return table.freeze(v1)
