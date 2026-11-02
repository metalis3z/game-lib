-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
require(ReplicatedStorage.Shared.Types.AreaEggs)
require(ReplicatedStorage.Shared.Globals.Constants)
local EggState = require(ReplicatedStorage.Client.EggState)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local Hud = require(ReplicatedStorage.Client.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SettingsCmds = require(ReplicatedStorage.Shared.SettingsCmds)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local SpeedGainPopup = require(ReplicatedStorage.Client.UI.VFX.SpeedGainPopup)
local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
local Trails = require(ReplicatedStorage.Data.Trails)
local TreadmillCharacterPresentationController = require(script.Parent.Parent.Game.Plots.TreadmillCharacterPresentationController)
local Visibility = require(script.Visibility)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local RuntimeInstanceRegistry = require(ReplicatedStorage.Client.Modules.RuntimeInstanceRegistry)
local SpeedValue = Hud.Get("SpeedValue")
local Treadmill = Hud.Find("SpeedValue", "Treadmill")
local Treadmill_2 = Hud.Find("SpeedMultiShine", "Treadmill")
local TextColor3 = SpeedValue.TextColor3
local TemporarySpeedBoost = Hud.Find("TemporarySpeedBoost")
local v1

if TemporarySpeedBoost == nil then
else
    v1 = TemporarySpeedBoost:FindFirstChild("CurrentBoost")
end
local v2 = false
local v3
local v4 = 0
local v5 = 0
local v6
local v7 = 1

local function visibleSpeedLabel() -- line 47 | captures: v3, SpeedValue, Treadmill
    if v3 == nil then
        return SpeedValue
    end
    if Treadmill == nil then
        return SpeedValue
    end
    return Treadmill
end

local function updateSpeedPower() -- line 56 | captures: v7, Workspace, AdminBoosts, Save, SpeedPowerProjection, Trails, TreadmillUtil, SpeedValue, Treadmill, TextColor3
    local v8 = Save.Get()
    if not v8 then
        return
    end
    local v9 = TreadmillUtil.ResolveEffectiveSpeedPower(SpeedPowerProjection.ReadProjected(), v7) * AdminBoosts.ReadMultiplier(AdminBoosts.SPEED)
    local v10 = TreadmillUtil.FormatSpeedPower((math.floor(v9)))
    local v11 = TreadmillUtil.ResolveSpeedBoostSpeedStepMultiplier(v8)
    local v12 = TreadmillUtil.ResolveTemporarySpeedBoostSpeedStepMultiplier(v8, Workspace:GetServerTimeNow())
    local v13 = TreadmillUtil.ResolveAdditiveSpeedStepMultiplier(v11, v12)
    local v14 = TextColor3
    local EquippedTrail = v8.EquippedTrail
    if EquippedTrail ~= nil and Trails.TrailNameExists(EquippedTrail) and v8.TrailInventory[EquippedTrail] then
        v14 = Trails.Directory[EquippedTrail].Rarity.Color
    end
    if TreadmillUtil.DEFAULT_SPEED_STEP_MULTIPLIER < v13 then
        v10 ..= (" <font color=\"#00FF00\">(%*)</font>"):format((TreadmillUtil.FormatSpeedMultiplierValue(v13)))
    end
    SpeedValue.Text = v10
    SpeedValue.TextColor3 = v14
    if Treadmill ~= nil then
        Treadmill.Text = v10
        Treadmill.TextColor3 = v14
    end
end

local function updateTemporarySpeedBoostDisplay() -- line 83 | captures: v1, Workspace, Elapsed, Save, TreadmillUtil, TemporarySpeedBoost
    local v15 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(Save.Get(), Workspace:GetServerTimeNow())
    if TemporarySpeedBoost == nil or v1 == nil then
        return v15 > 0
    end
    if v15 <= 0 then
        TemporarySpeedBoost.Visible = false
        return false
    end
    TemporarySpeedBoost.Visible = true
    v1.Text = ("X2 Speed (%*)"):format((Elapsed(v15)))
    return true
end

local function startTemporarySpeedBoostCountdown() -- line 97 | captures: v5, updateSpeedPower, updateTemporarySpeedBoostDisplay
    v5 += 1
    local v16 = v5
    if updateTemporarySpeedBoostDisplay() then
        task.spawn(function() -- line 103 | captures: v16, v5, updateSpeedPower, updateTemporarySpeedBoostDisplay
            while true do
                if v16 == v5 then
                    task.wait(1)
                    if updateTemporarySpeedBoostDisplay() then
                        updateSpeedPower()
                        continue
                    end
                    break
                end
                return
            end
            updateSpeedPower()
        end)
    end
end

local function stopActiveTreadmillVisualSimulation() -- line 114 | captures: v4, v6, SpeedPowerProjection
    local v17 = v6
    if v17 ~= nil then
        SpeedPowerProjection.CloseSession(v17.Token)
    end
    v4 += 1
    v6 = nil
end

local function applyTreadmillVideoSetting(v18) -- line 122 | captures: v3, Save, SettingsCmds, TreadmillVideoGate, TreadmillVideoController
    local v19 = v3
    if v19 ~= nil and not SettingsCmds.Allows("DisableVideos") and not TreadmillVideoGate.IsVideoPlayerDisabled() then
        if v18 == nil then
            local v20 = Save.Get()
            local v21 = v20 ~= nil
            assert(v21, "Save data must be loaded before enabling treadmill videos")
            TreadmillVideoController.Start(v19, v20.TreadmillMediaFeedState)
        else
            TreadmillVideoController.Start(v19, v18)
        end
    else
        TreadmillVideoController.Stop()
    end
end

local function resolveCurrentSpeedPowerPerStep(v22, v23) -- line 137 | captures: Save, TreadmillUtil
    return TreadmillUtil.ResolveSpeedPowerPerStep(Save.Get(), v22, v23)
end

local function flushPendingScreenSpeedGain(v24) -- line 140 | captures: v3, SpeedGainPopup, SpeedPowerProjection, SpeedValue, Treadmill
    if v24.PendingScreenSpeedPowerDelta <= 0 then
        return
    end
    local PendingScreenSpeedPowerDelta = v24.PendingScreenSpeedPowerDelta
    local Play = SpeedGainPopup.Play
    local v25 = if v3 == nil or Treadmill == nil then SpeedValue else Treadmill
    Play(v25, PendingScreenSpeedPowerDelta, nil, function() -- line 154 | captures: v24, PendingScreenSpeedPowerDelta, SpeedPowerProjection
        SpeedPowerProjection.CreditRevealedGain(v24.Token, PendingScreenSpeedPowerDelta)
    end)
    v24.PendingScreenSpeedPowerDelta = 0
end

local function resetNextScreenPopupAt(v26, v27) -- line 159 | captures: TreadmillUtil
    v26.NextScreenPopupAt = v27 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
end

local function handleTransparentModeSpeedGainPulse(v28, v29, v30) -- line 162 | captures: v3, SpeedGainPopup, SpeedPowerProjection, TreadmillUtil, SpeedValue, Treadmill
    v28.PendingScreenSpeedPowerDelta += v29
    if not (v28.NextScreenPopupAt <= v30) then
        return
    end
    local PendingScreenSpeedPowerDelta
    if v28.PendingScreenSpeedPowerDelta > 0 then
        local PendingScreenSpeedPowerDelta_2 = v28.PendingScreenSpeedPowerDelta
        PendingScreenSpeedPowerDelta = PendingScreenSpeedPowerDelta_2
        local Play = SpeedGainPopup.Play
        local v31 = if v3 == nil or Treadmill == nil then SpeedValue else Treadmill
        Play(v31, PendingScreenSpeedPowerDelta_2, nil, function() -- line 177 | captures: PendingScreenSpeedPowerDelta, v28, SpeedPowerProjection
            SpeedPowerProjection.CreditRevealedGain(v28.Token, PendingScreenSpeedPowerDelta)
        end)
        v28.PendingScreenSpeedPowerDelta = 0
    end
    v28.NextScreenPopupAt = v30 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
end

local function handleVisibleModeSpeedGainPulse(v32, v33, v34) -- line 185 | captures: v3, SpeedGainPopup, SpeedPowerProjection, TreadmillUtil, SpeedValue, Treadmill
    v32.PendingScreenSpeedPowerDelta = 0
    v32.NextScreenPopupAt = v34 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
    local PlayWalk = SpeedGainPopup.PlayWalk
    local v35 = if v3 == nil or Treadmill == nil then SpeedValue else Treadmill
    local RarityColor = v32.RarityColor
    PlayWalk(v35, v33, RarityColor, function() -- line 197 | captures: v32, v33, SpeedPowerProjection
        SpeedPowerProjection.CreditRevealedGain(v32.Token, v33)
    end)
end

local function startActiveTreadmillVisualSimulation(v36, v37, v38, v39, v40) -- line 201 | captures: v3, v4, v6, Workspace, Save, SpeedGainPopup, SpeedPowerProjection, TreadmillCharacterPresentationController, TreadmillUtil, SpeedValue, Treadmill
    local v41 = v6
    if v41 ~= nil then
        SpeedPowerProjection.CloseSession(v41.Token)
    end
    v4 += 1
    v6 = nil
    local v42 = Workspace:GetServerTimeNow()
    local v43 = Save.Get()
    local v44 = v43 ~= nil
    assert(v44, "Save data must be loaded before starting treadmill simulation")
    local v45 = v4
    local v46 = { PendingScreenSpeedPowerDelta = 0 }
    if not v39 or not v37 then
        v46.NextScreenPopupAt = v42 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
    else
        v46.NextScreenPopupAt = v37
    end
    v46.NextSpeedAwardAt = v37
    v46.RarityColor = v38
    v46.SimulatedSpeedPower = TreadmillUtil.NormalizeSpeedPower(v43.SpeedPower)
    v46.SpeedMultiplier = v36
    v46.FixedSpeedPowerPerSecond = v39
    if v39 then
        v46.FixedGainInterval = v40 or 1
    else
        v46.FixedGainInterval = nil
    end
    v46.Token = v45
    v6 = v46
    SpeedPowerProjection.OpenSession(v45)
    task.spawn(function() -- line 225 | captures: v45, v3, v6, Workspace, Save, SpeedGainPopup, SpeedPowerProjection, TreadmillCharacterPresentationController, TreadmillUtil, SpeedValue, Treadmill
        local v47, v48, v49, v50, PendingScreenSpeedPowerDelta, v51
        while true do
            local v52 = v6
            if v52 ~= nil and v52.Token == v45 then
                local v53 = v52.NextSpeedAwardAt - Workspace:GetServerTimeNow()
                local v54 = math.max(v53, 0)
                if v54 > 0 then
                    task.wait(v54)
                end
                local v55 = v6
                if v55 ~= nil and v55.Token == v45 then
                    while true do
                        local v56 = Workspace:GetServerTimeNow()
                        if v56 < v55.NextSpeedAwardAt then
                            break
                        end
                        local NextSpeedAwardAt = v55.NextSpeedAwardAt
                        local v57
                        if v55.FixedSpeedPowerPerSecond then
                            v57 = v55.FixedSpeedPowerPerSecond * v55.FixedGainInterval
                        else
                            v57 = TreadmillUtil.ResolveSpeedPowerPerStep(Save.Get(), v55.SpeedMultiplier, NextSpeedAwardAt)
                        end
                        v55.SimulatedSpeedPower += v57
                        if TreadmillCharacterPresentationController.IsLocalCharacterFullyTransparent() then
                            v55.PendingScreenSpeedPowerDelta += v57
                            if v55.NextScreenPopupAt <= v56 then
                                if v55.PendingScreenSpeedPowerDelta > 0 then
                                    PendingScreenSpeedPowerDelta = v55.PendingScreenSpeedPowerDelta
                                    local Play = SpeedGainPopup.Play
                                    if v3 == nil then
                                        v48 = SpeedValue
                                    elseif Treadmill ~= nil then
                                        v48 = Treadmill
                                    end
                                    v51 = v55
                                    Play(v48, PendingScreenSpeedPowerDelta, nil, function() -- line 275 | captures: PendingScreenSpeedPowerDelta, v51, SpeedPowerProjection
                                        SpeedPowerProjection.CreditRevealedGain(v51.Token, PendingScreenSpeedPowerDelta)
                                    end)
                                    v55.PendingScreenSpeedPowerDelta = 0
                                end
                                v55.NextScreenPopupAt = v56 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
                            end
                        else
                            v55.PendingScreenSpeedPowerDelta = 0
                            v55.NextScreenPopupAt = v56 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
                            local PlayWalk = SpeedGainPopup.PlayWalk
                            if v3 == nil then
                                v47 = SpeedValue
                            elseif Treadmill ~= nil then
                                v47 = Treadmill
                            end
                            local RarityColor = v55.RarityColor
                            v49 = v55
                            v50 = v57
                            PlayWalk(v47, v57, RarityColor, function() -- line 259 | captures: v49, v50, SpeedPowerProjection
                                SpeedPowerProjection.CreditRevealedGain(v49.Token, v50)
                            end)
                        end
                        v55 = v6
                        if v55 ~= nil and v55.Token == v45 then
                            v55.NextSpeedAwardAt = NextSpeedAwardAt + (v55.FixedGainInterval or TreadmillUtil.ResolveWalkSpeedPowerAwardInterval(TreadmillUtil.SpeedPowerToProgressionWalkSpeed(v55.SimulatedSpeedPower)))
                            continue
                        end
                        return
                    end
                    continue
                end
            end
            return
        end
    end)
end

EggState.CarryChanged:Connect(function(v58) -- line 294 | captures: v7, updateSpeedPower
    v7 = v58.SpeedMultiplier
    updateSpeedPower()
end)

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
SpeedGainPopup.HideSource()
TreadmillVideoController.Stop()
TreadmillCharacterPresentationController.StopCameraTransparency()
updateSpeedPower()
v5 += 1
local v59 = v5

if updateTemporarySpeedBoostDisplay() then
    task.spawn(function() -- line 308 | captures: v5, updateSpeedPower, updateTemporarySpeedBoostDisplay, v59
        while true do
            if v59 == v5 then
                task.wait(1)
                if updateTemporarySpeedBoostDisplay() then
                    updateSpeedPower()
                    continue
                end
                break
            end
            return
        end
        updateSpeedPower()
    end)
end

if Treadmill_2 ~= nil then
    RunService.RenderStepped:Connect(function(v60) -- line 320 | captures: Treadmill_2
        Treadmill_2.Rotation = (Treadmill_2.Rotation + v60 * 20) % 360
    end)
end
SpeedPowerProjection.Changed:Connect(updateSpeedPower)
Save.WatchFields("SpeedBoostTierIndex", updateSpeedPower)
Save.WatchFields({ "EquippedTrail", "TrailInventory" }, updateSpeedPower)
AdminBoosts.Observe(AdminBoosts.SPEED):Connect(updateSpeedPower)
Save.WatchFields("TemporarySpeedBoostRemainingSeconds", function() -- line 328 | captures: v5, updateSpeedPower, updateTemporarySpeedBoostDisplay
    updateSpeedPower()
    v5 += 1
    local v61 = v5
    if updateTemporarySpeedBoostDisplay() then
        task.spawn(function() -- line 335 | captures: v61, v5, updateSpeedPower, updateTemporarySpeedBoostDisplay
            while true do
                if v61 == v5 then
                    task.wait(1)
                    if updateTemporarySpeedBoostDisplay() then
                        updateSpeedPower()
                        continue
                    end
                    break
                end
                return
            end
            updateSpeedPower()
        end)
    end
end)
Save.WatchFields("TemporarySpeedBoostActiveStartedAt", function() -- line 346 | captures: v5, updateSpeedPower, updateTemporarySpeedBoostDisplay
    updateSpeedPower()
    v5 += 1
    local v62 = v5
    if updateTemporarySpeedBoostDisplay() then
        task.spawn(function() -- line 353 | captures: v62, v5, updateSpeedPower, updateTemporarySpeedBoostDisplay
            while true do
                if v62 == v5 then
                    task.wait(1)
                    if updateTemporarySpeedBoostDisplay() then
                        updateSpeedPower()
                        continue
                    end
                    break
                end
                return
            end
            updateSpeedPower()
        end)
    end
end)
Remotes.Treadmill.SpeedGained.OnClientEvent:Connect(function(v63, v64) -- line 364 | captures: v3, v6, SpeedGainPopup, SpeedPowerProjection, SpeedValue, Treadmill, updateSpeedPower
    local v65 = v64 == "Treadmill"
    local v66, v67
    if v65 then
        v67 = v6 == nil
    else
        if v64 ~= "Instant" then
            updateSpeedPower()
            if v64 == "Walk" then
                local PlayWalk = SpeedGainPopup.PlayWalk
                local v68 = if v3 == nil or Treadmill == nil then SpeedValue else Treadmill
                PlayWalk(v68, v63, nil, updateSpeedPower)
            else
                local Play = SpeedGainPopup.Play
                local v69 = if v3 == nil or Treadmill == nil then SpeedValue else Treadmill
                Play(v69, v63, nil, updateSpeedPower)
            end
            return
        end
        v66 = v6 == nil
    end
    if v65 and v67 or not v65 and v66 or v65 then
        return
    end
    local v70 = v6
    v70.SimulatedSpeedPower += v63
    local v71 = SpeedPowerProjection.CreditRevealedGain(v70.Token, v63)
    assert(v71, "Instant Speed Power gain must target the active treadmill projection")
    local Play = SpeedGainPopup.Play
    local v72 = if v3 == nil or Treadmill == nil then SpeedValue else Treadmill
    Play(v72, v63, nil, updateSpeedPower)
end)
SettingsCmds.Changed:Connect(function(v73) -- line 411 | captures: v3, Save, SettingsCmds, TreadmillVideoGate, TreadmillVideoController
    if v73 ~= "DisableVideos" then
        return
    end
    local v74 = v3
    if not (v74 == nil or SettingsCmds.Allows("DisableVideos") or TreadmillVideoGate.IsVideoPlayerDisabled()) then
        local v75 = Save.Get()
        local v76 = v75 ~= nil
        assert(v76, "Save data must be loaded before enabling treadmill videos")
        TreadmillVideoController.Start(v74, v75.TreadmillMediaFeedState)
    else
        TreadmillVideoController.Stop()
    end
end)
TreadmillVideoGate.Changed:Connect(function() -- line 425 | captures: v3, Save, SettingsCmds, TreadmillVideoGate, TreadmillVideoController
    local v77 = v3
    if not (v77 == nil or SettingsCmds.Allows("DisableVideos") or TreadmillVideoGate.IsVideoPlayerDisabled()) then
        local v78 = Save.Get()
        local v79 = v78 ~= nil
        assert(v79, "Save data must be loaded before enabling treadmill videos")
        TreadmillVideoController.Start(v77, v78.TreadmillMediaFeedState)
    else
        TreadmillVideoController.Stop()
    end
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v80, v81, v82, v83, v84, v85, v86) -- line 436 | captures: v2, v3, v4, v6, Workspace, SpeedPowerProjection, TreadmillCharacterPresentationController, Visibility, TreadmillVideoController, Treadmills, RuntimeInstanceRegistry, updateSpeedPower, applyTreadmillVideoSetting, startActiveTreadmillVisualSimulation
    v3 = v80
    v2 = false
    if v80 == nil then
        local v87 = v6
        if v87 ~= nil then
            SpeedPowerProjection.CloseSession(v87.Token)
        end
        v4 += 1
        v6 = nil
        updateSpeedPower()
        TreadmillVideoController.Stop()
        TreadmillCharacterPresentationController.StopCameraTransparency()
        Visibility.Apply(false)
    else
        local v88 = typeof(v81) == "number"
        assert(v88, "Active treadmill speed multiplier must be a number")
        local v89 = typeof(v82) == "number"
        assert(v89, "Active treadmill next award time must be a number")
        local v90 = typeof(v83) == "table"
        assert(v90, "Active treadmill media feed state must be a table")
        local v91, v92 = Treadmills.TreadmillNameExists(v80)
        local v93 = v92 or ("Treadmill \"%*\" does not exist"):format(v80)
        assert(v91, v93)
        updateSpeedPower()
        Visibility.Apply(true)
        if v86 ~= nil then
            local v94 = v86:IsA("Tool") and v86:IsDescendantOf(Workspace)
            assert(v94, "Shared treadmill must be a workspace Tool")
            RuntimeInstanceRegistry.Bind("Treadmill", v80, v86)
        end
        local v95 = Treadmills.Directory[v80]
        startActiveTreadmillVisualSimulation(v81, v82, v95.Rarity.Color, v95.FixedSpeedPowerPerSecond, v95.SpeedGainInterval)
        TreadmillCharacterPresentationController.StartCameraTransparency(v80)
        applyTreadmillVideoSetting(v83)
    end
end)
UserInputService.JumpRequest:Connect(function() -- line 476 | captures: v2, v3, Remotes
    if v3 == nil or v2 then
        return
    end
    v2 = Remotes.Treadmill.AskDoff:InvokeServer() == true
end)
