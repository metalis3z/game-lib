-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    RefreshSeconds = 60,
    RetryBackoffSeconds = 30,
    TimerUpdateSeconds = 1,
    PromptDistance = 12,
    ToUnix = function(v2) -- ToUnix | line 11
        if type(v2) == "table" then
            local v3, v4 = pcall(function() -- line 16 | captures: v2
                return DateTime.fromUniversalTime(v2.Year, v2.Month, v2.Day, v2.Hour, v2.Minute, v2.Second, v2.Millisecond or 0)
            end)
            if v3 and v4 then
                return v4.UnixTimestamp
            end
        end
        return nil
    end
}

function v1.IsEligible(v5, v6) -- line 28 | captures: v1
    if type(v5) == "table" then
        local Id = v5.Id
        if type(Id) == "string" and v5.Id ~= "" and v5.Status == Enum.ExperienceEventStatus.Active and v5.HasStarted ~= true and v5.HasEnded ~= true then
            local v7 = v1.ToUnix(v5.StartTime)
            if v7 == nil then
                return false
            end
            return v6 < v7
        end
    end
    return false
end

function v1.Pick(v8, v9) -- line 36 | captures: v1
    if type(v8) == "table" then
        local v10
        for v11, v12 in v8 do
            if v1.IsEligible(v12, v9) then
                local v13 = v1.ToUnix(v12.StartTime)
                if v10 == nil then
                    v10 = { Id = v12.Id }
                    local Title = v12.Title
                    if type(Title) == "string" then
                        v10.Title = v12.Title
                    else
                        v10.Title = ""
                    end
                    v10.StartsAt = v13
                    v10.Going = v12.UserRsvpStatus == Enum.RsvpStatus.Going
                elseif v10.StartsAt <= v13 then
                end
            end
        end
        return v10
    end
    return nil
end

local function ShouldShow(v14) -- line 67
    if v14 == nil then
        return false
    end
    return not v14.Going
end

v1.ShouldShow = ShouldShow

local function Countdown(v15) -- line 71
    local v16 = math.floor(v15)
    local v17 = math.max(0, v16)
    local v18 = v17 // 86400
    local v19 = v17 % 86400 // 3600
    local v20 = v17 % 3600 // 60
    local v21 = v17 % 60
    if v18 > 0 then
        return string.format("%dd %dh %dm", v18, v19, v20)
    end
    if v19 > 0 then
        return string.format("%dh %dm %ds", v19, v20, v21)
    end
    return string.format("%dm %ds", v20, v21)
end

v1.Countdown = Countdown
return table.freeze(v1)
