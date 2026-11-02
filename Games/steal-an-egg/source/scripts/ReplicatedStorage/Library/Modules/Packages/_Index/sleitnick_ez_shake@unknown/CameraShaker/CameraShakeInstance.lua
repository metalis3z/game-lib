-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t

local v1 = Vector3.new
local noise = math.noise

t.CameraShakeState = {
	FadingIn = 0,
	FadingOut = 1,
	Sustained = 2,
	Inactive = 3
}
function t.new(p1, p2, p3, p4) --[[ new | Line: 37 | Upvalues: v1 (copy), t (copy) ]]
	local v12 = p3 or 0
	local v2 = p4 or 0

	assert(if type(p1) == "number" then true else false, "Magnitude must be a number")
	assert(if type(p2) == "number" then true else false, "Roughness must be a number")
	assert(if type(v12) == "number" then true else false, "FadeInTime must be a number")
	assert(if type(v2) == "number" then true else false, "FadeOutTime must be a number")

	local t2 = {
		DeleteOnInactive = true,
		roughMod = 1,
		magnMod = 1,
		_camShakeInstance = true,
		Magnitude = p1,
		Roughness = p2,
		PositionInfluence = v1(),
		RotationInfluence = v1(),
		fadeOutDuration = v2,
		fadeInDuration = v12
	}

	t2.sustain = v12 > 0
	t2.currentFadeTime = if v12 > 0 then 0 else 1
	t2.tick = Random.new():NextNumber(-100, 100)

	return setmetatable(t2, t)
end
function t.UpdateShake(p1, p2) --[[ UpdateShake | Line: 68 | Upvalues: noise (copy), v1 (copy) ]]
	local v12 = p1.tick
	local currentFadeTime = p1.currentFadeTime
	local v2 = v1(noise(v12, 0) * 0.5, noise(0, v12) * 0.5, noise(v12, v12) * 0.5)

	if p1.fadeInDuration > 0 and p1.sustain then
		if currentFadeTime < 1 then
			currentFadeTime = currentFadeTime + p2 / p1.fadeInDuration
		elseif p1.fadeOutDuration > 0 then
			p1.sustain = false
		end
	end

	if not p1.sustain then
		currentFadeTime = currentFadeTime - p2 / p1.fadeOutDuration
	end

	if p1.sustain then
		p1.tick = v12 + p2 * p1.Roughness * p1.roughMod
	else
		p1.tick = v12 + p2 * p1.Roughness * p1.roughMod * currentFadeTime
	end

	p1.currentFadeTime = currentFadeTime

	return v2 * p1.Magnitude * p1.magnMod * currentFadeTime
end
function t.StartFadeOut(p1, p2) --[[ StartFadeOut | Line: 97 ]]
	if p2 == 0 then
		p1.currentFadeTime = 0
	end

	p1.fadeOutDuration = p2
	p1.fadeInDuration = 0
	p1.sustain = false
end
function t.StartFadeIn(p1, p2) --[[ StartFadeIn | Line: 106 ]]
	if p2 == 0 then
		p1.currentFadeTime = 1
	end

	p1.fadeInDuration = if p2 then p2 else p1.fadeInDuration
	p1.fadeOutDuration = 0
	p1.sustain = true
end
function t.GetScaleRoughness(p1) --[[ GetScaleRoughness | Line: 115 ]]
	return p1.roughMod
end
function t.SetScaleRoughness(p1, p2) --[[ SetScaleRoughness | Line: 119 ]]
	p1.roughMod = p2
end
function t.GetScaleMagnitude(p1) --[[ GetScaleMagnitude | Line: 123 ]]
	return p1.magnMod
end
function t.SetScaleMagnitude(p1, p2) --[[ SetScaleMagnitude | Line: 127 ]]
	p1.magnMod = p2
end
function t.GetNormalizedFadeTime(p1) --[[ GetNormalizedFadeTime | Line: 131 ]]
	return p1.currentFadeTime
end
function t.IsShaking(p1) --[[ IsShaking | Line: 135 ]]
	return if p1.currentFadeTime > 0 then true else p1.sustain
end
function t.IsFadingOut(p1) --[[ IsFadingOut | Line: 139 ]]
	return not p1.sustain and p1.currentFadeTime > 0
end
function t.IsFadingIn(p1) --[[ IsFadingIn | Line: 143 ]]
	return if p1.currentFadeTime < 1 then p1.sustain and p1.fadeInDuration > 0 else false
end
function t.GetState(p1) --[[ GetState | Line: 147 | Upvalues: t (copy) ]]
	if p1:IsFadingIn() then
		return t.CameraShakeState.FadingIn
	end

	if p1:IsFadingOut() then
		return t.CameraShakeState.FadingOut
	end

	if p1:IsShaking() then
		return t.CameraShakeState.Sustained
	end

	return t.CameraShakeState.Inactive
end

return t