



local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.UserGenerated.Logging)
local v_u_4 = require(v1.UserGenerated.Lang.Asserts)
local v_u_11 = table.freeze({
    ["__index"] = table.freeze({
        ["Disconnect"] = function(p5)
            p5.Connection:Disconnect()
            p5:OnDisconnected()
        end,
        ["OnDisconnected"] = function(p6)
            if not p6.Vars.Disconnected then
                p6.Vars.Disconnected = true
                for _, v7 in ipairs(p6.Callbacks) do
                    task.spawn(v7)
                end
                table.clear(p6.Callbacks)
            end
        end,
        ["Then"] = function(p8, p9)
            v_u_4.Function(p9)
            if p8.Vars.Disconnected then
                task.spawn(p9)
            else
                local v10 = p8.Callbacks
                table.insert(v10, p9)
            end
        end
    })
})
function new(p_u_12, p_u_13)
    v_u_4.FiniteNonNegative(p_u_12)
    v_u_4.Function(p_u_13)
    local v14 = {
        ["Callbacks"] = {},
        ["Connection"] = nil,
        ["Vars"] = {
            ["Disconnected"] = false
        }
    }
    local v15 = v_u_11
    local v_u_16 = setmetatable(v14, v15)
    local v_u_17 = 0
    local v_u_18 = nil
    v_u_18 = v_u_2.RenderStepped:Connect(function(p19)
        local v20 = false
        local v21 = v_u_17
        v_u_17 = v_u_17 + p19
        if p_u_12 <= v_u_17 then
            v_u_17 = p_u_12
            v_u_18:Disconnect()
            v20 = true
        end
        local v22 = p_u_12 <= v_u_17 and 1 or v_u_17 / p_u_12
        local v23 = v_u_17
        local v24 = v_u_17 - v21
        local v25, v26 = pcall(p_u_13, v22, v23, v24)
        if not v25 then
            v_u_3.Warn("RenderError", v26)
        end
        if not v25 or v26 ~= nil then
            v_u_18:Disconnect()
            v20 = true
        end
        if v20 then
            v_u_16:OnDisconnected()
        end
    end)
    v_u_16.Connection = v_u_18
    table.freeze(v_u_16)
    return v_u_16
end
return new