-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    "Head",
    "UpperTorso",
    "Torso",
    "LowerTorso",
    "LeftFoot",
    "LeftHand",
    "LeftLowerArm",
    "LeftLowerLeg",
    "LeftUpperArm",
    "LeftUpperLeg",
    "RightFoot",
    "RightHand",
    "RightLowerArm",
    "RightLowerLeg",
    "RightUpperArm",
    "RightUpperLeg"
}
local v2 = {
    Root = "LowerTorso",
    Waist = "UpperTorso",
    Neck = "Head",
    LeftAnkle = "LeftFoot",
    LeftWrist = "LeftHand",
    LeftElbow = "LeftLowerArm",
    LeftKnee = "LeftLowerLeg",
    LeftShoulder = "LeftUpperArm",
    LeftHip = "LeftUpperLeg",
    RightAnkle = "RightFoot",
    RightWrist = "RightHand",
    RightElbow = "RightLowerArm",
    RightKnee = "RightLowerLeg",
    RightShoulder = "RightUpperArm",
    RightHip = "RightUpperLeg"
}
local v3 = {
    Optional = {}
}
local v4 = t.strict(t.Vector3)
local v5 = t.strict(t.number)

function v3.Player(v6) -- line 47 | captures: Players
    return v6 or Players.LocalPlayer
end

function v3.Get(v7) -- line 54 | captures: Players
    return v7 or Players.LocalPlayer
end

local function Character(v8) -- line 61 | captures: Players
    return (v8 or Players.LocalPlayer).Character
end

v3.Optional.Character = Character

function v3.Character(v9) -- line 68 | captures: Players
    local v10 = v9 or Players.LocalPlayer
    return v10.Character or v10.CharacterAdded:Wait()
end

local function Position(v11) -- line 79 | captures: v3
    local v12 = v3.Optional.Character(v11)
    if v12 then
        return v12:GetPivot().Position
    end
    return nil
end

v3.Optional.Position = Position

function v3.Position(v13) -- line 86 | captures: v3
    return v3.Character(v13):GetPivot().Position
end

local function CFrame(v14) -- line 89 | captures: v3
    local v15 = v3.Optional.Character(v14)
    if v15 then
        return (v15:GetPivot())
    end
    return nil
end

v3.Optional.CFrame = CFrame

function v3.CFrame(v16) -- line 96 | captures: v3
    return v3.Character(v16):GetPivot()
end

local function GetDistanceFrom(v17, v18) -- line 99 | captures: v3, v4
    v4(v18)
    local v19 = v3.Optional.Position(v17)
    if v19 then
        return (v18 - v19).Magnitude
    end
    return nil
end

v3.Optional.GetDistanceFrom = GetDistanceFrom

function v3.GetDistanceFrom(v20, v21) -- line 107 | captures: v3
    local v22 = v3.Optional.GetDistanceFrom(v20, v21)
    return assert(v22, "no character to measure from")
end

local function IsWithinRange(v23, v24, v25) -- line 111 | captures: v3, v4, v5
    local v26 = v3.Optional.GetDistanceFrom(v23, v24)
    if v26 then
        v4(v24)
        v5(v25)
        return v26 <= v25
    end
    return nil
end

v3.Optional.IsWithinRange = IsWithinRange

function v3.IsWithinRange(v27, v28, v29) -- line 121 | captures: v3
    local v30 = v3.Optional.IsWithinRange(v27, v28, v29)
    local v31 = v30 ~= nil
    assert(v31, "no character to range-check")
    return v30
end

local function Part(v32, v33) -- line 127 | captures: v3
    return v3.Character(v32):FindFirstChild(v33)
end

v3.Optional.Part = Part

function v3.Part(v34, v35) -- line 130 | captures: v3
    return v3.Character(v34):WaitForChild(v35, (1/0))
end

local function EmbeddedMotor6D(v36, v37, v38) -- line 133 | captures: v3
    local v39 = v3.Optional.Part(v36, v37)
    if v39 then
        return (v39:FindFirstChild(v38))
    end
    return nil
end

v3.Optional.EmbeddedMotor6D = EmbeddedMotor6D

function v3.EmbeddedMotor6D(v40, v41, v42) -- line 140 | captures: v3
    return v3.Part(v40, v41):WaitForChild(v42, (1/0))
end

for v43, v44 in v1 do
    local Optional = v3.Optional
    local v45 = v44

    Optional[v44] = function(v46) -- line 148 | captures: v3, v45
        return v3.Optional.Part(v46, v45)
    end

    v3[v44] = function(v47) -- line 151 | captures: v3, v45
        return v3.Part(v47, v45)
    end
end
for v48, v49 in v2 do
    local Optional = v3.Optional
    local v50 = v49
    local v51 = v48

    Optional[v48] = function(v52) -- line 159 | captures: v3, v50, v51
        return v3.Optional.EmbeddedMotor6D(v52, v50, v51)
    end

    v3[v48] = function(v53) -- line 162 | captures: v3, v50, v51
        return v3.EmbeddedMotor6D(v53, v50, v51)
    end
end

local function PrimaryPart(v54) -- line 166 | captures: v3
    local v55 = v3.Optional.Character(v54)
    if v55 then
        return v55.PrimaryPart
    end
    return nil
