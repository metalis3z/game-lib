-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.array(t.integer), function(v2) -- line 15
    local v3 = {}
    for v4, v5 in ipairs(v2) do
        if v3[v5] then
            return false
        end
        v3[v5] = true
    end
    return true
end)
local BaseUpgradeTransitionLifecycle = require(ReplicatedStorage.Client.BaseUpgradeTransitionLifecycle)
require(ReplicatedStorage.Shared.Globals.Constants)
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local Emit = require(ReplicatedStorage.Shared.Utils.VFX).Emit
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local PlotUpgradeVisibility = require(ReplicatedStorage.Client.PlotUpgradeVisibility)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local OnRender = require(ReplicatedStorage.Shared.Utils.FrameStepper).OnRender
local RuntimeInstanceRegistry = require(ReplicatedStorage.Client.Modules.RuntimeInstanceRegistry)
local Save = require(ReplicatedStorage.Shared.Save)
local TreadmillStaticCover = require(ReplicatedStorage.Client.UI.TreadmillStaticCover)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local Render = require(script.Render)
require(script.Types.Interface)
local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
local LocalPlayer = Players.LocalPlayer
local v6 = Log.new()
local TreadmillUpgrade = ReplicatedStorage.Assets.Particles.TreadmillUpgrade
local Folder = Instance.new("Folder")

Folder.Name = "__ClientTreadmillRenders"
Folder.Parent = Workspace
task.spawn(require(ReplicatedStorage.Shared.Utils.Warmup).WarmAssets, TreadmillUpgrade)
local v7
local v8 = false
local v9 = {}
local v10 = false
local v11 = TryLock()
local v12 = false
local v13 = 0
local v14 = true
local v15 = 0
local v16 = 0
local v17 = false
local v18 = 0
local v19 = false
local v20 = false
local v21 = false
local v22 = false
local v23 = {}
local v24 = {}
local v25 = {}

local function destroyRender(v26) -- line 69 | captures: RuntimeInstanceRegistry, LocalPlayer, v24
    local v27 = v24[v26]
    if v27 == nil then
        return
    end
    v24[v26] = nil
    if v27.OwnerUserId == LocalPlayer.UserId then
        RuntimeInstanceRegistry.Release("TreadmillPlotRender", (tostring(v26)))
        if RuntimeInstanceRegistry.Peek("Treadmill", v27.TreadmillId) == v27.Model then
            RuntimeInstanceRegistry.Release("Treadmill", v27.TreadmillId)
        end
    end
    if v27.Cover ~= nil then
        v27.Cover:Destroy()
    end
    v27.Model:Destroy()
end

local function resolveLocalRender() -- line 87 | captures: PlotState, v24
    local v28 = PlotState.ResolveLocalSlot()
    if v28 == nil then
        return nil
    end
    return v24[v28]
end

local function animateScale(v29, v30, v31, v32, v33) -- line 94 | captures: Ease, OnRender, Render
    OnRender(function(v34, v35) -- line 95 | captures: v29, v30, v31, v33, Ease, Render
        if v29.Model.Parent == nil then
            return true
        end
        local v36 = Ease(v35, v33, Enum.EasingDirection.Out)
        Render.SetGroundedScale(v29, v30 + (v31 - v30) * v36)
        return false
    end, v32, true):Wait()
    if v29.Model.Parent ~= nil then
        Render.SetGroundedScale(v29, v31)
    end
end

