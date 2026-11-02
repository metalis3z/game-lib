-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
require(ReplicatedStorage.Shared.Globals.Constants)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(ReplicatedStorage.Shared.Eggs.EggRenderer)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Message = require(ReplicatedStorage.Client.Message)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Message_2 = require(ReplicatedStorage.Client.Notifications.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraFX = require(ReplicatedStorage.Client.SakuraFX)
local SakuraSignals = require(ReplicatedStorage.Client.SakuraSignals)
local Sakura_2 = require(ReplicatedStorage.Shared.Types.Sakura)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit)

if not GameFlags.GreatBloomEnabled:Get() then
    return
end
local v1 = Color3.fromRGB(255, 120, 200)
local v2 = Color3.fromRGB(255, 0, 0)
local v3 = { 1.5, 9 }
local v4 = Color3.fromRGB(235, 154, 200)
local v5 = Color3.fromRGB(255, 200, 232)
local v6 = Color3.fromRGB(255, 240, 248)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local __OBJECTS = Workspace:WaitForChild("__OBJECTS")
local Build = __OBJECTS:WaitForChild("Build")
local IncubatorAnchor = __OBJECTS:WaitForChild("Areas"):WaitForChild("CherryBlossom"):WaitForChild("IncubatorAnchor")
local BasePart = IncubatorAnchor:IsA("BasePart")
assert(BasePart, "CherryBlossom.IncubatorAnchor must be a BasePart")
local Sakura_3 = ReplicatedStorage.Assets.Models.Sakura
local IncubatorDead = Sakura_3.IncubatorDead
local IncubatorBloomed = Sakura_3.IncubatorBloomed
local CraneSign = Sakura_3.CraneSign
local Cutscene = Sakura_3.Cutscene
local CameraRig = Cutscene.CameraRig
local CraneRig = Cutscene.CraneRig
local PlayerRig = Cutscene.PlayerRig
local LeafCover = Cutscene.LeafCover
local LeafRing = Cutscene.LeafRing
local BlossomEffect = Cutscene.BlossomEffect
local Floor = Cutscene.Floor
local Cutscene_2 = script:WaitForChild("Cutscene")
local Sound = Cutscene_2:IsA("Sound")
assert(Sound, "SakuraIncubator.Cutscene must be a Sound")
Sound = BlossomEffect:IsA("BasePart") and Floor:IsA("BasePart")
assert(Sound, "Sakura cutscene BlossomEffect and Floor must be BaseParts")
local BasePart_2 = IncubatorDead.PrimaryPart and IncubatorBloomed.PrimaryPart
assert(BasePart_2, "Sakura incubator templates need PrimaryParts")
local Model = CraneSign:IsA("Model") and CraneSign.PrimaryPart
assert(Model, "Sakura.CraneSign must be a Model with a PrimaryPart")
local PrimaryPart = CameraRig.PrimaryPart and CraneRig.PrimaryPart and PlayerRig.PrimaryPart
assert(PrimaryPart, "Sakura cutscene rigs need PrimaryParts")
local PrimaryPart_2 = LeafCover.PrimaryPart
assert(PrimaryPart_2, "Sakura cutscene LeafCover needs a PrimaryPart")
PrimaryPart_2 = LeafRing.PrimaryPart
assert(PrimaryPart_2, "Sakura cutscene LeafRing needs a PrimaryPart")
local CameraAnimation = CameraRig.CameraAnimation
local CraneAnimation = CraneRig.CraneAnimation
local PlayerAnimation = PlayerRig.PlayerAnimation
local Animation = CameraAnimation:IsA("Animation") and CraneAnimation:IsA("Animation") and PlayerAnimation:IsA("Animation")
assert(Animation, "Sakura cutscene rigs need their Animation children")
local IncubatorBillboard = Sakura_3.IncubatorBillboard
local BillboardGui = IncubatorBillboard:IsA("BillboardGui")
assert(BillboardGui, "Sakura.IncubatorBillboard must be a BillboardGui")
local v7 = Trove.new()
local v8, PointLight, v9, v11
local v12 = false
local v13

local function notifyError(v14) -- line 105 | captures: Message_2, v2
    Message_2.Bottom({
        Time = 3,
        Message = v14,
        Color = v2
    })
end

local function isUnlocked() -- line 108 | captures: Save
    local v15 = Save.Get()
    if v15 == nil then
        return false
    end
    return v15.Sakura.Unlocked
end

local function spawnVisual(v16, v17) -- line 114 | captures: Workspace
    local v18 = v16:Clone()
    v18:PivotTo(v17)
    v18.Parent = Workspace
    return v18
end

local function rigCFrame(v19) -- line 120 | captures: IncubatorAnchor
    local RootOffset = v19:GetAttribute("RootOffset")
    local v20 = typeof(RootOffset) == "CFrame"
    local v21 = ("%* needs a RootOffset CFrame attribute"):format(v19.Name)
    assert(v20, v21)
    return IncubatorAnchor.CFrame * RootOffset
end

local function makePrompt(v22, v23, v24, v25) -- line 126
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "PromptAttachment"
    Attachment.Position = Vector3.new(0, 3, 0)
    Attachment.Parent = v22
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    ProximityPrompt.ActionText = v23
    ProximityPrompt.ObjectText = v24
    ProximityPrompt.HoldDuration = 0
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.MaxActivationDistance = v25
    ProximityPrompt.Parent = Attachment
    return ProximityPrompt
