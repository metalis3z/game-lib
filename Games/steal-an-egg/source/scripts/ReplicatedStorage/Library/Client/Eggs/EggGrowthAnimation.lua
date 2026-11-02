-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local EggActionMovement = require(script.Parent.EggActionMovement)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local t = {}

t.__index = t
t.__class = "EggGrowthAnimation"
function t.new(p1, p2, p3) --[[ new | Line: 37 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p1)
	Asserts.CFrame(p2)
	Asserts.number(p3)
	assert(p3 > 0, "Jump height multiplier must be positive")

	local v3 = setmetatable({}, t)

	v3._model = p1
	v3._basePivot = p2
	v3._jumpHeightMultiplier = p3
	v3._animation = nil
	v3._destroyed = false

	return v3
end
function t._resetVisual(p1) --[[ _resetVisual | Line: 57 | Upvalues: EggActionMovement (copy) ]]
	local _model = p1._model

	if not _model:IsDescendantOf(game) then
		return
	end

	EggActionMovement.SetPivot(_model, p1._basePivot)
end
function t.SetBasePivot(p1, p2) --[[ SetBasePivot | Line: 68 | Upvalues: Asserts (copy) ]]
	Asserts.CFrame(p2)
	p1._basePivot = p2

	if p1:IsPlaying() then
		return
	end

	p1:_resetVisual()
end
function t.IsPlaying(p1) --[[ IsPlaying | Line: 77 ]]
	local _animation = p1._animation

	return if _animation == nil then false else _animation:IsConnected()
end
function t.Play(p1) --[[ Play | Line: 82 | Upvalues: RenderStepped (copy), Easing (copy), EggActionMovement (copy) ]]
	if p1._destroyed or (p1:IsPlaying() or not p1._model:IsDescendantOf(game)) then
		return false
	end

	local v1 = RenderStepped(function(p12, p2) --[[ Line: 87 | Upvalues: p1 (copy), Easing (ref), EggActionMovement (ref) ]]
		if p1._destroyed or not p1._model:IsDescendantOf(game) then
			return true
		end

		local v1 = math.clamp(p2, 0, 1)
		local v2 = if v1 < 0.5 then Easing(v1 * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) else 1 - Easing((v1 - 0.5) * 2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
		local v3 = 1 - Easing(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v4 = math.sin(v1 * math.pi * 2 * 4) * math.rad(4) * v3

		EggActionMovement.SetPivot(p1._model, p1._basePivot * CFrame.new(0, 0.85 * p1._jumpHeightMultiplier * v2, 0) * CFrame.Angles(0, 0, v4))

		return p2 >= 1
	end, 0.55, true)

	p1._animation = v1
	v1:Then(function() --[[ Line: 108 | Upvalues: p1 (copy), v1 (copy) ]]
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
function t.Cancel(p1) --[[ Cancel | Line: 122 ]]
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
function t.Destroy(p1) --[[ Destroy | Line: 135 ]]
	if not p1._destroyed then
		p1:Cancel()
		p1._destroyed = true
	end
end

return t