--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = utf8.char(0)
local v_u_3 = utf8.char(1)
local v_u_4 = utf8.char(2)
local v_u_5 = {}
local v_u_6 = require(script.ReplicatorSignal)
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local function v_u_12(p10, p11)
    p10[p11] = (p10[p11] or 0) + 1
end
local function v_u_16(p13, p14)
    local v15
    if p13[p14] == 1 or p13[p14] == nil then
        v15 = nil
    else
        v15 = p13[p14] - 1
    end
    p13[p14] = v15
end
local function v_u_21(p17)
    -- upvalues: (copy) v_u_21
    local v18 = table.clone(p17)
    for v19, v20 in v18 do
        if type(v20) == "table" then
            v18[v19] = v_u_21(v20)
        end
    end
    return v18
end
local function v_u_25(p_u_22)
    for v_u_23, v_u_24 in p_u_22 do
        if type(v_u_24) == "function" then
            p_u_22[v_u_23] = function(...)
                -- upvalues: (copy) p_u_22, (copy) v_u_23, (copy) v_u_24
                if select(1, ...) == p_u_22 then
                    return v_u_24(...)
                end
                error((("called %* with .%*() instead of :%*()"):format(v_u_23, v_u_23, v_u_23)))
            end
        end
    end
end
local function v_u_70(p26)
    -- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_7, (copy) v_u_21, (copy) v_u_3, (copy) v_u_4, (copy) v_u_9
    local v27 = p26[1]
    local v28 = p26[2]
    if v27 == v_u_2 then
        local v29 = p26[3]
        local v30 = p26[4]
        for v31, v32 in v_u_8 do
            if v32 == v29 and v31 ~= v28 then
                error((("client received 2 Replicators with the same Id \"%*\""):format(v29)))
            end
        end
        v_u_8[v28] = v29
        local v33 = v_u_7.get(v29)
        v33.Data = v_u_21(v30)
        for _, v34 in v33._observe_signals do
            v34.signal:Fire(v33:TryIndex(v34.path), nil)
        end
        for _, v35 in v33._listen_signals do
            v35.signal:Fire(v33:TryIndex(v35.path))
        end
        v33._listen_raw_signal:Fire(v33.Data, v33.Data)
        return
    elseif v27 == v_u_3 then
        local v36 = p26[3]
        local v37 = v_u_8[v28]
        if v37 then
            local v38 = v_u_7.get(v37)
            local v_u_39 = v38._signal_descendants
            local v_u_40 = v38._listen_signals
            local v_u_41 = v38._observe_signals
            local _ = v38._listen_raw_signal
            local v_u_42 = {}
            local function v_u_64(p43, p44, p45)
                -- upvalues: (ref) v_u_21, (copy) v_u_64, (copy) v_u_39, (copy) v_u_40, (copy) v_u_42, (copy) v_u_41
                if p44 == nil then
                    if type(p43) == "table" then
                        return v_u_21(p43)
                    else
                        return nil
                    end
                elseif p44.o == 0 then
                    local v46 = p44.v
                    if type(v46) == "table" then
                        return v_u_21(p44.v)
                    else
                        return p44.v
                    end
                else
                    for v49, v48 in p44 do
                        if v48.k then
                            local v49 = tonumber(v49)
                        end
                        local v50
                        if p45 then
                            v50 = ("%*\255%*"):format(p45, v49)
                        else
                            v50 = nil
                        end
                        local v51
                        if v48.o == 0 then
                            v51 = v48.v
                        else
                            local v52 = v_u_64
                            local v53 = p43[v49] or {}
                            local v54
                            if v_u_39[v50] then
                                v54 = v50
                            else
                                v54 = nil
                            end
                            v51 = v52(v53, v48, v54)
                        end
                        if v50 then
                            local v55 = v_u_40[v50]
                            if v55 then
                                local v56 = v_u_42
                                local v57 = { v55.signal, v51, p44 }
                                table.insert(v56, v57)
                            end
                            local v58 = v_u_41[v50]
                            if v58 then
                                local v59 = v_u_42
                                local v60 = {}
                                local v61 = v58.signal
                                local v62 = p43[v49]
                                local v63
                                if type(v62) == "table" then
                                    v63 = v_u_21(p43[v49])
                                else
                                    v63 = p43[v49]
                                end
                                __set_list(v60, 1, {v61, v51, v63})
                                table.insert(v59, v60)
                            end
                        end
                        p43[v49] = v51
                    end
                    return p43
                end
            end
            v_u_64(v38.Data, v36, "\254")
            for _, v65 in v_u_42 do
                v65[1]:Fire(unpack(v65, 2, 3))
            end
            v38._listen_raw_signal:Fire(v38.Data, v36)
        end
    else
        if v27 == v_u_4 then
            local v66 = v_u_8[v28]
            local v67 = v_u_7.get(v66)
            if v67._destroyed == true then
                error("received 2 DESTROY_CMD for the same replicator")
            end
            v67.Destroying:Fire()
            for _, v68 in v67._listen_signals do
                v68.signal:DisconnectAll()
            end
            table.clear(v67._listen_signals)
            for _, v69 in v67._observe_signals do
                v69.signal:DisconnectAll()
            end
            table.clear(v67._observe_signals)
            table.clear(v67._signal_descendants)
            v67._destroyed = true
            v_u_9[v66] = nil
        end
        return
    end
