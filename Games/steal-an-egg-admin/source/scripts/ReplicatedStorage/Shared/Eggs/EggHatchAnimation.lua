-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local Audio = require(ReplicatedStorage.Shared.Audio)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local SpatialCurve = require(ReplicatedStorage.Shared.Utils.Interpolation).SpatialCurve
local CollisionGroups = require(ReplicatedStorage.Shared.Types.CollisionGroups)
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRenderer = require(script.Parent.EggRenderer)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local EmitTree = require(ReplicatedStorage.Shared.Utils.VFX).EmitTree
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Player = require(ReplicatedStorage.Shared.Player)
local SfxRework = require(ReplicatedStorage.Data.SfxRework)
local OnRender = require(ReplicatedStorage.Shared.Utils.FrameStepper).OnRender
local Fade = require(ReplicatedStorage.Shared.Utils.VisualTransform).Fade
local t = require(ReplicatedStorage.Packages.t)
local v1 = Color3.fromRGB(248, 248, 248)
local Assets_2 = ReplicatedStorage.Assets
local __DEBRIS = Workspace.__DEBRIS
local PlacedEggOpen = Assets_2.Particles["Egg Open"].PlacedEggOpen
local EggExplode = PlacedEggOpen.EggExplode
local Trail = PlacedEggOpen.Trail
local EggPoof = Assets_2.EggPoof
local Folder = __DEBRIS:IsA("Folder")
assert(Folder, "Workspace.__DEBRIS must be a Folder")
local Model = EggExplode:IsA("Model")
assert(Model, "PlacedEggOpen.EggExplode must be a Model")
local Trail_2 = Trail:IsA("Trail")
assert(Trail_2, "PlacedEggOpen.Trail must be a Trail")
local BasePart = EggPoof:IsA("BasePart")
assert(BasePart, "Assets.EggPoof must be a BasePart")
for v2, v3 in EggExplode:GetDescendants() do
    if v3:IsA("BasePart") then
        v3.CollisionGroup = CollisionGroups.PLAYER_COLLISION_GROUP
    end
end
local v4 = {}

local function buildAssetItemData(v5, v6) -- line 50
    local v7 = {
        HasBeenFirstPlaced = false,
        Category = v5.AssetCategory
    }
    v7.Scale = v6 or v5.AssetScale
    v7.EyeColor = v5.AssetEyeColor
    v7.ColorSeed = v5.AssetColorSeed
    v7.ColorIndex = v5.AssetColorIndex
    v7.Mutations = v5.Mutations or {}
    v7.BaseMutation = v5.BaseMutation
    return v7
end

local function playPoofSound() -- line 68 | captures: Audio
    Audio.Play("rbxassetid://96936782055661", script)
end

local function playAssetRevealSound(v8, v9) -- line 71 | captures: Assets, Audio, SfxRework
    local v10 = SfxRework.Resolve(v8.AssetCategory, "Idle", Assets.Directory[v8.AssetCategory].RandomIdleSound)
    if v10 == nil then
        return nil
    end
    return Audio.PlayFile(v10, v9)
end

local function autoControlPoint(v11, v12) -- line 78
    local v13 = (v11 + v12) / 2
    local Y = v11.Y
    local Y_2 = v12.Y
    local v14 = math.max(Y, Y_2) + ((v11 - v12) * Vector3.new(1, 0, 1)).Magnitude * 0.5
    local X = v13.X
    local Z = v13.Z
    return (Vector3.new(X, v14, Z))
end

local function getPlayerBodyPosition(v15, v16) -- line 84 | captures: Player
    local v17 = Player.Optional.PrimaryPart(v15)
    if v17 then
        return v17:GetPivot().Position
    end
    return v16
end

local function getBottomCFrameFacingPlayer(v18, v19, v20) -- line 91 | captures: Players, Player
    local v21 = Players:GetPlayerByUserId(v18)
    if v21 == nil then
        return CFrame.new(v19) * v20
    end
    local v22 = Player.Optional.PrimaryPart(v21)
    local v23 = if v22 then v22:GetPivot().Position else v19
    local X = v23.X
    local Y = v19.Y
    local Z = v23.Z
    local v24 = Vector3.new(X, Y, Z)
    if (v19 - v24).Magnitude < 0.001 then
        return CFrame.new(v19) * v20
    end
    return CFrame.lookAt(v19, v24)
