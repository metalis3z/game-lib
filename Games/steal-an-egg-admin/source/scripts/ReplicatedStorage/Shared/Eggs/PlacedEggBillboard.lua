-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local GUI = require(ReplicatedStorage.Client.GUI)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.Layout).SwapGradient
local HoverHighlight = require(ReplicatedStorage.Client.WorldFX.HoverHighlight)
local MonsterParasite = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local SurfaceTracker = require(ReplicatedStorage.Client.SmartProximityPrompt.SurfaceTracker)
local MonsterParasite_2 = require(ReplicatedStorage.Data.MonsterParasite)
local Save = require(ReplicatedStorage.Shared.Save)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local v2 = {}
local v3, v4
local v5 = ""
local v6
local v7 = 0
local v8, v9
local v10 = {}

local function getKey(v11, v12) -- line 33
    return (("%*:%*"):format(v11, v12))
end

local function bindGui() -- line 36 | captures: v4, GUI
    local v13 = v4
    if v13 == nil then
        local v14 = GUI.AssetEggData()
        local ScreenGui = v14:IsA("ScreenGui")
        assert(ScreenGui, "PlayerGui.AssetEggData must be a ScreenGui")
        local Frame = v14.Frame
        local GuiObject = Frame:IsA("GuiObject")
        assert(GuiObject, "AssetEggData.Frame must be a GuiObject")
        local CanvasGroup = Frame.CanvasGroup
        local GuiObject_2 = CanvasGroup:IsA("GuiObject")
        assert(GuiObject_2, "AssetEggData.Frame.CanvasGroup must be a GuiObject")
        local DisplayName = CanvasGroup.DisplayName
        local TextLabel = DisplayName:IsA("TextLabel")
        assert(TextLabel, "AssetEggData.Frame.CanvasGroup.DisplayName must be a TextLabel")
        local RemainingHatchTime = CanvasGroup.RemainingHatchTime
        local TextLabel_2 = RemainingHatchTime:IsA("TextLabel")
        assert(TextLabel_2, "AssetEggData.Frame.CanvasGroup.RemainingHatchTime must be a TextLabel")
        local v15 = {
            Root = v14,
            Frame = Frame,
            CanvasGroup = CanvasGroup,
            DisplayName = DisplayName,
            RemainingHatchTime = RemainingHatchTime
        }
        v4 = v15
        Frame.Visible = false
        RemainingHatchTime.RichText = true
        return v15
    end
    return v13
end

local function getRemainingSeconds(v16) -- line 68 | captures: Players, Workspace, EggRecords
    local Record = v16.Record
    local Placement = Record.Placement
    local v17, v18
    if Placement == nil then
        v18 = true
    elseif Placement.ReadyAt == nil then
        local TimeSkipSeconds = v16.TimeSkipSeconds
        if TimeSkipSeconds == nil then
            v17 = 0
        else
            v17 = TimeSkipSeconds.Value
        end
        v18 = false
    else
        v18 = true
    end
    if v18 then
        return 0
    end
    local v19 = Workspace:GetServerTimeNow()
    local v20 = EggRecords.GrowthSecondsRemaining(Record, v19, Record.GrowthSpeedMultiplier, nil, Players.LocalPlayer) - v17
    return (math.max(0, v20))
end

local function getEntryScreenPosition(v21) -- line 84 | captures: Workspace, ModelBounds
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        local v22, v23 = CurrentCamera:WorldToViewportPoint(ModelBounds(v21.Model).Position)
        if v23 then
            return true, Vector2.new(v22.X, v22.Y)
        end
    end
    return false, Vector2.zero
end

local function isEntryInRange(v24) -- line 96 | captures: Players
    local Character = Players.LocalPlayer.Character
    if Character == nil then
        return false
    end
    local PrimaryPart = Character.PrimaryPart
    if PrimaryPart == nil then
        return false
    end
    local v25, v26 = v24.Tracker:GetClosestSurfacePoint(PrimaryPart.Position, 0)
    _ = v25
    if v26 == nil then
        return false
    end
    return v26 <= 7
end

