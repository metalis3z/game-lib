-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Argument = require(script.Parent.Argument)
local v1 = RunService:IsServer()
local v2 = {}

v2.__index = v2

function v2.new(v3) -- line 12 | captures: v2
    local v4 = {
        Dispatcher = v3.Dispatcher,
        Cmdr = v3.Dispatcher.Cmdr,
        Name = v3.CommandObject.Name,
        RawText = v3.Text,
        Object = v3.CommandObject,
        Group = v3.CommandObject.Group,
        State = {},
        Aliases = v3.CommandObject.Aliases,
        Alias = v3.Alias,
        Description = v3.CommandObject.Description,
        Executor = v3.Executor,
        ArgumentDefinitions = v3.CommandObject.Args,
        RawArguments = v3.Arguments,
        Arguments = {},
        Data = v3.Data
    }
    setmetatable(v4, v2)
    return v4
end

function v2.Parse(v5, v6) -- line 33 | captures: Argument
    local v7 = false
    for v8, v9 in ipairs(v5.ArgumentDefinitions) do
        local v10
        if type(v9) == "function" then
            v10 = v9(v5)
            if v10 == nil then
                break
            end
        else
            v10 = v9
        end
        local v11 = if v10.Default == nil then v10.Optional ~= true else false
        if v11 then
            if v7 then
                error(("Command %q: Required arguments cannot occur after optional arguments."):format(v5.Name))
            end
        else
            v7 = true
        end
        if v5.RawArguments[v8] == nil and v11 then
            return false, ("Required argument #%d %s is missing."):format(v8, v10.Name)
        end
        if v5.RawArguments[v8] then
            v5.Arguments[v8] = Argument.new(v5, v10, v5.RawArguments[v8] or "")
        end
    end
    return true
end

local function Validate(v12, v13) -- line 62
    v12._Validated = true
    local v14 = ""
    local v15 = true
    for v16, v17 in pairs(v12.Arguments) do
        local v18, v19 = v17:Validate(v13)
        if not v18 then
            v14 = ("%s; #%d %s: %s"):format(v14, v16, v17.Name, v19 or "error")
            v15 = false
        end
    end
    return v15, v14:sub(3)
end

v2.Validate = Validate

local function GetLastArgument(v20) -- line 76
    local v21 = #v20.Arguments
    for v22 = v21, 1, -1 do
        if v20.Arguments[v22].RawValue then
            return v20.Arguments[v22]
        end
    end
end

v2.GetLastArgument = GetLastArgument

local function GatherArgumentValues(v23) -- line 85
    local v24 = {}
    local v25 = #v23.ArgumentDefinitions
    for v26 = 1, v25 do
        local v27 = v23.Arguments[v26]
        if v27 then
            v24[v26] = v27:GetValue()
        else
            local v28 = v23.ArgumentDefinitions[v26]
            if type(v28) == "table" then
                v24[v26] = v23.ArgumentDefinitions[v26].Default
            end
        end
    end
    return v24, #v23.ArgumentDefinitions
end

v2.GatherArgumentValues = GatherArgumentValues

function v2.Run(v29) -- line 101 | captures: v1
    if v29._Validated == nil then
        error("Must validate a command before running.")
    end
    local v30 = v29.Dispatcher:RunHooks("BeforeRun", v29)
    if v30 then
        return v30
    end
    if not v1 and v29.Object.Data and v29.Data == nil then
        local v31, v32 = v29:GatherArgumentValues()
        v29.Data = v29.Object.Data(v29, unpack(v31, 1, v32))
    end
    if not v1 and v29.Object.ClientRun then
        local v33, v34 = v29:GatherArgumentValues()
        v29.Response = v29.Object.ClientRun(v29, unpack(v33, 1, v34))
    end
    if v29.Response == nil then
        if v29.Object.Run then
            local v35, v36 = v29:GatherArgumentValues()
            v29.Response = v29.Object.Run(v29, unpack(v35, 1, v36))
        elseif v1 then
            if v29.Object.ClientRun then
                warn(v29.Name, "command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command.")
            else
                warn(v29.Name, "command has no implementation!")
            end
            v29.Response = "No implementation."
        else
            v29.Response = v29.Dispatcher:Send(v29.RawText, v29.Data)
        end
    end
    return v29.Dispatcher:RunHooks("AfterRun", v29) or v29.Response
end

local function GetArgument(v37, v38) -- line 139
    return v37.Arguments[v38]
end

v2.GetArgument = GetArgument

function v2.GetData(v39) -- line 142 | captures: v1
    if not v39.Data and v39.Object.Data and not v1 then
        v39.Data = v39.Object.Data(v39)
    end
    return v39.Data
end

function v2.SendEvent(v40, v41, v42, ...) -- line 151 | captures: Players, v1
    local v43 = typeof(v41) == "Instance"
    assert(v43, "Argument #1 must be a Player")
    local Player = v41:IsA("Player")
    assert(Player, "Argument #1 must be a Player")
    local v44 = type(v42) == "string"
    assert(v44, "Argument #2 must be a string")
    if v1 then
        v40.Dispatcher.Cmdr.RemoteEvent:FireClient(v41, v42, ...)
    elseif v40.Dispatcher.Cmdr.Events[v42] then
        local v45 = v41 == Players.LocalPlayer
        assert(v45, "Event messages can only be sent to the local player on the client.")
        v40.Dispatcher.Cmdr.Events[v42](...)
    end
end

function v2.BroadcastEvent(v46, ...) -- line 168 | captures: v1
    if not v1 then
        error("Can't broadcast event messages from the client.", 2)
    end
    v46.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end

local function Reply(v47, ...) -- line 174
    return v47:SendEvent(v47.Executor, "AddLine", ...)
end

v2.Reply = Reply

local function GetStore(v48, ...) -- line 177
    return v48.Dispatcher.Cmdr.Registry:GetStore(...)
end

v2.GetStore = GetStore

function v2.HasImplementation(v49) -- line 180 | captures: RunService
    if RunService:IsClient() then
        return not not (v49.Object.ClientRun or v49.Object.Run)
    end
    return not not v49.Object.Run
end

return v2