local function runLocalUpgradeAnimation(v37, v38) -- line 107 | captures: TweenService, Audio, Emit, Message, TreadmillUpgrade, animateScale
    local Root = v37.Model.Root
    local BasePart = Root:IsA("BasePart")
    local v39 = ("Treadmill \"%*\" Root must be a BasePart"):format(v37.TreadmillId)
    assert(BasePart, v39)
    local Highlight = Instance.new("Highlight")
    Highlight.Adornee = v37.Model
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 1
    Highlight.OutlineColor = Color3.new(1, 1, 1)
    Highlight.OutlineTransparency = 1
    Highlight.Parent = v37.Model
    local v40 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v41 = TweenService:Create(Highlight, v40, {
        FillTransparency = 0.15,
        OutlineTransparency = 0
    })
    local v42 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local v43 = TweenService:Create(Highlight, v42, {
        FillTransparency = 1,
        OutlineTransparency = 1
    })
    v41.Completed:Once(function() -- line 123 | captures: v43
        v43:Play()
    end)
    v43.Completed:Once(function() -- line 126 | captures: Highlight
        Highlight:Destroy()
    end)
    v41:Play()
    local v44 = TreadmillUpgrade:Clone()
    Emit(Root, nil, v44:GetChildren())
    Audio.Play(100001942526412, script, {
        Volume = 1.5,
        PlaybackSpeed = { 0.9, 1.1 }
    })
    Message.Bottom({
        Message = "Successfully upgraded your treadmill!",
        Time = 0.7,
        Color = Color3.fromRGB(0, 255, 47)
    })
    animateScale(v37, v38 * 0.8, v38, 0.55, Enum.EasingStyle.Elastic)
end

local function replaceRender(v45, v46, v47, v48) -- line 139 | captures: v7, v8, RuntimeInstanceRegistry, TreadmillStaticCover, Render, LocalPlayer, Folder, v24, v25, destroyRender, animateScale, runLocalUpgradeAnimation
    local v49 = (v25[v45] or 0) + 1
    v25[v45] = v49
    local v50 = v24[v45]
    if v48 and v50 ~= nil then
        local v51 = v50.Model:GetScale()
        animateScale(v50, v51, v51 * 0.8, 0.22, Enum.EasingStyle.Quad)
        if v25[v45] ~= v49 then
            return
        end
    end
    destroyRender(v45)
    local v52 = if v48 then 0.8 else 1
    local v53 = v46 == LocalPlayer.UserId
    local v54 = Render.Build(v45, v46, v47, v52, v53, Folder)
    v24[v45] = v54
    if v53 then
        local v55 = tostring(v45)
        RuntimeInstanceRegistry.Bind("TreadmillPlotRender", v55, v54.Model)
        local v56 = v7 == nil
        v54.RateSign.Enabled = v56
        if v54.Cover ~= nil then
            TreadmillStaticCover.SetEnabled(v54.Cover, v56)
        end
        if v7 ~= nil and not v8 then
            RuntimeInstanceRegistry.Bind("Treadmill", v54.TreadmillId, v54.Model)
        end
    end
    if v48 then
        runLocalUpgradeAnimation(v54, v54.Model:GetScale() / 0.8)
    end
end

local function refreshSlot(v57, v58, v59) -- line 175 | captures: v13, v22, Players, BaseUpgradeTransitionLifecycle, PlotState, Save, LocalPlayer, v9, v25, destroyRender, replaceRender
    if v58 == nil then
        v25[v57] = (v25[v57] or 0) + 1
        destroyRender(v57)
    elseif v58 == LocalPlayer.UserId then
        local v60 = Players:GetPlayerByUserId(v58)
        if v60 ~= nil then
            local v61 = Save.Get(v60)
            if v61 ~= nil and PlotState.LookupOwner(v57) == v58 then
                if v61.BaseUpgradeLevel == 0 then
                    destroyRender(v57)
                elseif v58 == LocalPlayer.UserId then
                    if v22 then
                        v22 = true
                        destroyRender(v57)
                    elseif not (v13 == 0 and BaseUpgradeTransitionLifecycle.IsPlaying()) then
                        replaceRender(v57, v58, v61, v59)
                    else
                        v22 = true
                        destroyRender(v57)
                    end
                else
                    replaceRender(v57, v58, v61, v59)
                end
            end
        end
    elseif v9[v58] ~= true then
        v25[v57] = (v25[v57] or 0) + 1
        destroyRender(v57)
    end
end

local function refreshPlayerRender(v62, v63) -- line 216 | captures: PlotState, refreshSlot
    for v64, v65 in pairs(PlotState.ReadOwners()) do
        if v65 == v62.UserId then
            refreshSlot(v64, v65, v63)
            return
        end
    end
end

local function applyRemoteSessionTransition(v66, v67, v68) -- line 224 | captures: v15, LocalPlayer, v9, refreshPlayerRender
    if not (v68 <= v15) then
        v15 = v68
        if v66 ~= LocalPlayer then
            if v67 then
                v9[v66.UserId] = true
            else
                v9[v66.UserId] = nil
            end
            refreshPlayerRender(v66, false)
        end
    end
