-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    local TimeScale = v1.TimeScale
    if TimeScale <= 0 then
        return 0
    end
    local Rate = v1.Rate
    local EmitCount = v1:GetAttribute("EmitCount")
    if type(EmitCount) ~= "number" then
        EmitCount = Rate
    end
    local v2 = math.floor(EmitCount)
    local v3 = v2
    local v4 = EmitCount - v2
    if v4 > 0 and math.random() < v4 then
        v2 += 1
        v3 = v2
    end
    if v2 < 1 then
        return 0
    end
    local EmitDelay = v1:GetAttribute("EmitDelay")
    if type(EmitDelay) ~= "number" then
        EmitDelay = 0
    end
    if EmitDelay == (1/0) then
        return 0
    end
    local v5 = math.max(EmitDelay, 0)
    task.delay(v5, function() -- line 33 | captures: v3, v1
        v1:Emit(v3)
    end)
    return v5 + v1.Lifetime.Max / TimeScale
end
