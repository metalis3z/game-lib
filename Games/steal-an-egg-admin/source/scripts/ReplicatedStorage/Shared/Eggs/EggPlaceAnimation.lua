-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local EggActionMovement = require(script.Parent.EggActionMovement)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local v4 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(0.12, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local v6 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v7 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v8 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v9 = {}
local v10 = Color3.fromRGB(101, 67, 33)
local v11 = Color3.fromRGB(92, 60, 28)
local v12 = Color3.fromRGB(110, 75, 40)

v9[1] = v10
v9[2] = v11
v9[3] = v12
v9[4] = Color3.fromRGB(85, 55, 25)

local v13 = {}

function v13.CreateDirtChunk(v14, v15, v16) -- line 29 | captures: Debris, TweenService, t, v4, v5, v6, v7, v9
    local function v17(v18, v19, ...)
        return (Vector3.new(v18, v19, ...))
    end

    local function v20(v21, v22, ...)
        return (Vector3.new(v21, v22, ...))
    end

    t.strict(t.Instance)(v14)
    t.strict(t.Vector3)(v15)
    t.strict(t.number)(v16)
    local Part = Instance.new("Part")
    local v23 = math.random(25, 45) / 100 * v16
    local v24 = v23 * 0.7
    Part.Size = Vector3.new(v23, v24, v23)
    Part.Color = v9[math.random(1, #v9)]
    Part.Material = Enum.Material.SmoothPlastic
    Part.Anchored = true
    Part.CanCollide = false
    Part.CastShadow = false
    Part.Transparency = 0
    Part.Position = v15 + Vector3.new(0, 0.05000000074505806, 0)
    Part.Orientation = v17(math.random(-30, 30), math.random(-180, 180), math.random(-30, 30))
    Part.Parent = v14
    local v25 = math.random(0, 360)
    local v26 = math.rad(v25)
    local v27 = math.random(30, 60) / 100 * v16
    local v28 = math.cos(v26) * v27
    local v29 = math.sin(v26) * v27
    local v30 = math.random(50, 90) / 100 * v16
    local v31 = v28 * 0.6
    local v32 = v29 * 0.6
    local v33 = v15 + Vector3.new(v31, v30, v32)
    local v34 = v16 * 0.02
    local v35 = v15 + Vector3.new(v28, v34, v29)
    local v36 = v16 * -0.01
    local v37 = v35 + Vector3.new(0, v36, 0)
    local v38 = { Position = v33 }
    v38.Orientation = Part.Orientation + v20(math.random(-45, 45), math.random(-90, 90), math.random(-45, 45))
    local v39 = TweenService:Create(Part, v4, v38)
    v39:Play()
    v39.Completed:Once(function() -- line 65 | captures: Part, v23, v35, v37, Debris, TweenService, v5, v6, v7
        local v40 = { Position = v35 }
        local v41 = v23 * 1.1
        local v42 = v23 * 0.5
        local v43 = v23 * 1.1
        v40.Size = Vector3.new(v41, v42, v43)
        local v44 = TweenService:Create(Part, v5, v40)
        v44:Play()
        v44.Completed:Once(function() -- line 68 | captures: Part, v23, v37, Debris, TweenService, v6, v7
            local v45 = { Position = v37 }
            local v46 = v23 * 0.65
            v45.Size = Vector3.new(v23, v46, v23)
            local v47 = TweenService:Create(Part, v6, v45)
            v47:Play()
            v47.Completed:Once(function() -- line 71 | captures: Part, Debris, TweenService, v7
                task.delay(0.15, function() -- line 72 | captures: Part, Debris, TweenService, v7
                    TweenService:Create(Part, v7, { Transparency = 1 }):Play()
                    Debris:AddItem(Part, v7.Time)
                end)
            end)
        end)
    end)
end

function v13.PlaySfx(v48) -- line 80 | captures: Debris, t
    t.strict(t.Instance)(v48)
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://107809368960446"
    Sound.PlaybackSpeed = 1 + math.random(-10, 10) / 100
    Sound.Parent = v48
    Sound:Play()
    Sound.Ended:Once(function() -- line 88 | captures: Sound
        Sound:Destroy()
    end)
    Debris:AddItem(Sound, 5)
end

function v13.SpawnDirtChunks(v49, v50, v51) -- line 94 | captures: t, v13
    t.strict(t.Instance)(v49)
    t.strict(t.Vector3)(v50)
    t.strict(t.number)(v51)
    local v52 = math.random(6, 10)
    v13.CreateDirtChunk(v49, v50, v51)
    for v53 = 2, v52 do
        local delay = task.delay
        local v54 = (v53 - 1) * 0.015
        delay(v54, function() -- line 106 | captures: v49, v50, v51, v13
            v13.CreateDirtChunk(v49, v50, v51)
        end)
    end
end

function v13.CreateDirtDecal(v55, v56, v57) -- line 111 | captures: Debris, TweenService, t, v1, v2
    t.strict(t.Instance)(v55)
    t.strict(t.Vector3)(v56)
    t.strict(t.number)(v57)
    local v58 = v57 * 0.1
    local v59 = v57 * 0.8
    local v60 = v57 * 1.6
    local v61 = v57 * 1.4000000000000001
    local Part = Instance.new("Part")
    Part.Name = "EggPlaceDirtDecal"
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(v58, v59, v59)
    Part.Color = Color3.fromRGB(101, 67, 33)
    Part.Material = Enum.Material.SmoothPlastic
    Part.Anchored = true
    Part.CanCollide = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Position = v56 - Vector3.new(0, 0.009999999776482582, 0)
    local v62 = math.random(-180, 180)
    Part.Orientation = Vector3.new(0, v62, 90)
    Part.Parent = v55
    TweenService:Create(Part, v1, {
        Transparency = 0,
        Size = Vector3.new(v58, v60, v60)
    }):Play()
    local v63 = math.random(7, 11)
    task.delay(v63, function() -- line 138 | captures: v58, v61, Part, Debris, TweenService, v2
        local v64 = { Transparency = 1 }
        v64.Size = Vector3.new(v58, v61, v61)
        TweenService:Create(Part, v2, v64):Play()
        Debris:AddItem(Part, v2.Time)
    end)
end

function v13.CreateImpactRing(v65, v66, v67) -- line 143 | captures: Debris, TweenService, t, v8
    t.strict(t.Instance)(v65)
    t.strict(t.Vector3)(v66)
    t.strict(t.number)(v67)
    local Part = Instance.new("Part")
    Part.Name = "EggPlaceImpactRing"
    Part.Shape = Enum.PartType.Cylinder
    local v68 = v67 * 0.05
    local v69 = v67 * 0.3
    local v70 = v67 * 0.3
    Part.Size = Vector3.new(v68, v69, v70)
    Part.Color = Color3.fromRGB(139, 90, 43)
    Part.Material = Enum.Material.SmoothPlastic
    Part.Anchored = true
    Part.CanCollide = false
    Part.CastShadow = false
    Part.Transparency = 0.3
    Part.Position = v66 + Vector3.new(0, 0.019999999552965164, 0)
    Part.Orientation = Vector3.new(0, 0, 90)
    Part.Parent = v65
    local v71 = { Transparency = 1 }
    local v72 = v67 * 0.05
    local v73 = v67 * 1.8
    local v74 = v67 * 1.8
    v71.Size = Vector3.new(v72, v73, v74)
    TweenService:Create(Part, v8, v71):Play()
    Debris:AddItem(Part, 0.35)
end

function v13.Play(v75, v76, v77) -- line 166 | captures: TweenService, EggActionMovement, Trove, t, v3, v13
    t.strict(t.instanceIsA("Model"))(v75)
    t.strict(t.CFrame)(v76)
    t.strict(t.Instance)(v77)
    local PrimaryPart = v75.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    local X = PrimaryPart.Size.X
    local Y = PrimaryPart.Size.Y
    local Z = PrimaryPart.Size.Z
    local v78 = math.min(X, Y, Z)
    local v79 = math.max(v78, 0.1)
    local Position = v76.Position
    local v80 = v76.Position.Y + PrimaryPart.Size.Y * 0.1
    local v81 = false
    local v82 = PrimaryPart.Size.Y * 2
    local v83 = v76 + Vector3.new(0, v82, 0)
    local CFrameValue = Instance.new("CFrameValue")
    CFrameValue.Value = v83
    EggActionMovement.SetPivot(v75, v83)
    local v84 = Trove.new()
    v84:Add(CFrameValue)

    local function startImpactEffects() -- line 187 | captures: v81, v77, v79, Position, v13
        if v81 then
            return
        end
        v81 = true
        v13.PlaySfx(v77)
        v13.SpawnDirtChunks(v77, Position, v79)
        v13.CreateDirtDecal(v77, Position, v79)
        v13.CreateImpactRing(v77, Position, v79)
    end

    local Value = CFrameValue:GetPropertyChangedSignal("Value")
    v84:Add(Value:Connect(function() -- line 198 | captures: v75, v80, CFrameValue, startImpactEffects, EggActionMovement
        EggActionMovement.SetPivot(v75, CFrameValue.Value)
        if CFrameValue.Value.Position.Y <= v80 then
            startImpactEffects()
        end
    end))
    local v85 = TweenService:Create(CFrameValue, v3, { Value = v76 })
    v85:Play()
    v85.Completed:Once(function() -- line 206 | captures: v75, v76, v84, startImpactEffects, EggActionMovement
        EggActionMovement.SetPivot(v75, v76)
        startImpactEffects()
        v84:Destroy()
    end)
end

return v13
