-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Signal = require(ReplicatedStorage.Packages.Signal)
local environment = require(ReplicatedStorage.Shared.environment)
local v1 = RunService:IsServer()
local v2 = RunService:IsRunning()
assert(v2, "Networking should not be required outside of a runtime context (got Studio edit mode).")
local name, env

local function ErrorSignal(v3) -- line 12 | captures: Signal
    local v4 = Signal.new()

    function v4.Connect() -- line 14 | captures: v3
        error(v3)
    end

    return v4
end

local function WarnOnInvoked(v5) -- line 19
    return function() -- line 20 | captures: v5
        warn(v5)
    end
end

local function ErrorOnInvoked(v6) -- line 24
    return function() -- line 25 | captures: v6
        error(v6)
    end
end

local function WaitFor(v7, v8) -- line 29
    task.delay(3, function() -- line 31 | captures: v7
        warn((("Waited longer than %* second for Networking.%* to exist."):format(3, v7)))
    end)
    return (script:WaitForChild(v7, v8))
end

local function ExtendRemoteEvent(v9) -- line 38 | captures: Players
    local v10 = {
        OnServerEvent = v9.OnServerEvent,
        OnClientEvent = v9.OnClientEvent
    }

    function v10.FireClient(v11, v12, ...) -- line 42 | captures: v9
        v9:FireClient(v12, ...)
    end

    function v10.FireAllClients(v13, ...) -- line 45 | captures: v9
        v9:FireAllClients(...)
    end

    function v10.FireServer(v14, ...) -- line 48 | captures: v9
        v9:FireServer(...)
    end

    function v10.FireAllExcept(v15, v16, ...) -- line 51 | captures: v9, Players
        local v17
        if typeof(v16) == "Instance" then
            v17 = v16:IsA("Player")
        else
            v17 = false
        end
        local v18 = ("invalid player to ignore \"%*\""):format(v16)
        assert(v17, v18)
        for v19, v20 in Players:GetPlayers() do
            if v20 ~= v16 then
                v9:FireClient(v20, ...)
            end
        end
    end

    return v10
end