end

local function shakeEggPass(v25, v26, v27) -- line 109 | captures: RunService, EggActionMovement
    local v28 = 0
    while v28 < 0.5 do
        v28 += RunService.Heartbeat:Wait()
        local v29 = 1 - v28 / 0.5
        local v30 = tick() * 90
        local v31 = v29 * math.sin(v30) * v27
        EggActionMovement.SetPivot(v25, v26 * CFrame.Angles(0, 0, (math.rad(v31))))
    end
end

local function shakeEgg(v32, v33) -- line 118 | captures: shakeEggPass
    shakeEggPass(v32, v33, 7)
    task.wait(0.3)
    shakeEggPass(v32, v33, 9)
    task.wait(0.3)
    shakeEggPass(v32, v33, 13)
end

local function pivotAssetToEggBottom(v34, v35) -- line 125 | captures: ModelBounds
    local v36 = v34:GetPivot()
    local v37, v38 = ModelBounds(v34)
    local v39 = v37.Position - Vector3.new(0, 1, 0) * (v38.Y * 0.5)
    v34:PivotTo(CFrame.new(v35.Position - (v39 - v36.Position)) * (v35 - v35.Position))
end

local function growAsset(v40, v41, v42) -- line 132 | captures: Ease, OnRender, pivotAssetToEggBottom
    local v43 = v42 * 0.5
    OnRender(function(v44, v45) -- line 134 | captures: v40, v41, v42, v43, Ease, pivotAssetToEggBottom
        if v40.Parent == nil then
            return true
        end
        local v46 = Ease(v45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        v40:ScaleTo(v43 + (v42 - v43) * v46)
        pivotAssetToEggBottom(v40, v41)
    end, 1.3, true):Wait()
    if v40.Parent ~= nil then
        v40:ScaleTo(v42)
        pivotAssetToEggBottom(v40, v41)
    end
end

local function lookAtPlayer(v47, v48) -- line 147 | captures: Ease, Player, OnRender
    local v49 = v47:GetPivot()
    OnRender(function(v50, v51) -- line 149 | captures: v47, v48, v49, Ease, Player
        if v47.Parent == nil then
            return true
        end
        local v52 = 6.283185307179586 * v51 * 0.5
        local v53 = math.sin(v52) * 1
        local v54 = v49 + Vector3.new(0, v53, 0)
        local v55 = Player.Optional.PrimaryPart(v48)
        local v56 = if v55 then v55:GetPivot().Position else v49.Position
        local X = v56.X
        local Y = v54.Y
        local Z = v56.Z
        local v57 = Vector3.new(X, Y, Z)
        local v58
        if (v54.Position - v57).Magnitude >= 0.001 then
            v58 = CFrame.lookAt(v54.Position, v57)
        else
            v58 = v54
        end
        local v59 = Ease(v51, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v47:PivotTo(v54:Lerp(v58, v59))
    end, 3, true):Wait()
end

local function flyAssetIntoPlayer(v60, v61) -- line 172 | captures: SpatialCurve, Ease, Player, OnRender, Fade
    local v62 = v60:GetScale()
    local v63 = v60:GetPivot()
    local v64 = Fade()
    task.spawn(function() -- line 176 | captures: v60, v61, v62, v63, v64, SpatialCurve, Ease, Player, OnRender
        OnRender(function(v65, v66) -- line 177 | captures: v60, v61, v62, v63, v64, SpatialCurve, Ease, Player
            if v60.Parent == nil then
                return true
            end
            local v67 = Player.Optional.PrimaryPart(v61)
            local v68 = if v67 then v67:GetPivot().Position else v63.Position
            local Position = v63.Position
            local v69 = (Position + v68) / 2
            local Y = Position.Y
            local Y_2 = v68.Y
            local v70 = math.max(Y, Y_2) + ((Position - v68) * Vector3.new(1, 0, 1)).Magnitude * 0.5
            local Position_2 = v63.Position
            local X = v69.X
            local Z = v69.Z
            local v71 = SpatialCurve(Position_2, Vector3.new(X, v70, Z), v68)
            local v72 = CFrame.new(v71(v66)) * v63.Rotation
            local X_2 = v68.X
            local Y_3 = v72.Y
            local Z_2 = v68.Z
            local v73 = Vector3.new(X_2, Y_3, Z_2)
            if (v72.Position - v73).Magnitude >= 0.001 then
                v72 = CFrame.lookAt(v72.Position, v73)
            end
            local v74 = (v66 - 0.6) / 0.4
            local v75 = math.clamp(v74, 0, 1)
            local v76 = Ease(v75, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
            v64(v60, 1, v76)
            local v77 = v62 * (1 - v76)
            v60:ScaleTo((math.max(0.001, v77)))
            v60:PivotTo(v72)
        end, 0.7, true):Wait()
        if v60.Parent == nil then
            return
        end
        v64(v60, 1, 1)
        v60:ScaleTo(0.001)
        v60:Destroy()
    end)
    task.wait(0.3)
end

local function playAssetClaimSequence(v78, v79) -- line 215 | captures: Players, Ease, Player, OnRender, flyAssetIntoPlayer
    local v80 = Players:GetPlayerByUserId(v78)
    if v80 == nil then
        v79:Destroy()
    else
        local v81 = v79:GetPivot()
        OnRender(function(v82, v83) -- line 222 | captures: v79, v80, v81, Ease, Player
            if v79.Parent == nil then
                return true
            end
            local v84 = 6.283185307179586 * v83 * 0.5
            local v85 = math.sin(v84) * 1
            local v86 = v81 + Vector3.new(0, v85, 0)
            local v87 = Player.Optional.PrimaryPart(v80)
            local v88 = if v87 then v87:GetPivot().Position else v81.Position
            local X = v88.X
            local Y = v86.Y
            local Z = v88.Z
            local v89 = Vector3.new(X, Y, Z)
            local v90
            if (v86.Position - v89).Magnitude >= 0.001 then
                v90 = CFrame.lookAt(v86.Position, v89)
            else
                v90 = v86
            end
            local v91 = Ease(v83, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v79:PivotTo(v86:Lerp(v90, v91))
        end, 3, true):Wait()
        flyAssetIntoPlayer(v79, v80)
    end
end

local function revealAsset(v92, v93, v94, v95) -- line 246 | captures: TweenService, ModelBounds, ItemDisplay, t, __DEBRIS, buildAssetItemData, pivotAssetToEggBottom, growAsset
    local v96 = ItemDisplay.CreateActiveModel(v93, buildAssetItemData(v94, 1), true, true)
    v96.Name = ("%*_%*"):format(v92, v93)
    v96.Parent = __DEBRIS
    local PrimaryPart = v96.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    PrimaryPart.Anchored = true
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 0
    Highlight.OutlineTransparency = 1
    Highlight.Adornee = v96
    Highlight.Parent = v96
    v96:ScaleTo(v94.AssetScale * 0.5)
    local v97, v98 = ModelBounds(v96)
    PrimaryPart.PivotOffset = CFrame.new(0, v97.Position.Y - v98.Y * 0.5 - PrimaryPart.CFrame.Position.Y, 0)
    pivotAssetToEggBottom(v96, v95)
    task.spawn(function() -- line 267 | captures: v94, v95, v96, growAsset
        growAsset(v96, v95, v94.AssetScale)
    end)
    for v99, v100 in ipairs(v96:GetDescendants()) do
        if v100:IsA("BasePart") then
            v100.CanCollide = false
            v100.CanQuery = false
        end
    end
    local v101 = TweenInfo.new(0.5)
    TweenService:Create(Highlight, v101, { FillTransparency = 1 }):Play()
    return v96
end

function v4.Play(v102, v103, v104, v105, v106) -- line 280 | captures: Debris, Players, ReplicatedStorage, TweenService, Assets, Audio, ModelBounds, Ease, EggRenderer, Eggs, EmitTree, Player, SfxRework, OnRender, t, v1, __DEBRIS, EggExplode, Trail, EggPoof, getBottomCFrameFacingPlayer, shakeEgg, flyAssetIntoPlayer, revealAsset
    t.strict(t.number)(v102)
    t.strict(t.string)(v103)
    local v107 = Eggs.SchemaValidation.SavedEgg(v104)
    assert(v107, "Invalid saved egg record")
    t.strict(t.instanceIsA("Model"))(v105)
    t.strict(t.optional(t.boolean))(v106)
    EggRenderer.DisableCollisions(v105)
    local v108 = EggExplode:Clone()
    v108:ScaleTo(v105:GetScale() / 3)
    v108:PivotTo(v105:GetPivot())
    local Core = v108.Core
    local BasePart = Core:IsA("BasePart")
    assert(BasePart, "Egg explosion Core must be a BasePart")
    Core.Parent = __DEBRIS
    Debris:AddItem(Core, 60)
    v108.Parent = ReplicatedStorage
    if not v106 then
        task.wait(0.4)
        Audio.Play("rbxassetid://103116044135853", script, { Volume = 2.8 })
    end
    local v109 = v105:GetPivot()
    local v110, v111 = ModelBounds(v105)
    local v112 = v110.Position - Vector3.new(0, 1, 0) * (v111.Y * 0.5) + Vector3.new(0, 0.20000000298023224, 0)
    local v113 = getBottomCFrameFacingPlayer(v102, v112, v109 - v109.Position)
    if not v106 then
        shakeEgg(v105, v109)
    end
    local v114 = 0
    local v115 = 0
    local v116 = 0
    local v117 = 0
    local v118 = 0
    for v119, v120 in ipairs(v105:GetDescendants()) do
        if v120:IsA("BasePart") and v120.Transparency < 1 then
            local Color = v120.Color
            v114 += Color.R
            v115 += Color.G
            v116 += Color.B
            v117 += 1
            if v120.Transparency > 0.3 then
                v118 = v120.Transparency
            end
        end
    end
    local v121
    if v117 <= 0 then
        v121 = v1
    else
        v121 = Color3.new(v114 / v117, v115 / v117, v116 / v117)
    end
    local PrimaryPart = v105.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    local v122 = {
        Color = v121,
        Material = PrimaryPart.Material,
        MaterialVariant = PrimaryPart.MaterialVariant,
        Transparency = PrimaryPart.Transparency
    }
    v105:Destroy()
    v108.Parent = __DEBRIS
    for v123, v124 in ipairs(v108:GetDescendants()) do
        if v124 ~= Core and v124.Name ~= "RootPart" and v124:IsA("BasePart") then
            v124.Anchored = false
        end
    end
    local v125 = revealAsset(v102, v103, v104, v113)
    local v126 = SfxRework.Resolve(v104.AssetCategory, "Idle", Assets.Directory[v104.AssetCategory].RandomIdleSound)
    local v127
    if v126 == nil then
    else
        v127 = Audio.PlayFile(v126, v113)
    end
    for v128, v129 in ipairs(v108:GetChildren()) do
        if not v129:IsA("BasePart") then
            local Model = v129:IsA("Model")
            local v130 = ("Explosion child %* must be a Model"):format((v129:GetFullName()))
            assert(Model, v130)
            local PrimaryPart = v129.PrimaryPart
            t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
            local v131, v132 = v129:GetBoundingBox()
            local Part = Instance.new("Part")
            Part.Transparency = 1
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CFrame = v131
            Part.Size = v132
            local WeldConstraint = Instance.new("WeldConstraint")
            WeldConstraint.Part0 = Part
            WeldConstraint.Part1 = PrimaryPart
            WeldConstraint.Parent = Part
            Part.Parent = v129
            local Attachment = Instance.new("Attachment")
            local Attachment_2 = Instance.new("Attachment")
            Attachment.Parent = Part
            Attachment_2.Parent = Part
            local v133 = v132.Y / 2
            Attachment.Position = Vector3.new(0, v133, 0)
            local v134 = -v132.Y / 2
            Attachment_2.Position = Vector3.new(0, v134, 0)
            local v135 = Trail:Clone()
            v135.Attachment0 = Attachment
            v135.Attachment1 = Attachment_2
            v135.Color = ColorSequence.new(v122.Color)
            v135.Parent = Attachment
            v135.Enabled = true
        end
    end
    if not v106 then
        Audio.Play("rbxassetid://96936782055661", script)
    end
    for v136, v137 in ipairs(v108:GetDescendants()) do
        if v137 ~= Core and v137.Name ~= "RootPart" and v137:IsA("BasePart") then
            local v138 = CFrame.new(Core.Position, v137.Position).LookVector * 16 + Vector3.new(0, 24, 0)
            v137.Transparency = v118
            v137.Color = v121
            v137.Material = v122.Material
            v137.MaterialVariant = v122.MaterialVariant
            v137:ApplyImpulse(v138 * v137.AssemblyMass)
        end
    end
    task.delay(3, function() -- line 401 | captures: v108, Debris, TweenService
        for v139, v140 in ipairs(v108:GetChildren()) do
            for v141, v142 in ipairs(v140:GetDescendants()) do
                if v142:IsA("BasePart") then
                    local v143 = TweenInfo.new(1)
                    TweenService:Create(v142, v143, { Transparency = 1 }):Play()
                end
            end
        end
        Debris:AddItem(v108, 1)
    end)
    local Attachment = Core.Attachment
    local Attachment_2 = Attachment:IsA("Attachment")
    assert(Attachment_2, "Egg explosion core Attachment must be an Attachment")
    for v144, v145 in ipairs(Attachment:GetDescendants()) do
        if v145:IsA("ParticleEmitter") and v145.Name == "ColorMe" then
            v145.Color = ColorSequence.new(v122.Color)
        end
    end
    EmitTree(Attachment)
    local Rare = Core.Rare
    local Attachment_3 = Rare:IsA("Attachment")
    assert(Attachment_3, "Egg explosion core Rare must be an Attachment")
    for v146, v147 in ipairs(Rare:GetDescendants()) do
        if v147:IsA("ParticleEmitter") then
            v147.Color = ColorSequence.new(v122.Color)
        end
    end
    EmitTree(Rare)
    local v148 = EggPoof:Clone()
    v148.CFrame = v109
    v148.Parent = __DEBRIS
    EmitTree(v148)
    Debris:AddItem(v148, 6)
    local v149 = Players:GetPlayerByUserId(v102)
    if v149 == nil then
        v125:Destroy()
    else
        local v150 = v125:GetPivot()
        OnRender(function(v151, v152) -- line 442 | captures: v125, v149, v150, Ease, Player
            if v125.Parent == nil then
                return true
            end
            local v153 = 6.283185307179586 * v152 * 0.5
            local v154 = math.sin(v153) * 1
            local v155 = v150 + Vector3.new(0, v154, 0)
            local v156 = Player.Optional.PrimaryPart(v149)
            local v157 = if v156 then v156:GetPivot().Position else v150.Position
            local X = v157.X
            local Y = v155.Y
            local Z = v157.Z
            local v158 = Vector3.new(X, Y, Z)
            local v159
            if (v155.Position - v158).Magnitude >= 0.001 then
                v159 = CFrame.lookAt(v155.Position, v158)
            else
                v159 = v155
            end
            local v160 = Ease(v152, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v125:PivotTo(v155:Lerp(v159, v160))
        end, 3, true):Wait()
        flyAssetIntoPlayer(v125, v149)
    end
    return v127
end

function v4.FadeSoundWhenGrantedToolUnequips(v161, v162) -- line 467 | captures: Players, Audio, t
    t.strict(t.instanceIsA("Sound"))(v161)
    t.strict(t.string)(v162)
    if not v161:IsDescendantOf(game) then
        return
    end
    local LocalPlayer = Players.LocalPlayer
    local v163, v164, v165, v166
    local v167 = false

    local function disconnectLifecycle() -- line 481 | captures: v163, v164, v165, v166
        if v163 ~= nil then
            v163:Disconnect()
            v163 = nil
        end
        if v164 ~= nil then
            v164:Disconnect()
            v164 = nil
        end
        if v165 ~= nil then
            v165:Disconnect()
            v165 = nil
        end
        if v166 ~= nil then
            v166:Disconnect()
            v166 = nil
        end
    end

    local function fadeAndStop() -- line 499 | captures: v161, disconnectLifecycle, Audio
        disconnectLifecycle()
        if v161:IsDescendantOf(game) then
            Audio.Fade(v161, 0, 0.35).Completed:Once(function() -- line 504 | captures: v161
                if v161:IsDescendantOf(game) then
                    v161:Stop()
                end
            end)
        end
    end

    local function tryBindTool(v168) -- line 510 | captures: v163, v166, v167, v162, fadeAndStop
        if v167 or not v168:IsA("Tool") or not (v168:GetAttribute("UID") == v162) then
            return
        end
        v167 = true
        if v163 ~= nil then
            v163:Disconnect()
            v163 = nil
        end
        v166 = v168.Unequipped:Once(fadeAndStop)
    end

    for v169, v170 in LocalPlayer:GetDescendants() do
        tryBindTool(v170)
        if v167 then
            break
        end
    end
end

return v4
