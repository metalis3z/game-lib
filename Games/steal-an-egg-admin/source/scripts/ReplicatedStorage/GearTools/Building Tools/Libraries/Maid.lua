-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = { ClassName = "Maid" }

function v1.new() -- line 12 | captures: v1
    local v2 = {
        _tasks = {}
    }
    return (setmetatable(v2, v1))
end

function v1.__index(v3, v4) -- line 22 | captures: v1
    if v1[v4] then
        return v1[v4]
    end
    return v3._tasks[v4]
end

function v1.__newindex(v5, v6, v7) -- line 37 | captures: v1
    if v1[v6] ~= nil then
        error(("'%s' is reserved"):format((tostring(v6))), 2)
    end
    local _tasks = v5._tasks
    local v8 = _tasks[v6]
    _tasks[v6] = v7
    if not v8 then
        return
    end
    if type(v8) == "function" then
        v8()
    elseif typeof(v8) == "RBXScriptConnection" then
        v8:Disconnect()
    elseif v8.Destroy then
        v8:Destroy()
    end
end

local function GiveTask(v9, v10) -- line 60
    assert(v10)
    local v11 = #v9._tasks + 1
    v9[v11] = v10
    return v11
end

v1.GiveTask = GiveTask

local function DoCleaning(v12) -- line 69
    local _tasks = v12._tasks
    for v13, v14 in pairs(_tasks) do
        if typeof(v14) == "RBXScriptConnection" then
            _tasks[v13] = nil
            v14:Disconnect()
        end
    end
    local v15, v16 = next(_tasks)
    while true do
        if v16 == nil then
            break
        end
        _tasks[v15] = nil
        if type(v16) == "function" then
            v16()
        elseif typeof(v16) == "RBXScriptConnection" then
            v16:Disconnect()
        elseif v16.Destroy then
            v16:Destroy()
        end
        v15, v16 = next(_tasks)
    end
end

v1.DoCleaning = DoCleaning
v1.Destroy = v1.DoCleaning
return v1
