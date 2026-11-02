-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = newproxy()
local v2 = newproxy()
local RunService = game:GetService("RunService")

local function GetObjectCleanupFunction(v3, v4) -- line 9 | captures: v1, v2
    local v5 = typeof(v3)
    if v5 == "function" then
        return v1
    end
    if v5 == "thread" then
        return v2
    end
    if v4 then
        return v4
    end
    if v5 == "Instance" then
        return "Destroy"
    end
    if v5 == "RBXScriptConnection" then
        return "Disconnect"
    end
    if v5 == "table" then
        local Destroy = v3.Destroy
        if typeof(Destroy) == "function" then
            return "Destroy"
        end
        local Disconnect = v3.Disconnect
        if typeof(Disconnect) == "function" then
            return "Disconnect"
        end
        local v6 = "Failed to get cleanup function for object " .. v5 .. ": " .. tostring(v3)
        error(v6, 3)
    else
        local v7 = "Failed to get cleanup function for object " .. v5 .. ": " .. tostring(v3)
        error(v7, 3)
    end
end

local function AssertPromiseLike(v8) -- line 41
    if type(v8) == "table" then
        local getStatus = v8.getStatus
        if type(getStatus) == "function" then
            local finally = v8.finally
            if type(finally) == "function" then
                local cancel = v8.cancel
                if type(cancel) ~= "function" then
                    error("Did not receive a Promise as an argument", 3)
                end
            else
                error("Did not receive a Promise as an argument", 3)
            end
        else
            error("Did not receive a Promise as an argument", 3)
        end
    else
        error("Did not receive a Promise as an argument", 3)
    end
end

local v9 = {}

v9.__index = v9

function v9.new() -- line 54 | captures: v9
    local v10 = {}
    local v11 = setmetatable(v10, v9)
    v11._objects = {}
    return v11
end

function v9.Extend(v12) -- line 59 | captures: v9
    return v12:Construct(v9)
end

local function Clone(v13, v14) -- line 62
    return v13:Add(v14:Clone())
end

v9.Clone = Clone

local function Construct(v15, v16, ...) -- line 65
    local v17 = type(v16)
    local v18
    if v17 == "table" then
        v18 = v16.new(...)
    elseif v17 == "function" then
        v18 = v16(...)
    end
    return v15:Add(v18)
end

v9.Construct = Construct

local function Connect(v19, v20, v21) -- line 75
    return v19:Add(v20:Connect(v21))
end

v9.Connect = Connect

function v9.BindToRenderStep(v22, v23, v24, v25) -- line 78 | captures: RunService
    RunService:BindToRenderStep(v23, v24, v25)
    v22:Add(function() -- line 80 | captures: v23, RunService
        RunService:UnbindFromRenderStep(v23)
    end)
end

local function AddPromise(v26, v27) -- line 84
    if type(v27) == "table" then
        local getStatus = v27.getStatus
        if type(getStatus) == "function" then
            local finally = v27.finally
            if type(finally) == "function" then
                local cancel = v27.cancel
                if type(cancel) ~= "function" then
                    error("Did not receive a Promise as an argument", 3)
                end
            else
                error("Did not receive a Promise as an argument", 3)
            end
        else
            error("Did not receive a Promise as an argument", 3)
        end
    else
        error("Did not receive a Promise as an argument", 3)
    end
    if v27:getStatus() == "Started" then
        v27:finally(function() -- line 95 | captures: v26, v27
            return v26:_findAndRemoveFromObjects(v27, false)
        end)
        v26:Add(v27, "cancel")
    end
    return v27
end

v9.AddPromise = AddPromise

function v9.Add(v28, v29, v30) -- line 102 | captures: GetObjectCleanupFunction
    local v31 = GetObjectCleanupFunction(v29, v30)
    local _objects = v28._objects
    local v32 = { v29, v31 }
    table.insert(_objects, v32)
    return v29
end

local function Remove(v33, v34, ...) -- line 107
    return v33:_findAndRemoveFromObjects(v34, true, ...)
end

v9.Remove = Remove

local function Clean(v35) -- line 110
    for v36, v37 in ipairs(v35._objects) do
        v35:_cleanupObject(v37[1], v37[2])
    end
    table.clear(v35._objects)
end

v9.Clean = Clean

local function _findAndRemoveFromObjects(v38, v39, v40, ...) -- line 116
    local _objects = v38._objects
    for v41, v42 in ipairs(_objects) do
        if v42[1] == v39 then
            local v43 = #_objects
            _objects[v41] = _objects[v43]
            _objects[v43] = nil
            if v40 then
                v38:_cleanupObject(v42[1], v42[2], ...)
            end
            return true
        end
    end
    return false
end

v9._findAndRemoveFromObjects = _findAndRemoveFromObjects

function v9._cleanupObject(v44, v45, v46, ...) -- line 132 | captures: v1, v2
    if v46 == v1 then
        v45()
    elseif v46 == v2 then
        coroutine.close(v45)
    elseif typeof(v46) == "function" then
        v46(v45, ...)
    else
        v45[v46](v45)
    end
end

local function AttachToInstance(v47, v48) -- line 147
    local v49 = v48:IsDescendantOf(game)
    assert(v49, "Instance is not a descendant of the game hierarchy")
    local Destroying = v48.Destroying
    return v47:Connect(Destroying, function() -- line 150 | captures: v47
        v47:Destroy()
    end)
end

v9.AttachToInstance = AttachToInstance

local function Destroy(v50) -- line 154
    v50:Clean()
end

v9.Destroy = Destroy
return v9
