-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Globals.Constants)
local GuardTutorialFlags = require(ReplicatedStorage.Shared.Flags.GuardTutorialFlags)
local GuardTutorialPresentation = require(ReplicatedStorage.Client.GuardTutorialPresentation)
local GuardTutorialSteps = require(ReplicatedStorage.Data.GuardTutorialSteps)
local GuardTutorial = require(ReplicatedStorage.Shared.Types.GuardTutorial)
local Log = require(ReplicatedStorage.Packages.Log)
local MilestoneAdapter = require(script.MilestoneAdapter)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local EquipEgg = require(script.Steps.EquipEgg)
local ExpandPen = require(script.Steps.ExpandPen)
local HatchEgg = require(script.Steps.HatchEgg)
local HeadToPen = require(script.Steps.HeadToPen)
local PlaceEgg = require(script.Steps.PlaceEgg)
local PlacePet = require(script.Steps.PlacePet)
local StealEgg = require(script.Steps.StealEgg)
local TreadmillIntro = require(script.Steps.TreadmillIntro)
local v1 = {}

v1.__index = v1
v1.__class = "GuardTutorialController"

local v2 = {}

v2[StealEgg.StepId] = StealEgg
v2[HeadToPen.StepId] = HeadToPen
v2[EquipEgg.StepId] = EquipEgg
v2[PlaceEgg.StepId] = PlaceEgg
v2[HatchEgg.StepId] = HatchEgg
v2[PlacePet.StepId] = PlacePet
v2[ExpandPen.StepId] = ExpandPen
v2[TreadmillIntro.StepId] = TreadmillIntro

local v3 = Log.new()

local function getProgressIndex(v4) -- line 42 | captures: GuardTutorialSteps
    if v4.Completed then
        return (1/0)
    end
    local CurrentStepId = v4.CurrentStepId
    return CurrentStepId ~= nil and GuardTutorialSteps.GetIndex(CurrentStepId) or 0
end

function v1.new() -- line 52 | captures: GuardTutorialPresentation, GuardTutorial, MilestoneAdapter, Trove, v1
    local v5 = {}
    local v6 = setmetatable(v5, v1)
    v6._activeStepCleanup = nil
    v6._activeStepId = nil
    v6._adapter = MilestoneAdapter.new()
    v6._currentProgress = GuardTutorial.CopyProgress(GuardTutorial.DEFAULT_PROGRESS)
    v6._lastStoredIndex = nil
    v6._presentation = GuardTutorialPresentation.new()
    v6._refreshGeneration = 0
    v6._retryScheduled = false
    v6._runtimeEnabled = false
    v6._runtimeRevision = -1
    v6._runtimeStateReady = false
    v6._runtimeStateRequestPending = false
    v6._pauseNotificationShown = false
    v6._pausedForAdminAbuse = false
    v6._started = false
    v6._trove = Trove.new()
    return v6
end

local function _clearActiveStep(v7) -- line 72
    local _activeStepCleanup = v7._activeStepCleanup
    if _activeStepCleanup ~= nil then
        v7._activeStepCleanup = nil
        _activeStepCleanup()
    end
    v7._presentation:DropEverything()
    v7._activeStepId = nil
end

v1._clearActiveStep = _clearActiveStep

function v1._maybeShowPauseNotification(v8) -- line 81 | captures: GuardTutorialFlags, Message, Save
    if v8._pauseNotificationShown or not v8._runtimeStateReady or v8._runtimeEnabled or not v8._pausedForAdminAbuse or not GuardTutorialFlags.PauseNotificationEnabled:Get() or not Save.IsLocalDataLoaded() or v8:_readStoredProgress().Completed then
        return
    end
    v8._pauseNotificationShown = true
    Message.Top({
        Message = "Tutorial paused during Admin Abuse. It will resume after the event.",
        Time = 5,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    }, { PreventDuplicateText = true })
end

local function _applyRuntimeState(v9, v10) -- line 88
    if v10.Revision < v9._runtimeRevision then
        return
    end
    local _runtimeStateReady = v9._runtimeStateReady
    local _runtimeEnabled = v9._runtimeEnabled
    v9._runtimeEnabled = v10.Enabled
    v9._runtimeRevision = v10.Revision
    v9._runtimeStateReady = true
    v9._pausedForAdminAbuse = v10.PausedForAdminAbuse
    if not v10.PausedForAdminAbuse then
        v9._pauseNotificationShown = false
    end
    if v10.Enabled then
        if not _runtimeStateReady or not _runtimeEnabled then
            v9:RefreshProgress()
        end
    else
        v9:_clearActiveStep()
        v9._refreshGeneration += 1
        v9:_maybeShowPauseNotification()
    end
