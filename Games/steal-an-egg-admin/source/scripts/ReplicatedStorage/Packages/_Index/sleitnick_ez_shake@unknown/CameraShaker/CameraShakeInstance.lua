-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

v1.__index = v1

local new = Vector3.new
local noise = math.noise

v1.CameraShakeState = {
    FadingIn = 0,
    FadingOut = 1,
    Sustained = 2,
    Inactive = 3
}

function v1.new(v2, v3, v4, v5) -- line 12 | captures: v1, new
    local v6 = v4 or 0
    local v7 = v5 or 0
    local v8 = type(v2) == "number"
    assert(v8, "Magnitude must be a number")
    local v9 = type(v3) == "number"
    assert(v9, "Roughness must be a number")
    local v10 = type(v6) == "number"
    assert(v10, "FadeInTime must be a number")
    local v11 = type(v7) == "number"
    assert(v11, "FadeOutTime must be a number")
    local v12 = {
        DeleteOnInactive = true,
        roughMod = 1,
        magnMod = 1,
        _camShakeInstance = true,
        Magnitude = v2,
        Roughness = v3,
        PositionInfluence = new(),
        RotationInfluence = new(),
        fadeOutDuration = v7,
        fadeInDuration = v6
    }
    v12.sustain = v6 > 0
    if v6 <= 0 then
        v12.currentFadeTime = 1
    else
        v12.currentFadeTime = 0
    end
    v12.tick = Random.new():NextNumber(-100, 100)
    return (setmetatable(v12, v1))
end

function v1.UpdateShake(v13, v14) -- line 46 | captures: new, noise
    local tick = v13.tick
    local currentFadeTime = v13.currentFadeTime
    local v15 = noise(tick, 0) * 0.5
    local v16 = noise(0, tick) * 0.5
    local v17 = noise(tick, tick) * 0.5
    local v18 = new(v15, v16, v17)
    if v13.fadeInDuration > 0 and v13.sustain then
        if currentFadeTime < 1 then
            currentFadeTime += v14 / v13.fadeInDuration
        elseif v13.fadeOutDuration > 0 then
            v13.sustain = false
        end
    end
    if not v13.sustain then
        currentFadeTime -= v14 / v13.fadeOutDuration
    end
    if v13.sustain then
        v13.tick = tick + v14 * v13.Roughness * v13.roughMod
    else
        v13.tick = tick + v14 * v13.Roughness * v13.roughMod * currentFadeTime
    end
    v13.currentFadeTime = currentFadeTime
    return v18 * v13.Magnitude * v13.magnMod * currentFadeTime
end

local function StartFadeOut(v19, v20) -- line 70
    if v20 == 0 then
        v19.currentFadeTime = 0
    end
    v19.fadeOutDuration = v20
    v19.fadeInDuration = 0
    v19.sustain = false
end

v1.StartFadeOut = StartFadeOut

local function StartFadeIn(v21, v22) -- line 78
    if v22 == 0 then
        v21.currentFadeTime = 1
    end
    v21.fadeInDuration = v22 or v21.fadeInDuration
    v21.fadeOutDuration = 0
    v21.sustain = true
end

v1.StartFadeIn = StartFadeIn

local function GetScaleRoughness(v23) -- line 90
    return v23.roughMod
end

v1.GetScaleRoughness = GetScaleRoughness

local function SetScaleRoughness(v24, v25) -- line 93
    v24.roughMod = v25
end

v1.SetScaleRoughness = SetScaleRoughness

local function GetScaleMagnitude(v26) -- line 96
    return v26.magnMod
end

v1.GetScaleMagnitude = GetScaleMagnitude

local function SetScaleMagnitude(v27, v28) -- line 99
    v27.magnMod = v28
end

v1.SetScaleMagnitude = SetScaleMagnitude

local function GetNormalizedFadeTime(v29) -- line 102
    return v29.currentFadeTime
end

v1.GetNormalizedFadeTime = GetNormalizedFadeTime

local function IsShaking(v30) -- line 105
    if v30.currentFadeTime <= 0 then
        return v30.sustain
    end
    return true
end

v1.IsShaking = IsShaking

local function IsFadingOut(v31) -- line 110
    return not v31.sustain and v31.currentFadeTime > 0
end

v1.IsFadingOut = IsFadingOut

local function IsFadingIn(v32) -- line 117
    if v32.currentFadeTime < 1 then
        return v32.sustain and v32.fadeInDuration > 0
    end
    return false
end

v1.IsFadingIn = IsFadingIn

function v1.GetState(v33) -- line 127 | captures: v1
    if v33:IsFadingIn() then
        return v1.CameraShakeState.FadingIn
    end
    if v33:IsFadingOut() then
        return v1.CameraShakeState.FadingOut
    end
    if v33:IsShaking() then
        return v1.CameraShakeState.Sustained
    end
    return v1.CameraShakeState.Inactive
end

return v1