end

local function getChargePercent() -- line 141 | captures: Sakura, Save
    local v26 = Save.Get()
    if v26 == nil or v26.Sakura.Egg == false then
        return 0, false
    end
    return Sakura.GetChargePercent(v26.Sakura.Deposited, Sakura.GetRequiredCrystals()), true
end

local function getNextBloomAt(v27) -- line 149 | captures: Sakura
    local IntervalSeconds = Sakura.Bloom.IntervalSeconds
    return v27 + IntervalSeconds - (v27 + Sakura.Bloom.OffsetSeconds) % IntervalSeconds
end

local function getBloomStatusText() -- line 153 | captures: Workspace, Sakura
    local v28 = Workspace:GetServerTimeNow()
    local v29 = Workspace:GetAttribute(Sakura.Bloom.EndsAtAttribute)
    if typeof(v29) == "number" then
        if v28 < v29 then
            return "The Great Bloom is live!"
        end
        local IntervalSeconds = Sakura.Bloom.IntervalSeconds
        local v30 = v28 + IntervalSeconds - (v28 + Sakura.Bloom.OffsetSeconds) % IntervalSeconds - v28
        local v31 = math.max(0, v30)
        local v32 = v31 / 60
        local v33 = math.floor(v32)
        local format = string.format
        local v34 = v31 % 60
        return (("Next Great Bloom in %*:%*"):format(v33, (format("%02d", (math.floor(v34))))))
    end
    local IntervalSeconds = Sakura.Bloom.IntervalSeconds
    local v35 = v28 + IntervalSeconds - (v28 + Sakura.Bloom.OffsetSeconds) % IntervalSeconds - v28
    local v36 = math.max(0, v35)
    local v37 = v36 / 60
    local v38 = math.floor(v37)
    local format = string.format
    local v39 = v36 % 60
    return (("Next Great Bloom in %*:%*"):format(v38, (format("%02d", (math.floor(v39))))))
end

local function syncBillboardEnabled() -- line 171 | captures: v8, v12
    local v40 = v8
    if v40 then
        v40.Enabled = not v12
    end
end

local function renderBillboard() -- line 177 | captures: v8, PointLight, v12, TweenService, Sakura, Save, getBloomStatusText
    local v41 = v8
    if v41 == nil then
        return
    end
    v41.Enabled = not v12
    local Countdown = v41.Countdown
    local Progress = v41.Progress
    local v42 = Countdown:IsA("TextLabel") and Progress:IsA("Frame")
    assert(v42, "IncubatorBillboard needs Countdown and Progress")
    local Bar = Progress.Bar
    local Frame = Bar:IsA("Frame")
    assert(Frame, "IncubatorBillboard.Progress.Bar must be a Frame")
    local v43 = Save.Get()
    if v43 ~= nil and v43.Sakura.Unlocked then
        local v44 = Save.Get()
        local v45, v46
        if v44 == nil or v44.Sakura.Egg == false then
            v46 = 0
            v45 = false
        else
            v46 = Sakura.GetChargePercent(v44.Sakura.Deposited, Sakura.GetRequiredCrystals())
            v45 = true
        end
        Countdown.Text = getBloomStatusText()
        if v45 then
            Progress.Visible = true
            local v47 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v48 = {}
            local v49 = v46 / Sakura.Incubator.MaxChargePercent
            local v50 = math.clamp(v49, 0, 1)
            v48.Size = UDim2.fromScale(v50, 1)
            TweenService:Create(Bar, v47, v48):Play()
            local PointLight_2 = PointLight
            if PointLight_2 then
                local v51 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v52 = {}
                local v53 = v46 / Sakura.Incubator.MaxChargePercent
                v52.Brightness = math.clamp(v53, 0, 1) * 3
                TweenService:Create(PointLight_2, v51, v52):Play()
            end
        else
            Progress.Visible = false
        end
    else
        Countdown.Text = "Return a Crane pet to unlock Great Bloom"
        Progress.Visible = false
    end
end

