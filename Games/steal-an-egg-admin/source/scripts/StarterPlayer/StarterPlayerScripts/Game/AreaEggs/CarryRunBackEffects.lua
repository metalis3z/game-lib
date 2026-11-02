-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AreaEggs)
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggState = require(ReplicatedStorage.Client.EggState)
local ScreenEffects = require(script.ScreenEffects)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local __OBJECTS = Workspace.__OBJECTS
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS must be a Folder")
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS.Areas must be a Folder")
local GuardAreas = Areas.GuardAreas
local Folder_3 = GuardAreas:IsA("Folder")
assert(Folder_3, "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")
local v1
local v2 = {}

local function stopGuardedMusic(v3) -- line 29 | captures: MusicDirector
    if v3.GuardedMusicActive then
        v3.GuardedMusicActive = false
        MusicDirector.SetGuardedGameplay(false)
    end
end

local function releaseUiHide(v4) -- line 36
    local ReleaseUiHide = v4.ReleaseUiHide
    if ReleaseUiHide ~= nil then
        v4.ReleaseUiHide = nil
        ReleaseUiHide()
    end
end

local function cancelGuardStateWait(v5) -- line 44
    local GuardStateConnection = v5.GuardStateConnection
    if GuardStateConnection ~= nil then
        v5.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
end

local function acquireUiHide() -- line 52 | captures: HiddenUIHandler
    return HiddenUIHandler.Acquire()
end

local function stopGuardedMusicForGeneration(v6, v7) -- line 55 | captures: MusicDirector
    if v6.GuardedMusicGeneration == v7 and v6.GuardedMusicActive then
        v6.GuardedMusicActive = false
        MusicDirector.SetGuardedGameplay(false)
    end
end

local function stopRunBackState(v8) -- line 62 | captures: MusicDirector
    local GuardStateConnection = v8.GuardStateConnection
    if GuardStateConnection ~= nil then
        v8.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if not v8.Active then
        return
    end
    v8.Active = false
    v8.Effects:Stop()
    if v8.GuardedMusicActive then
        v8.GuardedMusicActive = false
        MusicDirector.SetGuardedGameplay(false)
    end
    MusicDirector.SetCarryingAreaEgg(false)
end

local function startCarryState(v9) -- line 79 | captures: HiddenUIHandler, Player, LocalPlayer
    if v9.ReleaseUiHide ~= nil then
        return
    end
    local v10 = Player.Optional.Humanoid(LocalPlayer)
    if v10 ~= nil then
        v10:UnequipTools()
    end
    v9.ReleaseUiHide = HiddenUIHandler.Acquire()
end

local function stopCarryState(v11) -- line 89 | captures: MusicDirector
    v11.CarryGeneration += 1
    local GuardStateConnection = v11.GuardStateConnection
    if GuardStateConnection ~= nil then
        v11.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if v11.Active then
        v11.Active = false
        v11.Effects:Stop()
        if v11.GuardedMusicActive then
            v11.GuardedMusicActive = false
            MusicDirector.SetGuardedGameplay(false)
        end
        MusicDirector.SetCarryingAreaEgg(false)
    end
    local ReleaseUiHide = v11.ReleaseUiHide
    if ReleaseUiHide ~= nil then
        v11.ReleaseUiHide = nil
        ReleaseUiHide()
    end
end

local function startRunBackState(v12, v13) -- line 112 | captures: Audio, MusicDirector
    local GuardStateConnection = v12.GuardStateConnection
    if GuardStateConnection ~= nil then
        v12.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if v12.Active then
        return
    end
    v12.Active = true
    v12.GuardedMusicGeneration += 1
    local GuardedMusicGeneration = v12.GuardedMusicGeneration
    MusicDirector.SetCarryingAreaEgg(true)
    v12.GuardedMusicActive = true
    MusicDirector.SetGuardedGameplay(true)
    v12.Effects:Start(v13)
    local v14 = Audio.Play("rbxassetid://116448247742339", script, {
        PlaybackSpeed = 1.07,
        Volume = 2
    })
    if v14 == nil or v14.SoundId == "" then
        if v12.GuardedMusicGeneration == GuardedMusicGeneration and v12.GuardedMusicActive then
            v12.GuardedMusicActive = false
            MusicDirector.SetGuardedGameplay(false)
        end
    else
        v12.Trove:Add(v14.Ended:Once(function() -- line 138 | captures: v12, GuardedMusicGeneration, MusicDirector
            if v12.GuardedMusicGeneration == GuardedMusicGeneration and v12.GuardedMusicActive then
                v12.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
        end))
        v12.Trove:Add(v14.Stopped:Once(function() -- line 146 | captures: v12, GuardedMusicGeneration, MusicDirector
            if v12.GuardedMusicGeneration == GuardedMusicGeneration and v12.GuardedMusicActive then
                v12.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
        end))
    end
end

