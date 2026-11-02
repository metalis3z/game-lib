-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)

local function whichScopeLivesLonger(v1, v2) -- line 15
    local v3 = {}
    local v4, v5, v6, v7 = { v1, v2 }, {}, 2, 0
    while true do
        if v6 > 0 then
            v6 = v7
            for v8, v9 in v4 do
                v3[v9] = true
                local v10 = v6
                for v11, v12 in ipairs(v9) do
                    if v12 == v1 then
                        return "definitely-b"
                    end
                    if v12 == v2 then
                        return "definitely-a"
                    end
                    if typeof(v12) == "table" and v12[1] ~= nil and v3[v9] == nil then
                        v10 += 1
                        v5[v10] = v12
                    end
                    v6 = v10
                end
            end
            table.clear(v4)
            v4, v5, v7 = v5, v4, 0
            continue
        end
        return "unsure"
    end
end

local function whichLivesLonger(v13, v14, v15, v16) -- line 51 | captures: External, whichScopeLivesLonger
    if External.isTimeCritical() then
        return "unsure"
    end
    if v13 == v15 then
        local v17 = #v13
        for v18 = v17, 1, -1 do
            local v19 = v13[v18]
            if v19 == v14 then
                return "definitely-b"
            end
            if v19 == v16 then
                return "definitely-a"
            end
        end
        return "unsure"
    end
    return (whichScopeLivesLonger(v13, v15))
end

return whichLivesLonger