end

local function refreshLocalRender(v69) -- line 239 | captures: v12, LocalPlayer, refreshPlayerRender
    v12 = true
    refreshPlayerRender(LocalPlayer, v69)
    v12 = false
end

local function consumePendingUpgradeRefresh() -- line 244 | captures: v7, v10, v12, v16, v20, v21, Workspace, LocalPlayer, refreshPlayerRender
    if not (v10 and v20 and v7 == nil) then
        return
    end
    v10 = false
    v20 = false
    v21 = false
    v12 = true
    refreshPlayerRender(LocalPlayer, v21)
    v12 = false
    v16 = Workspace:GetServerTimeNow() + 1.25
end

local function refreshPlotUpgradeVisibility() -- line 256 | captures: v13, PlotUpgradeVisibility
    local v70 = v13 > 0
    PlotUpgradeVisibility.Apply("TreadmillUpgrade", v70)
end

local function revealFirstExpansionTreadmill() -- line 260 | captures: v12, v13, v16, v22, Workspace, PlotUpgradeVisibility, Save, LocalPlayer, refreshPlayerRender
    local v71 = Save.Get()
    local v72 = v71 ~= nil
    assert(v72, "First expansion treadmill reveal requires local save data")
    if v71.BaseUpgradeLevel == 0 then
        return
    end
    v13 = v71.BaseUpgradeLevel
    v22 = false
    local v73 = v13 > 0
    PlotUpgradeVisibility.Apply("TreadmillUpgrade", v73)
    v12 = true
    refreshPlayerRender(LocalPlayer, true)
    v12 = false
    v16 = Workspace:GetServerTimeNow() + 1.25
end

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
local v74 = Save.Get()
local v75 = v74 ~= nil
assert(v75, "Static treadmill controller requires local save data")
local TreadmillUpgradeLevel = v74.TreadmillUpgradeLevel
v13 = v74.BaseUpgradeLevel
Remotes.Treadmill.RenderStateShifted.OnClientEvent:Connect(function(v76, v77, v78) -- line 284 | captures: v14, v15, t, LocalPlayer, v9, v23, refreshPlayerRender
    t.strict(t.instanceIsA("Player"))(v76)
    t.strict(t.boolean)(v77)
    t.strict(t.number)(v78)
    if v14 then
        local v79 = {
            Active = v77,
            Player = v76,
            Revision = v78
        }
        table.insert(v23, v79)
    elseif not (v78 <= v15) then
        v15 = v78
        if v76 ~= LocalPlayer then
            if v77 then
                v9[v76.UserId] = true
            else
                v9[v76.UserId] = nil
            end
            refreshPlayerRender(v76, false)
        end
    end
end)
local v80, v81 = Remotes.Treadmill.AskRenderSnapshot:InvokeServer()
t.strict(v1)(v80)
t.strict(t.number)(v81)
table.clear(v9)
for v82, v83 in ipairs(v80) do
    if v83 ~= LocalPlayer.UserId then
        v9[v83] = true
    end
end
v15 = v81
table.sort(v23, function(v84, v85) -- line 323
    return v84.Revision < v85.Revision
end)
v14 = false
local OnClientEvent
for v86, v87 in ipairs(v23) do
    OnClientEvent = v87.Player
    local Revision = v87.Revision
    if v15 < Revision then
        v15 = Revision
        if OnClientEvent ~= LocalPlayer then
            if v87.Active then
                v9[OnClientEvent.UserId] = true
            else
                v9[OnClientEvent.UserId] = nil
            end
            refreshPlayerRender(OnClientEvent, false)
        end
    end
end
table.clear(v23)
for v88, v89 in pairs(PlotState.ReadOwners()) do
    task.spawn(refreshSlot, v88, v89, false)