local function AssertNamespaceOpen(v21, v22) -- line 62 | captures: name, env
    local name_2 = name
    local v23
    if type(name_2) == "string" then
        local env_2 = env
        v23 = type(env_2) == "string"
    else
        v23 = false
    end
    local v24 = ("Networking.%*(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(v21, v22)
    assert(v23, v24)
end

local freeze = table.freeze
local v25 = {
    namespace = function(v26) -- namespace | line 67 | captures: name, env
        name = v26.name
        env = v26.env
    end,
    close = function() -- close | line 71 | captures: name, env
        name = nil
        env = nil
    end
}

function v25.remoteEvent(v27) -- line 75 | captures: name, env, Signal, environment, v1, ExtendRemoteEvent
    local name_2 = name
    local v28
    if type(name_2) == "string" then
        local env_2 = env
        v28 = type(env_2) == "string"
    else
        v28 = false
    end
    local v29 = ("Networking.remoteEvent(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(v27)
    assert(v28, v29)
    local v30 = ("RE/%*/%*"):format(name, v27)
    if v1 then
        local v31 = script:FindFirstChild(v30)
        if not (v31 == nil or v31:IsA("RemoteEvent")) then
            v31:Destroy()
            v31 = nil
        end
        if v31 == nil then
            v31 = Instance.new("RemoteEvent")
            v31.Name = v30
            v31.Parent = script
        end
        if env ~= "all" and environment.placeType ~= env then
            local v32 = {}
            local v33 = ("tried to FireClient with mock remote %*"):format(v30)

            function v32.FireClient() -- line 108 | captures: v33
                warn(v33)
            end

            local v34 = ("tried to FireAllClients with mock remote %*"):format(v30)

            function v32.FireAllClients() -- line 112 | captures: v34
                warn(v34)
            end

            local v35 = ("tried to FireAllExcept with mock remote %*"):format(v30)

            function v32.FireAllExcept() -- line 116 | captures: v35
                warn(v35)
            end

            v32.OnServerEvent = Signal.new()
            local v36 = Signal.new()

            function v36.Connect() -- line 122
                error("tried to use OnClientEvent on the server on a mock remote.")
            end

            v32.OnClientEvent = v36
            local v37 = ("tried to FireServer %* on the server"):format(v30)

            function v32.FireServer() -- line 127 | captures: v37
                error(v37)
            end

            v31.OnServerEvent:Connect(function(v38) -- line 130 | captures: v30
                error((("Remote invocation from %* for remote %* was filtered."):format(v38, v30)))
            end)
            return v32
        end
        return (ExtendRemoteEvent(v31))
    end
    local v39 = false
    task.delay(3, function() -- line 82 | captures: v39, v30
        if not v39 then
            warn((("Waited longer than %* second for Networking.%* to exist."):format(3, v30)))
        end
    end)
    local v40 = script:WaitForChild(v30, 10)
    v39 = v40 ~= nil
    local v41 = ("Server did not create RemoteEvent \"%*\""):format(v30)
    assert(v40, v41)
    return v40
end

function v25.unreliableRemoteEvent(v42) -- line 135 | captures: name, env, environment, v1, ExtendRemoteEvent
    local name_2 = name
    local v43
    if type(name_2) == "string" then
        local env_2 = env
        v43 = type(env_2) == "string"
    else
        v43 = false
    end
    local v44 = ("Networking.unreliableRemoteEvent(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(v42)
    assert(v43, v44)
    local v45 = ("URE/%*/%*"):format(name, v42)
    if v1 then
        local v46 = script:FindFirstChild(v45)
        if not (v46 == nil or v46:IsA("UnreliableRemoteEvent")) then
            v46:Destroy()
            v46 = nil
        end
        if v46 == nil then
            v46 = Instance.new("UnreliableRemoteEvent")
            v46.Name = v45
            v46.Parent = script
        end
        if env ~= "all" and environment.placeType ~= env then
            local UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent")
            UnreliableRemoteEvent.Name = v45
            return (ExtendRemoteEvent(UnreliableRemoteEvent))
        end
        return (ExtendRemoteEvent(v46))
    end
    local v47 = false
    task.delay(3, function() -- line 142 | captures: v47, v45
        if not v47 then
            warn((("Waited longer than %* second for Networking.%* to exist."):format(3, v45)))
        end
    end)
    local v48 = script:WaitForChild(v45, 10)
    v47 = v48 ~= nil
    local v49 = ("Server did not create UnreliableRemoteEvent \"%*\""):format(v45)
    assert(v48, v49)
    return v48
end

function v25.remoteFunction(v50) -- line 169 | captures: name, env, environment, v1
    local name_2 = name
    local v51
    if type(name_2) == "string" then
        local env_2 = env
        v51 = type(env_2) == "string"
    else
        v51 = false
    end
    local v52 = ("Networking.remoteFunction(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(v50)
    assert(v51, v52)
    local v53 = ("RF/%*/%*"):format(name, v50)
    if v1 then
        local v54 = script:FindFirstChild(v53)
        if not (v54 == nil or v54:IsA("RemoteFunction")) then
            v54:Destroy()
            v54 = nil
        end
        if v54 == nil then
            v54 = Instance.new("RemoteFunction")
            v54.Name = v53
            v54.Parent = script
        end
        if env ~= "all" and environment.placeType ~= env then
            local RemoteFunction = Instance.new("RemoteFunction")
            RemoteFunction.Name = v53
            return RemoteFunction
        end
        return v54
    end
    local v55 = false
    task.delay(3, function() -- line 176 | captures: v55, v53
        if not v55 then
            warn((("Waited longer than %* second for Networking.%* to exist."):format(3, v53)))
        end
    end)
    local v56 = script:WaitForChild(v53, 10)
    v55 = v56 ~= nil
    local v57 = ("Server did not create RemoteFunction \"%*\""):format(v53)
    assert(v56, v57)
    return v56
end

return freeze(v25)
