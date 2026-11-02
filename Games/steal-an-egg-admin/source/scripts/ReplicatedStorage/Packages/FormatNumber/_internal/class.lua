-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {}
local v3 = {}
local v4 = { __mode = "k" }
local v5 = setmetatable(v3, v4)

local function proxy_tostring(v6) -- line 11 | captures: v5
    return v5[v6].type_name .. ": " .. v5[v6].as_string
end

local v7 = {
    DEFAULT = 0,
    NUMBER_FORMATTER = 1,
    SYMBOLS = 2
}
local v8 = table.freeze(v7)

v1.ImmutabilityType = v8

function v1.create_init_function(v9, v10, v11, v12, v13) -- line 17 | captures: v2, v5, proxy_tostring, v8
    local v14
    if v12 then
        local v15 = table.clone(v12)
        local v16 = { __index = v11 }
        v14 = setmetatable(v15, v16)
    else
        v14 = v11
    end
    v2[v9] = v10 or "FormatNumberObject"
    return function(v17, v18) -- line 26 | captures: v14, v9, v13, v5, proxy_tostring, v8
        local v19 = newproxy(true)
        local v20 = getmetatable(v19)
        if v13 ~= v8.SYMBOLS and type(v17) == "table" then
            table.freeze(v17)
        end
        v20.data = v17
        v20.resolved_data = nil
        v20.type_name = v9
        if v18 then
            v20.as_string = v18
        else
            local v21 = tostring(v19)
            v20.as_string = string.sub(v21, 11)
        end
        v20.__index = v14
        v20.__tostring = proxy_tostring
        v20.__metatable = "The metatable is locked"
        if v13 ~= v8.NUMBER_FORMATTER then
            table.freeze(v20)
        end
        v5[v19] = v20
        return v19
    end
end

function v1.is_a(v22, v23) -- line 51 | captures: v2, v5
    local v24 = v5[v22]
    local v25 = v24 and v24.type_name
    if v25 == v23 then
        return true
    end
    local v26
    if v25 then
        while true do
            v25 = v2[v25]
            local v27 = v25 == v23
            if v25 then
                if v27 then
                    v26 = v27
                    break
                end
                continue
            end
            v26 = v27
            break
        end
    else
        v26 = false
    end
    return v26
end

function v1.get_data(v28) -- line 73 | captures: v5
    return v5[v28].data
end

function v1.get_resolved_data(v29, v30) -- line 76 | captures: v5
    local v31 = v5[v29]
    local resolved_data = v31.resolved_data
    if not resolved_data then
        resolved_data = v30(v31.data)
        v31.resolved_data = resolved_data
        if resolved_data then
            table.freeze(v31)
        end
    end
    return resolved_data
end

function v1.try_coerce(v32, v33, v34, v35) -- line 88 | captures: v1, v5
    local v36, v37, v38
    if v33 == nil then
        if v35 == nil then
            v37 = false
        else
            v38 = v34
            v37 = true
            v36 = v35
        end
    elseif v34 == "string" then
        if type(v33) == "string" then
            v38 = v34
            v37 = true
            v36 = v33
        elseif type(v33) == "number" then
            v38, v37, v36 = v34, true, tostring(v33)
        else
            v38 = v34
            v37 = false
        end
    elseif v34 == "number" then
        v36 = tonumber(v33)
        if v36 then
            v38 = v34
            v37 = true
        else
            v38 = v34 .. " object"
            v37 = false
        end
    elseif string.sub(v34, 1, 1) == "{" then
        local v39 = string.sub(v34, 2, -2)
        if type(v33) == "table" then
            local v40 = rawlen(v33)
            v36 = table.move(v33, 1, v40, 1, table.create((rawlen(v33))))
            for v41, v42 in v36 do
                if type(v42) ~= v39 then
                    local v43 = string.format("Values inside the table argument must be a %s, index %d got %s", v39, v41, (type(v42)))
                    error(v43, 3)
                end
            end
            v38 = v34
            v37 = true
        else
            v38 = "table"
            v37 = false
        end
    elseif v1.is_a(v33, v34) then
        v38, v37, v36 = v34, true, v5[v33].data
    else
        v38 = v34
        v37 = false
    end
    if not v37 then
        local v44 = string.format("Argument #%d provided must be a %s", v32, v38)
        error(v44, 3)
    end
    return v36
end

function v1.try_coerce_range(v45, v46, v47, v48, v49) -- line 153 | captures: v1
    local v50
    if v46 == nil then
        v50 = v49
    else
        local v51 = tonumber(v46)
        if v51 then
            v50 = v1.double_to_int32(v51)
            if not (v47 <= v50 and v50 <= v48) then
                v50 = nil
            end
        end
    end
    if not v50 then
        local v52 = string.format("Argument #%d provided must be an integer that is in the range of %d to (and including) %d", v45, v47, v48)
        v50 = error(v52, 3)
    end
    return v50
end

function v1.try_coerce_enum(v53, v54, v55, v56) -- line 174 | captures: v1
    local v57
    if v54 == nil then
        v57 = v56
    elseif tonumber(v54) then
        for v58, v59 in v55 do
            if v1.double_to_int32(v54) == v59 then
                v57 = v59
                break
            end
            v57 = nil
        end
    end
    if not v57 then
        local v60 = string.format("Argument #%d provided is out of range", v53)
        v57 = error(v60, 3)
    end
    return v57
end

local function double_to_int32(v61) -- line 197
    if v61 <= -2147483649 or v61 >= 2147483648 then
        return UDim.new(nil, v61).Offset
    end
    if v61 <= -1 then
        return (math.ceil(v61))
    end
    if v61 >= 1 then
        return (math.floor(v61))
    end
    return 0
end

v1.double_to_int32 = double_to_int32
return table.freeze(v1)