end
function v_u_7.get(p71)
    -- upvalues: (copy) v_u_9, (copy) v_u_6, (copy) v_u_5, (copy) v_u_12, (copy) v_u_16, (copy) v_u_25
    local v72 = v_u_9[p71]
    if v72 then
        return v72
    end
    local v_u_73 = {
        ["Id"] = p71,
        ["Data"] = nil,
        ["Ready"] = false,
        ["Destroying"] = v_u_6.new(),
        ["_listen_signals"] = {},
        ["_listen_raw_signal"] = v_u_6.new(),
        ["_observe_signals"] = {},
        ["_destroyed"] = false,
        ["_signal_descendants"] = {}
    }
    local function v_u_87(p_u_74, p75, p76)
        -- upvalues: (ref) v_u_5, (copy) v_u_73, (ref) v_u_6, (ref) v_u_12, (ref) v_u_16
        if #p_u_74 == 0 and p_u_74 ~= v_u_5 then
            warn("path:", p_u_74)
            error("invalid path to register listener.")
        end
        local v_u_77 = ("\254\255%*"):format((table.concat(p_u_74, "\255")))
        local v_u_78 = v_u_73._signal_descendants
        local v_u_79
        if p75 then
            v_u_79 = v_u_73._observe_signals
        else
            v_u_79 = v_u_73._listen_signals
        end
        local v_u_80 = v_u_79[v_u_77]
        if not v_u_80 then
            v_u_80 = {
                ["signal"] = v_u_6.new(),
                ["path"] = p_u_74,
                ["connected"] = 0
            }
            v_u_79[v_u_77] = v_u_80
        end
        local function v_u_84(p81)
            -- upvalues: (copy) v_u_78, (copy) p_u_74
            p81(v_u_78, "\254")
            local v82 = "\254"
            for v83 = 1, #p_u_74 - 1 do
                v82 = ("%*\255%*"):format(v82, p_u_74[v83])
                p81(v_u_78, v82)
            end
        end
        local v_u_85 = v_u_80.signal:Connect(p76)
        v_u_80.connected = v_u_80.connected + 1
        v_u_84(v_u_12)
        return function()
            -- upvalues: (copy) v_u_85, (ref) v_u_80, (copy) v_u_79, (copy) v_u_77, (copy) v_u_84, (ref) v_u_16
            v_u_85:Disconnect()
            local v86 = v_u_80
            v86.connected = v86.connected - 1
            if v_u_80.connected == 0 then
                v_u_79[v_u_77] = nil
            end
            v_u_84(v_u_16)
        end
    end
    function v_u_73.Listen(_, p88, p89)
        -- upvalues: (copy) v_u_87
        local v90 = p88[1]
        if type(v90) ~= "table" then
            return v_u_87(p88, false, p89)
        end
        local v_u_91 = {}
        for _, v92 in p88 do
            local v93 = v_u_87(v92, false, p89)
            table.insert(v_u_91, v93)
        end
        return function()
            -- upvalues: (copy) v_u_91
            for _, v94 in v_u_91 do
                v94()
            end
            table.clear(v_u_91)
        end
    end
    function v_u_73.ListenRaw(_, p95)
        -- upvalues: (copy) v_u_73
        return v_u_73._listen_raw_signal:Connect(p95)
    end
    function v_u_73.Observe(_, p96, p97)
        -- upvalues: (copy) v_u_73, (copy) v_u_87
        task.spawn(p97, v_u_73:TryIndex(p96), nil)
        return v_u_87(p96, true, p97)
    end
    function v_u_73.Index(_, p98)
        -- upvalues: (copy) v_u_73
        local v99 = v_u_73.Data
        if type(v99) ~= "table" then
            error("Replicator:Index() failed Data is not a table.")
        end
        local v100 = #p98
        for v101, v102 in p98 do
            v99 = v99[v102]
            if v101 < v100 and type(v99) ~= "table" then
                error((("Replicator:Index() failed %* is not a table."):format((table.concat(p98, "/", 1, v101)))))
            end
        end
        return v99
    end
    function v_u_73.TryIndex(_, p103)
        -- upvalues: (copy) v_u_73
        local v104 = v_u_73.Data
        if type(v104) ~= "table" then
            return nil
        end
        local v105 = #p103
        for v106, v107 in p103 do
            v104 = v104[v107]
            if v106 < v105 and type(v104) ~= "table" then
                return nil
            end
        end
        return v104
    end
    function v_u_73.WaitForLoaded(_)
        -- upvalues: (copy) v_u_73
        coroutine.running()
        if not v_u_73.Data then
            v_u_73._listen_raw_signal:Wait()
        end
    end
    v_u_9[p71] = v_u_73
    v_u_25(v_u_73)
    return v_u_73
end
function v_u_7.init()
    -- upvalues: (copy) v_u_1, (copy) v_u_70
    local v_u_108 = coroutine.running()
    local v_u_109 = false
    local v110 = v_u_1:WaitForChild("__ReplicatorInternal"):WaitForChild("RemoteEvent")
    v110.OnClientEvent:Connect(function(p111)
        -- upvalues: (ref) v_u_70, (ref) v_u_109, (copy) v_u_108
        for _, v112 in p111 do
            v_u_70(v112)
        end
        if v_u_109 and coroutine.status(v_u_108) == "suspended" then
            task.spawn(v_u_108)
            v_u_109 = false
        end
    end)
    v110:FireServer()
    v_u_109 = true
    coroutine.yield()
end
return v_u_7