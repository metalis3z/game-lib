-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")

local function getTweenRatio(v1, v2) -- line 13 | captures: TweenService
    local DelayTime = v1.DelayTime
    local Time = v1.Time
    local Reverses = v1.Reverses
    local v3 = 1 + v1.RepeatCount
    local EasingStyle = v1.EasingStyle
    local EasingDirection = v1.EasingDirection
    local v4 = DelayTime + Time
    if Reverses then
        v4 += Time
    end
    if v2 == (1/0) then
        return 1
    end
    if v4 * v3 <= v2 and v1.RepeatCount > -1 then
        return 1
    end
    local v5 = v2 % v4
    if v5 <= DelayTime then
        return 0
    end
    local v6 = (v5 - DelayTime) / Time
    if v6 > 1 then
        v6 = 2 - v6
    end
    return (TweenService:GetValue(v6, EasingStyle, EasingDirection))
end

return getTweenRatio