local function buildTree(v54) -- line 230 | captures: v8, PointLight, v9, v11, v12, TweenService, Workspace, Message_2, Remotes, Tabs, v1, v2, IncubatorAnchor, IncubatorDead, IncubatorBloomed, CraneSign, IncubatorBillboard, v7, renderBillboard
    v7:Clean()
    local v55 = if v54 then IncubatorBloomed else IncubatorDead
    local v56 = v55:Clone()
    v56:PivotTo(IncubatorAnchor.CFrame)
    v56.Parent = Workspace
    v7:Add(v56)
    v9 = v56
    v11 = v54
    if v54 then
        local Door = v56:WaitForChild("Door")
        Door.CanCollide = false
        Door.CanTouch = false
        Door.CanQuery = false
        local v57 = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        TweenService:Create(Door, v57, { Transparency = 1 }):Play()
    end
    local Radius = v55:GetAttribute("Radius")
    local Height = v55:GetAttribute("Height")
    local PrimaryPart = v56.PrimaryPart
    v56:AddTag("MainSakuraTree")
    local v58 = IncubatorBillboard:Clone()
    local v59 = Height * 0.65
    v58.StudsOffsetWorldSpace = Vector3.new(0, v59, 0)
    v58.Enabled = not v12
    v58.Parent = PrimaryPart
    v8 = v58
    PointLight = nil
    if v54 then
        local Attachment = Instance.new("Attachment")
        Attachment.Name = "ChargeGlow"
        local v60 = Height * 0.6
        Attachment.Position = Vector3.new(0, v60, 0)
        Attachment.Parent = PrimaryPart
        local PointLight_2 = Instance.new("PointLight")
        PointLight_2.Color = v1
        PointLight_2.Brightness = 0
        PointLight_2.Range = 50
        PointLight_2.Parent = Attachment
        PointLight = PointLight_2
    end
    v7:Add(function() -- line 275 | captures: v8, PointLight
        v8 = nil
        PointLight = nil
    end)
    renderBillboard()
    if v54 then
        local Attachment = Instance.new("Attachment")
        Attachment.Name = "PromptAttachment"
        Attachment.Position = Vector3.new(0, 3, 0)
        Attachment.Parent = PrimaryPart
        local ProximityPrompt = Instance.new("ProximityPrompt")
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt.ActionText = "Open Incubator"
        ProximityPrompt.ObjectText = "Sakura Incubator"
        ProximityPrompt.HoldDuration = 0
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.MaxActivationDistance = Radius + 8
        ProximityPrompt.Parent = Attachment
        v7:Add(ProximityPrompt.Triggered:Connect(function() -- line 293 | captures: Tabs
            Tabs.Show("SakuraEggCharge")
        end))
    elseif not v12 then
        local RootOffset = CraneSign:GetAttribute("RootOffset")
        local v61 = typeof(RootOffset) == "CFrame"
        local v62 = ("%* needs a RootOffset CFrame attribute"):format(CraneSign.Name)
        assert(v61, v62)
        local v63 = IncubatorAnchor.CFrame * RootOffset
        local v64 = CraneSign:Clone()
        v64:PivotTo(v63)
        v64.Parent = Workspace
        v7:Add(v64)
        local Attachment = Instance.new("Attachment")
        Attachment.Name = "PromptAttachment"
        Attachment.Position = Vector3.new(0, 3, 0)
        Attachment.Parent = PrimaryPart
        local ProximityPrompt = Instance.new("ProximityPrompt")
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt.ActionText = "Hatch and Return Crane pet"
        ProximityPrompt.ObjectText = "Dormant Sakura Tree"
        ProximityPrompt.HoldDuration = 0
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.MaxActivationDistance = Radius + 8
        ProximityPrompt.Parent = Attachment
        local Triggered = ProximityPrompt.Triggered
        v7:Add(Triggered:Connect(function() -- line 321 | captures: ProximityPrompt, Message_2, Remotes, v2
            ProximityPrompt.Enabled = false
            local v65, v66 = Remotes.Bloomery.AskCraneReturn:InvokeServer()
            if v65 then
                return
            end
            local v67 = if typeof(v66) == "string" then v66 else "The tree sleeps... bring it a Crane pet"
            Message_2.Bottom({
                Time = 3,
                Message = v67,
                Color = v2
            })
            ProximityPrompt.Enabled = true
        end))
    end
end

local function emitPetals(v68, v69) -- line 338
    for v70, v71 in ipairs(v68:GetDescendants()) do
        if v71:IsA("ParticleEmitter") then
            v71:Emit(v69)
        end
    end
end

local function playTrack(v72, v73) -- line 345
    local v74 = v72:LoadAnimation(v73)
    v74.Priority = Enum.AnimationPriority.Action4
    v74.Looped = false
    v74:Play(0)
    return v74
end

local function getAnimator(v75) -- line 352
    local v76 = v75:FindFirstChildOfClass("Humanoid") or v75:FindFirstChildOfClass("AnimationController")
    local v77 = ("%* needs a Humanoid or AnimationController"):format(v75.Name)
    assert(v76, v77)
    local Animator = v76:FindFirstChildOfClass("Animator")
    local v78 = ("%* needs an Animator"):format(v75.Name)
    assert(Animator, v78)
    return Animator
end

