-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Util = require(script.Parent.Util)
local v1 = {
    TypeMethods = Util.MakeDictionary({
        "Transform",
        "Validate",
        "Autocomplete",
        "Parse",
        "DisplayName",
        "Listable",
        "ValidateOnce",
        "Prefixes",
        "Default",
        "ArgumentOperatorAliases"
    }),
    CommandMethods = Util.MakeDictionary({
        "Name",
        "Aliases",
        "AutoExec",
        "Description",
        "Args",
        "Run",
        "ClientRun",
        "Data",
        "Group"
    }),
    CommandArgProps = Util.MakeDictionary({ "Name", "Type", "Description", "Optional", "Default" }),
    Types = {},
    TypeAliases = {},
    Commands = {},
    CommandsArray = {},
    Hooks = {
        BeforeRun = {},
        AfterRun = {}
    }
}
local v2 = {}
local v3 = {
    __index = function(v4, v5) -- __index | line 47
        v4[v5] = {}
        return v4[v5]
    end
}

v1.Stores = setmetatable(v2, v3)
v1.AutoExecBuffer = {}

local function RegisterType(v6, v7, v8) -- line 54
    if v7 then
        if typeof(v7) == "string" then
        end
    else
        error("Invalid type name provided: nil")
    end
    if not v7:find("^[%d%l]%w*$") then
        error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(v7))
    end
    for v9 in pairs(v8) do
        if v6.TypeMethods[v9] == nil then
            error("Unknown key/method in type \"" .. v7 .. "\": " .. v9)
        end
    end
    if v6.Types[v7] ~= nil then
        error(("Type \"%s\" has already been registered."):format(v7))
    end
    v8.Name = v7
    v8.DisplayName = v8.DisplayName or v7
    v6.Types[v7] = v8
    if v8.Prefixes then
        v6:RegisterTypePrefix(v7, v8.Prefixes)
    end
end

v1.RegisterType = RegisterType

local function RegisterTypePrefix(v10, v11, v12) -- line 77
    if not v10.TypeAliases[v11] then
        v10.TypeAliases[v11] = v11
    end
    v10.TypeAliases[v11] = ("%s %s"):format(v10.TypeAliases[v11], v12)
end

v1.RegisterTypePrefix = RegisterTypePrefix

local function RegisterTypeAlias(v13, v14, v15) -- line 83
    local function v16(v17, ...)
        assert(v17, ...)
    end

    v16(v13.TypeAliases[v14] == nil, ("Type alias %s already exists!"):format(v15))
    v13.TypeAliases[v14] = v15
end

v1.RegisterTypeAlias = RegisterTypeAlias

local function RegisterTypesIn(v18, v19) -- line 88
    for v20, v21 in pairs(v19:GetChildren()) do
        if v21:IsA("ModuleScript") then
            v21.Parent = v18.Cmdr.ReplicatedRoot.Types
            require(v21)(v18)
        else
            v18:RegisterTypesIn(v21)
        end
    end
end

v1.RegisterTypesIn = RegisterTypesIn
v1.RegisterHooksIn = v1.RegisterTypesIn

function v1.RegisterCommandObject(v22, v23, v24) -- line 101 | captures: RunService
    for v25 in pairs(v23) do
        if v22.CommandMethods[v25] == nil then
            error("Unknown key/method in command " .. (v23.Name or "unknown command") .. ": " .. v25)
        end
    end
    if v23.Args then
        for v26, v27 in pairs(v23.Args) do
            if type(v27) == "table" then
                for v28 in pairs(v27) do
                    if v22.CommandArgProps[v28] == nil then
                        error(("Unknown property in command \"%s\" argument #%d: %s"):format(v23.Name or "unknown", v26, v28))
                    end
                end
            end
        end
    end
    if v23.AutoExec and RunService:IsClient() then
        local AutoExecBuffer = v22.AutoExecBuffer
        local AutoExec = v23.AutoExec
        table.insert(AutoExecBuffer, AutoExec)
        v22:FlushAutoExecBufferDeferred()
    end
    local v29 = v22.Commands[v23.Name:lower()]
    if v29 then
        if v29.Aliases then
            for v30, v31 in pairs(v29.Aliases) do
                local v32 = v31:lower()
                v22.Commands[v32] = nil
            end
        end
    else
        local CommandsArray = v22.CommandsArray
        table.insert(CommandsArray, v23)
    end
    v22.Commands[v23.Name:lower()] = v23
    if v23.Aliases then
        for v33, v34 in pairs(v23.Aliases) do
            v22.Commands[v34:lower()] = v23
        end
    end
end

