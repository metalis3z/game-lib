-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1

local function guarded(v2, v3, ...) -- line 11
    local v4 = v2:acquire()
    local v5, v6
    local v7 = table.pack(xpcall(v3, function(v8) -- line 15 | captures: v5, v6
        local function v9(...)
            return (tostring(...))
        end

        v5 = tostring(v8)
        v6 = v9(debug.traceback(nil, 3))
    end, ...))
    v2:release(v4)
    if v7[1] ~= true then
        local v10 = v5
        local v11 = tostring(v10)
        local error_2 = error
        local v12 = v6
        error_2((("[Mutex] guarded call failed with %*\n-- traceback --\n%*"):format(v11, (tostring(v12)))))
    end
    return v7
end

function v1.new() -- line 26 | captures: v1
    local v13 = {
        issued = 0,
        busy = false,
        parked = {}
    }
    return (setmetatable(v13, v1))
end

local function issueTicket(v14) -- line 30
    local issued = v14.issued
    v14.issued += 1
    return issued
end

v1.issueTicket = issueTicket

local function acquireNow(v15) -- line 35
    local v16
    if v15.holder then
    else
        v16 = v15:issueTicket()
    end
    v15.holder = v16 or v15.holder
    return v16
end

v1.acquireNow = acquireNow

local function acquire(v17) -- line 49
    local function v18(v19, ...)
        table.insert(v19, ...)
    end

    local v20 = v17:acquireNow()
    if v20 == nil then
        v18(v17.parked, coroutine.running())
        return coroutine.yield()
    end
    return v20
end

v1.acquire = acquire

function v1.release(v21, v22) -- line 57 | captures: t
    local function v23(...)
        return (assert(...))
    end

    t.strict(t.number)(v22)
    local holder = v21.holder
    local v24 = v22 == holder
    local v25 = ("[Mutex] ticket %* does not own this lock; %* does"):format(v22, holder)
    assert(v24, v25)
    v21.holder = nil
    local v26
    while true do
        if #v21.parked <= 0 then
            return
        end
        v26 = v23(table.remove(v21.parked, 1))
        if coroutine.status(v26) == "suspended" then
            break
        end
    end
    local v27 = v21:issueTicket()
    v21.holder = v27
    task.delay(0, v26, v27)
end

local function owner(v28) -- line 79
    return v28.holder
end

v1.owner = owner

function v1.run(v29, v30, ...) -- line 82 | captures: guarded
    local v31 = guarded(v29, v30, ...)
    return table.unpack(v31, 2)
end

function v1.wrun(v32, v33, ...) -- line 86 | captures: guarded
    local v34 = guarded(v32, v33, ...)
    return v34[1], table.unpack(v34, 2)
end

function v1.spawn(v35, v36, ...) -- line 90 | captures: guarded
    task.spawn(guarded, v35, v36, ...)
end

local function Destroy(v37) -- line 93
    if v37.holder == nil then
        table.clear(v37)
        setmetatable(v37, nil)
    end
end

v1.Destroy = Destroy
v1.destroy = v1.Destroy
return v1