local function cloneCharacterRig() -- line 362 | captures: Workspace, LocalPlayer, IncubatorAnchor, PlayerRig
    local Character = LocalPlayer.Character
    local v79 = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character ~= nil and v79 ~= nil and Character.PrimaryPart ~= nil then
        local Archivable = Character.Archivable
        Character.Archivable = true
        local v80 = Character:Clone()
        Character.Archivable = Archivable
        v80.Name = "SakuraCutscenePlayer"
        for v81, v82 in ipairs(v80:GetChildren()) do
            if v82:IsA("LocalScript") then
                v82:Destroy()
            elseif v82:IsA("Script") or v82:IsA("Tool") then
            end
        end
        local Humanoid = v80:FindFirstChildOfClass("Humanoid")
        assert(Humanoid, "Cloned character lost its Humanoid")
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        if Humanoid:FindFirstChildOfClass("Animator") == nil then
            Instance.new("Animator").Parent = Humanoid
        end
        for v83, v84 in ipairs(v80:GetDescendants()) do
            if v84:IsA("BasePart") then
                v84.Anchored = v84 == v80.PrimaryPart
                v84.CanCollide = false
                v84.CanQuery = false
                v84.CanTouch = false
                v84.LocalTransparencyModifier = 0
            end
        end
        local RootOffset = PlayerRig:GetAttribute("RootOffset")
        local v85 = typeof(RootOffset) == "CFrame"
        local v86 = ("%* needs a RootOffset CFrame attribute"):format(PlayerRig.Name)
        assert(v85, v86)
        v80:PivotTo(IncubatorAnchor.CFrame * RootOffset)
        v80.Parent = Workspace
        return v80
    end
    local RootOffset = PlayerRig:GetAttribute("RootOffset")
    local v87 = typeof(RootOffset) == "CFrame"
    local v88 = ("%* needs a RootOffset CFrame attribute"):format(PlayerRig.Name)
    assert(v87, v88)
    local v89 = IncubatorAnchor.CFrame * RootOffset
    local v90 = PlayerRig:Clone()
    v90:PivotTo(v89)
    v90.Parent = Workspace
    return v90
end

local function hideCharacter(v91) -- line 415 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    if Character == nil then
        return
    end
    local v92 = {}
    for v93, v94 in ipairs(Character:GetDescendants()) do
        if v94:IsA("BasePart") then
            v92[v94] = v94.LocalTransparencyModifier
            v94.LocalTransparencyModifier = 1
        elseif v94:IsA("Decal") then
            v92[v94] = v94.Transparency
            v94.Transparency = 1
        end
    end
    v91:Add(function() -- line 430 | captures: v92
        for v95, v96 in v92 do
            if v95.Parent then
                if v95:IsA("BasePart") then
                    v95.LocalTransparencyModifier = v96
                elseif v95:IsA("Decal") then
                    v95.Transparency = v96
                end
            end
        end
    end)
end

local function emitEffect(v97) -- line 445 | captures: Debris, Workspace, Emit, IncubatorAnchor
    local v98 = v97:Clone()
    local RootOffset = v97:GetAttribute("RootOffset")
    local v99 = typeof(RootOffset) == "CFrame"
    local v100 = ("%* needs a RootOffset CFrame attribute"):format(v97.Name)
    assert(v99, v100)
    v98.CFrame = IncubatorAnchor.CFrame * RootOffset
    v98.Parent = Workspace
    Debris:AddItem(v98, Emit(v98) + 1)
end

local function playBloom(v101) -- line 454 | captures: v9, Debris, TweenService, Workspace, Emit, v1, IncubatorAnchor, BlossomEffect, Floor, buildTree, emitPetals
    buildTree(true)
    local v102 = v9
    local PointLight = Instance.new("PointLight")
    PointLight.Color = v1
    PointLight.Brightness = 6
    PointLight.Range = 60
    PointLight.Parent = v102.PrimaryPart
    v101:Add(PointLight)
    local v103 = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(PointLight, v103, { Brightness = 0 }):Play()
    local v104 = BlossomEffect:Clone()
    local RootOffset = BlossomEffect:GetAttribute("RootOffset")
    local v105 = typeof(RootOffset) == "CFrame"
    local v106 = ("%* needs a RootOffset CFrame attribute"):format(BlossomEffect.Name)
    assert(v105, v106)
    v104.CFrame = IncubatorAnchor.CFrame * RootOffset
    v104.Parent = Workspace
    Debris:AddItem(v104, Emit(v104) + 1)
    local v107 = Floor:Clone()
    local RootOffset_2 = Floor:GetAttribute("RootOffset")
    local v108 = typeof(RootOffset_2) == "CFrame"
    local v109 = ("%* needs a RootOffset CFrame attribute"):format(Floor.Name)
    assert(v108, v109)
    v107.CFrame = IncubatorAnchor.CFrame * RootOffset_2
    v107.Parent = Workspace
    Debris:AddItem(v107, Emit(v107) + 1)
    emitPetals(v102, 80)
end

local function partKeys(v110) -- line 483
    local v111 = {}
    local v112

    function v112(v113, v114) -- line 486 | captures: v112, v111
        local v115 = {}
        for v116, v117 in ipairs(v113:GetChildren()) do
            local v118 = (v115[v117.Name] or 0) + 1
            v115[v117.Name] = v118
            local v119 = ("%*/%*#%*"):format(v114, v117.Name, v118)
            if v117:IsA("BasePart") then
                v111[v119] = v117
            end
            v112(v117, v119)
        end
    end

    v112(v110, "")
    return v111
end