local function selectNearestEntry() -- line 110 | captures: Players, v1
    local Character = Players.LocalPlayer.Character
    if Character == nil or Character.PrimaryPart == nil then
        return nil
    end
    local v27
    local v28 = (1/0)
    for v29, v30 in pairs(v1) do
        if v30.Model.Parent ~= nil then
            local v31, v32 = v30.Tracker:GetClosestSurfacePoint(Character.PrimaryPart.Position, 0)
            _ = v31
            if v32 ~= nil and v32 <= 7 and v32 < v28 then
                v27 = v30
                v28 = v32
            end
        end
    end
    return v27
end

local function updateStaticContent(v33, v34) -- line 129 | captures: Assets, SwapGradient
    local v35 = Assets.Directory[v34.Record.AssetCategory]
    local v36 = v35 ~= nil
    local v37 = ("Missing asset config for category %*"):format(v34.Record.AssetCategory)
    assert(v36, v37)
    v33.DisplayName.Text = "Egg"
    local RarityGradient
    if v35.Egg.HideRarity then
    else
        RarityGradient = v35.Rarity.RarityGradient
    end
    SwapGradient(v33.DisplayName, RarityGradient)
end

local function updateCountdown(v38, v39) -- line 142 | captures: v5, Players, Workspace, EggRecords, Elapsed, MonsterParasite, MonsterParasite_2, Save
    local v40 = v39.OwnerUserId == Players.LocalPlayer.UserId
    v38.RemainingHatchTime.Visible = v40
    if v40 then
        local Record = v39.Record
        local Placement = Record.Placement
        local v41
        if Placement == nil then
            v41 = 0
        elseif Placement.ReadyAt == nil then
            local TimeSkipSeconds = v39.TimeSkipSeconds
            local v42 = if TimeSkipSeconds == nil then 0 else TimeSkipSeconds.Value
            local v43 = Workspace:GetServerTimeNow()
            local v44 = EggRecords.GrowthSecondsRemaining(Record, v43, Record.GrowthSpeedMultiplier, nil, Players.LocalPlayer) - v42
            v41 = math.max(0, v44)
        else
            v41 = 0
        end
        local v45
        if v41 > 0 then
            v45 = Elapsed(v41)
        else
            v45 = "Ready!"
        end
        local v46 = EggRecords.ServerGrowthBoostMultiplier()
        local v47 = Save.Get()
        local v48
        if v47 == nil then
            v48 = 0
        elseif MonsterParasite.IsBoostActive(v47.MonsterParasite, MonsterParasite.BoostKinds.EggGrowth) then
            v48 = MonsterParasite_2.BoostMultiplier(MonsterParasite.BoostKinds.EggGrowth) - 1
        else
            v48 = 0
        end
        local v49 = v39.Record.GrowthSpeedMultiplier + v46 + v48
        if v41 > 0 and v49 > 1 then
            v45 ..= (" <font color=\"#FFD700\">(x%*)</font>"):format(v49)
        end
        if v45 ~= v5 then
            v5 = v45
            v38.RemainingHatchTime.Text = v45
        end
    else
        v5 = ""
    end
end

local function clearActiveHighlight() -- line 191 | captures: v6, HoverHighlight
    local v50 = v6
    v6 = nil
    if v50 ~= nil then
        HoverHighlight.FadeOut(v50, 0.25)
    end
end

local function clearFadeTween() -- line 198 | captures: v8, v9
    local v51 = v8
    v8 = nil
    v9 = nil
    if v51 ~= nil then
        v51:Cancel()
        v51:Destroy()
    end
end

local function playCanvasFade(v52, v53, v54) -- line 207 | captures: v3, v7, v8, v9, Tween
    if v8 == nil then
        local v55 = v8
        v8 = nil
        v9 = nil
        if v55 ~= nil then
            v55:Cancel()
            v55:Destroy()
        end
        v9 = v53
        if v53 < 1 then
            v52.Frame.Visible = true
        end
        local v56 = v52.CanvasGroup.GroupTransparency - v53
        if math.abs(v56) > 0.001 then
            local v57 = Tween(v52.CanvasGroup, { GroupTransparency = v53 }, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            })
            v8 = v57
            v57.Completed:Once(function(v58) -- line 224 | captures: v52, v53, v54, v57, v3, v7, v8, v9
                if v8 == v57 then
                    v8 = nil
                    v9 = nil
                end
                v57:Destroy()
                if v58 == Enum.PlaybackState.Completed then
                    v52.CanvasGroup.GroupTransparency = v53
                    if v53 >= 1 and v54 ~= nil and v3 == nil and v7 == v54 then
                        v52.Frame.Visible = false
                    end
                end
            end)
        else
            v52.CanvasGroup.GroupTransparency = v53
            v9 = nil
            if v53 >= 1 and v54 ~= nil and v3 == nil and v7 == v54 then
                v52.Frame.Visible = false
            end
        end
    elseif v9 == v53 then
    end
