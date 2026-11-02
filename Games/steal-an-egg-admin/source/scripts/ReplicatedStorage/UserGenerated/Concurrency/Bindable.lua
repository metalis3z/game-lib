-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function ErrorHandler(v1) -- line 6
    local v2 = tostring(v1)
    warn((("%*\nStack Begin\n%*Stack End"):format(v2, (debug.traceback(nil, 3)))))
end

local function WCall(v3, ...) -- line 10 | captures: ErrorHandler
    return xpcall(v3, ErrorHandler, ...)
end

local function FindRight(v4, v5) -- line 13
    local v6, v7, v8 = false, 1, #v4
    while true do
        local v9, v10, v11
        if v7 <= v8 then
            local v12 = v7 + (v8 - v7) // 2
            local v13 = v4[v12].Pr - v5.Pr
            if v13 > 0 then
                v11, v9, v10 = v6, v7, v12 - 1
            elseif v13 >= 0 then
                v11, v9, v10 = true, v12 + 1, v8
            else
                v11, v9, v10 = v6, v12 + 1, v8
            end
        else
            break
        end
        v6 = v11
        v7 = v9
        v8 = v10
    end
    return v6 and v7 or -v7
end

local function FindLeft(v14, v15) -- line 41
    local v16, v17, v18 = false, 1, #v14
    while true do
        local v19, v20, v21
        if v17 <= v18 then
            local v22 = v17 + (v18 - v17) // 2
            local v23 = v14[v22].Pr - v15.Pr
            if v23 > 0 then
                v21, v19, v20 = v16, v17, v22 - 1
            elseif v23 >= 0 then
                v21, v19, v20 = true, v17, v22 - 1
            else
                v21, v19, v20 = v16, v22 + 1, v18
            end
        else
            break
        end
        v16 = v21
        v17 = v19
        v18 = v20
    end
    return v16 and v17 or -v17
end

local function InsertRight(v24, v25) -- line 69 | captures: FindRight
    local v26 = FindRight(v24, v25)
    local v27 = math.abs(v26)
    table.insert(v24, v27, v25)
    return v27
end

local function Remove(v28, v29) -- line 74 | captures: FindLeft
    local v30 = FindLeft(v28, v29)
    if not (v30 <= 0) then
        local v31 = #v28
        for v32 = v30, v31 do
            if v28[v32] == v29 then
                table.remove(v28, v32)
                return true
            end
        end
    end
    return false
end

local function Connection_Disconnect(v33) -- line 89 | captures: Remove
    local Ow = v33.Ow
    if Ow == nil then
        return
    end
    v33.Ow = nil
    if not Remove(Ow.Cs, v33) then
        warn("BindableConnectionDisconnect")
    end
    for v34, v35 in ipairs(v33.Wt) do
        task.spawn(v35)
    end
    table.clear(v33.Wt)
end

local v36 = table.freeze({
    IsConnected = function(v37) -- IsConnected | line 103
        return v37.Ow ~= nil
    end,
    Disconnect = Connection_Disconnect,
    GetPriority = function(v38) -- GetPriority | line 108
        return v38.Pr
    end
})
local v39 = table.freeze({ __index = v36 })

local function Connection_new(v40, v41, v42) -- line 113 | captures: v39
    local v43 = {
        Ow = v40,
        Cb = v41,
        Pr = v42,
        Wt = {}
    }
    return (setmetatable(v43, v39))
end

local freeze = table.freeze
local v44 = {
    Fire = function(v45, ...) -- Fire | line 118
        local Cs = v45.Cs
        local v46 = 1
        while true do
            if v46 <= #Cs then
                local v47 = Cs[v46]
                task.spawn(v47.Cb, ...)
                if Cs[v46] == v47 then
                    v46 += 1
                end
            else
                break
            end
        end
    end
}

function v44.FireAndWait(v48, ...) -- line 130 | captures: WCall
    local Cs = v48.Cs
    if #Cs == 0 then
        return
    end
    local v49 = 1
    local v50 = coroutine.running()

    local function executor(v51, ...) -- line 138 | captures: v49, v50, WCall
        WCall(v51, ...)
        v49 -= 1
        if v49 == 0 then
            task.spawn(v50)
        end
    end

    local v52 = 1
    while true do
        if v52 <= #Cs then
            local v53 = Cs[v52]
            v49 += 1
            task.spawn(executor, v53.Cb, ...)
            if Cs[v52] == v53 then
                v52 += 1
            end
        else
            break
        end
    end
    v49 -= 1
    if v49 > 0 then
        coroutine.yield()
    end
