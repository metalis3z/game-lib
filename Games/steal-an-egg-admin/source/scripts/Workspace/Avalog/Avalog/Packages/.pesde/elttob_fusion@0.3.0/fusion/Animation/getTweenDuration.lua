-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("TweenService")

local function getTweenDuration(v1) -- line 13
    if v1.RepeatCount <= -1 then
        return (1/0)
    end
    local v2 = v1.DelayTime + v1.Time
    if v1.Reverses then
        v2 += v1.Time
    end
    return v2 * (v1.RepeatCount + 1)
end

return getTweenDuration