local function tweenTreeToBloomed(v120) -- line 503 | captures: v9, v11, TweenService, IncubatorBloomed
    local v121 = v9
    if v121 == nil or v11 then
        return
    end
    local v122 = {}
    local v123

    function v123(v124, v125) -- line 510 | captures: v123, v122
        local v126 = {}
        for v127, v128 in ipairs(v124:GetChildren()) do
            local v129 = (v126[v128.Name] or 0) + 1
            v126[v128.Name] = v129
            local v130 = ("%*/%*#%*"):format(v125, v128.Name, v129)
            if v128:IsA("BasePart") then
                v122[v130] = v128
            end
            v123(v128, v130)
        end
    end

    v123(IncubatorBloomed, "")
    local v131 = TweenInfo.new(v120, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local v132 = {}
    local v133

    function v133(v134, v135) -- line 527 | captures: v133, v132
        local v136 = {}
        for v137, v138 in ipairs(v134:GetChildren()) do
            local v139 = (v136[v138.Name] or 0) + 1
            v136[v138.Name] = v139
            local v140 = ("%*/%*#%*"):format(v135, v138.Name, v139)
            if v138:IsA("BasePart") then
                v132[v140] = v138
            end
            v133(v138, v140)
        end
    end

    v133(v121, "")
    for v141, v142 in v132 do
        local v143 = v122[v141]
        if v143 and v143.Color ~= v142.Color then
            TweenService:Create(v142, v131, { Color = v143.Color }):Play()
        end
    end
end

local function playLeafCover(v144) -- line 552 | captures: RunService, TweenService, Workspace, v3, v4, v5, v6, LocalPlayer, CurrentCamera, IncubatorAnchor, LeafCover, tweenTreeToBloomed
    local CFrame = IncubatorAnchor.CFrame
    local v145 = LeafCover:Clone()
    v145:PivotTo(CFrame)
    v145.Parent = Workspace
    v144:Add(v145)
    local v146 = {}
    for v147, v148 in ipairs(v145:GetDescendants()) do
        if v148:IsA("BasePart") and v148 ~= v145.PrimaryPart then
            table.insert(v146, v148)
        end
    end
    table.sort(v146, function(v149, v150) -- line 566
        return v149.Position.Y < v150.Position.Y
    end)
    local v151 = {}
    for v152, v153 in v146 do
        v151[v153] = v153.Size
        v153.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        v153.Transparency = 1
    end
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = v4
    Highlight.OutlineColor = v5
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Parent = v145
    local v154 = true
    local v155 = false
    v144:Add(function() -- line 588 | captures: v154
        v154 = false
    end)

    local function sweep(v156, v157, v158) -- line 591 | captures: v154, v145, v146
        local v159 = #v146
        local v160 = os.clock()
        for v161, v162 in v146 do
            local v163 = v161 - 1
            local v164 = v159 - 1
            local v165 = v156 * v157(v163 / math.max(v164, 1)) - (os.clock() - v160)
            if v165 > 0 then
                task.wait(v165)
            end
            if v154 then
                if v145.Parent == nil then
                    return
                end
                v10(v162)
            else
                return
            end
        end
    end

    local function accelerating(v166) -- line 612
        return 1 - (1 - v166) ^ 2
    end

    local function linear(v167) -- line 615
        return v167
    end

    local FieldOfView = CurrentCamera.FieldOfView
    v144:Add(function() -- line 619 | captures: FieldOfView, CurrentCamera
        CurrentCamera.FieldOfView = FieldOfView
    end)
    local v168 = {}
    for v169, v170 in v146 do
        v168[v170] = v170.Color
    end
    task.spawn(function() -- line 629 | captures: v154, v155, v144, v146, v151, Highlight, sweep, accelerating, linear, FieldOfView, v168, RunService, TweenService, v3, v6, CurrentCamera, tweenTreeToBloomed
        local v171 = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        tweenTreeToBloomed(3.669999999999998)
        sweep(3.069999999999998, accelerating, function(v172) -- line 632 | captures: v171, v151, TweenService
            v172.Transparency = 0
            TweenService:Create(v172, v171, { Size = v151[v172] }):Play()
        end)
        task.wait(0.6)
        if not v154 or v155 then
            return
        end
        local v173 = TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        local v174 = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
        TweenService:Create(Highlight, v174, { OutlineTransparency = 0 }):Play()
        local v175 = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
        local v176 = { FieldOfView = FieldOfView - 12 }
        TweenService:Create(CurrentCamera, v175, v176):Play()
        task.spawn(sweep, 1.25, linear, function(v177) -- line 646 | captures: v173, v151, TweenService
            TweenService:Create(v177, v173, { Size = v151[v177] * 0.8 }):Play()
        end)
        local v178 = os.clock()
        local v179 = 0
        local v180
        v180 = RunService.Heartbeat:Connect(function(v181) -- line 652 | captures: v179, v180, v178, v154, v155, v146, Highlight, v168, v3, v6
            if not v154 or v155 then
                v180:Disconnect()
            else
                local v182 = (os.clock() - v178) / 2.5
                local v183 = math.clamp(v182, 0, 1)
                v179 += v181 * (v3[1] + (v3[2] - v3[1]) * v183 ^ 2) * 3.141592653589793 * 2
                local v184 = v179
                local v185 = (math.sin(v184) + 1) * 0.5 * (v183 * 0.65 + 0.35)
                Highlight.FillTransparency = 1 - v185 * 0.85
                for v186, v187 in v146 do
                    v187.Color = v168[v187]:Lerp(v6, v185)
                end
            end
        end)
        v144:Add(v180)
    end)

    local function flashScreen() -- line 671 | captures: v144, TweenService, v6, LocalPlayer
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "SakuraExplosionFlash"
        ScreenGui.IgnoreGuiInset = true
        ScreenGui.DisplayOrder = 1000
        ScreenGui.ResetOnSpawn = false
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.BackgroundColor3 = v6
        Frame.BorderSizePixel = 0
        Frame.Parent = ScreenGui
        ScreenGui.Parent = LocalPlayer.PlayerGui
        v144:Add(ScreenGui)
        local v188 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(Frame, v188, { BackgroundTransparency = 1 }):Play()
        task.delay(0.6, function() -- line 686 | captures: ScreenGui
            ScreenGui:Destroy()
        end)
    end

    local v189 = { Model = v145 }

    function v189.Explode() -- line 692 | captures: v154, v155, v145, v151, Highlight, sweep, linear, FieldOfView, flashScreen, TweenService, v6, CurrentCamera
        if v155 or not v154 then
            return
        end
        v155 = true
        flashScreen()
        local v190 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v191 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(Highlight, v191, {
            FillTransparency = 1,
            OutlineTransparency = 1,
            FillColor = v6,
            OutlineColor = v6
        }):Play()
        local v192 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v193 = TweenService:Create(CurrentCamera, v192, { FieldOfView = FieldOfView + 14 })
        v193.Completed:Once(function() -- line 703 | captures: FieldOfView, TweenService, CurrentCamera
            local v194 = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            TweenService:Create(CurrentCamera, v194, { FieldOfView = FieldOfView }):Play()
        end)
        v193:Play()
        task.spawn(sweep, 0.25, linear, function(v195) -- line 708 | captures: v190, v151, TweenService
            TweenService:Create(v195, v190, {
                Transparency = 1,
                Size = v151[v195] * 1.8
            }):Play()
        end)
        task.delay(0.55, function() -- line 711 | captures: v145
            v145:Destroy()
        end)
    end

    return v189
end

local function setEmitters(v196, v197) -- line 717
    local v198 = 0
    for v199, v200 in ipairs(v196:GetDescendants()) do
        if v200:IsA("ParticleEmitter") then
            v200.Enabled = v197
            local Max = v200.Lifetime.Max
            v198 = math.max(v198, Max)
        end
    end
    return v198
end

local function playLeafRing(v201) -- line 727 | captures: Workspace, IncubatorAnchor, LeafRing, setEmitters
    local RootOffset = LeafRing:GetAttribute("RootOffset")
    local v202 = typeof(RootOffset) == "CFrame"
    local v203 = ("%* needs a RootOffset CFrame attribute"):format(LeafRing.Name)
    assert(v202, v203)
    local v204 = IncubatorAnchor.CFrame * RootOffset
    local v205 = LeafRing:Clone()
    v205:PivotTo(v204)
    v205.Parent = Workspace
    v201:Add(v205)
    setEmitters(v205, true)
    return function() -- line 739 | captures: v205, setEmitters
        local v206 = setEmitters(v205, false)
        task.delay(v206, function() -- line 741 | captures: v205
            v205:Destroy()
        end)
    end
end

local function setTrails(v207, v208) -- line 746
    for v209, v210 in ipairs(v207:GetDescendants()) do
        if v210:IsA("Trail") then
            v210.Enabled = v208
        end
    end
end

local function playCutsceneSound(v211) -- line 753 | captures: SoundService, Cutscene_2
    local v212 = Cutscene_2:Clone()
    v212.Parent = SoundService
    v211:Add(v212)
    v212:Play()
end

local function runUnlockCutscene(v213) -- line 759 | captures: ContentProvider, RunService, SoundService, Workspace, CurrentCamera, IncubatorAnchor, CameraRig, CraneRig, Cutscene_2, CameraAnimation, CraneAnimation, PlayerAnimation, buildTree, getAnimator, cloneCharacterRig, hideCharacter, playBloom, playLeafCover, playLeafRing, setTrails
    buildTree(false)
    local RootOffset = CameraRig:GetAttribute("RootOffset")
    local v214 = typeof(RootOffset) == "CFrame"
    local v215 = ("%* needs a RootOffset CFrame attribute"):format(CameraRig.Name)
    assert(v214, v215)
    local v216 = IncubatorAnchor.CFrame * RootOffset
    local v217 = CameraRig:Clone()
    v217:PivotTo(v216)
    v217.Parent = Workspace
    local RootOffset_2 = CraneRig:GetAttribute("RootOffset")
    local v218 = typeof(RootOffset_2) == "CFrame"
    local v219 = ("%* needs a RootOffset CFrame attribute"):format(CraneRig.Name)
    assert(v218, v219)
    local v220 = IncubatorAnchor.CFrame * RootOffset_2
    local v221 = CraneRig:Clone()
    v221:PivotTo(v220)
    v221.Parent = Workspace
    v213:Add(v217)
    v213:Add(v221)
    local Torso = v217:FindFirstChild("Torso")
    local v222 = Torso and Torso:IsA("BasePart")
    assert(v222, "CameraRig needs a Torso part")
    local v223 = cloneCharacterRig()
    v213:Add(v223)
    hideCharacter(v213)
    ContentProvider:PreloadAsync({ CameraAnimation, CraneAnimation, PlayerAnimation })
    local v224 = getAnimator(v217):LoadAnimation(CameraAnimation)
    v224.Priority = Enum.AnimationPriority.Action4
    v224.Looped = false
    v224:Play(0)
    local v225 = getAnimator(v221):LoadAnimation(CraneAnimation)
    v225.Priority = Enum.AnimationPriority.Action4
    v225.Looped = false
    v225:Play(0)
    local v226 = {}
    local v227 = getAnimator(v223):LoadAnimation(PlayerAnimation)
    v227.Priority = Enum.AnimationPriority.Action4
    v227.Looped = false
    v227:Play(0)
    v226[1] = v224
    v226[2] = v225
    v226[3] = v227
    v213:Add(function() -- line 812 | captures: v226
        for v228, v229 in v226 do
            v229:Stop(0)
            v229:Destroy()
        end
    end)
    local v230, v231
    local v232 = false
    local Start = v224:GetMarkerReachedSignal("Start")
    v213:Add(Start:Connect(function() -- line 825 | captures: v230, v213, playLeafCover
        v230 = v230 or playLeafCover(v213)
    end))
    local Explosion = v224:GetMarkerReachedSignal("Explosion")
    v213:Add(Explosion:Connect(function() -- line 832 | captures: v230, v231, v232, v213, playBloom
        if v232 then
            return
        end
        v232 = true
        local v233 = v230
        if v233 then
            v233.Explode()
        end
        local v234 = v231
        if v234 then
            v234()
        end
        task.spawn(playBloom, v213)
    end))
    local Spell = v225:GetMarkerReachedSignal("Spell")
    v213:Add(Spell:Connect(function() -- line 848 | captures: v231, v213, playLeafRing
        v231 = v231 or playLeafRing(v213)
    end))
    setTrails(v221, true)
    local v235 = Cutscene_2:Clone()
    v235.Parent = SoundService
    v213:Add(v235)
    v235:Play()
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    v213:Add(function() -- line 860 | captures: RunService, CurrentCamera
        RunService:UnbindFromRenderStep("SakuraUnlockCamera")
        CurrentCamera.CameraType = Enum.CameraType.Custom
    end)
    local v236 = Enum.RenderPriority.Camera.Value + 1
    RunService:BindToRenderStep("SakuraUnlockCamera", v236, function() -- line 864 | captures: Torso, CurrentCamera
        CurrentCamera.CFrame = Torso.CFrame
    end)
    task.wait(25)
    if v232 then
        return
    end
    local v237 = v230
    if v237 then
        v237.Explode()
    end
    local v238 = v231
    if v238 then
        v238()
    end
    task.spawn(playBloom, v213)
end

local function playUnlockCutscene() -- line 880 | captures: v8, v12, v13, HiddenUIHandler, Tabs, Trove, runUnlockCutscene
    if v12 then
        return
    end
    v12 = true
    local v239 = v8
    if v239 then
        v239.Enabled = not v12
    end
    Tabs.Dismiss(true)
    local v240 = Trove.new()
    local v241, v242 = pcall(runUnlockCutscene, v240)
    v240:Clean()
    HiddenUIHandler.Acquire()()
    v12 = false
    v13()
    if not v241 then
        error(v242)
    end
end

local function runMutateReveal(v243, v244) -- line 901 | captures: RunService, TweenService, Workspace, Directory, EggRecords, EggRenderer, Mutations, SakuraFX, v1, LocalPlayer, CurrentCamera, IncubatorAnchor, IncubatorBloomed
    local v245 = EggRecords.Decode(v244.Egg)
    local v246 = Directory[v245.AssetCategory]
    local v247 = v246 ~= nil
    local v248 = ("Missing asset config %*"):format(v245.AssetCategory)
    assert(v247, v248)
    local v249 = Mutations.Get(v244.Mutation)
    local v250 = if v249 then v249.Tint else v1
    local CFrame = IncubatorAnchor.CFrame
    local v251 = CFrame * CFrame.new(0, 0, -IncubatorBloomed:GetAttribute("Radius") - 4)
    local v252 = EggRenderer.RenderVisual({
        ModelName = "SakuraRevealEgg",
        OwnerUserId = LocalPlayer.UserId,
        UID = v244.Uid,
        Record = v245
    }, Workspace)
    local Model = v252.Model
    v243:Add(Model)
    for v253, v254 in ipairs(Model:GetDescendants()) do
        if v254:IsA("BasePart") then
            v254.Anchored = true
            v254.CanCollide = false
            v254.CanQuery = false
        end
    end
    local v255 = v252.Config and EggRenderer.GetVisibleBounds(v245).Y or 4
    local new = CFrame.new
    local Position = v251.Position
    local v256 = v255 / 2 + 1.5
    local v257 = new(Position + Vector3.new(0, v256, 0))
    Model:PivotTo(v257)
    local v258 = Model:GetScale()
    local v259 = v258 * 0.05
    Model:ScaleTo((math.max(0.05, v259)))
    local PointLight = Instance.new("PointLight")
    PointLight.Color = v250
    PointLight.Brightness = 0
    PointLight.Range = 30
    PointLight.Parent = Model.PrimaryPart or Model:FindFirstChildWhichIsA("BasePart")
    v243:Add(PointLight)
    local v260 = v255 * 2.2
    local v261 = math.max(v260, 9)
    local LookVector = CFrame.LookVector
    local v262 = v257.Position + LookVector * v261 * 1.6
    local v263 = v255 * 0.9
    local v264 = v262 + Vector3.new(0, v263, 0)
    local v265 = CFrame.lookAt(v264, v257.Position)
    local v266 = v257.Position + (LookVector * 0.85 + CFrame.RightVector * 0.5).Unit * v261
    local v267 = v255 * 0.4
    local v268 = v266 + Vector3.new(0, v267, 0)
    local v269 = CFrame.lookAt(v268, v257.Position)
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    v243:Add(function() -- line 954 | captures: RunService, CurrentCamera
        RunService:UnbindFromRenderStep("SakuraMutateReveal")
        CurrentCamera.CameraType = Enum.CameraType.Custom
    end)
    local v270 = 0
    local v271 = Enum.RenderPriority.Camera.Value + 1
    RunService:BindToRenderStep("SakuraMutateReveal", v271, function(v272) -- line 959 | captures: v270, CFrame, Model, v257, v258, v265, v269, TweenService, CurrentCamera
        v270 += v272
        local v273 = v270 / 3.2
        local v274 = math.clamp(v273, 0, 1)
        local v275 = TweenService:GetValue(v274, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        CurrentCamera.CFrame = v265:Lerp(v269, v275)
        local v276 = v270 / 0.9
        local v277 = math.clamp(v276, 0, 1)
        local v278 = TweenService:GetValue(v277, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local v279 = v258 * v278
        Model:ScaleTo((math.max(0.05, v279)))
        Model:PivotTo(v257 * CFrame.Angles(0, v270 * 1.2, 0))
    end)
    SakuraFX.EmitBurst("Bloom", v257.Position, 80, v255 * 2)
    SakuraFX.PlayCue("Bloom", LocalPlayer, 0.8, 1.15)
    local v280 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(PointLight, v280, { Brightness = 5 }):Play()
    task.wait(0.9)
    SakuraFX.PlayCue("Mutate", LocalPlayer, 1)
    SakuraFX.EmitBurst("Pickup", v257.Position, 40, v255 * 1.5)
    task.wait(2.3000000000000003)
    return v246.Egg.DisplayName, v250, v246.Egg.Icon
end

local function playMutateReveal(v281) -- line 979 | captures: v8, v12, v13, HiddenUIHandler, Message, Mutations, Tabs, Trove, runMutateReveal
    if v12 then
        return
    end
    v12 = true
    local v282 = v8
    if v282 then
        v282.Enabled = not v12
    end
    Tabs.Dismiss(true)
    local v283 = Trove.new()
    local v284, v285, v286, v287 = pcall(runMutateReveal, v283, v281)
    v283:Clean()
    HiddenUIHandler.Acquire()()
    v12 = false
    v13()
    if not v284 then
        error(v285)
    end
    local v288 = ("Your %* is now <font color=\"#%*\">%*</font>!"):format(v285, v286:ToHex(), (Mutations.LabelOf(v281.Mutation)))
    Message.Prompt(v288, {
        dontRestore = true,
        icon = v287
    })
end

function v13() -- line 1003 | captures: v9, v11, v12, Save, Build, v7, renderBillboard, buildTree
    if v12 then
        return
    end
    local v289, v290
    if Build:GetAttribute("DragonEventMap") == true then
        v290 = true
    elseif Build:GetAttribute("CherryBlossomZoneRevealed") == true then
        local v291 = Save.Get()
        if v291 == nil then
            v289 = false
        else
            v289 = v291.Sakura.Unlocked
        end
        v290 = false
    else
        v290 = true
    end
    if not v290 then
        if v11 ~= v289 then
            buildTree(v289)
        end
        renderBillboard()
    else
        v7:Clean()
        v9 = nil
        v11 = nil
    end
end

Remotes.Bloomery.CutsceneOpened.OnClientEvent:Connect(function() -- line 1021 | captures: playUnlockCutscene
    task.spawn(playUnlockCutscene)
end)
SakuraSignals.Reveal:Connect(function(v292) -- line 1024 | captures: Sakura_2, playMutateReveal
    local v293 = Sakura_2.MutateResult(v292)
    assert(v293, "Sakura mutate reveal needs a valid result")
    task.spawn(playMutateReveal, v292)
end)
Save.WatchFields("Sakura", v13)
Build:GetAttributeChangedSignal("DragonEventMap"):Connect(v13)
Build:GetAttributeChangedSignal("CherryBlossomZoneRevealed"):Connect(v13)
Save.ProfileReady:Connect(function(v294) -- line 1034 | captures: v13, LocalPlayer
    if v294 == LocalPlayer then
        v13()
    end
end)

if Save.IsLocalDataLoaded() then
    v13()
end
task.spawn(function() -- line 1042 | captures: v8, Save, renderBillboard
    while true do
        task.wait(1)
        if not v8 then
            continue
        end
        local v295 = Save.Get()
        if v295 ~= nil and v295.Sakura.Unlocked then
            renderBillboard()
        end
    end
end)
task.spawn(function() -- line 1055 | captures: ContentProvider, CameraAnimation, CraneAnimation, PlayerAnimation
    ContentProvider:PreloadAsync({ CameraAnimation, CraneAnimation, PlayerAnimation })
end)
