-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local v1 = newproxy()
local v2 = newproxy()
local v3 = { "Destroy", "Disconnect", "destroy", "disconnect" }
local v4 = table.freeze(v3)

local function GetObjectCleanupFunction(v5, v6) -- line 11 | captures: v1, v2, v4
    local v7 = typeof(v5)
    if v7 == "function" then
        return v1
    end
    if v7 == "thread" then
        return v2
    end
    if v6 then
        return v6
    end
    if v7 == "Instance" or v7 == "Object" then
        return "Destroy"
    end
    if v7 == "RBXScriptConnection" then
        return "Disconnect"
    end
    if v7 == "table" then
        for v8, v9 in v4 do
            local v10 = v5[v9]
            if typeof(v10) == "function" then
                return v9
            end
        end
        local v11 = ("failed to get cleanup function for object %*: %*"):format(v7, v5)
        error(v11, 3)
    else
        local v12 = ("failed to get cleanup function for object %*: %*"):format(v7, v5)
        error(v12, 3)
    end
end

local function AssertPromiseLike(v13) -- line 45
    if typeof(v13) == "table" then
        local getStatus = v13.getStatus
        if typeof(getStatus) == "function" then
            local finally = v13.finally
            if typeof(finally) == "function" then
                local cancel = v13.cancel
                if typeof(cancel) ~= "function" then
                    error("did not receive a promise as an argument", 3)
                end
            else
                error("did not receive a promise as an argument", 3)
            end
        else
            error("did not receive a promise as an argument", 3)
        end
    else
        error("did not receive a promise as an argument", 3)
    end
end

local v14 = {}

v14.__index = v14

function v14.new() -- line 58 | captures: v14
    local v15 = {}
    local v16 = setmetatable(v15, v14)
    v16._objects = {}
    v16._cleaning = false
    return v16
end

function v14.is(v17) -- line 64 | captures: v14
    if typeof(v17) == "table" then
        return getmetatable(v17) == v14
    end
    return false
end

function v14.Add(v18, v19, v20) -- line 72 | captures: GetObjectCleanupFunction
    if v18._cleaning then
        error("cannot call trove:Add() while cleaning", 2)
    end
    local v21 = GetObjectCleanupFunction(v19, v20)
    local _objects = v18._objects
    local v22 = { v19, v21 }
    table.insert(_objects, v22)
    return v19
end

local function Clone(v23, v24) -- line 80
    if v23._cleaning then
        error("cannot call trove:Clone() while cleaning", 2)
    end
    return v23:Add(v24:Clone())
end

v14.Clone = Clone

local function Construct(v25, v26, ...) -- line 86
    if v25._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2)
    end
    local v27 = type(v26)
    local v28
    if v27 == "table" then
        v28 = v26.new(...)
    elseif v27 == "function" then
        v28 = v26(...)
    end
    return v25:Add(v28)
end

v14.Construct = Construct

local function Connect(v29, v30, v31) -- line 99
    if v29._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2)
    end
    return v29:Add(v30:Connect(v31))
end

v14.Connect = Connect

function v14.BindToRenderStep(v32, v33, v34, v35) -- line 105 | captures: RunService
    if v32._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2)
    end
    RunService:BindToRenderStep(v33, v34, v35)
    v32:Add(function() -- line 110 | captures: v33, RunService
        RunService:UnbindFromRenderStep(v33)
    end)
end

local function AddPromise(v36, v37) -- line 114
    if v36._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2)
    end
    if typeof(v37) == "table" then
        local getStatus = v37.getStatus
        if typeof(getStatus) == "function" then
            local finally = v37.finally
            if typeof(finally) == "function" then
                local cancel = v37.cancel
                if typeof(cancel) ~= "function" then
                    error("did not receive a promise as an argument", 3)
                end
            else
                error("did not receive a promise as an argument", 3)
            end
        else
            error("did not receive a promise as an argument", 3)
        end
    else
        error("did not receive a promise as an argument", 3)
    end
    if v37:getStatus() == "Started" then
        v37:finally(function() -- line 128 | captures: v36, v37
            if not v36._cleaning then
                v36:_findAndRemoveFromObjects(v37, false)
            end
        end)
        v36:Add(v37, "cancel")
    end
    return v37
end

v14.AddPromise = AddPromise

local function Remove(v38, v39, ...) -- line 138
    if v38._cleaning then
        error("cannot call trove:Remove() while cleaning", 2)
    end
    return v38:_findAndRemoveFromObjects(v39, true, ...)
end

v14.Remove = Remove

function v14.Extend(v40) -- line 144 | captures: v14
    if v40._cleaning then
        error("cannot call trove:Extend() while cleaning", 2)
    end
    return v40:Construct(v14)
end

local function Clean(v41) -- line 150
    if v41._cleaning then
        return
    end
    v41._cleaning = true
    for v42, v43 in v41._objects do
        v41:_cleanupObject(v43[1], v43[2])
    end
    table.clear(v41._objects)
    v41._cleaning = false
end

v14.Clean = Clean

local function WrapClean(v44) -- line 164
    return function() -- line 165 | captures: v44
        v44:Clean()
    end
end

v14.WrapClean = WrapClean

local function _findAndRemoveFromObjects(v45, v46, v47, ...) -- line 169
    local _objects = v45._objects
    for v48, v49 in _objects do
        if v49[1] == v46 then
            local v50 = #_objects
            _objects[v48] = _objects[v50]
            _objects[v50] = nil
            if v47 then
                v45:_cleanupObject(v49[1], v49[2], ...)
            end
            return true
        end
    end
    return false
end

v14._findAndRemoveFromObjects = _findAndRemoveFromObjects

function v14._cleanupObject(v51, v52, v53, ...) -- line 188 | captures: v1, v2
    if v53 == v1 then
        task.spawn(v52)
    elseif v53 == v2 then
        pcall(task.cancel, v52)
    elseif typeof(v53) == "function" then
        v53(v52, ...)
    else
        v52[v53](v52)
    end
end

local function AttachToInstance(v54, v55) -- line 203
    if v54._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2)
    elseif not v55:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2)
    end
    local Destroying = v55.Destroying
    return v54:Connect(Destroying, function() -- line 209 | captures: v54
        v54:Destroy()
    end)
end

v14.AttachToInstance = AttachToInstance

local function Destroy(v56) -- line 213
    v56:Clean()
end

v14.Destroy = Destroy

return {
    new = v14.new,
    is = v14.is
}
