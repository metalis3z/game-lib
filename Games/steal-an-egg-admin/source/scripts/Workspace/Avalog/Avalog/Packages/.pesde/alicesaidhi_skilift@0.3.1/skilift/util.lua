-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function clone(v1) -- line 1 | captures: clone
    if type(v1) == "table" then
        local v2 = table.clone(v1)
        for v3, v4 in v2 do
            if typeof(v3) == "table" or typeof(v4) == "table" then
                v2[clone(v3)] = clone(v4)
            end
        end
        return v2
    end
    return v1
end

local function deep_freeze(v5) -- line 17 | captures: deep_freeze
    if type(v5) == "table" then
        if not table.isfrozen(v5) then
            table.freeze(v5)
        end
        for v6, v7 in v5 do
            deep_freeze(v6)
            deep_freeze(v7)
        end
    end
    return v5
end

local function path(v8) -- line 41
    local v9 = {}
    local v10 = #v8
    for v11 = v10, 1, -1 do
        local v12 = v8[v11]
        table.insert(v9, v12)
    end
    return table.concat(v9, ".")
end

local function tostring_err(v13) -- line 49 | captures: path
    if v13.why == "bad_type" then
        return (("value at %* isn't JSON-encodeable"):format((path(v13.where))))
    end
    if v13.why == "non_real_number" then
        return (("value at %* is not a real number"):format((path(v13.where))))
    end
    if v13.why == "only_use_string_key_dict" then
        return (("value at %* is a dictionary, but not all keys are strings"):format((path(v13.where))))
    end
    if v13.why == "recursive_table" then
        return (("value at %* is recursive."):format((path(v13.where))))
    end
    if v13.why == "invalid_utf8" then
        return (("value at %* contains invalid utf-8 characters."):format((path(v13.where))))
    end
    if v13.why == "saving_nil" then
        return (("attempt to save nil at %* - use false instead"):format((path(v13.where))))
    end
    return (("unknown error at %*"):format((path(v13.where))))
end

local function throw(v14, ...) -- line 59 | captures: tostring_err
    local error_2 = error
    local v15 = {
        why = v14,
        where = { ... }
    }
    local v16 = { __tostring = tostring_err }
    error_2((setmetatable(v15, v16)))
end

local function check_table_type(v17) -- line 63
    for v18 in v17 do
        if typeof(v18) == "number" and v18 == 1 then
            return "array"
        end
        if typeof(v18) == "string" then
            return "dict"
        end
        return "bad"
    end
    return "none"
end

local v19 = {}
local v20 = { __mode = "ks" }
local v21 = setmetatable(v19, v20)
local check_json

local function check_json_2(v22, ...) -- line 77 | captures: throw, check_table_type, v21, check_json
    if typeof(v22) == "string" then
        if utf8.len(v22) == nil then
            throw("invalid_utf8", ...)
        end
        return true
    end
    if typeof(v22) == "number" then
        if v22 == v22 then
            if math.abs(v22) == (1/0) then
                return (throw("non_real_number", ...))
            end
            return true
        end
        return (throw("non_real_number", ...))
    end
    if typeof(v22) == "buffer" then
        return true
    end
    if typeof(v22) == "boolean" then
        return true
    end
    if typeof(v22) == "table" then
        if v21[v22] then
            throw("recursive_table", ...)
        end
        v21[v22] = true
        local v23 = check_table_type(v22)
        if v23 == "array" then
            for v24, v25 in v22 do
                check_json(v25, v24, ...)
            end
        elseif v23 == "dict" then
            for v26, v27 in v22 do
                if typeof(v26) ~= "string" then
                    throw("only_use_string_key_dict", ...)
                end
                check_json(v27, v26, ...)
            end
        elseif v23 == "bad" then
            throw("only_use_string_key_dict", ...)
        end
        return true
    end
    if typeof(v22) == "nil" then
        return throw("saving_nil")
    end
    return throw("bad_type", ...)
end

check_json = check_json_2

return {
    clone = clone,
    deep_freeze = deep_freeze,
    check_json_valid = function(v28) -- check_json_valid | line 116 | captures: v21, check_json_2
        table.clear(v21)
        return check_json_2(v28, "root")
    end,
    delta_eq = (function()
        local function v29(v30, v31, ...) -- line 121 | captures: v29
            if typeof(v30) == typeof(v31) then
                if typeof(v30) == "buffer" and typeof(v31) == "buffer" then
                    return buffer.tostring(v30) == buffer.tostring(v31)
                end
                if not (typeof(v30) == "table" and typeof(v31) == "table") then
                    return v30 == v31
                end
                if #v30 == #v31 then
                    for v32, v33 in v30 do
                        local v34, v35 = v29(v33, v31[v32], v32, ...)
                        if not v34 then
                            return v34, v35
                        end
                    end
                    for v36, v37 in v31 do
                        if v30[v36] == nil then
                            local v38, v39 = v29(v37, v30[v36], v36, ...)
                            if not v38 then
                                return v38, v39
                            end
                        end
                    end
                    return true
                end
            end
            return false, table.concat({ ... }, ".")
        end

        return v29
    end)()
}
