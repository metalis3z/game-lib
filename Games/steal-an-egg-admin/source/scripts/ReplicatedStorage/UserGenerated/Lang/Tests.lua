-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify)
local DeepEquals = require(game.ReplicatedStorage.UserGenerated.Collections.DeepEquals)

local function StripErrorSource(v1) -- line 8
    local v2 = tostring(v1)
    local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
    return v3 and v4 or v2
end

local function ToString(v5) -- line 17 | captures: Stringify
    return Stringify.Pretty(v5, {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    })
end

local v6 = {
    IsEqual = function(v7, v8) -- IsEqual | line 21
        if rawequal(v7, v8) then
            return true
        end
        if type(v7) == "table" then
            if type(v8) == "table" or v7 == v7 then
                return false
            end
        elseif v7 == v7 then
            return false
        end
        return v8 ~= v8
    end,
    ErrorUnsafe = function(v9, v10, ...) -- ErrorUnsafe | line 42
        local v11
        local v12 = table.pack(xpcall(v10, function(v13) -- line 44 | captures: v11
            v11 = v13
        end, ...))
        if v12[1] then
            error("ExpectedError", 2)
        end
        if v11 ~= v9 then
            local format = string.format
            local v14 = v11
            local v15 = ("ExpectedError Mismatch: %*"):format((format("%q", (tostring(v14)))))
            error(v15, 2)
        end
        return table.unpack(v12, 2)
    end
}

function v6.Error(v16, v17, ...) -- line 56 | captures: Stringify
    local v18
    local v19 = table.pack(xpcall(v17, function(v20) -- line 59 | captures: v18
        v18 = v20
    end, ...))
    if v19[1] then
        local v21 = {
            Pretty = false,
            IndentChar = "",
            IndentSize = 0
        }
        local v22 = ("ExpectedError(%*)"):format((Stringify.Pretty(v16, v21)))
        error(v22, 2)
    end
    local v23 = v18
    if type(v23) == "string" then
        local v24 = v18
        local v25 = tostring(v24)
        local v26, v27 = string.match(v25, "^(.*:%d+): (.+)$")
        v18 = v26 and v27 or v25
    end
    if v16 ~= v18 then
        local v28 = Stringify.Pretty(v16, {
            Pretty = false,
            IndentChar = "",
            IndentSize = 0
        })
        local v29 = {
            Pretty = false,
            IndentChar = "",
            IndentSize = 0
        }
        local v30 = ("ExpectedError(%*): %*"):format(v28, (Stringify.Pretty(v18, v29)))
        error(v30, 2)
    end
    return table.unpack(v19, 2)
end

function v6.Equal(v31, v32) -- line 85 | captures: Stringify
    local v33
    if rawequal(v31, v32) then
        v33 = true
    elseif type(v31) == "table" then
        if type(v32) == "table" then
            v33 = false
        end
    elseif v31 == v31 then
        v33 = false
    else
        v33 = v32 ~= v32
    end
    if v33 then
        return
    end
    local v34 = {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    }
    local v35 = ("Equal(%*, %*)"):format(Stringify.Pretty(v31, {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    }), (Stringify.Pretty(v32, v34)))
    error(v35, 2)
end

function v6.DeepEqual(v36, v37) -- line 105 | captures: Stringify, DeepEquals
    if DeepEquals(v36, v37) then
        return
    end
    local v38 = {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    }
    local v39 = ("DeepEqual(%*, %*)"):format(Stringify.Pretty(v36, {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    }), (Stringify.Pretty(v37, v38)))
    error(v39, 2)
end

function v6.FuzzyEqual(v40, v41, v42) -- line 113
    local v43
    if not v42 then
        local v44 = v40 - v41
        v43 = math.abs(v44) > 0.001
    end
    if not (v42 or v43) then
        return
    end
    local v45 = tostring(v40)
    local v46 = tostring(v41)
    local v47 = v40 - v41
    local v48 = ("FuzzyEqual(%*, %*): %*"):format(v45, v46, (math.abs(v47)))
    error(v48, 2)
end

function v6.ColorEqual(v49, v50, v51) -- line 121 | captures: Stringify
    local R = v49.R
    local G = v49.G
    local B = v49.B
    local v52 = Vector3.new(R, G, B) * 255
    local v53
    if not v51 then
        local R = v50.R
        local G = v50.G
        local B = v50.B
        v53 = (Vector3.new(R, G, B) * 255 - v52).Magnitude > 0.001
    end
    if not (v51 or v53) then
        return
    end
    local v54 = {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    }
    local v55 = ("ColorEqual(%*, %*)"):format(Stringify.Pretty(v49, {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    }), (Stringify.Pretty(v50, v54)))
    error(v55, 2)
end

return table.freeze(v6)
