-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local EggActionMovement = require(script.Parent.EggActionMovement)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local t = {}

t.__index = t
t.__class = "PlacedEggReadyPulse"
function t.new(p1, p2, p3) --[[ new | Line: 42 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p1)
	Asserts.CFrame(p2)
	Asserts.number(p3)

	local v2 = setmetatable({}, t)

	v2._model = p1
	v2._highlight = nil
	v2._basePivot = p2
	v2._baseScale = p3
	v2._animation = nil
	v2._destroyed = false

	return v2
end
function t._createHighlight(p1) --[[ _createHighlight | Line: 62 ]]
	local ReadyEggPulseHighlight = Instance.new("Highlight")

	ReadyEggPulseHighlight.Name = "ReadyEggPulseHighlight"
	ReadyEggPulseHighlight.Adornee = p1._model
	ReadyEggPulseHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
	ReadyEggPulseHighlight.FillColor = Color3.new(255/255, 255/255, 255/255)
	ReadyEggPulseHighlight.FillTransparency = 1
	ReadyEggPulseHighlight.OutlineTransparency = 1
	ReadyEggPulseHighlight.Parent = p1._model
	p1._highlight = ReadyEggPulseHighlight

	return ReadyEggPulseHighlight
end
function t._destroyHighlight(p1) --[[ _destroyHighlight | Line: 76 ]]
	local _highlight = p1._highlight

	if _highlight ~= nil then
		p1._highlight = nil
		_highlight:Destroy()
	end
end
function t._resetVisual(p1) --[[ _resetVisual | Line: 86 | Upvalues: EggActionMovement (copy) ]]
	local _model = p1._model

	if _model:IsDescendantOf(game) then
		_model:ScaleTo(p1._baseScale)
		EggActionMovement.SetPivot(_model, p1._basePivot)
	end

	p1:_destroyHighlight()
end
function t.SetTransform(p1, p2, p3) --[[ SetTransform | Line: 100 | Upvalues: Asserts (copy) ]]
	Asserts.CFrame(p2)
	Asserts.number(p3)
	p1._basePivot = p2
	p1._baseScale = p3
end
function t.IsPlaying(p1) --[[ IsPlaying | Line: 108 ]]
	local _animation = p1._animation

	return if _animation == nil then false else _animation:IsConnected()
end
function t.Play(p1) --[[ Play | Line: 113 | Upvalues: RenderStepped (copy), Easing (copy), EggActionMovement (copy) ]]
	if p1._destroyed or (p1:IsPlaying() or not p1._model:IsDescendantOf(game)) then
		return false
	end

	p1:_resetVisual()

	local v1 = RenderStepped(function(p12, p2) --[[ Line: 120 | Upvalues: p1 (copy), Easing (ref), EggActionMovement (ref) ]]
		if p1._destroyed or not p1._model:IsDescendantOf(game) then
			return true
		end

		local v1 = math.clamp(p2, 0, 1) * 1.05
		local _model = p1._model
		local _basePivot = p1._basePivot
		local _baseScale = p1._baseScale

		if v1 < 0.25 then
			local v2 = v1 / 0.25
			local v3 = 1 - Easing(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local v4 = math.sin(v2 * math.pi * 2 * 3) * 0.05235987755982989 * v3

			_model:ScaleTo(_baseScale)
			EggActionMovement.SetPivot(_model, _basePivot * CFrame.Angles(0, 0, v4))

			return false
		end

		local v5 = v1 - 0.25

		if v5 < 0.6 then
			local v6 = v5 / 0.6
			local v7 = Easing(v6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
			local v8 = math.sin(v6 * math.pi);

			(p1._highlight or p1:_createHighlight()).FillTransparency = 1 - v8 * 0.9
			_model:ScaleTo(_baseScale * (1 + 0.19999999999999996 * v7))
			EggActionMovement.SetPivot(_model, _basePivot)

			return false
		end

		p1:_destroyHighlight()
		_model:ScaleTo(_baseScale * (1.2 + -0.19999999999999996 * Easing(math.clamp((v5 - 0.6) / 0.2, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
		EggActionMovement.SetPivot(_model, _basePivot)

		return p2 >= 1
	end, 1.05, true)

	p1._animation = v1
	v1:Then(function() --[[ Line: 165 | Upvalues: p1 (copy), v1 (copy) ]]
		if p1._animation ~= v1 then
			return
		end

		p1._animation = nil

		if p1._destroyed then
			return
		end

		p1:_resetVisual()
	end)

	return true
end
function t.Cancel(p1) --[[ Cancel | Line: 179 ]]
	local _animation = p1._animation

	if _animation == nil then
		return
	end

	p1._animation = nil
	_animation:Disconnect()

	if p1._destroyed then
		return
	end

	p1:_resetVisual()
end
function t.Destroy(p1) --[[ Destroy | Line: 192 ]]
	if not p1._destroyed then
		p1:Cancel()
		p1._destroyed = true
		p1:_destroyHighlight()
	end
end

return t