local function startWhenGuardWakeFinishes(v15, v16) -- line 162 | captures: GuardAreas, startRunBackState
    v15.CarryGeneration += 1
    local CarryGeneration = v15.CarryGeneration
    local GuardStateConnection = v15.GuardStateConnection
    if GuardStateConnection ~= nil then
        v15.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if not v15.Active then
        local v17 = v16.GuardDisabled == true
        if v16.RunBackWakeDelayRequired == true then
            local AreaId = v16.AreaId
            local v18 = AreaId ~= nil
            assert(v18, "Carried area egg state must include AreaId")
            local v19 = GuardAreas[AreaId]
            local v20 = v19 ~= nil
            local v21 = ("Workspace.__OBJECTS.Areas.GuardAreas.%* is required"):format(AreaId)
            assert(v20, v21)
            local Model = v19:IsA("Model")
            local v22 = ("Workspace.__OBJECTS.Areas.GuardAreas.%* must be a Model"):format(AreaId)
            assert(Model, v22)
            local Guard = v19.Guard
            local v23 = Guard ~= nil
            local v24 = ("%*.Guard is required"):format((v19:GetFullName()))
            assert(v23, v24)
            local Model_2 = Guard:IsA("Model")
            local v25 = ("%*.Guard must be a Model"):format((v19:GetFullName()))
            assert(Model_2, v25)
            if Guard:GetAttribute("GuardState") == "Chasing" then
                startRunBackState(v15, v17)
            else
                local GuardState = Guard:GetAttributeChangedSignal("GuardState")
                v15.GuardStateConnection = GuardState:Connect(function() -- line 196 | captures: v15, CarryGeneration, Guard, v17, startRunBackState
                    if v15.CarryGeneration == CarryGeneration and Guard:GetAttribute("GuardState") == "Chasing" then
                        startRunBackState(v15, v17)
                    end
                end)
            end
        else
            startRunBackState(v15, v17)
        end
    end
end

local function applyCarryState(v26, v27) -- line 203 | captures: HiddenUIHandler, MusicDirector, Player, LocalPlayer, startWhenGuardWakeFinishes
    if v27.IsCarrying then
        if v26.ReleaseUiHide == nil then
            local v28 = Player.Optional.Humanoid(LocalPlayer)
            if v28 ~= nil then
                v28:UnequipTools()
            end
            v26.ReleaseUiHide = HiddenUIHandler.Acquire()
        end
        startWhenGuardWakeFinishes(v26, v27)
    else
        v26.CarryGeneration += 1
        local GuardStateConnection = v26.GuardStateConnection
        if GuardStateConnection ~= nil then
            v26.GuardStateConnection = nil
            GuardStateConnection:Disconnect()
        end
        if v26.Active then
            v26.Active = false
            v26.Effects:Stop()
            if v26.GuardedMusicActive then
                v26.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
            MusicDirector.SetCarryingAreaEgg(false)
        end
        local ReleaseUiHide = v26.ReleaseUiHide
        if ReleaseUiHide ~= nil then
            v26.ReleaseUiHide = nil
            ReleaseUiHide()
        end
    end
end

local function resolveRuntime() -- line 238 | captures: v1, ScreenEffects, Trove
    local v29 = v1
    if v29 == nil then
        local v30 = {
            Active = false,
            CarryGeneration = 0,
            GuardedMusicActive = false,
            GuardedMusicGeneration = 0,
            Started = false,
            Effects = ScreenEffects.new(),
            Trove = Trove.new()
        }
        v1 = v30
        return v30
    end
    return v29
end

function v2.Start() -- line 255 | captures: EggState, HiddenUIHandler, MusicDirector, Player, LocalPlayer, startWhenGuardWakeFinishes, resolveRuntime
    local v31 = resolveRuntime()
    if v31.Started then
        return
    end
    v31.Started = true
    v31.Trove:Add(EggState.CarryChanged:Connect(function(v32) -- line 261 | captures: v31, HiddenUIHandler, MusicDirector, Player, LocalPlayer, startWhenGuardWakeFinishes
        if v32.IsCarrying then
            if v31.ReleaseUiHide == nil then
                local v33 = Player.Optional.Humanoid(LocalPlayer)
                if v33 ~= nil then
                    v33:UnequipTools()
                end
                v31.ReleaseUiHide = HiddenUIHandler.Acquire()
            end
            startWhenGuardWakeFinishes(v31, v32)
        else
            v31.CarryGeneration += 1
            local GuardStateConnection = v31.GuardStateConnection
            if GuardStateConnection ~= nil then
                v31.GuardStateConnection = nil
                GuardStateConnection:Disconnect()
            end
            if v31.Active then
                v31.Active = false
                v31.Effects:Stop()
                if v31.GuardedMusicActive then
                    v31.GuardedMusicActive = false
                    MusicDirector.SetGuardedGameplay(false)
                end
                MusicDirector.SetCarryingAreaEgg(false)
            end
            local ReleaseUiHide = v31.ReleaseUiHide
            if ReleaseUiHide ~= nil then
                v31.ReleaseUiHide = nil
                ReleaseUiHide()
            end
        end
    end))
    v31.Trove:Connect(LocalPlayer.CharacterRemoving, function() -- line 297 | captures: v31, MusicDirector
        v31.CarryGeneration += 1
        local GuardStateConnection = v31.GuardStateConnection
        if GuardStateConnection ~= nil then
            v31.GuardStateConnection = nil
            GuardStateConnection:Disconnect()
        end
        if v31.Active then
            v31.Active = false
            v31.Effects:Stop()
            if v31.GuardedMusicActive then
                v31.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
            MusicDirector.SetCarryingAreaEgg(false)
        end
        local ReleaseUiHide = v31.ReleaseUiHide
        if ReleaseUiHide ~= nil then
            v31.ReleaseUiHide = nil
            ReleaseUiHide()
        end
    end)
    v31.Trove:Add(function() -- line 321 | captures: v31, MusicDirector
        v31.CarryGeneration += 1
        local GuardStateConnection = v31.GuardStateConnection
        if GuardStateConnection ~= nil then
            v31.GuardStateConnection = nil
            GuardStateConnection:Disconnect()
        end
        if v31.Active then
            v31.Active = false
            v31.Effects:Stop()
            if v31.GuardedMusicActive then
                v31.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
            MusicDirector.SetCarryingAreaEgg(false)
        end
        local ReleaseUiHide = v31.ReleaseUiHide
        if ReleaseUiHide ~= nil then
            v31.ReleaseUiHide = nil
            ReleaseUiHide()
        end
    end)
end

return v2