end

local function setActiveEntry(v59) -- line 250 | captures: v3, v5, v6, v7, Assets, SwapGradient, HoverHighlight, bindGui, updateCountdown, playCanvasFade
    if v59 == nil then
        if v3 ~= nil then
            local v60 = bindGui()
            v3 = nil
            v5 = ""
            v7 += 1
            local v61 = v6
            v6 = nil
            if v61 ~= nil then
                HoverHighlight.FadeOut(v61, 0.25)
            end
            if v60.Frame.Visible then
                playCanvasFade(v60, 1, v7)
            end
        end
    else
        local v62 = bindGui()
        v7 += 1
        if not v62.Frame.Visible then
            v62.CanvasGroup.GroupTransparency = 1
        end
        playCanvasFade(v62, 0, nil)
        local v63 = ("%*:%*"):format(v59.OwnerUserId, v59.Uid)
        if v3 ~= v63 then
            v3 = v63
            v5 = ""
            local v64 = v6
            v6 = nil
            if v64 ~= nil then
                HoverHighlight.FadeOut(v64, 0.25)
            end
            v6 = HoverHighlight.FadeIn(v59.Model, "EggHoverHighlight", 0.25)
            local v65 = Assets.Directory[v59.Record.AssetCategory]
            local v66 = v65 ~= nil
            local v67 = ("Missing asset config for category %*"):format(v59.Record.AssetCategory)
            assert(v66, v67)
            v62.DisplayName.Text = "Egg"
            local RarityGradient
            if v65.Egg.HideRarity then
            else
                RarityGradient = v65.Rarity.RarityGradient
            end
            SwapGradient(v62.DisplayName, RarityGradient)
        end
        updateCountdown(v62, v59)
        v62.Frame.Visible = true
    end
end

local function updateBillboard() -- line 301 | captures: v3, v5, v6, v7, Players, Workspace, ModelBounds, HoverHighlight, v2, bindGui, selectNearestEntry, playCanvasFade, setActiveEntry
    if next(v2) == nil then
        local v68 = selectNearestEntry()
        if v68 == nil then
            if v3 ~= nil then
                local v69 = bindGui()
                v3 = nil
                v5 = ""
                v7 += 1
                local v70 = v6
                v6 = nil
                if v70 ~= nil then
                    HoverHighlight.FadeOut(v70, 0.25)
                end
                if v69.Frame.Visible then
                    playCanvasFade(v69, 1, v7)
                end
            end
        else
            local Character = Players.LocalPlayer.Character
            local v71
            if Character == nil then
                v71 = false
            else
                local PrimaryPart = Character.PrimaryPart
                if PrimaryPart == nil then
                    v71 = false
                else
                    local v72, v73 = v68.Tracker:GetClosestSurfacePoint(PrimaryPart.Position, 0)
                    _ = v72
                    if v73 == nil then
                        v71 = false
                    else
                        v71 = v73 <= 7
                    end
                end
            end
            if v71 then
                local v74 = bindGui()
                local CurrentCamera = Workspace.CurrentCamera
                local v75, v76
                if CurrentCamera == nil then
                    v75, v76 = false, Vector2.zero
                else
                    local v77, v78 = CurrentCamera:WorldToViewportPoint(ModelBounds(v68.Model).Position)
                    if v78 then
                        v75, v76 = true, Vector2.new(v77.X, v77.Y)
                    else
                        v75, v76 = false, Vector2.zero
                    end
                end
                if v75 then
                    setActiveEntry(v68)
                    v74.Frame.Position = UDim2.fromOffset(v76.X, v76.Y)
                elseif v3 ~= nil then
                    local v79 = bindGui()
                    v3 = nil
                    v5 = ""
                    v7 += 1
                    local v80 = v6
                    v6 = nil
                    if v80 ~= nil then
                        HoverHighlight.FadeOut(v80, 0.25)
                    end
                    if v79.Frame.Visible then
                        playCanvasFade(v79, 1, v7)
                    end
                end
            end
        end
    elseif v3 ~= nil then
        local v81 = bindGui()
        v3 = nil
        v5 = ""
        v7 += 1
        local v82 = v6
        v6 = nil
        if v82 ~= nil then
            HoverHighlight.FadeOut(v82, 0.25)
        end
        if v81.Frame.Visible then
            playCanvasFade(v81, 1, v7)
        end
    end
