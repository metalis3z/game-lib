

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.UserGenerated.ABTests.SharedABTests)
local v_u_4 = require(v2.UserGenerated.Collections.DeepFreezeUnsafe)
local v5 = require(v2.UserGenerated.Concurrency.Bindable)
local v_u_6 = v1.LocalPlayer
local v_u_7 = false
local v_u_8 = v5.new()
local function v9()
    return v_u_7
end
local v_u_10 = nil
local function v_u_16(p11, p12)
    local v13
    if typeof(p11) == "Instance" then
        v13 = p11:IsA("Player")
    else
        v13 = false
    end
    assert(v13)
    local v14 = type(p12) == "boolean"
    assert(v14)
    if p11 ~= v_u_6 then
        return nil
    end
    while true do
        local v15 = v_u_10
        if v15 then
            break
        end
        if not p12 then
            return nil
        end
        if not p11.Parent then
            return nil
        end
        task.wait()
    end
    return v15
end
local v_u_17 = nil
local function v20(p18)
    if p18 == v_u_6 then
        return v_u_17
    end
    local v19
    if typeof(p18) == "Instance" then
        v19 = p18:IsA("Player")
    else
        v19 = false
    end
    assert(v19)
    return nil
end
local function v_u_27(p21, p22, p23)
    local v24 = type(p22) == "string"
    assert(v24)
    local v25
    if p21 == v_u_6 then
        v25 = v_u_17
    else
        local v26
        if typeof(p21) == "Instance" then
            v26 = p21:IsA("Player")
        else
            v26 = false
        end
        assert(v26)
        v25 = nil
    end
    if v25 then
        v25 = v25[p22]
    end
    if v25 == nil then
        return p23, false
    else
        return v25, true
    end
end
local v_u_28 = v5.new()
v3.UpdateRemote.OnClientEvent:Connect(function(p29, p30)
    v_u_4(p29)
    v_u_4(p30)
    v_u_17 = p29
    v_u_10 = p30
    v_u_7 = true
    v_u_8:Fire()
    v_u_28:Fire(v_u_6)
end)
return table.freeze({
    ["GetAttributes"] = v20,
    ["GetAttribute"] = v_u_27,
    ["GetAttributeAsync"] = function(p31, p32, p33)
        local v34 = type(p32) == "string"
        assert(v34)
        if v_u_16(p31, true) then
            return v_u_27(p31, p32, p33)
        else
            return p33, false
        end
    end,
    ["GetAssignmentsAsync"] = v_u_16,
    ["IsLoaded"] = v9,
    ["Loaded"] = v_u_8,
    ["PlayerUpdated"] = v_u_28
})