function v1.RegisterCommand(v35, v36, v37, v38) -- line 145 | captures: RunService
    local v39 = require(v36)
    local v40 = typeof(v39) == "table"
    local v41 = ("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(v36.Name, (typeof(v39)))
    assert(v40, v41)
    if v37 then
        local v42 = RunService:IsServer()
        assert(v42, "The commandServerScript parameter is not valid for client usage.")
        v39.Run = require(v37)
    end
    if v38 then
        if v38(v39) then
            v35:RegisterCommandObject(v39)
            v36.Parent = v35.Cmdr.ReplicatedRoot.Commands
        end
    else
        v35:RegisterCommandObject(v39)
        v36.Parent = v35.Cmdr.ReplicatedRoot.Commands
    end
end

local function RegisterCommandsIn(v43, v44, v45) -- line 165
    local v46 = {}
    local v47 = {}
    for v48, v49 in pairs(v44:GetChildren()) do
        if v49:IsA("ModuleScript") then
            if v49.Name:find("Server") then
                v46[v49] = true
            else
                local v50 = v44:FindFirstChild(v49.Name .. "Server")
                if v50 then
                    v47[v50] = true
                end
                local xpcall_2 = xpcall
                local v51 = v49
                xpcall_2(function() -- line 180 | captures: v43, v45, v50, v51
                    v43:RegisterCommand(v51, v50, v45)
                end, function(v52) -- line 182 | captures: v51
                    local v53 = ("[CMDR] Command Init Error for %*:"):format(v51.Name)
                    warn(v53, v52)
                end)
            end
        else
            v43:RegisterCommandsIn(v49, v45)
        end
    end
    for v54 in pairs(v46) do
        if not v47[v54] then
            warn("Command script " .. v54.Name .. " was skipped because it has 'Server' in its name, and has no equivalent shared script.")
        end
    end
end

v1.RegisterCommandsIn = RegisterCommandsIn

function v1.RegisterDefaultCommands(v55, v56) -- line 194 | captures: RunService, Util
    local v57 = RunService:IsServer()
    assert(v57, "RegisterDefaultCommands cannot be called from the client.")
    local v58 = type(v56) == "table"
    local v59, v60
    if v58 then
        v60 = Util.MakeDictionary(v56)
        v59 = v60
    else
        v59 = v56
        v60 = v56
    end
    local DefaultCommandsFolder = v55.Cmdr.DefaultCommandsFolder
    if v58 then
        v60 = function(v61) -- v1 | line 208 | captures: v59
                return v59[v61.Group] or false
            end or
            v59
    end
    v55:RegisterCommandsIn(DefaultCommandsFolder, v60)
end

local function GetCommand(v62, v63) -- line 217
    return v62.Commands[(v63 or ""):lower()]
end

v1.GetCommand = GetCommand

local function GetCommands(v64) -- line 220
    return v64.CommandsArray
end

v1.GetCommands = GetCommands

local function GetCommandNames(v65) -- line 223
    local v66 = {}
    for v67, v68 in pairs(v65.CommandsArray) do
        local Name = v68.Name
        table.insert(v66, Name)
    end
    return v66
end

v1.GetCommandNames = GetCommandNames
v1.GetCommandsAsStrings = v1.GetCommandNames

local function GetTypeNames(v69) -- line 231
    local v70 = {}
    for v71 in pairs(v69.Types) do
        table.insert(v70, v71)
    end
    return v70
end

v1.GetTypeNames = GetTypeNames

local function GetType(v72, v73) -- line 238
    return v72.Types[v73]
end

v1.GetType = GetType

local function GetTypeName(v74, v75) -- line 241
    return v74.TypeAliases[v75] or v75
end

v1.GetTypeName = GetTypeName

local function RegisterHook(v76, v77, v78, v79) -- line 244
    if not v76.Hooks[v77] then
        local v80 = ("Invalid hook name: %q"):format(v77)
        error(v80, 2)
    end
    local v81 = v76.Hooks[v77]
    local v82 = {
        callback = v78,
        priority = v79 or 0
    }
    table.insert(v81, v82)
    table.sort(v76.Hooks[v77], function(v83, v84) -- line 250
        return v83.priority < v84.priority
    end)
end

v1.RegisterHook = RegisterHook
v1.AddHook = v1.RegisterHook

local function GetStore(v85, v86) -- line 256
    return v85.Stores[v86]
end

v1.GetStore = GetStore

function v1.FlushAutoExecBufferDeferred(v87) -- line 259 | captures: RunService
    if not v87.AutoExecFlushConnection then
        local Heartbeat = RunService.Heartbeat
        v87.AutoExecFlushConnection = Heartbeat:Connect(function() -- line 263 | captures: v87
            v87.AutoExecFlushConnection:Disconnect()
            v87.AutoExecFlushConnection = nil
            v87:FlushAutoExecBuffer()
        end)
    end
end

local function FlushAutoExecBuffer(v88) -- line 269
    for v89, v90 in ipairs(v88.AutoExecBuffer) do
        for v91, v92 in ipairs(v90) do
            v88.Cmdr.Dispatcher:EvaluateAndRun(v92)
        end
    end
    v88.AutoExecBuffer = {}
end

v1.FlushAutoExecBuffer = FlushAutoExecBuffer
return function(v93) -- line 278 | captures: v1
    v1.Cmdr = v93
    return v1
end