end

function v44.FireSync(v54, ...) -- line 159 | captures: WCall
    local Cs = v54.Cs
    local v55 = 1
    while true do
        if v55 <= #Cs then
            local v56 = Cs[v55]
            WCall(v56.Cb, ...)
            if Cs[v55] == v56 then
                v55 += 1
            end
        else
            break
        end
    end
end

function v44.Invoke(v57, ...) -- line 171
    local Cs = v57.Cs
    if #Cs >= 1 then
        return Cs[1].Cb(...)
    end
    error("Invoke")
end

function v44.Connect(v58, v59, v60) -- line 178 | captures: FindRight, v39
    local v61
    if v60 == nil then
        v61 = true
    elseif type(v60) == "number" then
        v61 = v60 == v60
    else
        v61 = false
    end
    assert(v61)
    local v62 = v60 or (1/0)
    local v63 = {
        Ow = v58,
        Cb = v59,
        Pr = v62,
        Wt = {}
    }
    local v64 = setmetatable(v63, v39)
    if v62 == (1/0) then
        local Cs = v58.Cs
        table.insert(Cs, v64)
    else
        local Cs = v58.Cs
        local v65 = FindRight(Cs, v64)
        local v66 = math.abs(v65)
        table.insert(Cs, v66, v64)
    end
    return v64
end

function v44.Wait(v67) -- line 191 | captures: Connection_Disconnect, v39
    local v68 = coroutine.running()
    local v69 = true
    assert(true)
    local v70 = {
        Pr = (1/0),
        Ow = v67
    }

    function v70.Cb(...) -- line 199 | captures: v69, v68, Connection_Disconnect
        local v71 = table.find((nil).Wt, v68)
        if v71 then
            table.remove((nil).Wt, v71)
        end
        v69 = false
        Connection_Disconnect(nil)
        task.spawn(v68, ...)
    end

    v70.Wt = {}
    local v72 = setmetatable(v70, v39)
    local Cs = v67.Cs
    table.insert(Cs, v72)
    local Wt = v72.Wt
    table.insert(Wt, v68)
    local v73 = table.pack(coroutine.yield())
    if v69 then
        error("Disconnected")
    end
    return table.unpack(v73)
end

function v44.Once(v74, v75, v76) -- line 218 | captures: FindRight, Connection_Disconnect, v39
    local v77
    if v76 == nil then
        v77 = true
    elseif type(v76) == "number" then
        v77 = v76 == v76
    else
        v77 = false
    end
    assert(v77)
    local v78 = v76 or (1/0)
    local v79 = { Ow = v74 }

    function v79.Cb(...) -- line 225 | captures: v75, Connection_Disconnect
        Connection_Disconnect(nil)
        return v75(...)
    end

    v79.Pr = v78
    v79.Wt = {}
    local v80 = setmetatable(v79, v39)
    if v78 == (1/0) then
        local Cs = v74.Cs
        table.insert(Cs, v80)
    else
        local Cs = v74.Cs
        local v81 = FindRight(Cs, v80)
        local v82 = math.abs(v81)
        table.insert(Cs, v82, v80)
    end
    return v80
end

function v44.DisconnectAll(v83) -- line 240 | captures: Connection_Disconnect
    local Cs = v83.Cs
    local v84 = #Cs
    for v85 = v84, 1, -1 do
        Connection_Disconnect(Cs[v85])
    end
end

function v44.GetSize(v86) -- line 248
    return #v86.Cs
end

function v44.IsEmpty(v87) -- line 251
    return #v87.Cs == 0
end

local v88 = freeze(v44)
local v89 = table.freeze({ __index = v88 })
local freeze_2 = table.freeze
local v90 = {}

function v90.new(v91) -- line 258 | captures: v89
    local v92 = {
        Cs = {}
    }
    return (table.freeze((setmetatable(v92, v89))))
end

function v90.IsA(v93) -- line 262 | captures: v89
    if type(v93) == "table" then
        return getmetatable(v93) == v89
    end
    return false
end

function v90.Assert(v94) -- line 270 | captures: v89
    if not (type(v94) == "table" and getmetatable(v94) == v89) then
        error("Bindable", 2)
    end
    return v94
end

function v90.IsAConnection(v95) -- line 281 | captures: v39
    if type(v95) == "table" then
        return getmetatable(v95) == v39
    end
    return false
end

function v90.AssertConnection(v96) -- line 289 | captures: v39
    if not (type(v96) == "table" and getmetatable(v96) == v39) then
        error("Connection", 2)
    end
    return v96
end

return freeze_2(v90)