end

v1._applyRuntimeState = _applyRuntimeState

function v1._requestRuntimeState(v11) -- line 111 | captures: GuardTutorial, Remotes
    if v11._runtimeStateRequestPending then
        return false
    end
    v11._runtimeStateRequestPending = true
    local v12, v13 = pcall(function() -- line 117 | captures: Remotes
        return Remotes.GuardOnboarding.AskLiveState:InvokeServer()
    end)
    v11._runtimeStateRequestPending = false
    if not (v12 and GuardTutorial.SchemaValidation.RuntimeState(v13)) then
        return false
    end
    v11:_applyRuntimeState(v13)
    return true
end

function v1._queueRuntimeStateRetry(v14) -- line 127 | captures: Timer
    if v14._runtimeStateReady or not v14._started then
        return
    end
    local v15
    v15 = Timer.Simple(0.5, function() -- line 132 | captures: v15, v14
        if v14._started then
            if v14._runtimeStateReady then
                local v16 = v15
                if v16 ~= nil then
                    v16:Disconnect()
                end
            elseif v14:_requestRuntimeState() then
                local v17 = v15
                if v17 ~= nil then
                    v17:Disconnect()
                end
            end
        else
            local v18 = v15
            if v18 ~= nil then
                v18:Disconnect()
            end
        end
    end)
    v14._trove:Add(v15)
end

function v1._readStoredProgress(v19) -- line 153 | captures: GuardTutorial, Save
    local v20 = Save.Get()
    if v20 == nil then
        return GuardTutorial.CopyProgress(GuardTutorial.DEFAULT_PROGRESS)
    end
    return GuardTutorial.SanitizeProgress(v20.GuardTutorialProgress)
end

function v1._syncProgress(v21, v22) -- line 160 | captures: GuardTutorial, Remotes, TryCall
    local v23, v24, v25 = TryCall(function() -- line 162 | captures: v22, Remotes
        return Remotes.GuardOnboarding.AskProgressSync:InvokeServer(v22)
    end)
    if not (v23 and v24 == true) then
        return nil
    end
    local v26, v27 = GuardTutorial.SchemaValidation.Progress(v25)
    assert(v26, v27)
    return GuardTutorial.SanitizeProgress(v25)
end

function v1._queueSyncRetry(v28) -- line 172 | captures: v3
    if v28._retryScheduled or not v28._started or not v28._runtimeStateReady or not v28._runtimeEnabled then
        return
    end
    v3:AtTrace():Log("[GuardTutorialController] Queueing tutorial progress sync retry")
    v28._retryScheduled = true
    task.delay(0.5, function() -- line 178 | captures: v28
        if v28._started and v28._runtimeStateReady and v28._runtimeEnabled then
            v28._retryScheduled = false
            v28:RefreshProgress()
        else
            v28._retryScheduled = false
        end
    end)
end

function v1._resolveNextProgress(v29, v30) -- line 187 | captures: GuardTutorialSteps, GuardTutorial, v2
    if v30.Completed then
        return GuardTutorial.CopyProgress(v30)
    end
    if not v29._currentProgress.Completed then
        local v31 = GuardTutorialSteps.GetOrderedStepIds()
        local v32
        if v30.CurrentStepId == nil then
            v32 = 1
        else
            local v33 = GuardTutorialSteps.GetIndex(v30.CurrentStepId)
            local v34 = v33 ~= nil
            local v35 = ("Unknown guard tutorial step id: %*"):format(v30.CurrentStepId)
            assert(v34, v35)
            v32 = v33
        end
        local CurrentStepId = v29._currentProgress.CurrentStepId
        if CurrentStepId ~= nil then
            local v36 = GuardTutorialSteps.GetIndex(CurrentStepId)
            if v36 ~= nil and v32 < v36 then
                v32 = v36
            end
        end
        local v37 = #v31
        for v38 = v32, v37 do
            local v39 = v31[v38]
            local v40 = v2[v39]
            local v41 = v40 ~= nil
            local v42 = ("Missing guard tutorial step module for %*"):format(v39)
            assert(v41, v42)
            if not v40.IsSatisfied(v29._adapter) then
                return {
                    Completed = false,
                    CurrentStepId = v39
                }
            end
        end
    end
    return { Completed = true }
end