end

v3.Optional.PrimaryPart = PrimaryPart

function v3.PrimaryPart(v56) -- line 173 | captures: v3
    local v57 = v3.Character(v56)
    local PrimaryPart = v57.PrimaryPart
    if not PrimaryPart then
        v57:WaitForChild("HumanoidRootPart", (1/0))
        local PrimaryPart = v57.PrimaryPart
        assert(PrimaryPart)
    end
    return PrimaryPart
end

local function PrimaryPartPosition(v58) -- line 182 | captures: v3
    local v59 = v3.Optional.PrimaryPart(v58)
    if v59 then
        return v59.Position
    end
    return nil
end

v3.Optional.PrimaryPartPosition = PrimaryPartPosition

function v3.PrimaryPartPosition(v60) -- line 189 | captures: v3
    return v3.PrimaryPart(v60).Position
end

local function PrimaryPartCFrame(v61) -- line 192 | captures: v3
    local v62 = v3.Optional.PrimaryPart(v61)
    if v62 then
        return v62.CFrame
    end
    return nil
end

v3.Optional.PrimaryPartCFrame = PrimaryPartCFrame

function v3.PrimaryPartCFrame(v63) -- line 199 | captures: v3
    return v3.PrimaryPart(v63).CFrame
end

local function HumanoidRootPart(v64) -- line 202 | captures: v3
    local v65 = v3.Optional.Character(v64)
    if v65 then
        return (v65:FindFirstChild("HumanoidRootPart"))
    end
    return nil
end

v3.Optional.HumanoidRootPart = HumanoidRootPart

function v3.HumanoidRootPart(v66) -- line 209 | captures: v3
    return v3.Character(v66):WaitForChild("HumanoidRootPart")
end

local function Humanoid(v67) -- line 212 | captures: v3
    local v68 = v3.Optional.Character(v67)
    if v68 then
        return (v68:FindFirstChildOfClass("Humanoid"))
    end
    return nil
end

v3.Optional.Humanoid = Humanoid

function v3.Humanoid(v69) -- line 219 | captures: v3
    local v70 = v3.Character(v69)
    local Humanoid = v70:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        v70:WaitForChild("Humanoid", (1/0))
        Humanoid = v70:FindFirstChildOfClass("Humanoid")
        assert(Humanoid, "no Humanoid on the rig")
    end
    return Humanoid
end

local function animationHost(v71) -- line 229
    return v71:FindFirstChildOfClass("Animator") or v71:FindFirstChildOfClass("AnimationController") or v71
end

local function Animator(v72) -- line 239 | captures: v3
    local v73 = v3.Optional.Humanoid(v72)
    if v73 then
        return v73:FindFirstChildOfClass("Animator") or v73:FindFirstChildOfClass("AnimationController") or v73
    end
    return nil
end

v3.Optional.Animator = Animator

function v3.Animator(v74) -- line 254 | captures: v3
    local v75 = v3.Humanoid(v74)
    return v75:FindFirstChildOfClass("Animator") or v75:FindFirstChildOfClass("AnimationController") or v75
end

local function GetAppliedDescription(v76) -- line 265 | captures: v3
    local v77 = v3.Optional.Humanoid(v76)
    return v77 and v77:GetAppliedDescription()
end

v3.Optional.GetAppliedDescription = GetAppliedDescription

function v3.GetAppliedDescription(v78) -- line 273 | captures: v3
    return v3.Humanoid(v78):GetAppliedDescription()
end

local function FeetCFrame(v79) -- line 276 | captures: v3
    local v80 = v3.Optional.Character(v79)
    if v80 then
        local PrimaryPart = v80.PrimaryPart
        local Humanoid = v80:FindFirstChildOfClass("Humanoid")
        if not PrimaryPart or not Humanoid then
            return nil
        end
        return PrimaryPart.CFrame - PrimaryPart.CFrame.UpVector * (Humanoid.HipHeight + PrimaryPart.Size.Y * 0.5)
    end
    return nil
end

v3.Optional.FeetCFrame = FeetCFrame

function v3.FeetCFrame(v81) -- line 288 | captures: v3
    local v82 = v3.Optional.FeetCFrame(v81)
    if v82 then
        return v82
    end
    local v83 = v3.PrimaryPart(v81)
    return v83.CFrame - v83.CFrame.UpVector * (v3.Humanoid(v81).HipHeight + v83.Size.Y * 0.5)
end

local function PlayerGui(v84) -- line 296 | captures: Players
    return (v84 or Players.LocalPlayer):FindFirstChild("PlayerGui")
end

v3.Optional.PlayerGui = PlayerGui

function v3.PlayerGui(v85) -- line 303 | captures: Players
    return (v85 or Players.LocalPlayer):WaitForChild("PlayerGui", (1/0))
end

function v3.Mouse(v86) -- line 310 | captures: Players
    return (v86 or Players.LocalPlayer):GetMouse()
end

local function Camera() -- line 317
    return workspace.CurrentCamera
end

v3.Camera = Camera

function v3.Name(v87) -- line 320 | captures: Players
    return (v87 or Players.LocalPlayer).Name
end

function v3.DisplayName(v88) -- line 327 | captures: Players
    return (v88 or Players.LocalPlayer).DisplayName
end

return v3
