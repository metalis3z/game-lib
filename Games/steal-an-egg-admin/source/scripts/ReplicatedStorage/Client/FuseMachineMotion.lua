-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EmitTree = require(ReplicatedStorage.Shared.Utils.VFX).EmitTree
local Interpolation = require(ReplicatedStorage.Shared.Utils.Interpolation)
local OnRender = require(ReplicatedStorage.Shared.Utils.FrameStepper).OnRender
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    {
        Seconds = 0.22,
        Rise = 2.6,
        Squash = 0.92,
        Stretch = 1.12,
        Pitch = -6,
        Roll = 5
    },
    {
        Seconds = 0.18,
        Rise = 1.65,
        Squash = 0.96,
        Stretch = 1.08,
        Pitch = 4,
        Roll = -3
    },
    {
        Seconds = 0.15,
        Rise = 0.9,
        Squash = 0.985,
        Stretch = 1.04,
        Pitch = -2,
        Roll = 1.5
    }
}
local v2 = {}
local EasingStyle = Enum.EasingStyle
local EasingDirection = Enum.EasingDirection

local function backOut(v3) -- line 40 | captures: Interpolation, EasingStyle, EasingDirection
    return Interpolation.Ease(v3, EasingStyle.Back, EasingDirection.Out)
end

local function bounceOut(v4) -- line 43 | captures: Interpolation, EasingStyle, EasingDirection
    return Interpolation.Ease(v4, EasingStyle.Bounce, EasingDirection.Out)
end

local function quadIn(v5) -- line 46 | captures: Interpolation, EasingStyle, EasingDirection
    return Interpolation.Ease(v5, EasingStyle.Quad, EasingDirection.In)
end

local function locateEmitter(v6, v7) -- line 49
    return v7:FindFirstChild("EmitFuse") or v6:FindFirstChild("EmitFuse")
end

local function poseAt(v8, v9, v10) -- line 56 | captures: Interpolation, EasingStyle, EasingDirection
    if v9 < 0.34 then
        local v11 = v9 / 0.34
        local v12 = math.min(v11, 1)
        local v13 = Interpolation.Ease(v12, EasingStyle.Back, EasingDirection.Out)
        return v8.Rise * v13, v8.Pitch * v13, v8.Roll * v13, v10 + (v8.Stretch - v10) * v13
    end
    local v14 = v9 - 0.34
    local v15 = math.max(v14, 0) / 0.66
    local v16 = 1 - Interpolation.Ease(v15, EasingStyle.Bounce, EasingDirection.Out)
    local v17 = if v15 >= 0.55 then v8.Squash + (v10 - v8.Squash) * Interpolation.Ease((v15 - 0.55) / 0.45, EasingStyle.Bounce, EasingDirection.Out) else v8.Stretch + (v8.Squash - v8.Stretch) * Interpolation.Ease(v15 / 0.55, EasingStyle.Quad, EasingDirection.In)
    return v8.Rise * v16, v8.Pitch * v16, v8.Roll * v16, v17
end

function v2.Bounce(v18, v19) -- line 72 | captures: OnRender, t, v1, poseAt
    local v20 = {}
    t.strict(t.instanceIsA("Model"))(v18)
    t.strict(t.callback)(v19)
    local v21 = v18:GetPivot()
    local v22 = v18:GetScale()
    for v23, v24 in ipairs(v1) do
        v20[1] = false
        local v25 = v24
        OnRender((function(v26)
            return function(v27, v28) -- line 81 | captures: v26, v18, v19, v21, v22, v25, poseAt
                if v19() then
                    local v29, v30, v31, v32 = poseAt(v25, v28, v22)
                    v18:ScaleTo(v32)
                    local v33 = v21 * CFrame.new(0, v29, 0)
                    local v34 = math.rad(v30)
                    v18:PivotTo(v33 * CFrame.Angles(v34, 0, (math.rad(v31))))
                    return false
                end
                v18:PivotTo(v21)
                v18:ScaleTo(v22)
                v26[1] = true
                return true
            end
        end)(v20), v24.Seconds, true):Wait()
        v18:ScaleTo(v22)
        v18:PivotTo(v21)
        if v20[1] then
            return false
        end
        local v35 = v20[1]
        local v36 = {}
        v36[1] = v35
        v20 = v36
    end
    return true
end

function v2.Burst(v37, v38) -- line 104 | captures: EmitTree, t
    t.strict(t.instanceIsA("Model"))(v37)
    t.strict(t.instanceIsA("BasePart"))(v38)
    local v39 = v38:FindFirstChild("EmitFuse") or v37:FindFirstChild("EmitFuse")
    if v39 ~= nil then
        EmitTree(v39)
    end
end

function v2.Run(v40, v41, v42) -- line 117 | captures: t, v2
    t.strict(t.instanceIsA("Model"))(v40)
    t.strict(t.instanceIsA("BasePart"))(v41)
    t.strict(t.callback)(v42)
    local v43 = v2.Bounce(v40, v42)
    if v43 then
        v2.Burst(v40, v41)
    end
    return v43
end

return v2
