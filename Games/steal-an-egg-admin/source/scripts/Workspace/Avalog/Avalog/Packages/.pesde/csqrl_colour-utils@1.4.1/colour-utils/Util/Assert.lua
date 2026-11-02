-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local format = string.format

v1.TYPE = {
    INVALID_TYPE = "%s(...): The `%s` argument must be a %s, but you passed %q (%s)",
    INVALID_ARRAY = "%s(...): The `%s` argument must be an array of %s, but you passed %q (%s) at index #%d",
    INVALID_EVAL_ARG = "%s(...): The `%s` argument must %s, but you passed %q (%s)"
}

function v1.typeOf(v2, v3, v4, v5) -- line 13 | captures: v1, format
    local v6 = format(v1.TYPE.INVALID_TYPE, v2, v3, v4, tostring(v5), (typeof(v5)))
    if typeof(v5) ~= v4 then
        error(v6, 3)
    end
    return v5
end

function v1.evalArg(v7, v8, v9, v10, v11) -- line 23 | captures: v1, format
    local v12 = format(v1.TYPE.INVALID_EVAL_ARG, v7, v8, v9, tostring(v11), (typeof(v11)))
    if v10 ~= true then
        error(v12, 3)
    end
    return v11
end

function v1.arrayOf(v13, v14, v15, v16) -- line 33 | captures: v1, format
    v1.typeOf("Assert.arrayOf", "array", "table", v16)
    for v17, v18 in ipairs(v16) do
        if typeof(v18) ~= v15 then
            local v19 = format(v1.TYPE.INVALID_ARRAY, v13, v14, v15, tostring(v18), typeof(v18), v17)
            error(v19, 3)
        end
    end
    return nil
end

function v1.prepTypeOf(v20) -- line 47 | captures: v1
    return function(v21, v22, v23) -- line 48 | captures: v20, v1
        return v1.typeOf(v20, v21, v22, v23)
    end
end

function v1.prepEvalArg(v24) -- line 53 | captures: v1
    return function(v25, v26, v27, v28) -- line 54 | captures: v24, v1
        return v1.evalArg(v24, v25, v26, v27, v28)
    end
end

function v1.prepArrayOf(v29) -- line 59 | captures: v1
    return function(v30, v31, v32) -- line 60 | captures: v29, v1
        return v1.arrayOf(v29, v30, v31, v32)
    end
end

return v1
