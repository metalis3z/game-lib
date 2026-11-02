-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString)
return function(v1) -- line 8 | captures: TrimmedNumberString
    local v2
    if type(v1) == "string" then
        v2 = v1
    else
        v2 = TrimmedNumberString(v1)
    end
    local v3, v4, v5 = string.match(v2, "^(.-)([0-9,]+)(.*)$")
    if v4 then
        local v6 = {}
        if v3 then
            table.insert(v6, v3)
        end
        local v7 = string.gsub(v4, ",", "")
        local v8 = #v7 % 3
        local v9
        if v8 > 0 then
            local v10 = 1 + v8 - 1
            local v11 = string.sub(v7, 1, v10)
            table.insert(v6, v11)
            v9 = 1 + v8
        else
            v9 = 1
        end
        while true do
            if v9 <= #v7 then
                if v9 > 1 then
                    table.insert(v6, ",")
                end
            else
                break
            end
            local v12 = v9 + 2
            local v13 = string.sub(v7, v9, v12)
            table.insert(v6, v13)
            v9 += 3
        end
        if v5 then
            table.insert(v6, v5)
        end
        return table.concat(v6)
    end
    return v2
end
