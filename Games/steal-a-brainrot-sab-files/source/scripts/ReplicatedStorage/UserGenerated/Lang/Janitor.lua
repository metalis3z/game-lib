
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.UserGenerated.Concurrency.Bindable)
local function v_u_5(p_u_3)
    if typeof(p_u_3) == "RBXScriptConnection" then
        task.spawn(p_u_3.Disconnect, p_u_3)
        return
    elseif typeof(p_u_3) == "Instance" then
        if p_u_3:IsA("AnimationTrack") and p_u_3.IsPlaying then
            task.spawn(function()
                p_u_3:Stop(0.05)
                task.delay(0.11666666666666667, function()
                    p_u_3:Destroy()
                end)
            end)
        else
            task.spawn(p_u_3.Destroy, p_u_3)
        end
    elseif type(p_u_3) == "thread" then
        pcall(task.cancel, p_u_3)
        return
    elseif type(p_u_3) == "function" then
        task.spawn(p_u_3)
    elseif type(p_u_3) == "table" then
        task.spawn(function(p4)
            if p4.Destroy then
                p4:Destroy()
            elseif p4.Disconnect then
                p4:Disconnect()
            end
        end, p_u_3)
    end
end
local function v11(p6, p7)
    if p7 ~= nil then
        if typeof(p7) ~= "RBXScriptConnection" and (typeof(p7) ~= "Instance" and (type(p7) ~= "thread" and type(p7) ~= "function")) then
            if type(p7) == "table" then
                local v8 = p7.Destroy
                if type(v8) ~= "function" then
                    local v9 = p7.Disconnect
                    if type(v9) ~= "function" then
                        error("Unknown thing: table (missing Destroy/Disconnect)")
                    end
                end
            else
                error((("Unknown thing: %*"):format((typeof(p7)))))
            end
        end
        if not p6.Destroyed then
            local v10 = p6.Things
            table.insert(v10, p7)
            return p7
        end
        v_u_5(p7)
    end
    return p7
end
local v15 = {
    ["Destroy"] = function(p12)
        if p12.Destroyed then
            return false
        end
        p12.Destroyed = true
        for _, v13 in ipairs(p12.Things) do
            v_u_5(v13)
        end
        p12.Destroying:Fire()
        return true
    end,
    ["IsDestroyed"] = function(p14)
        return p14.Destroyed
    end,
    ["Add"] = v11
}
local v_u_16 = table.freeze({
    ["__index"] = v15,
    ["__call"] = v11
})
table.freeze(v15)
return table.freeze({
    ["new"] = function()
        local v17 = {
            ["Destroyed"] = false,
            ["Destroying"] = v_u_2.new(),
            ["Things"] = {}
        }
        local v18 = v_u_16
        return setmetatable(v17, v18)
    end
})