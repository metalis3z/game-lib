-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)

local function DestroyThing(v1) -- line 8
    if typeof(v1) == "RBXScriptConnection" then
        task.spawn(v1.Disconnect, v1)
    elseif typeof(v1) == "Instance" then
        if v1:IsA("AnimationTrack") and v1.IsPlaying then
            task.spawn(function() -- line 19 | captures: v1
                v1:Stop(0.05)
                task.delay(0.11666666666666667, function() -- line 21 | captures: v1
                    v1:Destroy()
                end)
            end)
        else
            task.spawn(v1.Destroy, v1)
        end
    elseif type(v1) == "thread" then
        pcall(task.cancel, v1)
    elseif type(v1) == "function" then
        task.spawn(v1)
    elseif type(v1) == "table" then
        task.spawn(function(v2) -- line 39
            if v2.Destroy then
                v2:Destroy()
            elseif v2.Disconnect then
                v2:Disconnect()
            end
        end, v1)
    end
end

local function Add(v3, v4) -- line 50 | captures: DestroyThing
    if v4 ~= nil then
        if typeof(v4) ~= "RBXScriptConnection" and typeof(v4) ~= "Instance" and type(v4) ~= "thread" and type(v4) ~= "function" then
            if type(v4) == "table" then
                local Destroy = v4.Destroy
                if type(Destroy) ~= "function" then
                    local Disconnect = v4.Disconnect
                    if type(Disconnect) ~= "function" then
                        error("Unknown thing: table (missing Destroy/Disconnect)")
                    end
                end
            else
                error((("Unknown thing: %*"):format((typeof(v4)))))
            end
        end
        if v3.Destroyed then
            DestroyThing(v4)
        else
            local Things = v3.Things
            table.insert(Things, v4)
        end
    end
    return v4
end

local v5 = {}

function v5.Destroy(v6) -- line 69 | captures: DestroyThing
    if v6.Destroyed then
        return false
    end
    v6.Destroyed = true
    for v7, v8 in ipairs(v6.Things) do
        DestroyThing(v8)
    end
    v6.Destroying:Fire()
    return true
end

function v5.IsDestroyed(v9) -- line 80
    return v9.Destroyed
end

v5.Add = Add

local v10 = table.freeze({
    __index = v5,
    __call = Add
})
table.freeze(v5)
local freeze = table.freeze
local v11 = {}

function v11.new() -- line 88 | captures: Bindable, v10
    local v12 = {
        Destroyed = false,
        Destroying = Bindable.new(),
        Things = {}
    }
    return (setmetatable(v12, v10))
end

return freeze(v11)