function v1._bindCurrentStep(v43) -- line 223 | captures: v2
    local CurrentStepId = v43._currentProgress.CurrentStepId
    if v43._currentProgress.Completed or CurrentStepId == nil then
        v43:_clearActiveStep()
    elseif v43._activeStepId == CurrentStepId then
        if v43._activeStepCleanup == nil then
        end
    else
        v43:_clearActiveStep()
        local v44 = v2[CurrentStepId]
        local v45 = v44 ~= nil
        local v46 = ("Missing guard tutorial step module for %*"):format(CurrentStepId)
        assert(v45, v46)
        v43._activeStepId = CurrentStepId
        local v47
        if v44.Present == nil then
        else
            v47 = v44.Present(v43._presentation, v43._adapter)
        end
        local v48 = v44.Bind(v43._adapter, function() -- line 240 | captures: v43, CurrentStepId
            if not v43._currentProgress.Completed and v43._currentProgress.CurrentStepId == CurrentStepId then
                v43:RefreshProgress()
            end
        end)
        local v49 = v47

        function v43._activeStepCleanup() -- line 246 | captures: v43, v48, v49
            v48()
            if v49 ~= nil then
                v49()
            end
            v43._presentation:DropEverything()
        end
    end
end

local function _startAfterReadiness(v50) -- line 259
    local v51 = v50:_readStoredProgress()
    v50._currentProgress = v51
    if v51.Completed then
        v50:_clearActiveStep()
    else
        v50:RefreshProgress()
        v50:_maybeShowPauseNotification()
    end
end

v1._startAfterReadiness = _startAfterReadiness

function v1.Start(v52) -- line 269 | captures: GuardTutorialFlags, GuardTutorial, Remotes, Save
    if v52._started then
        return
    end
    v52._started = true
    v52._trove:Add(Remotes.GuardOnboarding.LiveStateShifted.OnClientEvent:Connect(function(v53) -- line 274 | captures: v52, GuardTutorial
        if GuardTutorial.SchemaValidation.RuntimeState(v53) then
            v52:_applyRuntimeState(v53)
        end
    end))
    v52._trove:Add(GuardTutorialFlags.PauseNotificationEnabled.Changed:Connect(function(v54) -- line 279 | captures: v52
        if v54 then
            v52:_maybeShowPauseNotification()
        else
            v52._pauseNotificationShown = false
        end
    end))
    if not v52:_requestRuntimeState() then
        v52:_queueRuntimeStateRetry()
    end
    v52._trove:Add(v52._adapter.Changed:Connect(function() -- line 289 | captures: v52
        v52:RefreshProgress()
    end))
    v52._trove:Add(Save.FieldSignal("GuardTutorialProgress"):Connect(function() -- line 292 | captures: v52
        v52:RefreshProgress()
    end))
    if Save.IsLocalDataLoaded() then
        v52:_startAfterReadiness()
    else
        local v55 = Save.ProfileReady:Connect(function() -- line 299 | captures: v52
            v52:_startAfterReadiness()
        end)
        v52._trove:Add(v55)
        if Save.IsLocalDataLoaded() then
            v55:Disconnect()
            v52:_startAfterReadiness()
        end
    end
end

function v1.RefreshProgress(v56) -- line 308 | captures: GuardTutorialSteps, GuardTutorial, Save
    local _refreshGeneration, v57, v58
    if v56._started and v56._runtimeStateReady and v56._runtimeEnabled and Save.IsLocalDataLoaded() then
        v56._refreshGeneration += 1
        _refreshGeneration = v56._refreshGeneration
        v57 = v56:_readStoredProgress()
        if v57.Completed then
            v58 = (1/0)
        else
            local CurrentStepId = v57.CurrentStepId
            v58 = CurrentStepId ~= nil and GuardTutorialSteps.GetIndex(CurrentStepId) or 0
        end
    else
        return
    end
    if v56._lastStoredIndex ~= nil and v58 < v56._lastStoredIndex then
        v56._currentProgress = GuardTutorial.CopyProgress(v57)
    end
    v56._lastStoredIndex = v58
    local v59 = v56:_resolveNextProgress(v57)
    local v60 = if v57.Completed == v59.Completed then v57.CurrentStepId ~= v59.CurrentStepId else true
    v56._currentProgress = v59
    v56:_bindCurrentStep()
    if v60 then
        local v61 = v56:_syncProgress(v59)
        if v56._started and _refreshGeneration == v56._refreshGeneration then
            if v61 == nil then
                v56:_queueSyncRetry()
            else
                v56._currentProgress = v61
                v56:_bindCurrentStep()
            end
        end
    end
end

local function Destroy(v62) -- line 348
    v62._started = false
    v62:_clearActiveStep()
    v62._trove:Destroy()
    v62._presentation:Destroy()
    v62._adapter:Destroy()
end

v1.Destroy = Destroy
return v1
