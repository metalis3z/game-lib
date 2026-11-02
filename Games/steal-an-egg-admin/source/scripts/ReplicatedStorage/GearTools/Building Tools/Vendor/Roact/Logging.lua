-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = true
local v2 = {}
local v3 = {}

local function indent(v4, v5) -- line 24
    local v6 = ("\t"):rep(v5)
    return v6 .. v4:gsub("\n", "\n" .. v6)
end

local function indentLines(v7, v8) -- line 34
    local v9 = {}
    for v10, v11 in ipairs(v7) do
        local v12 = ("\t"):rep(v8)
        local v13 = v12 .. v11:gsub("\n", "\n" .. v12)
        table.insert(v9, v13)
    end
    return table.concat(v9, "\n")
end

local v14 = {}

function v14.__tostring(v15) -- line 50 | captures: indentLines
    local function v16(v17, ...)
        table.insert(v17, ...)
    end

    local function v18(v19, ...)
        table.insert(v19, ...)
    end

    local function v20(v21, ...)
        table.insert(v21, ...)
    end

    local function v22(v23, ...)
        table.insert(v23, ...)
    end

    local function v24(v25, ...)
        table.insert(v25, ...)
    end

    local function v26(v27, ...)
        table.insert(v27, ...)
    end

    local v28 = { "LogInfo {" }
    local v29 = #v15.errors
    local v30 = #v15.warnings
    local v31 = #v15.infos
    if v29 + v30 + v31 == 0 then
        table.insert(v28, "\t(no messages)")
    end
    if v29 > 0 then
        v16(v28, ("\tErrors (%d) {"):format(v29))
        v18(v28, indentLines(v15.errors, 2))
        table.insert(v28, "\t}")
    end
    if v30 > 0 then
        v20(v28, ("\tWarnings (%d) {"):format(v30))
        v22(v28, indentLines(v15.warnings, 2))
        table.insert(v28, "\t}")
    end
    if v31 > 0 then
        v24(v28, ("\tInfos (%d) {"):format(v31))
        v26(v28, indentLines(v15.infos, 2))
        table.insert(v28, "\t}")
    end
    table.insert(v28, "}")
    return table.concat(v28, "\n")
end

local function createLogInfo() -- line 84 | captures: v14
    local v32 = {
        errors = {},
        warnings = {},
        infos = {}
    }
    setmetatable(v32, v14)
    return v32
end

local v33 = {}

function v33.capture(v34) -- line 105 | captures: v1, v2, createLogInfo
    local v35 = createLogInfo()
    local v36 = v1
    v1 = false
    v2[v35] = true
    local v37, v38 = pcall(v34)
    v2[v35] = nil
    v1 = v36
    assert(v37, v38)
    return v35
end

function v33.warn(v39, ...) -- line 125 | captures: v1, v2
    local v40 = v39:format(...)
    for v41 in pairs(v2) do
        local warnings = v41.warnings
        table.insert(warnings, v40)
    end
    local v42 = debug.traceback("", 2):sub(2)
    local v43 = ("\t"):rep(1)
    local v44 = ("%s\n%s"):format(v40, v43 .. v42:gsub("\n", "\n" .. v43))
    if v1 then
        warn(v44)
    end
end

function v33.warnOnce(v45, ...) -- line 148 | captures: v3, v33
    local v46 = debug.traceback()
    if not v3[v46] then
        v3[v46] = true
        v33.warn(v45, ...)
    end
end

return v33
