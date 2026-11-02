-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Heartbeat = game:GetService("RunService").Heartbeat

local function getPromiseReference() -- line 8
    return false
end

local v1 = newproxy(true)

getmetatable(v1).__tostring = function() -- __tostring | line 13
    return "IndicesReference"
end

local v2 = newproxy(true)

getmetatable(v2).__tostring = function() -- __tostring | line 18
    return "LinkToInstanceIndex"
end

local v3 = {
    IGNORE_MEMORY_DEBUG = true,
    ClassName = "Janitor"
}
local v4 = { CurrentlyCleaning = true }

v4[v1] = nil
v3.__index = v4

local v5 = {
    ["function"] = true,
    Promise = "cancel"
}

v5.RBXScriptConnection = "Disconnect"

function v3.new() -- line 29 | captures: v1, v3
    local v6 = { CurrentlyCleaning = false }
    v6[v1] = nil
    return (setmetatable(v6, v3))
end

function v3.Is(v7) -- line 34 | captures: v3
    if type(v7) == "table" then
        return getmetatable(v7) == v3
    end
    return false
end

v3.is = v3.Is

local function Add(v8, v9, v10, v11) -- line 43 | captures: v1, v5
    if v11 then
        v8:Remove(v11)
        local v12 = v8[v1]
        if not v12 then
            v12 = {}
            v8[v1] = v12
        end
        v12[v11] = v9
    end
    local v13 = typeof(v9)
    if v13 == "table" then
        local v14 = tostring(v9)
        if string.match(v14, "Promise") then
            v13 = "Promise"
        end
    end
    local v15 = v10 or v5[v13] or "Destroy"
    if type(v9) ~= "function" and not v9[v15] then
        local v16 = tostring(v9)
        local v17 = tostring(v15)
        warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", v16, v17, debug.traceback(nil, 2)))
    end
    v8[v9] = {
        v15,
        (debug.traceback(""))
    }
    return v9
end

v3.__index.Add = Add
v3.__index.Give = v3.__index.Add

local function AddPromise(v18, v19) -- line 79
    return v19
end

v3.__index.AddPromise = AddPromise
v3.__index.GivePromise = v3.__index.AddPromise

local function AddObject(v20, v21) -- line 109
    local v22 = newproxy(false)
    return v20:Add(v21, false, v22), v22
end

v3.__index.AddObject = AddObject
v3.__index.GiveObject = v3.__index.AddObject

local function Remove(v23, v24) -- line 127 | captures: v1
    local v25 = v23[v1]
    local v26, v27, v28
    if v25 then
        v26 = v25[v24]
        if v26 then
            local v29 = v23[v26]
            v27 = v29 and v29[1]
            v28 = false
        else
            v28 = true
        end
    else
        v28 = true
    end
    if not v28 then
        if v27 then
            if v27 == true then
                v26()
            else
                local v30 = v26[v27]
                if v30 then
                    v30(v26)
                end
            end
            v23[v26] = nil
        end
        v25[v24] = nil
    end
    return v23
end

v3.__index.Remove = Remove

local function Get(v31, v32) -- line 153 | captures: v1
    local v33 = v31[v1]
    if v33 then
        return v33[v32]
    end
    return nil
end

v3.__index.Get = Get

