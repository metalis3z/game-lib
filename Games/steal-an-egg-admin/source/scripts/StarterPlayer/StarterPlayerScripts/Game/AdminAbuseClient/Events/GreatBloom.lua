-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local GUI = require(ReplicatedStorage.Client.GUI)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local NotificationInstance = require(ReplicatedStorage.Client.Notifications.NotificationInstance)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local SakuraBloomVisibility = require(ReplicatedStorage.Client.SakuraBloomVisibility)
local SakuraFX = require(ReplicatedStorage.Client.SakuraFX)
local SakuraSignals = require(ReplicatedStorage.Client.SakuraSignals)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)

if GameFlags.GreatBloomEnabled:Get() then
    local v1 = Color3.fromRGB(255, 120, 200)
    local v2 = Color3.fromRGB(120, 20, 70)
    local v3 = Color3.fromRGB(255, 170, 220)
    local v4 = Color3.fromRGB(120, 255, 140)
    local v5 = Color3.fromRGB(255, 90, 110)
    local LocalPlayer = Players.LocalPlayer
    local CurrentCamera = Workspace.CurrentCamera
    local Sakura_2 = ReplicatedStorage.Assets.Models.Sakura
    local BloomWaypoint = Sakura_2.BloomWaypoint
    local BillboardGui = BloomWaypoint:IsA("BillboardGui")
    assert(BillboardGui, "Sakura.BloomWaypoint must be a BillboardGui")
    local Sparkles = ReplicatedStorage.Assets.VFX.Sakura.Hit:FindFirstChild("Sparkles")
    local v6 = Sparkles and Sparkles:IsA("ParticleEmitter")
    assert(v6, "VFX.Sakura.Hit.Sparkles must be a ParticleEmitter")
    local Crystal = Sakura_2.Crystal
    local Model = Crystal:IsA("Model") and Crystal.PrimaryPart
    assert(Model, "Sakura.Crystal needs a PrimaryPart")
    local Name = Crystal.PrimaryPart.Name
    local Bounds = Workspace:WaitForChild("__OBJECTS"):WaitForChild("Areas"):WaitForChild("CherryBlossom"):WaitForChild("Bounds")
    local BasePart = Bounds:IsA("BasePart")
    assert(BasePart, "CherryBlossom.Bounds must be a BasePart")
    local v7 = GUI.SakuraEventTutorialFrame()
    local SakuraEventTutorialFrame = v7.SakuraEventTutorialFrame
    local Frame = SakuraEventTutorialFrame:IsA("Frame")
    assert(Frame, "SakuraEventTutorialFrame.SakuraEventTutorialFrame must be a Frame")
    local Ok = SakuraEventTutorialFrame.Ok
    local ImageButton = Ok:IsA("ImageButton")
    assert(ImageButton, "SakuraEventTutorialFrame.Ok must be an ImageButton")
    local v8 = GUI.GreatBloomBanner()
    local Banner = v8:FindFirstChild("Banner")
    local v9 = Banner and Banner:IsA("Frame")
    assert(v9, "GreatBloomBanner needs a Banner Frame")
    local Position = Banner.Position
    local v10 = 0
    local v11 = GUI.SakuraCrystalCounter()
    local GuiObject = v11:FindFirstChildWhichIsA("GuiObject")
    assert(GuiObject, "SakuraCrystalCounter needs a root Frame")
    local v12 = v11:FindFirstChild("Count", true)
    local v13 = v12 and v12:IsA("TextLabel")
    assert(v13, "SakuraCrystalCounter needs a TextLabel named Count")
    local v14 = v11:FindFirstChild("Gain", true)
    local UIScale = GuiObject:FindFirstChildOfClass("UIScale")
    local UIScale_2 = UIScale
    if not UIScale then
        UIScale = Instance.new("UIScale")
        UIScale_2 = UIScale
    end
    UIScale.Parent = GuiObject
    local Position_2 = GuiObject.Position
    local v15 = false
    local v16, v17
    if v14 then
        v17 = v14:FindFirstChildOfClass("UIStroke")
        v16 = v14.Position
    else
        v16 = UDim2.new()
    end
    local v18 = 0
    local v19 = false
    local v20 = {}
    for v21, v22 in ipairs(GuiObject:GetDescendants()) do
        if v14 then
            if v22 == v14 or v22:IsDescendantOf(v14) then
            end
        else
            local v23
            if v22:IsA("TextLabel") then
                v23 = {
                    Property = "TextTransparency",
                    Instance = v22,
                    Value = v22.TextTransparency
                }
                table.insert(v20, v23)
                v23 = {
                    Property = "TextStrokeTransparency",
                    Instance = v22,
                    Value = v22.TextStrokeTransparency
                }
                table.insert(v20, v23)
            elseif v22:IsA("ImageLabel") then
                v23 = {
                    Property = "ImageTransparency",
                    Instance = v22,
                    Value = v22.ImageTransparency
                }
                table.insert(v20, v23)
            elseif not v22:IsA("ImageButton") and v22:IsA("UIStroke") then
                v23 = {
                    Property = "Transparency",
                    Instance = v22,
                    Value = v22.Transparency
                }
                table.insert(v20, v23)
            end
            if v22:IsA("GuiObject") and v22.BackgroundTransparency < 1 then
                v23 = {
                    Property = "BackgroundTransparency",
                    Instance = v22,
                    Value = v22.BackgroundTransparency
                }
                table.insert(v20, v23)
            end
        end
    end
    if GuiObject.BackgroundTransparency < 1 then
        local v24 = {
            Property = "BackgroundTransparency",
            Instance = GuiObject,
            Value = GuiObject.BackgroundTransparency
        }
        table.insert(v20, v24)
    end
    local v25 = 0
    local SakuraCrystals
    local v26 = 0
    local v27 = Trove.new()
    local v28 = CameraShaker.new(Enum.RenderPriority.Camera.Value + 2, function(v29) -- line 138 | captures: CurrentCamera
        CurrentCamera.CFrame *= v29
    end)
    local v30 = {}
    local v31 = {}
    local v32 = {}
    local v33 = {}
    local v34 = {}
    local v35 = {}
    local v36 = {}
    local v37 = {}
    local v38 = {}
    local v39 = {}
    local v40 = {}
    local v41 = {}
    local v42 = {}
    local v43 = 0
    local v44 = false
    local v45 = false
    local v46 = false
    local v47, v48, Part
    local v49 = false
    local v50 = false
    local v51 = false
    local v52 = {}
    local v53 = {}

    local function isUnlocked() -- line 166 | captures: SakuraBloomPolicy, Save
        local v54 = Save.IsLocalDataLoaded()
        local v55
        if v54 then
            v55 = Save.Get()
        end
        return SakuraBloomPolicy.HasBloomUnlocked(v54, v55)
    end

    local function shouldPresent() -- line 176 | captures: v44, SakuraBloomPolicy, Save
        local v56 = Save.IsLocalDataLoaded()
        local v57
        if v56 then
            v57 = Save.Get()
        end
        return SakuraBloomPolicy.CanShowBloom(v44, v56, v57)
    end

    local function setBloomInstanceHidden(v58, v59) -- line 186 | captures: SakuraBloomVisibility, v52
        local v60 = v52[v58]
        if v60 then
            v60:Clean()
            v52[v58] = nil
        end
        if v59 then
            v52[v58] = SakuraBloomVisibility.Conceal(v58)
        end
    end

    local function setWorldVFXEnabled(v61) -- line 197 | captures: CollectionService
        for v62, v63 in CollectionService:GetTagged("GreatBloomVFX") do
            for v64, v65 in v63:GetDescendants() do
                if v65:IsA("Beam") then
                    v65.Enabled = v61
                elseif v65:IsA("ParticleEmitter") then
                end
            end
        end
    end

    local function refreshReplicatedVisibility() -- line 208 | captures: v44, CollectionService, Sakura, SakuraBloomPolicy, SakuraBloomVisibility, Save, v52, setWorldVFXEnabled
        local v66 = Save.IsLocalDataLoaded()
        local v67
        if v66 then
            v67 = Save.Get()
        end
        local v68 = SakuraBloomPolicy.HasBloomUnlocked(v66, v67)
        for v69, v70 in CollectionService:GetTagged(Sakura.TreeTag) do
            local v71 = v52[v70]
            if v71 then
                v71:Clean()
                v52[v70] = nil
            end
            if not v68 then
                v52[v70] = SakuraBloomVisibility.Conceal(v70)
            end
        end
        for v72, v73 in CollectionService:GetTagged(Sakura.CrystalTag) do
            local v74 = v52[v73]
            if v74 then
                v74:Clean()
                v52[v73] = nil
            end
            if not v68 then
                v52[v73] = SakuraBloomVisibility.Conceal(v73)
            end
        end
        setWorldVFXEnabled(v44 and v68)
    end

    local function distanceFromCharacter(v75) -- line 239 | captures: Player, LocalPlayer
        local v76 = Player.Optional.PrimaryPart(LocalPlayer)
        if v76 == nil then
            return (1/0)
        end
        return (v76.Position - v75).Magnitude
    end

    local function shakeIfNear(v77, v78, v79, v80) -- line 246 | captures: Player, LocalPlayer, v28
        local v81 = Player.Optional.PrimaryPart(LocalPlayer)
        local v82 = if v81 == nil then (1/0) else (v81.Position - v77).Magnitude
        if v82 <= v78 then
            v28:ShakeOnce(v79, v80, 0.1, 0.6)
        end
    end

    local function notifyTop(v83, v84) -- line 258 | captures: Message, v1, v2
        Message.Top({
            Message = v83,
            Color = v1,
            StrokeColor = v2,
            Time = v84
        })
    end

    local function showBanner() -- line 261 | captures: v10, TweenService, NotificationInstance, v8, Banner, Position
        v10 += 1
        local v85 = v10
        local v86 = NotificationInstance.ReserveTop()
        task.spawn(function() -- line 265 | captures: v85, v86, v10, TweenService, NotificationInstance, v8, Banner, Position
            while NotificationInstance.IsTopContended() and v10 == v85 do
                task.wait(0.1)
            end
            if v10 == v85 then
                local v87 = Position - UDim2.fromScale(0, Position.Y.Scale + Banner.Size.Y.Scale)
                Banner.Position = v87
                v8.Enabled = true
                local v88 = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                TweenService:Create(Banner, v88, { Position = Position }):Play()
                task.wait(7)
                if v10 == v85 then
                    local v89 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    local v90 = TweenService:Create(Banner, v89, { Position = v87 })
                    v90.Completed:Once(function() -- line 288 | captures: v85, v86, v10, v8
                        if v10 == v85 then
                            v8.Enabled = false
                        end
                        v86()
                    end)
                    v90:Play()
                else
                    v86()
                end
            else
                v86()
            end
        end)
    end

    local function showCrystalPopup(v91, v92) -- line 297 | captures: Debris, TweenService, Workspace, Simple, v1
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Transparency = 1
        Part.Size = Vector3.new(1, 1, 1)
        Part.Position = v92 + Vector3.new(0, 4, 0)
        Part.Parent = Workspace
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Size = UDim2.fromOffset(140, 40)
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Parent = Part
        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.fromScale(1, 1)
        TextLabel.Font = Enum.Font.GothamBlack
        TextLabel.TextScaled = true
        TextLabel.TextColor3 = v1
        TextLabel.TextStrokeTransparency = 0.2
        TextLabel.Text = ("+%* Crystals"):format((Simple.FormatCompact(v91)))
        TextLabel.Parent = BillboardGui
        local v93 = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(Part, v93, { Position = Part.Position + Vector3.new(0, 6, 0) }):Play()
        local v94 = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        TweenService:Create(TextLabel, v94, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play()
        Debris:AddItem(Part, 1.2000000000000002)
    end

    local function setCounterShown(v95, v96) -- line 326 | captures: UIScale_2, v15, TweenService, v11, GuiObject, Position_2, v20
        local v97 = if v95 then Enum.EasingDirection.Out else Enum.EasingDirection.In
        local v98 = TweenInfo.new(v96, Enum.EasingStyle.Quad, v97)
        for v99, v100 in v20 do
            local v101 = {}
            local v102 = if v95 then v100.Value else 1
            v101[v100.Property] = v102
            TweenService:Create(v100.Instance, v98, v101):Play()
        end
        if v95 == v15 then
            return
        end
        v15 = v95
        local v103 = UDim2.fromScale(0, -GuiObject.Size.Y.Scale * 0.6)
        if v95 then
            v11.Enabled = true
            GuiObject.Position = Position_2 + v103
            UIScale_2.Scale = 0.8
            local v104 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            TweenService:Create(GuiObject, v104, { Position = Position_2 }):Play()
            local v105 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            TweenService:Create(UIScale_2, v105, { Scale = 1 }):Play()
        else
            local v106 = TweenInfo.new(v96, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(GuiObject, v106, { Position = Position_2 + v103 }):Play()
            local v107 = TweenInfo.new(v96, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(UIScale_2, v107, { Scale = 0.85 }):Play()
            task.delay(v96, function() -- line 358 | captures: v15, v11
                if not v15 then
                    v11.Enabled = false
                end
            end)
        end
    end

    local function hideCounter() -- line 373 | captures: v19, v26, setCounterShown
        setCounterShown(false, 0.5)
        v26 = 0
        v19 = false
    end

    local function animateGain(v108) -- line 378 | captures: v16, v17, v18, v19, TweenService, Simple, v4, v5, v14
        local v109, v110, v111
        if v14 == nil then
            v111 = true
        elseif v14:IsA("TextLabel") then
            v18 += 1
            v109 = v18
            v110 = v108 > 0
            v111 = false
        else
            v111 = true
        end
        if v111 then
            return
        end
        local v112 = if v110 then "+" else "-"
        v14.Text = ("%*%*"):format(v112, (Simple.FormatCompact((math.abs(v108)))))
        local v113 = if v110 then v4 else v5
        v14.TextColor3 = v113
        local v114 = v14.Size.Y.Scale * 0.9
        local v115, v116
        if v110 then
            v115 = -1
            v116 = -1
        else
            v115 = 1
            v116 = 1
        end
        local v117 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        if v19 then
            v14.Position = v16 + UDim2.fromScale(0, -v116 * v114 * 0.2)
            TweenService:Create(v14, v117, {
                TextTransparency = 0,
                Position = v16
            }):Play()
        else
            v14.Position = v16 + UDim2.fromScale(0, -v116 * v114 * 0.5)
            v14.TextTransparency = 1
            if v17 then
                v17.Transparency = 1
            end
            TweenService:Create(v14, v117, {
                TextTransparency = 0,
                Position = v16
            }):Play()
            if v17 then
                TweenService:Create(v17, v117, { Transparency = 0 }):Play()
            end
        end
        v19 = true
        local delay = task.delay
        local v118 = v109
        delay(1.8000000000000003, function() -- line 421 | captures: v115, v114, v118, v16, v17, v18, v19, TweenService, v14
            if v18 ~= v118 then
                return
            end
            v19 = false
            local v119 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(v14, v119, {
                TextTransparency = 1,
                Position = v16 + UDim2.fromScale(0, v115 * v114)
            }):Play()
            if v17 then
                TweenService:Create(v17, v119, { Transparency = 1 }):Play()
            end
        end)
    end

    local function popCounter() -- line 433 | captures: UIScale_2, v15, v19, v25, SakuraCrystals, v26, TweenService, Workspace, Save, Simple, v12, setCounterShown, animateGain
        local v120 = Save.Get()
        if v120 == nil then
            return
        end
        local SakuraCrystals_2 = v120.SakuraCrystals
        local SakuraCrystals_3 = SakuraCrystals
        SakuraCrystals = SakuraCrystals_2
        if SakuraCrystals_3 == nil or SakuraCrystals_2 == SakuraCrystals_3 then
            return
        end
        local v121 = SakuraCrystals_2 - SakuraCrystals_3
        local v122 = Workspace:GetServerTimeNow()
        if v25 < v122 then
            v26 = 0
        elseif v26 > 0 then
            if not (v121 > 0) then
                v26 = 0
            end
        elseif v121 > 0 then
            v26 = 0
        end
        v26 += v121
        v12.Text = Simple.FormatCompact(SakuraCrystals_2)
        animateGain(v26)
        v25 = Workspace:GetServerTimeNow() + 2.2
        setCounterShown(true, 0.15)
        if v15 then
            UIScale_2.Scale = 1.12
            local v123 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            TweenService:Create(UIScale_2, v123, { Scale = 1 }):Play()
        end
        task.delay(2.2, function() -- line 465 | captures: v19, v25, v26, Workspace, setCounterShown
            local v124 = Workspace:GetServerTimeNow()
            if not (v25 - 0.05 <= v124) then
                return
            end
            setCounterShown(false, 0.5)
            v26 = 0
            v19 = false
        end)
    end

    local function decorateTree(v125) -- line 474 | captures: v3, Sparkles, v34
        local PrimaryPart = v125.PrimaryPart
        local v126 = ("%* needs a PrimaryPart"):format(v125.Name)
        assert(PrimaryPart, v126)
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "BloomOutline"
        Highlight.FillColor = Color3.new(0, 0, 0)
        Highlight.FillTransparency = 1
        Highlight.OutlineColor = v3
        Highlight.OutlineTransparency = 0
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.Enabled = false
        Highlight.Parent = v125
        v34[v125] = Highlight
        local v127 = Sparkles:Clone()
        v127.Name = "BloomSparkles"
        v127.Rate = 14
        v127.Enabled = true
        v127.Parent = PrimaryPart
    end

    local function damageFraction(v128) -- line 493
        local Hits = v128:GetAttribute("Hits")
        local HitsRequired = v128:GetAttribute("HitsRequired")
        if typeof(Hits) == "number" and typeof(HitsRequired) == "number" and not (HitsRequired <= 1) then
            local v129 = Hits / HitsRequired
            return (math.clamp(v129, 0, 1))
        end
        return 0
    end

    local function renderDamage(v130) -- line 501 | captures: TweenService, v34
        local v131 = v34[v130]
        if v131 == nil then
            return
        end
        local v132 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v133 = {}
        local Hits = v130:GetAttribute("Hits")
        local HitsRequired = v130:GetAttribute("HitsRequired")
        local v134
        if typeof(Hits) == "number" and typeof(HitsRequired) == "number" and HitsRequired > 1 then
            local v135 = Hits / HitsRequired
            v134 = math.clamp(v135, 0, 1)
        else
            v134 = 0
        end
        v133.FillTransparency = 1 - v134 * 0.85
        TweenService:Create(v131, v132, v133):Play()
    end

    local function shakeTree(v136) -- line 523 | captures: v31, v32, v33
        local v137 = v31[v136]
        if v137 == nil or v33[v136] then
            return
        end
        local v138 = (v32[v136] or 0) + 1
        v32[v136] = v138
        local Radius = v136:GetAttribute("Radius")
        if typeof(Radius) ~= "number" then
            Radius = 10
        end
        local v139 = Radius / 10
        local v140 = math.clamp(v139, 0.8, 1.6) * 0.06981317007977318
        local v141 = math.random() * 100
        task.spawn(function() -- line 540 | captures: v136, v137, v138, v140, v141, v32
            local v142 = 0
            while v142 < 0.7 do
                if v136.Parent and v32[v136] == v138 then
                    v142 += task.wait()
                    local v143 = (1 - v142 / 0.7) ^ 2
                    local v144 = v142 * 9
                    local v145 = math.noise(v141, v144) * 2
                    local v146 = math.noise(v144, v141) * 2
                    v136:PivotTo(v137 * CFrame.Angles(v145 * v140 * v143, 0, v146 * v140 * v143))
                    continue
                end
                break
            end
            if v136.Parent and v32[v136] == v138 then
                v136:PivotTo(v137)
            end
        end)
    end

    local function clampTreeHeight(v147) -- line 566
        local Y = v147:GetExtentsSize().Y
        if Y > 30 then
            v147:ScaleTo(v147:GetScale() * (30 / Y))
        end
    end

    local function growTree(v148) -- line 572 | captures: TweenService, v33, decorateTree, renderDamage
        if not v148 or v148:GetAttribute("TreeLoaded") then
            warn(v148, "already loaded")
        else
            v148:SetAttribute("TreeLoaded", true)
            v33[v148] = true
            local v149 = v148:GetScale()
            task.spawn(function() -- line 580 | captures: v148, v149, TweenService, v33, decorateTree, renderDamage
                v148:ScaleTo(v149 * 0.05)
                local v150 = 0
                while true do
                    local v151
                    if v150 < 0.55 and v148.Parent then
                        v151 = v150 + task.wait()
                        local v152 = v151 / 0.55
                        local v153 = math.clamp(v152, 0, 1)
                        local v154 = TweenService:GetValue(v153, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                        v148:ScaleTo(v149 * math.max(0.05, v154))
                        local Y = v148:GetExtentsSize().Y
                        if Y > 30 then
                            v148:ScaleTo(v148:GetScale() * (30 / Y))
                        end
                    else
                        break
                    end
                    v150 = v151
                end
                if v148.Parent then
                    v148:ScaleTo(v149)
                    local Y = v148:GetExtentsSize().Y
                    if Y > 30 then
                        v148:ScaleTo(v148:GetScale() * (30 / Y))
                    end
                    decorateTree(v148)
                    renderDamage(v148)
                end
                v33[v148] = nil
            end)
        end
    end

    local function fallTree(v155, v156) -- line 611 | captures: TweenService, Workspace, Sakura
        local v157 = v155:Clone()
        v157.Name = "SakuraTreeFalling"
        v157:RemoveTag(Sakura.TreeTag)
        for v158, v159 in ipairs(v157:GetTags()) do
            v157:RemoveTag(v159)
        end
        for v160, v161 in ipairs(v157:GetDescendants()) do
            if v161:IsA("BasePart") then
                v161.Anchored = true
                v161.CanCollide = false
                v161.CanQuery = false
                v161.CanTouch = false
            elseif v161:IsA("ProximityPrompt") then
                v161:Destroy()
            elseif v161:IsA("BillboardGui") or v161:IsA("ParticleEmitter") or v161:IsA("Highlight") then
            end
        end
        v157.Parent = Workspace
        local v162 = v157:GetScale()
        local v163 = math.random() * 3.141592653589793 * 2
        local v164 = CFrame.Angles(0, v163, 0)
        task.spawn(function() -- line 634 | captures: v156, v157, v162, v164, TweenService
            local v165 = 0
            while v165 < 0.6 do
                v165 += task.wait()
                local v166 = v165 / 0.6
                local v167 = math.clamp(v166, 0, 1)
                local v168 = TweenService:GetValue(v167, Enum.EasingStyle.Quad, Enum.EasingDirection.In) * 0.6108652381980153
                local v169 = v156 * v164 * CFrame.Angles(v168, 0, 0)
                v157:PivotTo(v169 * v164:Inverse())
                local v170 = 1 - v167 * v167
                v157:ScaleTo(v162 * math.max(0.05, v170))
            end
            v157:Destroy()
        end)
    end

    local function onTreeHit(v171) -- line 648 | captures: Player, SakuraFX, LocalPlayer, v28, renderDamage, shakeTree
        shakeTree(v171)
        renderDamage(v171)
        local Position = v171:GetPivot().Position
        local Height = v171:GetAttribute("Height")
        if typeof(Height) ~= "number" then
            Height = 20
        end
        local v172 = Height * 0.6
        local v173 = Position + Vector3.new(0, v172, 0)
        SakuraFX.EmitBurst("Hit", v173, 30, 8)
        SakuraFX.PlayCue("TreeHit", Position, 0.9, 0.9 + math.random() * 0.2)
        local v174 = Player.Optional.PrimaryPart(LocalPlayer)
        local v175 = if v174 == nil then (1/0) else (v174.Position - Position).Magnitude
        if v175 <= 30 then
            v28:ShakeOnce(0.8, 6, 0.1, 0.6)
        end
    end

    local function updateHighlights() -- line 672 | captures: Player, LocalPlayer, v34
        local v176 = Player.Optional.PrimaryPart(LocalPlayer)
        local v177 = {}
        local v178
        for v179, v180 in v34 do
            if v179.Parent ~= nil then
                local v181 = if v176 then (v176.Position - v179:GetPivot().Position).Magnitude else (1/0)
                local Hits = v179:GetAttribute("Hits")
                local HitsRequired = v179:GetAttribute("HitsRequired")
                if typeof(Hits) == "number" then
                    if typeof(HitsRequired) == "number" and HitsRequired > 1 then
                        local v182 = Hits / HitsRequired
                        v178 = math.clamp(v182, 0, 1)
                    end
                else
                    v178 = 0
                end
                if v178 > 0 then
                    v181 = 0
                end
                if v181 > 160 then
                    v180.Enabled = false
                else
                    local v183 = {
                        Tree = v179,
                        Distance = v181
                    }
                    table.insert(v177, v183)
                end
            end
        end
        table.sort(v177, function(v184, v185) -- line 703
            return v184.Distance < v185.Distance
        end)
        for v186, v187 in v177 do
            local v188 = v186 <= 24
            v34[v187.Tree].Enabled = v188
        end
    end

    local function onTreeAdded(v189) -- line 715 | captures: Player, Sakura, SakuraBloomPolicy, SakuraFX, Save, LocalPlayer, v28, v30, v31, v35, growTree, onTreeHit
        local v190 = Save.IsLocalDataLoaded()
        local v191
        if v190 then
            v191 = Save.Get()
        end
        local Position, v192, v193
        if SakuraBloomPolicy.HasBloomUnlocked(v190, v191) and v189:IsA("Model") then
            if v189.Name == "SakuraTreeFalling" then
                v193 = true
            else
                Position = v189:GetPivot().Position
                v30[v189] = Position
                v31[v189] = v189:GetPivot()
                local v194 = Player.Optional.PrimaryPart(LocalPlayer)
                if v194 == nil then
                    v192 = (1/0)
                else
                    v192 = (v194.Position - Position).Magnitude
                end
                v193 = false
            end
        else
            v193 = true
        end
        if v193 then
            return
        end
        if v192 <= Sakura.Bloom.SpawnShakeRadius then
            v28:ShakeOnce(1.5, 8, 0.1, 0.6)
        end
        local v195 = Position + Vector3.new(0, 1, 0)
        SakuraFX.EmitBurst("Spawn", v195, 40, 10)
        SakuraFX.PlayCue("TreeSpawn", Position, 0.7, 0.75)
        growTree(v189)
        local v196 = v35[v189]
        if v196 then
            v196:Disconnect()
        end
        local Hits = v189:GetAttributeChangedSignal("Hits")
        v35[v189] = Hits:Connect(function() -- line 747 | captures: v189, onTreeHit
            onTreeHit(v189)
        end)
    end

    local function onTreeRemoved(v197) -- line 751 | captures: Player, SakuraFX, LocalPlayer, v28, v30, v31, v32, v33, v34, v35, fallTree
        local v198 = v30[v197]
        local v199 = v31[v197]
        v30[v197] = nil
        v31[v197] = nil
        v32[v197] = nil
        v33[v197] = nil
        v34[v197] = nil
        local v200 = v35[v197]
        if v200 then
            v200:Disconnect()
            v35[v197] = nil
        end
        if v198 == nil then
            return
        end
        if v197:IsA("Model") and v199 then
            fallTree(v197, v199)
        end
        local v201 = Player.Optional.PrimaryPart(LocalPlayer)
        local v202 = if v201 == nil then (1/0) else (v201.Position - v198).Magnitude
        if v202 <= 60 then
            v28:ShakeOnce(2, 10, 0.1, 0.6)
        end
        local v203 = v198 + Vector3.new(0, 8, 0)
        SakuraFX.EmitBurst("Break", v203, 90, 12)
        SakuraFX.PlayCue("TreeBreak", v198, 1, 1)
    end

    local function onCrystalAdded(v204) -- line 784 | captures: Players, SakuraBloomPolicy, Save, v1, Name, v37, v38, v39, v40, v41
        local v205 = Save.IsLocalDataLoaded()
        local v206
        if v205 then
            v206 = Save.Get()
        end
        local v207
        if SakuraBloomPolicy.HasBloomUnlocked(v205, v206) and v204:IsA("Model") then
            v207 = v204.PrimaryPart or v204:WaitForChild(Name, 5)
        else
            return
        end
        if v207 == nil or v204.Parent == nil or v37[v204] then
            return
        end
        v37[v204] = v204:GetPivot()
        local PointLight = Instance.new("PointLight")
        PointLight.Color = v1
        PointLight.Brightness = 1.2
        PointLight.Range = 8
        PointLight.Parent = v207
        v38[v204] = PointLight
        local Owner = v204:GetAttribute("Owner")
        local v208
        if typeof(Owner) == "number" then
            v208 = Players:GetPlayerByUserId(Owner)
        end
        local Origin = v204:GetAttribute("Origin")
        if not (v208 and typeof(Origin) == "Vector3") then
            return
        end
        v39[v204] = v208
        v40[v204] = Origin
        v41[v204] = 0
        v204:PivotTo(CFrame.new(Origin))
    end

    local function hideCrystal(v209) -- line 823 | captures: v37, v42
        v37[v209] = nil
        v42[v209] = nil
        for v210, v211 in ipairs(v209:GetDescendants()) do
            if v211:IsA("BasePart") then
                v211.Transparency = 1
            elseif v211:IsA("PointLight") then
                v211.Enabled = false
            end
        end
    end

    local function requestCollect(v212, v213) -- line 834 | captures: Remotes, v36, v37, v42
        task.spawn(function() -- line 835 | captures: v212, v213, Remotes, v36, v37, v42
            if Remotes.Bloomery.AskGatherPetal:InvokeServer(v212) then
                return
            end
            task.wait(1)
            v36[v212] = nil
            if v212.Parent then
                v37[v212] = v213
                v42[v212] = 0
            end
        end)
    end

    local function animateCrystals(v214, v215) -- line 846 | captures: TweenService, Player, Remotes, Sakura, LocalPlayer, v36, v37, v38, v39, v40, v41, v42, hideCrystal
        local v216 = Player.Optional.PrimaryPart(LocalPlayer)
        for v217, v218 in v37 do
            if v217.Parent ~= nil then
                local v219 = v41[v217]
                local v220 = v40[v217]
                if v219 == nil then
                    local v221 = v39[v217]
                    local v222
                    if v221 then
                        v222 = Player.Optional.PrimaryPart(v221)
                    end
                    local v223 = v42[v217]
                    if v223 == nil then
                        local v224 = if v216 == nil then false else (v216.Position - v218.Position).Magnitude <= 22
                        local v225, v226
                        if v224 then
                            v226 = 4
                            v225 = 2.5
                        else
                            v226 = 2
                            v225 = 1
                        end
                        local new = CFrame.new
                        local v227 = v214 * v226 + v218.Position.X
                        v217:PivotTo(v218 * new(0, math.sin(v227) * 0.35, 0) * CFrame.Angles(0, v214 * 1.2 * v225, 0))
                        local v228 = v38[v217]
                        if v228 then
                            if v224 then
                                local v229 = v214 * 6
                                v228.Brightness = math.sin(v229) * 0.8 + 2.5
                            else
                                v228.Brightness = 1.2
                            end
                        end
                    elseif v222 then
                        local v230 = v223 + v215
                        v42[v217] = v230
                        local v231 = v230 / 0.7
                        local v232 = math.clamp(v231, 0, 1)
                        local v233 = v232 * v232
                        local v234 = v222.Position + Vector3.new(0, 1, 0)
                        local Position = v217:GetPivot().Position
                        local v235 = v233 * 0.5 + v215 * 6
                        local v236 = Position:Lerp(v234, (math.min(1, v235)))
                        v217:PivotTo(CFrame.new(v236) * CFrame.Angles(0, v214 * 1.2 * 4, 0))
                        local v237 = Sakura.Bloom.CrystalScale * (1 - v233 * 0.6)
                        v217:ScaleTo((math.max(0.2, v237)))
                        if v232 >= 1 then
                            if v221 == LocalPlayer then
                                v42[v217] = nil
                                v37[v217] = nil
                                local spawn = task.spawn
                                local v238 = v217
                                local v239 = v218
                                spawn(function() -- line 903 | captures: v238, v239, Remotes, v36, v37, v42
                                    if Remotes.Bloomery.AskGatherPetal:InvokeServer(v238) then
                                        return
                                    end
                                    task.wait(1)
                                    v36[v238] = nil
                                    if v238.Parent then
                                        v37[v238] = v239
                                        v42[v238] = 0
                                    end
                                end)
                            else
                                hideCrystal(v217)
                            end
                        elseif (v236 - v234).Magnitude >= 1 then
                        end
                    end
                elseif v220 then
                    local v240 = v219 + v215
                    v41[v217] = v240
                    local v241 = v240 / 0.5
                    local v242 = math.clamp(v241, 0, 1)
                    local v243 = TweenService:GetValue(v242, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v244 = v220:Lerp(v218.Position, v243)
                    local new = CFrame.new
                    local v245 = v242 * 3.141592653589793
                    local v246 = math.sin(v245) * 6
                    v217:PivotTo(new(v244 + Vector3.new(0, v246, 0)) * CFrame.Angles(0, v214 * 1.2 * 3, 0))
                    if v240 >= 0.7 then
                        v41[v217] = nil
                        v42[v217] = 0
                        v36[v217] = true
                    end
                end
            end
        end
    end

    local function findTreeInReach(v247) -- line 934 | captures: Sakura, v31, v33
        local v248
        local v249 = (1/0)
        for v250, v251 in v31 do
            if not (v250.Parent == nil or v33[v250]) then
                local Radius = v250:GetAttribute("Radius")
                local v252 = typeof(Radius) == "number"
                local v253 = ("%* needs a Radius attribute"):format(v250.Name)
                assert(v252, v253)
                local v254 = v247.Position.X - v251.Position.X
                local v255 = v247.Position.Z - v251.Position.Z
                local Magnitude = Vector3.new(v254, 0, v255).Magnitude
                if Magnitude <= Radius + Sakura.Bloom.HitRange and Magnitude < v249 then
                    v248 = v250
                    v249 = Magnitude
                end
            end
        end
        return v248
    end

    local function tryAutoSwing() -- line 956 | captures: v50, Player, Remotes, Sakura, SakuraBloomPolicy, Save, LocalPlayer, findTreeInReach
        if v50 then
            return
        end
        local v256 = Player.Optional.Character(LocalPlayer)
        local v257 = Player.Optional.PrimaryPart(LocalPlayer)
        local v258 = Player.Optional.Humanoid(LocalPlayer)
        if v256 ~= nil and v257 ~= nil and v258 ~= nil and not (v258.Health <= 0) then
            local Tool = v256:FindFirstChildOfClass("Tool")
            if Tool ~= nil and Sakura.IsBatTool(Tool) then
                local v259 = findTreeInReach(v257)
                if v259 ~= nil then
                    local v260 = Save.IsLocalDataLoaded()
                    local v261
                    if v260 then
                        v261 = Save.Get()
                    end
                    if SakuraBloomPolicy.HasBloomUnlocked(v260, v261) then
                        local Animator = v258:FindFirstChildOfClass("Animator")
                        local HitAnim = Tool:FindFirstChild("HitAnim")
                        local v262 = Animator and HitAnim and HitAnim:IsA("Animation")
                        local v263 = ("%* needs a HitAnim and the character an Animator"):format(Tool.Name)
                        assert(v262, v263)
                        v50 = true
                        local v264 = Animator:LoadAnimation(HitAnim)
                        v264.Priority = Enum.AnimationPriority.Action
                        v264:Play()
                        Remotes.Bloomery.AskStrikeTree:FireServer(v259)
                        task.spawn(function() -- line 999 | captures: v264, v50
                            while true do
                                task.wait()
                                if v264.IsPlaying then
                                    if os.clock() + 3 <= os.clock() then
                                        break
                                    end
                                    continue
                                end
                                break
                            end
                            v264:Stop()
                            v264:Destroy()
                            v50 = false
                        end)
                    end
                end
            end
        end
    end

    local function isInsideBounds(v265) -- line 1011 | captures: Bounds
        local v266 = Bounds.CFrame:PointToObjectSpace(v265)
        local X = v266.X
        if math.abs(X) <= Bounds.Size.X / 2 + 90 then
            local Z = v266.Z
            return math.abs(Z) <= Bounds.Size.Z / 2 + 90
        end
        return false
    end

    local function buildWaypoint() -- line 1021 | captures: v48, Part, v49, Workspace, BloomWaypoint, Bounds, v27
        local Part_2 = Instance.new("Part")
        Part_2.Name = "BloomWaypointHost"
        Part_2.Anchored = true
        Part_2.CanCollide = false
        Part_2.CanQuery = false
        Part_2.CanTouch = false
        Part_2.Transparency = 1
        Part_2.Size = Vector3.new(1, 1, 1)
        Part_2.Position = Bounds.Position + Vector3.new(0, 24, 0)
        Part_2.Parent = Workspace
        local v267 = BloomWaypoint:Clone()
        v267.Enabled = false
        for v268, v269 in v267:GetChildren() do
            if v269:IsA("TextLabel") then
                v269.TextTransparency = 1
                local UIStroke = v269:FindFirstChildOfClass("UIStroke")
                if UIStroke then
                    UIStroke.Transparency = 1
                end
            end
        end
        v267.Parent = Part_2
        Part = Part_2
        v48 = v267
        v49 = false
        v27:Add(Part_2)
        v27:Add(function() -- line 1049 | captures: v48, Part, v49
            v48 = nil
            Part = nil
            v49 = false
        end)
    end

    local function setWaypointShown(v270, v271) -- line 1055 | captures: v49, TweenService
        if v49 == v271 then
            return
        end
        v49 = v271
        local v272 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v273
        if v271 then
            v273 = 0
            v270.Enabled = true
        else
            v273 = 1
        end
        for v274, v275 in v270:GetChildren() do
            if v275:IsA("TextLabel") then
                TweenService:Create(v275, v272, { TextTransparency = v273 }):Play()
                local UIStroke = v275:FindFirstChildOfClass("UIStroke")
                if UIStroke then
                    TweenService:Create(UIStroke, v272, { Transparency = v273 }):Play()
                end
            end
        end
        if not v271 then
            task.delay(0.5, function() -- line 1080 | captures: v270, v49
                if not v49 and v270.Parent then
                    v270.Enabled = false
                end
            end)
        end
    end

    local function renderWaypoint() -- line 1087 | captures: v48, Part, Player, LocalPlayer, Bounds, setWaypointShown
        local v276 = v48
        local Part_2 = Part
        if v276 == nil or Part_2 == nil then
            return
        end
        local v277 = Player.Optional.PrimaryPart(LocalPlayer)
        if v277 ~= nil then
            local v278 = Bounds.CFrame:PointToObjectSpace(v277.Position)
            local X = v278.X
            local v279
            if math.abs(X) <= Bounds.Size.X / 2 + 90 then
                local Z = v278.Z
                v279 = math.abs(Z) <= Bounds.Size.Z / 2 + 90
            else
                v279 = false
            end
            local v280
            if v279 then
                v280 = true
            elseif LocalPlayer:GetAttribute("AreaId") == "Prehistoric" then
                setWaypointShown(v276, true)
                local Countdown = v276:FindFirstChild("Countdown")
                if Countdown and Countdown:IsA("TextLabel") then
                    local Magnitude = (v277.Position - Part_2.Position).Magnitude
                    Countdown.Text = ("%* studs"):format((math.floor(Magnitude)))
                end
                v280 = false
            else
                v280 = true
            end
            if not v280 then
                return
            end
        end
        setWaypointShown(v276, false)
    end

    local function toggleMusic(v281) -- line 1115
        if v281 then
            script.SakuraEventMusic:Play()
        else
            script.SakuraEventMusic:Stop()
        end
    end

    local function hideTutorial() -- line 1122 | captures: v47, v7
        if v7.Enabled then
            v7.Enabled = false
            local v282 = v47
            v47 = nil
            if v282 ~= nil then
                v282()
            end
        elseif v47 ~= nil then
            v7.Enabled = false
            local v283 = v47
            v47 = nil
            if v283 ~= nil then
                v283()
            end
        end
    end

    local function checkEndingWarning() -- line 1143 | captures: v43, v45, Workspace, Message, Sakura, v1, v2
        if not v45 then
            local v284 = v43 - Workspace:GetServerTimeNow()
            if v284 <= Sakura.Bloom.EndingWarningSeconds and v284 > 0 then
                v45 = true
                local v285 = ("\240\159\140\184 The Great Bloom ends in %* seconds!"):format(Sakura.Bloom.EndingWarningSeconds)
                Message.Top({
                    Time = 4,
                    Message = v285,
                    Color = v1,
                    StrokeColor = v2
                })
            end
        end
    end

    local function stopPresentation() -- line 1154 | captures: v10, v19, SakuraCrystals, v26, v47, v50, v51, Save, v7, v8, v27, v30, v31, v32, v33, v34, v35, setWorldVFXEnabled, setCounterShown
        v27:Clean()
        v51 = false
        v10 += 1
        v8.Enabled = false
        if v7.Enabled then
            v7.Enabled = false
            local v286 = v47
            v47 = nil
            if v286 ~= nil then
                v286()
            end
        end
        setCounterShown(false, 0.5)
        v26 = 0
        v19 = false
        for v287, v288 in v35 do
            v288:Disconnect()
            v35[v287] = nil
        end
        for v289, v290 in v34 do
            if v290.Parent then
                v290:Destroy()
            end
        end
        for v291 in v31 do
            if v291.Parent then
                v291:SetAttribute("TreeLoaded", nil)
                for v292, v293 in v291:GetDescendants() do
                    if v293.Name == "BloomSparkles" then
                        v293:Destroy()
                    end
                end
            end
        end
        table.clear(v30)
        table.clear(v31)
        table.clear(v32)
        table.clear(v33)
        table.clear(v34)
        v50 = false
        local v294
        if Save.IsLocalDataLoaded() then
            v294 = Save.Get()
        end
        if v294 then
            SakuraCrystals = v294.SakuraCrystals
        else
            SakuraCrystals = nil
        end
        setWorldVFXEnabled(false)
        script.SakuraEventMusic:Stop()
    end

    local function startPresentation() -- line 1220 | captures: v10, SakuraCrystals, v43, v44, v45, v51, CollectionService, RunService, TweenService, Workspace, NotificationInstance, Message, Sakura, SakuraBloomPolicy, Save, v1, v2, LocalPlayer, Bounds, v8, Banner, Position, v27, setWorldVFXEnabled, updateHighlights, onTreeAdded, onTreeRemoved, onCrystalAdded, animateCrystals, tryAutoSwing, buildWaypoint, renderWaypoint
        if v51 then
            return
        end
        local v295 = Save.IsLocalDataLoaded()
        local v296
        if v295 then
            v296 = Save.Get()
        end
        if not SakuraBloomPolicy.CanShowBloom(v44, v295, v296) then
            return
        end
        v51 = true
        setWorldVFXEnabled(true)
        script.SakuraEventMusic:Play()
        local TreeTag = Sakura.TreeTag
        for v297, v298 in ipairs(CollectionService:GetTagged(TreeTag)) do
            onTreeAdded(v298)
        end
        local v299 = CollectionService:GetInstanceAddedSignal(Sakura.TreeTag)
        v27:Add(v299:Connect(onTreeAdded))
        local v300 = CollectionService:GetInstanceRemovedSignal(Sakura.TreeTag)
        v27:Add(v300:Connect(onTreeRemoved))
        buildWaypoint()
        if Save.Get() then
            SakuraCrystals = Save.Get().SakuraCrystals
        else
            SakuraCrystals = nil
        end
        local v301 = 0
        local v302 = 0
        v27:Add(RunService.Heartbeat:Connect(function(v303) -- line 1254 | captures: v301, v302, v43, v45, Workspace, Message, Sakura, v1, v2, LocalPlayer, Bounds, updateHighlights, animateCrystals, tryAutoSwing, renderWaypoint
            v302 += v303
            v301 += v303
            animateCrystals(v302, v303)
            if v301 >= 0.15 then
                v301 = 0
                updateHighlights()
                tryAutoSwing()
                renderWaypoint()
                if not v45 then
                    local v304 = v43 - Workspace:GetServerTimeNow()
                    if v304 <= Sakura.Bloom.EndingWarningSeconds and v304 > 0 then
                        v45 = true
                        local v305 = ("\240\159\140\184 The Great Bloom ends in %* seconds!"):format(Sakura.Bloom.EndingWarningSeconds)
                        Message.Top({
                            Time = 4,
                            Message = v305,
                            Color = v1,
                            StrokeColor = v2
                        })
                    end
                end
            end
            local Character = LocalPlayer.Character
            local v306 = Character and Character:FindFirstChild("HumanoidRootPart")
            if v306 then
                local v307 = Bounds.CFrame:PointToObjectSpace(v306.Position)
                local X = v307.X
                local v308
                if math.abs(X) <= Bounds.Size.X / 2 + 90 then
                    local Z = v307.Z
                    v308 = math.abs(Z) <= Bounds.Size.Z / 2 + 90
                else
                    v308 = false
                end
                if v308 then
                    script.SakuraEventMusic.Volume = 0.5
                else
                    script.SakuraEventMusic.Volume = 0
                end
            else
                script.SakuraEventMusic.Volume = 0
            end
        end))
        for v309, v310 in CollectionService:GetTagged(Sakura.CrystalTag) do
            onCrystalAdded(v310)
        end
        v10 += 1
        local v311 = v10
        local v312 = NotificationInstance.ReserveTop()
        task.spawn(function() -- line 1300 | captures: v311, v312, v10, TweenService, NotificationInstance, v8, Banner, Position
            while NotificationInstance.IsTopContended() and v10 == v311 do
                task.wait(0.1)
            end
            if v10 == v311 then
                local v313 = Position - UDim2.fromScale(0, Position.Y.Scale + Banner.Size.Y.Scale)
                Banner.Position = v313
                v8.Enabled = true
                local v314 = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                TweenService:Create(Banner, v314, { Position = Position }):Play()
                task.wait(7)
                if v10 == v311 then
                    local v315 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    local v316 = TweenService:Create(Banner, v315, { Position = v313 })
                    v316.Completed:Once(function() -- line 1323 | captures: v311, v312, v10, v8
                        if v10 == v311 then
                            v8.Enabled = false
                        end
                        v312()
                    end)
                    v316:Play()
                else
                    v312()
                end
            else
                v312()
            end
        end)
    end

    function v53.StartEvent(v317, v318, v319) -- line 1332 | captures: v43, v44, v45, Workspace, Save, refreshReplicatedVisibility, stopPresentation, startPresentation
        stopPresentation()
        v44 = true
        v45 = false
        v43 = Workspace:GetServerTimeNow() + v318
        refreshReplicatedVisibility()
        if Save.IsLocalDataLoaded() then
            Save.Get()
        end
        startPresentation()
    end

    function v53.StopEvent(v320) -- line 1351 | captures: v44, refreshReplicatedVisibility, stopPresentation
        v44 = false
        stopPresentation()
        refreshReplicatedVisibility()
    end

    v28:Start()
    v7.Enabled = false
    v8.Enabled = false
    for v321, v322 in v20 do
        v322.Instance[v322.Property] = 1
    end
    if v14 and v14:IsA("TextLabel") then
        v14.TextTransparency = 1
        if v17 then
            v17.Transparency = 1
        end
    end
    GUI.ButtonActivated(Ok, function() -- line 1371 | captures: v46, v47, CollectionService, Remotes, Save, Tabs, LocalPlayer, v7
        if v46 then
            return
        end
        v46 = true
        if v7.Enabled then
            v7.Enabled = false
            local v323 = v47
            v47 = nil
            if v323 ~= nil then
                v323()
            end
        end
        local v324 = Save.Get()
        if v324 and not v324.Sakura.TutorialSeen then
            Remotes.Bloomery.AskBriefingConfirm:InvokeServer()
        end
        v46 = false
        local v325 = CollectionService:GetTagged("MainSakuraTree")[1]
        if v325 and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
            local v326 = Save.Get()
            if (LocalPlayer.Character.PrimaryPart.Position - v325:GetPivot().Position).Magnitude < 100 and v326 and v326.Sakura.Unlocked then
                LocalPlayer:SetAttribute("SakuraTutorialSkip", true)
                Tabs.Show("SakuraEggCharge")
            end
        end
    end)
    ButtonFX(Ok)
    CollectionService:GetInstanceAddedSignal(Sakura.TreeTag):Connect(function(v327) -- line 1402 | captures: SakuraBloomPolicy, SakuraBloomVisibility, Save, v52
        local v328 = Save.IsLocalDataLoaded()
        local v329
        if v328 then
            v329 = Save.Get()
        end
        local v330 = v52[v327]
        if v330 then
            v330:Clean()
            v52[v327] = nil
        end
        if not SakuraBloomPolicy.HasBloomUnlocked(v328, v329) then
            v52[v327] = SakuraBloomVisibility.Conceal(v327)
        end
    end)
    CollectionService:GetInstanceRemovedSignal(Sakura.TreeTag):Connect(function(v331) -- line 1421 | captures: v52
        local v332 = v52[v331]
        if v332 then
            v332:Clean()
            v52[v331] = nil
        end
    end)
    CollectionService:GetInstanceAddedSignal(Sakura.CrystalTag):Connect(function(v333) -- line 1429 | captures: SakuraBloomPolicy, SakuraBloomVisibility, Save, v52, onCrystalAdded
        local v334 = Save.IsLocalDataLoaded()
        local v335
        if v334 then
            v335 = Save.Get()
        end
        local v336 = v52[v333]
        if v336 then
            v336:Clean()
            v52[v333] = nil
        end
        if not SakuraBloomPolicy.HasBloomUnlocked(v334, v335) then
            v52[v333] = SakuraBloomVisibility.Conceal(v333)
        end
        onCrystalAdded(v333)
    end)
    CollectionService:GetInstanceRemovedSignal(Sakura.CrystalTag):Connect(function(v337) -- line 1448 | captures: v36, v37, v38, v39, v40, v41, v42
        if v337:IsA("Model") then
            v37[v337] = nil
            v38[v337] = nil
            v39[v337] = nil
            v40[v337] = nil
            v41[v337] = nil
            v42[v337] = nil
        end
        v36[v337] = nil
    end)
    CollectionService:GetInstanceRemovedSignal(Sakura.CrystalTag):Connect(function(v338) -- line 1460 | captures: v52
        local v339 = v52[v338]
        if v339 then
            v339:Clean()
            v52[v338] = nil
        end
    end)
    CollectionService:GetInstanceAddedSignal("GreatBloomVFX"):Connect(function() -- line 1468 | captures: refreshReplicatedVisibility
        task.defer(refreshReplicatedVisibility)
    end)
    Remotes.Bloomery.PetalsGathered.OnClientEvent:Connect(function(v340, v341) -- line 1471 | captures: SakuraBloomPolicy, SakuraFX, Save, LocalPlayer, showCrystalPopup
        local v342 = Save.IsLocalDataLoaded()
        local v343
        if v342 then
            v343 = Save.Get()
        end
        if not SakuraBloomPolicy.HasBloomUnlocked(v342, v343) then
            return
        end
        showCrystalPopup(v340, v341)
        local v344 = v341 + Vector3.new(0, 2, 0)
        SakuraFX.EmitBurst("Pickup", v344, 14, 3)
        SakuraFX.PlayCue("CrystalPickup", LocalPlayer, 0.6, 0.95 + math.random() * 0.15)
    end)
    Save.WatchFields("SakuraCrystals", function() -- line 1487 | captures: v19, v26, SakuraBloomPolicy, Save, setCounterShown, popCounter
        local v345 = Save.IsLocalDataLoaded()
        local v346
        if v345 then
            v346 = Save.Get()
        end
        if SakuraBloomPolicy.HasBloomUnlocked(v345, v346) then
            popCounter()
        else
            setCounterShown(false, 0.5)
            v26 = 0
            v19 = false
        end
    end)
    Save.WatchFields("Sakura", function() -- line 1503 | captures: v44, SakuraBloomPolicy, Save, refreshReplicatedVisibility, stopPresentation, startPresentation
        refreshReplicatedVisibility()
        local v347 = Save.IsLocalDataLoaded()
        local v348
        if v347 then
            v348 = Save.Get()
        end
        if SakuraBloomPolicy.CanShowBloom(v44, v347, v348) then
            startPresentation()
        else
            stopPresentation()
        end
    end)
    Save.ProfileReady:Connect(function(v349) -- line 1518 | captures: v44, SakuraBloomPolicy, Save, LocalPlayer, refreshReplicatedVisibility, stopPresentation, startPresentation
        if v349 ~= LocalPlayer then
            return
        end
        refreshReplicatedVisibility()
        local v350 = Save.IsLocalDataLoaded()
        local v351
        if v350 then
            v351 = Save.Get()
        end
        if SakuraBloomPolicy.CanShowBloom(v44, v350, v351) then
            startPresentation()
        else
            stopPresentation()
        end
    end)
    SakuraSignals.ShowTutorial:Connect(function() -- line 1536 | captures: v47, HiddenUIHandler, SakuraBloomPolicy, SakuraFX, Save, Tabs, LocalPlayer, v7
        local v352 = Save.IsLocalDataLoaded()
        local v353
        if v352 then
            v353 = Save.Get()
        end
        if not SakuraBloomPolicy.HasBloomUnlocked(v352, v353) or v7.Enabled then
            return
        end
        Tabs.Dismiss(true)
        v47 = HiddenUIHandler.Acquire()
        v7.Enabled = true
        SakuraFX.PlayCue("TutorialOpen", LocalPlayer, 0.8)
    end)
    refreshReplicatedVisibility()
    task.spawn(function() -- line 1553 | captures: Remotes, Sakura, v53
        local v354 = Remotes.LiveEvents.FetchRunning:InvokeServer()
        local v355 = if typeof(v354) == "table" then v354[Sakura.EventName] else nil
        if typeof(v355) == "number" and v355 - os.time() > 0 then
            v53:StartEvent(v355 - os.time())
        end
    end)
    return v53
end

return {
    StartEvent = function() -- StartEvent | line 35
    end,
    StopEvent = function() -- StopEvent | line 36
    end
}