end
task.spawn(function() -- line 350 | captures: PlotState, LocalPlayer, v6, v24, refreshSlot
    local v90 = os.clock() + 10
    while true do
        local v91 = PlotState.ResolveLocalSlot()
        if v91 == nil then
            task.wait(0.1)
            if v90 <= os.clock() then
                v6:AtWarning():Log("Timed out waiting for the local plot before rendering the treadmill")
                return
            end
            continue
        end
        if v24[v91] == nil then
            refreshSlot(v91, LocalPlayer.UserId, false)
        end
        break
    end
end)
OnClientEvent = v13 > 0
PlotUpgradeVisibility.Apply("TreadmillUpgrade", OnClientEvent)
PlotState.PlotChanged:Connect(function(v92, v93) -- line 366 | captures: v13, PlotUpgradeVisibility, refreshSlot
    local v94 = v13 > 0
    PlotUpgradeVisibility.Apply("TreadmillUpgrade", v94)
    task.spawn(refreshSlot, v92, v93, false)
end)
TreadmillVideoGate.Changed:Connect(function() -- line 371 | captures: PlotState, LocalPlayer, refreshSlot
    for v95, v96 in pairs(PlotState.ReadOwners()) do
        if v96 ~= LocalPlayer.UserId then
            task.spawn(refreshSlot, v95, v96, false)
        end
    end
end)
PlotState.FolderChanged:Connect(function() -- line 379 | captures: v13, PlotState, PlotUpgradeVisibility, refreshSlot
    local v97 = v13 > 0
    PlotUpgradeVisibility.Apply("TreadmillUpgrade", v97)
    for v98, v99 in pairs(PlotState.ReadOwners()) do
        task.spawn(refreshSlot, v98, v99, false)
    end
end)
Players.PlayerAdded:Connect(function(v100) -- line 386 | captures: refreshPlayerRender
    task.spawn(refreshPlayerRender, v100, false)
end)
Players.PlayerRemoving:Connect(function(v101) -- line 389 | captures: v9, v24, v25, destroyRender
    v9[v101.UserId] = nil
    for v102, v103 in pairs(v24) do
        if v103 and v103.OwnerUserId == v101.UserId then
            v25[v102] = (v25[v102] or 0) + 1
            destroyRender(v102)
        end
    end
end)
Save.PeerProfileReady:Connect(function(v104) -- line 398 | captures: refreshPlayerRender
    refreshPlayerRender(v104, false)
end)
Save.PeerFieldChanged:Connect(function(v105, v106) -- line 401 | captures: Save, TreadmillStaticCover, v24, refreshPlayerRender
    if v106 == "TreadmillUpgradeLevel" then
        refreshPlayerRender(v105, false)
    elseif v106 == "TreadmillMediaFeedState" then
        local v107 = Save.Get(v105, false)
        if v107 ~= nil then
            for v108, v109 in pairs(v24) do
                if v109 and v109.OwnerUserId == v105.UserId and v109.Cover ~= nil then
                    TreadmillStaticCover.ApplyFeed(v109.Cover, v107.TreadmillMediaFeedState)
                end
            end
        end
    end
end)
Remotes.Treadmill.ViewStateShifted.OnClientEvent:Connect(function(v110, v111) -- line 417 | captures: t, TreadmillStaticCover, TreadmillVideoController, LocalPlayer, v24
    t.strict(t.instanceIsA("Player"))(v110)
    t.strict(t.string)(v111)
    if v110 ~= LocalPlayer then
        local v112 = TreadmillVideoController.GetMediaEntryByKey(v111)
        if v112 ~= nil then
            for v113, v114 in pairs(v24) do
                if v114 and v114.OwnerUserId == v110.UserId and v114.Cover ~= nil then
                    TreadmillStaticCover.ApplyMedia(v114.Cover, v112)
                end
            end
        end
    end
end)
Save.FieldSignal("TreadmillUpgradeLevel"):Connect(function() -- line 435 | captures: v7, v10, v12, v13, v16, v20, v21, TreadmillUpgradeLevel, Workspace, PlotUpgradeVisibility, Save, LocalPlayer, refreshPlayerRender
    local v115 = Save.Get()
    local v116 = v115 ~= nil
    assert(v116, "Local treadmill upgrade requires save data")
    local v117 = TreadmillUpgradeLevel < v115.TreadmillUpgradeLevel
    TreadmillUpgradeLevel = v115.TreadmillUpgradeLevel
    local v118 = v13 > 0
    PlotUpgradeVisibility.Apply("TreadmillUpgrade", v118)
    if v7 == nil then
        if v10 then
            v20 = true
            v21 = v21 or v117
            if v10 and v20 and v7 == nil then
                v10 = false
                v20 = false
                v21 = false
                v12 = true
                refreshPlayerRender(LocalPlayer, v21)
                v12 = false
                v16 = Workspace:GetServerTimeNow() + 1.25
            end
        else
            v12 = true
            refreshPlayerRender(LocalPlayer, v117)
            v12 = false
        end
    else
        v20 = true
        v21 = v21 or v117
        if v10 and v20 and v7 == nil then
            v10 = false
            v20 = false
            v21 = false
            v12 = true
            refreshPlayerRender(LocalPlayer, v21)
            v12 = false
            v16 = Workspace:GetServerTimeNow() + 1.25
        end
    end
end)
Save.FieldSignal("BaseUpgradeLevel"):Connect(function() -- line 480 | captures: v12, v13, v16, v22, Workspace, BaseUpgradeTransitionLifecycle, PlotUpgradeVisibility, Save, LocalPlayer, refreshPlayerRender
    local v119 = Save.Get()
    local v120 = v119 ~= nil
    assert(v120, "Local base upgrade requires save data")
    local v121 = if v13 == 0 then v119.BaseUpgradeLevel > 0 else false
    v13 = v119.BaseUpgradeLevel
    if v121 then
        if BaseUpgradeTransitionLifecycle.IsPlaying() then
            v13 = 0
            v22 = true
            local v122 = v13 > 0
            PlotUpgradeVisibility.Apply("TreadmillUpgrade", v122)
        else
            local v123 = Save.Get()
            local v124 = v123 ~= nil
            assert(v124, "First expansion treadmill reveal requires local save data")
            if v123.BaseUpgradeLevel ~= 0 then
                v13 = v123.BaseUpgradeLevel
                v22 = false
                local v125 = v13 > 0
                PlotUpgradeVisibility.Apply("TreadmillUpgrade", v125)
                v12 = true
                refreshPlayerRender(LocalPlayer, true)
                v12 = false
                v16 = Workspace:GetServerTimeNow() + 1.25
            end
        end
    else
        local v126 = v13 > 0
        PlotUpgradeVisibility.Apply("TreadmillUpgrade", v126)
    end
end)
BaseUpgradeTransitionLifecycle.Completed:Connect(function() -- line 514 | captures: v12, v13, v16, v22, Workspace, PlotUpgradeVisibility, Save, LocalPlayer, refreshPlayerRender
    if not v22 then
        return
    end
    local v127 = Save.Get()
    local v128 = v127 ~= nil
    assert(v128, "First expansion treadmill reveal requires local save data")
    if v127.BaseUpgradeLevel == 0 then
        return
    end
    v13 = v127.BaseUpgradeLevel
    v22 = false
    local v129 = v13 > 0
    PlotUpgradeVisibility.Apply("TreadmillUpgrade", v129)
    v12 = true
    refreshPlayerRender(LocalPlayer, true)
    v12 = false
    v16 = Workspace:GetServerTimeNow() + 1.25
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v130, v131, v132, v133, v134, v135, v136) -- line 533 | captures: v7, v8, v10, v12, v16, v20, v21, Workspace, PlotState, RuntimeInstanceRegistry, TreadmillStaticCover, LocalPlayer, v24, refreshPlayerRender
    v7 = v130
    if v130 == nil then
        v8 = false
    else
        v8 = v135 == true
    end
    if v130 == nil then
        RuntimeInstanceRegistry.Release("Treadmill")
        v16 = Workspace:GetServerTimeNow() + 1.25
        if v134 == true then
            v10 = true
            if v10 and v20 and v7 == nil then
                v10 = false
                v20 = false
                v21 = false
                v12 = true
                refreshPlayerRender(LocalPlayer, v21)
                v12 = false
                v16 = Workspace:GetServerTimeNow() + 1.25
            end
        end
    elseif v135 == true then
        local v137 = v136 or Workspace:WaitForChild("AdminTreadmill", 5)
        local v138 = v137 and v137:IsA("Tool") and v137:IsDescendantOf(Workspace)
        assert(v138, "Shared treadmill must be a workspace Tool")
        RuntimeInstanceRegistry.Bind("Treadmill", v130, v137)
    end
    local v139 = PlotState.ResolveLocalSlot()
    local v140
    if v139 == nil then
    else
        v140 = v24[v139]
    end
    if v140 == nil then
        return
    end
    local v141 = if v130 == nil then true else v135 == true
    v140.RateSign.Enabled = v141
    local Cover = v140.Cover
    if Cover ~= nil then
        TreadmillStaticCover.SetEnabled(Cover, v141)
    end