end

function v10.SetEntry(v83) -- line 395 | captures: Eggs, SurfaceTracker, t, v1
    t.strict(t.number)(v83.OwnerUserId)
    t.strict(t.string)(v83.Uid)
    t.strict(t.instanceIsA("Model"))(v83.Model)
    local v84 = Eggs.SchemaValidation.RuntimeEggRecord(v83.Record)
    assert(v84, "Invalid runtime egg record")
    local v85 = ("%*:%*"):format(v83.OwnerUserId, v83.Uid)
    local v86 = v1[v85]
    local v87
    if v86 == nil then
        v87 = SurfaceTracker.new(v83.Model)
    elseif v86.Model == v83.Model then
        v87 = v86.Tracker
    else
        v87 = SurfaceTracker.new(v83.Model)
    end
    if v86 ~= nil and v86.Model ~= v83.Model then
        v86.Tracker:Destroy()
    end
    v1[v85] = {
        OwnerUserId = v83.OwnerUserId,
        Uid = v83.Uid,
        Record = v83.Record,
        Model = v83.Model,
        TimeSkipSeconds = v83.TimeSkipSeconds,
        Tracker = v87
    }
end

function v10.SetNightPresentationActive(v88, v89, v90) -- line 426 | captures: v3, v5, v6, v7, HoverHighlight, t, v2, bindGui, playCanvasFade
    t.strict(t.number)(v88)
    t.strict(t.string)(v89)
    t.strict(t.boolean)(v90)
    local v91 = ("%*:%*"):format(v88, v89)
    if v90 then
        v2[v91] = v88
        if v3 ~= nil then
            local v92 = bindGui()
            v3 = nil
            v5 = ""
            v7 += 1
            local v93 = v6
            v6 = nil
            if v93 ~= nil then
                HoverHighlight.FadeOut(v93, 0.25)
            end
            if v92.Frame.Visible then
                playCanvasFade(v92, 1, v7)
            end
        end
    else
        v2[v91] = nil
    end
end

function v10.RemoveEntry(v94, v95) -- line 456 | captures: v3, v5, v6, v7, HoverHighlight, t, v1, v2, bindGui, playCanvasFade
    t.strict(t.number)(v94)
    t.strict(t.string)(v95)
    local v96 = ("%*:%*"):format(v94, v95)
    local v97 = v1[v96]
    if v97 ~= nil then
        v97.Tracker:Destroy()
    end
    v1[v96] = nil
    v2[v96] = nil
    local v98, v99
    if v3 == v96 then
        if v3 == nil then
            v99 = true
        else
            v98 = bindGui()
            v3 = nil
            v5 = ""
            v7 += 1
            local v100 = v6
            v6 = nil
            if v100 ~= nil then
                HoverHighlight.FadeOut(v100, 0.25)
            end
            v99 = false
        end
    else
        v99 = true
    end
    if v99 then
        return
    end
    if v98.Frame.Visible then
        playCanvasFade(v98, 1, v7)
    end
end

function v10.DestroyOwner(v101) -- line 484 | captures: v3, v5, v6, v7, HoverHighlight, t, v1, v2, bindGui, playCanvasFade
    t.strict(t.number)(v101)
    for v102, v103 in pairs(v1) do
        if v103.OwnerUserId == v101 then
            v103.Tracker:Destroy()
            v1[v102] = nil
            if v3 == v102 and v3 ~= nil then
                local v104 = bindGui()
                v3 = nil
                v5 = ""
                v7 += 1
                local v105 = v6
                v6 = nil
                if v105 ~= nil then
                    HoverHighlight.FadeOut(v105, 0.25)
                end
                if v104.Frame.Visible then
                    playCanvasFade(v104, 1, v7)
                end
            end
        end
    end
    for v106, v107 in pairs(v2) do
        if v107 == v101 then
            v2[v106] = nil
        end
    end
end

require(ReplicatedStorage.Shared.Utils.FrameStepper).OnRender(function() -- line 515 | captures: updateBillboard
    updateBillboard()
    return nil
end)
return v10