local function Cleanup(v34) -- line 160 | captures: v1
    if v34.CurrentlyCleaning then
        return
    end
    v34.CurrentlyCleaning = nil
    for v35, v36 in next, v34 do
        if v35 ~= v1 then
            local v37 = type(v35)
            if v37 == "string" then
                v34[v35] = nil
            elseif v37 ~= "number" then
                local v38 = v36[1]
                local v39 = v36[2]

                local function warnUser(v40) -- line 176 | captures: v39
                    local v41 = debug.traceback("", 3)
                    local v42 = tostring(v40)
                    warn("-------- Janitor Error --------" .. "\n" .. v42 .. "\n" .. v41 .. "" .. v39)
                end

                if v38 == true then
                    local v43, v44 = pcall(v35)
                    if not v43 then
                        local v45 = debug.traceback("", 3)
                        local v46 = tostring(v44)
                        warn("-------- Janitor Error --------" .. "\n" .. v46 .. "\n" .. v45 .. "" .. v39)
                    end
                else
                    local v47 = v35[v38]
                    if v47 then
                        local v48, v49 = pcall(v47, v35)
                        local v50 = if typeof(v35) == "Instance" then v47 == "Destroy" else false
                        if not v48 and not v50 then
                            local v51 = debug.traceback("", 3)
                            local v52 = tostring(v49)
                            warn("-------- Janitor Error --------" .. "\n" .. v52 .. "\n" .. v51 .. "" .. v39)
                        end
                    end
                end
                v34[v35] = nil
            end
        end
    end
    local v53 = v34[v1]
    if v53 then
        for v54 in next, v53 do
            v53[v54] = nil
        end
        v34[v1] = {}
    end
    v34.CurrentlyCleaning = false
end

v3.__index.Cleanup = Cleanup
v3.__index.Clean = v3.__index.Cleanup

local function Destroy(v55) -- line 218
    v55:Cleanup()
end

v3.__index.Destroy = Destroy
v3.__call = v3.__index.Cleanup

local v56 = { Connected = true }

v56.__index = v56

local function Disconnect(v57) -- line 224
    if v57.Connected then
        v57.Connected = false
        v57.Connection:Disconnect()
    end
end

v56.Disconnect = Disconnect

local function __tostring(v58) -- line 230
    local Connected = v58.Connected
    return "Disconnect<" .. tostring(Connected) .. ">"
end

v56.__tostring = __tostring

local function LinkToInstance(v59, v60, v61) -- line 234 | captures: Heartbeat, v56
    local v62, v63
    if v61 then
        v63 = newproxy(false)
    end
    local v64 = v60.Parent == nil
    local v65 = {}
    local v66 = setmetatable(v65, v56)
    v62 = v60.AncestryChanged:Connect(function(v67, v68) -- line 244 | captures: v66, v62, v64, v59, Heartbeat
        if not v66.Connected then
            return
        end
        v64 = v68 == nil
        if v64 then
            coroutine.wrap(function() -- line 249 | captures: v66, v62, v64, v59, Heartbeat
                Heartbeat:Wait()
                if v66.Connected then
                    if v62.Connected then
                        while v64 do
                            if v62.Connected and v66.Connected then
                                Heartbeat:Wait()
                                continue
                            end
                            break
                        end
                        if v66.Connected and v64 then
                            v59:Cleanup()
                        end
                    else
                        v59:Cleanup()
                    end
                end
            end)()
        end
    end)
    v66.Connection = v62
    if v64 and v66.Connected then
        v64 = v60.Parent == nil
        if v64 then
            coroutine.wrap(function() -- line 275 | captures: v66, v62, v64, v59, Heartbeat
                Heartbeat:Wait()
                if v66.Connected then
                    if v62.Connected then
                        while v64 do
                            if v62.Connected and v66.Connected then
                                Heartbeat:Wait()
                                continue
                            end
                            break
                        end
                        if v66.Connected and v64 then
                            v59:Cleanup()
                        end
                    else
                        v59:Cleanup()
                    end
                end
            end)()
        end
    end
    return v59:Add(v66, "Disconnect", v63)
end

v3.__index.LinkToInstance = LinkToInstance

local function LinkToInstances(v69, ...) -- line 298 | captures: v3
    local v70 = v3.new()
    local v71 = { ... }
    for v72, v73 in ipairs(v71) do
        v70:Add(v69:LinkToInstance(v73, true), "Disconnect")
    end
    return v70
end

v3.__index.LinkToInstances = LinkToInstances

local __index = v3.__index
local v74 = {}
for v75, v76 in next, __index do
    v74[string.lower((string.sub(v75, 1, 1))) .. string.sub(v75, 2)] = v76
end
for v77, v78 in next, v74 do
    __index[v77] = v78
end
return v3