end)
TreadmillVideoController.MediaChanged:Connect(function(v142) -- line 585 | captures: PlotState, TreadmillStaticCover, v24
    local v143 = PlotState.ResolveLocalSlot()
    local v144
    if v143 == nil then
    else
        v144 = v24[v143]
    end
    if v144 ~= nil then
        local Cover = v144.Cover
        if Cover ~= nil then
            TreadmillStaticCover.ApplyMedia(Cover, v142)
        end
    end
end)
RunService.Heartbeat:Connect(function() -- line 600 | captures: v7, v10, v12, v16, v17, v18, v19, Workspace, PlotState, Remotes, RuntimeInstanceRegistry, LocalPlayer, v11, v24
    local v145 = PlotState.ResolveLocalSlot()
    local v146, v147
    if v145 == nil then
    else
        local v148 = v24[v145]
        v146 = v148
        v147 = v148
    end
    if v7 ~= nil then
        return
    end
    local v149 = Workspace:GetServerTimeNow()
    local Character = LocalPlayer.Character
    local v150
    if Character == nil then
    else
        v150 = Character:FindFirstChild("HumanoidRootPart")
    end
    local OPTREADMILL, v151, v152
    if v150 == nil then
        v152 = true
    elseif v150:IsA("BasePart") then
        OPTREADMILL = Workspace:FindFirstChild("OPTREADMILL")
        v151 = OPTREADMILL and OPTREADMILL:FindFirstChild("OPTreadmillDeck")
        v152 = false
    else
        v152 = true
    end
    if v152 then
        return
    end
    if OPTREADMILL and OPTREADMILL:IsA("Tool") and v151 and v151:IsA("BasePart") then
        local v153 = RaycastParams.new()
        v153.FilterType = Enum.RaycastFilterType.Include
        v153.FilterDescendantsInstances = { v151 }
        if Workspace:Raycast(v150.Position, Vector3.new(0, -8, 0), v153) then
            if v17 or v19 or v149 < v18 then
                return
            end
            v17 = true
            RuntimeInstanceRegistry.Bind("Treadmill", "OPTREADMILL", OPTREADMILL)
            local v154, v155, v156, v157 = pcall(function() -- line 633 | captures: Remotes
                return Remotes.Treadmill.AskWearStill:InvokeServer("OPTREADMILL")
            end)
            v17 = false
            if v154 then
                if v155 ~= true then
                    RuntimeInstanceRegistry.Release("Treadmill", "OPTREADMILL")
                end
            else
                RuntimeInstanceRegistry.Release("Treadmill", "OPTREADMILL")
            end
            v19 = v157 == "StepOffRequired"
            local v158 = Workspace:GetServerTimeNow()
            local v159 = if v157 == "GamepassRequired" then 1 else 0.1
            v18 = v158 + v159
            return
        end
    end
    v19 = false
    v18 = 0
    if v10 or v12 or not (v147 ~= nil) or v149 < v16 then
        return
    end
    local v160 = RaycastParams.new()
    v160.FilterType = Enum.RaycastFilterType.Include
    v160.FilterDescendantsInstances = {
        v147.Model,
        v147.Bottom
    }
    if Workspace:Raycast(v150.Position, Vector3.new(0, -8, 0), v160) ~= nil then
        v16 = v149 + 1.25
        v11(function() -- line 658 | captures: v146, Remotes, RuntimeInstanceRegistry
            RuntimeInstanceRegistry.Bind("Treadmill", v146.TreadmillId, v146.Model)
            if Remotes.Treadmill.AskWearStill:InvokeServer() ~= true then
                RuntimeInstanceRegistry.Release("Treadmill", v146.TreadmillId)
            end
        end)
    end
end)
