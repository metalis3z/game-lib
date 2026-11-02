-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Timecode = function(v2) -- Timecode | line 7
        local v3 = type(v2) == "number"
        assert(v3, "seconds must be a number")
        if v2 == v2 then
            if v2 == (1/0) then
                return "inf"
            end
            local v4 = math.max(0, v2)
            local v5 = math.ceil(v4)
            local v6 = v5 // 86400
            local v7 = v5 % 86400
            local v8 = v7 // 3600
            local v9 = v7 % 3600
            local v10 = v9 // 60
            local v11 = v9 % 60
            if v6 > 0 then
                return string.format("%d:%02d:%02d:%02d", v6, v8, v10, v11)
            end
            if v8 > 0 then
                return string.format("%d:%02d:%02d", v8, v10, v11)
            end
            if v10 > 0 then
                return string.format("%d:%02d", v10, v11)
            end
            return (("%*s"):format(v11))
        end
        return "nan"
    end
}

function v1.Elapsed(v12) -- line 35 | captures: v1
    local v13 = type(v12) == "number"
    assert(v13, "seconds must be a number")
    if v12 == v12 then
        if v12 == (1/0) then
            return "inf"
        end
        local v14 = math.max(0, v12)
        local v15 = math.ceil(v14)
        if v15 < 60 then
            return v1.Timecode(v15)
        end
        if v15 < 3600 then
            local v16 = v15 // 60
            local v17 = v15 % 60
            if v17 == 0 then
                return (("%*m"):format(v16))
            end
            return (("%*m %*s"):format(v16, v17))
        end
        if v15 < 86400 then
            local v18 = v15 // 3600
            local v19 = v15 % 3600 // 60
            if v19 == 0 then
                return (("%*h"):format(v18))
            end
            return (("%*h %*m"):format(v18, v19))
        end
        local v20 = v15 // 86400
        local v21 = v15 % 86400 // 3600
        if v21 == 0 then
            return (("%*d"):format(v20))
        end
        return (("%*d %*h"):format(v20, v21))
    end
    return "nan"
end

return table.freeze(v1)
