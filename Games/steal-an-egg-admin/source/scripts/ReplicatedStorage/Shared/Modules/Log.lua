-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local v1 = { "fatal", "error", "warn", "info", "debug", "trace" }
local v2 = {
    error = true,
    fatal = true
}
local v3 = {}
local v4

local function discard() -- line 19
end

local function merged(v5, v6) -- line 20
    local v7 = table.clone(v5)
    for v8, v9 in v6 or {} do
        v7[v8] = v9
    end
    return v7
end

local function describe(v10) -- line 33
    if typeof(v10) == "Instance" then
        local Parent = v10.Parent
        return (("%*/%*"):format(Parent and Parent.Name or "?", v10.Name))
    end
    if typeof(v10) == "string" then
        return v10
    end
    return "UNKNOWN"
end

local function escalate(v11, v12) -- line 53 | captures: v2
    local v13 = v2[v11.level]
    if v13 then
        warn(debug.traceback(v12 or "a record was escalated without a headline"))
    end
    return v13
end

local v14 = {}

function v14.log(v15, v16, v17, v18) -- line 61 | captures: v1
    local v19 = table.find(v1, v16)
    if table.find(v1, v15.threshold) < v19 then
        return
    end
    local v20 = {
        level = v16,
        message = v17
    }
    local v21 = table.clone(v15.bindings)
    for v22, v23 in v18 or {} do
        v21[v22] = v23
    end
    v20.context = v21
    local v24, v25 = pcall(v15.emit, v20)
    if not v24 then
        warn((("the log sink raised while taking a record: %*"):format(v25)))
    end
end

function v14.extend(v26, v27) -- line 84 | captures: v4
    local v28 = { emit = v26.emit }
    local v29 = table.clone(v26.bindings)
    for v30, v31 in v27 or {} do
        v29[v30] = v31
    end
    v28.bindings = v29
    v28.threshold = v26.threshold
    local v32 = v4
    return (setmetatable(v28, v32))
end

function v14.setLevel(v33, v34) -- line 100 | captures: v1
    if table.find(v1, v34) == nil then
        error((("%* is not a severity this logger knows"):format(v34)))
    end
    v33.threshold = v34
    return v33
end

v4 = { __index = v14 }

function v3.createLogger(v35, v36) -- line 109 | captures: v4, discard
    local v37 = if typeof(v35) == "function" then v35 else discard
    local v38 = {
        threshold = "info",
        emit = v37
    }
    v38.bindings = v36 or {}
    local v39 = v4
    return (setmetatable(v38, v39))
end

function v3.createDefaultCallback(v40) -- line 124 | captures: RunService, v2
    local v41
    if typeof(v40) == "Instance" then
        local Parent = v40.Parent
        v41 = ("%*/%*"):format(Parent and Parent.Name or "?", v40.Name)
    elseif typeof(v40) == "string" then
        v41 = v40
    else
        v41 = "UNKNOWN"
    end
    local v42 = RunService:IsStudio()
    return function(v43) -- line 144 | captures: v41, v42, v2
        local v44
        if v42 then
            v44 = ("[%*][%*] %*"):format(v41, v43.level, v43.message)
        else
            v44 = ("[%*] %*"):format(v41, v43.message)
        end
        if v42 and v43.context then
            local v45 = ("[%*] bound context ->"):format(v41)
            print(v45, v43.context)
        end
        local v46, v47
        if v2[v43.level] then
            warn(debug.traceback(v44 or "a record was escalated without a headline"))
            v47 = true
        elseif v42 then
            if v43.level == "warn" then
                v46 = warn
            else
                v46 = print
            end
            v47 = false
        else
            v47 = true
        end
        if v47 then
            return
        end
        v46(v44)
    end
end

return v3
