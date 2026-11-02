-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local EggActionMovement = require(script.Parent.EggActionMovement)
local FrameStepper = require(ReplicatedStorage.Shared.Utils.FrameStepper)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1
v1.__class = "PlacedEggReadyPulse"

function v1.new(v2, v3, v4) -- line 14 | captures: t, v1
    t.strict(t.instanceIsA("Model"))(v2)
    t.strict(t.CFrame)(v3)
    t.strict(t.number)(v4)
    local v5 = {}
    local v6 = setmetatable(v5, v1)
    v6._model = v2
    v6._highlight = nil
    v6._basePivot = v3
    v6._baseScale = v4
    v6._animation = nil
    v6._destroyed = false
    return v6
end

local function _createHighlight(v7) -- line 30
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ReadyEggPulseHighlight"
    Highlight.Adornee = v7._model
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.Parent = v7._model
    v7._highlight = Highlight
    return Highlight
end

v1._createHighlight = _createHighlight

local function _destroyHighlight(v8) -- line 42
    local _highlight = v8._highlight
    if _highlight ~= nil then
        v8._highlight = nil
        _highlight:Destroy()
    end
end

v1._destroyHighlight = _destroyHighlight

function v1._resetVisual(v9) -- line 50 | captures: EggActionMovement
    local _model = v9._model
    if _model:IsDescendantOf(game) then
        _model:ScaleTo(v9._baseScale)
        EggActionMovement.SetPivot(_model, v9._basePivot)
    end
    v9:_destroyHighlight()
end

function v1.SetTransform(v10, v11, v12) -- line 58 | captures: t
    t.strict(t.CFrame)(v11)
    t.strict(t.number)(v12)
    v10._basePivot = v11
    v10._baseScale = v12
end

local function IsPlaying(v13) -- line 66
    local _animation = v13._animation
    if _animation == nil then
        return false
    end
    return (_animation:IsRunning())
end

v1.IsPlaying = IsPlaying

function v1.Play(v14) -- line 71 | captures: Ease, EggActionMovement, FrameStepper
    if not v14._destroyed and not v14:IsPlaying() and v14._model:IsDescendantOf(game) then
        v14:_resetVisual()
        local v15 = FrameStepper.OnRender(function(v16, v17) -- line 76 | captures: v14, Ease, EggActionMovement
            if v14._destroyed or not v14._model:IsDescendantOf(game) then
                return true
            end
            local v18 = math.clamp(v17, 0, 1) * 1.05
            local _model = v14._model
            local _basePivot = v14._basePivot
            local _baseScale = v14._baseScale
            if v18 < 0.25 then
                local v19 = v18 / 0.25
                local v20 = v19 * 3.141592653589793 * 2 * 3
                local v21 = math.sin(v20) * 0.05235987755982989 * (1 - Ease(v19, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
                _model:ScaleTo(_baseScale)
                EggActionMovement.SetPivot(_model, _basePivot * CFrame.Angles(0, 0, v21))
            else
                local v22 = v18 - 0.25
                if v22 >= 0.6 then
                    v14:_destroyHighlight()
                    local v23 = (v22 - 0.6) / 0.2
                    local v24 = math.clamp(v23, 0, 1)
                    _model:ScaleTo(_baseScale * (1.2 + -0.19999999999999996 * Ease(v24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
                    EggActionMovement.SetPivot(_model, _basePivot)
                    return v17 >= 1
                end
                local v25 = v22 / 0.6
                local v26 = Ease(v25, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
                local v27 = v25 * 3.141592653589793
                local v28 = math.sin(v27);
                (v14._highlight or v14:_createHighlight()).FillTransparency = 1 - v28 * 0.9
                _model:ScaleTo(_baseScale * (1 + 0.19999999999999996 * v26))
                EggActionMovement.SetPivot(_model, _basePivot)
            end
            return false
        end, 1.05, true)
        v14._animation = v15
        v15:OnComplete(function() -- line 115 | captures: v14, v15
            if v14._animation == v15 then
                v14._animation = nil
                if not v14._destroyed then
                    v14:_resetVisual()
                end
            end
        end)
        return true
    end
    return false
end

local function Cancel(v29) -- line 126
    local _animation = v29._animation
    if _animation == nil then
        return
    end
    v29._animation = nil
    _animation:Cancel()
    if not v29._destroyed then
        v29:_resetVisual()
    end
end

v1.Cancel = Cancel

local function Destroy(v30) -- line 137
    if v30._destroyed then
        return
    end
    v30:Cancel()
    v30._destroyed = true
    v30:_destroyHighlight()
end

v1.Destroy = Destroy
return v1
