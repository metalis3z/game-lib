-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local EggActionMovement = require(script.Parent.EggActionMovement)
local FrameStepper = require(ReplicatedStorage.Shared.Utils.FrameStepper)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1
v1.__class = "EggGrowthAnimation"

function v1.new(v2, v3, v4) -- line 14 | captures: t, v1
    t.strict(t.instanceIsA("Model"))(v2)
    t.strict(t.CFrame)(v3)
    t.strict(t.number)(v4)
    local v5 = v4 > 0
    assert(v5, "Jump height multiplier must be positive")
    local v6 = {}
    local v7 = setmetatable(v6, v1)
    v7._model = v2
    v7._basePivot = v3
    v7._jumpHeightMultiplier = v4
    v7._animation = nil
    v7._destroyed = false
    return v7
end

function v1._resetVisual(v8) -- line 31 | captures: EggActionMovement
    local _model = v8._model
    if _model:IsDescendantOf(game) then
        EggActionMovement.SetPivot(_model, v8._basePivot)
    end
end

function v1.SetBasePivot(v9, v10) -- line 37 | captures: t
    t.strict(t.CFrame)(v10)
    v9._basePivot = v10
    if not v9:IsPlaying() then
        v9:_resetVisual()
    end
end

local function IsPlaying(v11) -- line 45
    local _animation = v11._animation
    if _animation == nil then
        return false
    end
    return (_animation:IsRunning())
end

v1.IsPlaying = IsPlaying

function v1.Play(v12) -- line 50 | captures: Ease, EggActionMovement, FrameStepper
    if not v12._destroyed and not v12:IsPlaying() and v12._model:IsDescendantOf(game) then
        local v13 = FrameStepper.OnRender(function(v14, v15) -- line 54 | captures: v12, Ease, EggActionMovement
            local v16, v17, v18
            if v12._destroyed then
                v18 = true
            elseif v12._model:IsDescendantOf(game) then
                v16 = math.clamp(v15, 0, 1)
                if v16 >= 0.5 then
                    v17 = 1 - Ease((v16 - 0.5) * 2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
                else
                    v17 = Ease(v16 * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                end
                v18 = false
            else
                v18 = true
            end
            if v18 then
                return true
            end
            local v19 = v16 * 3.141592653589793 * 2 * 4
            local v20 = math.sin(v19) * 0.06981317007977318 * (1 - Ease(v16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
            local v21 = v12._basePivot * CFrame.new(0, 0.85 * v12._jumpHeightMultiplier * v17, 0)
            EggActionMovement.SetPivot(v12._model, v21 * CFrame.Angles(0, 0, v20))
            return v15 >= 1
        end, 0.55, true)
        v12._animation = v13
        v13:OnComplete(function() -- line 72 | captures: v12, v13
            if v12._animation == v13 then
                v12._animation = nil
                if not v12._destroyed then
                    v12:_resetVisual()
                end
            end
        end)
        return true
    end
    return false
end

local function Cancel(v22) -- line 83
    local _animation = v22._animation
    if _animation == nil then
        return
    end
    v22._animation = nil
    _animation:Cancel()
    if not v22._destroyed then
        v22:_resetVisual()
    end
end

v1.Cancel = Cancel

local function Destroy(v23) -- line 94
    if not v23._destroyed then
        v23:Cancel()
        v23._destroyed = true
    end
end

v1.Destroy = Destroy
return v1
