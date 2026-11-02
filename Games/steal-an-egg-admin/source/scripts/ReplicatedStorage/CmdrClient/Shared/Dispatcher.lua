-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Util = require(script.Parent.Util)
local Command = require(script.Parent.Command)
local v1 = false
local v2 = {}

function v2.Evaluate(v3, v4, v5, v6, v7) -- line 13 | captures: RunService, Players, Util, Command
    if RunService:IsClient() == true and v5 ~= Players.LocalPlayer then
        error("Can't evaluate a command that isn't sent by the local player.")
    end
    local v8 = Util.SplitString(v4)
    local v9 = table.remove(v8, 1)
    local v10 = v3.Registry:GetCommand(v9)
    if v10 then
        local v11 = Util.MashExcessArguments(v8, #v10.Args)
        local v12 = Command.new({
            Dispatcher = v3,
            Text = v4,
            CommandObject = v10,
            Alias = v9,
            Executor = v5,
            Arguments = v11,
            Data = v7
        })
        local v13, v14 = v12:Parse(v6)
        if v13 then
            return v12
        end
        return false, v14
    end
    return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v9)))
end

function v2.EvaluateAndRun(v15, v16, v17, v18) -- line 40 | captures: RunService, Players
    local v19 = v17 or Players.LocalPlayer
    local v20 = v18 or {}
    if RunService:IsClient() and v20.IsHuman then
        v15:PushHistory(v16)
    end
    local v21, v22 = v15:Evaluate(v16, v19, nil, v20.Data)
    if v21 then
        local v23, v24 = xpcall(function() -- line 58 | captures: v21
            local v25, v26 = v21:Validate(true)
            if v25 then
                return v21:Run() or "Command executed."
            end
            return v26
        end, function(v27) -- line 65
            return debug.traceback((tostring(v27)))
        end)
        if v23 then
            return v24 or "An error occurred while running this command. Check the console for more information."
        end
        warn(("Error occurred while evaluating command string %q\n%s"):format(v16, (tostring(v24))))
        return "An error occurred while running this command. Check the console for more information."
    end
    return v22
end

function v2.Send(v28, v29, v30) -- line 81 | captures: RunService
    if RunService:IsClient() == false then
        error("Dispatcher:Send can only be called from the client.")
    end
    return v28.Cmdr.RemoteFunction:InvokeServer(v29, { Data = v30 })
end

function v2.Run(v31, ...) -- line 87 | captures: Players
    if not Players.LocalPlayer then
        error("Dispatcher:Run can only be called from the client.")
    end
    local v32 = { ... }
    local v33 = v32[1]
    local v34 = #v32
    for v35 = 2, v34 do
        local v36 = v32[v35]
        v33 ..= " " .. tostring(v36)
    end
    local v37, v38 = v31:Evaluate(v33, Players.LocalPlayer)
    if not v37 then
        error(v38)
    end
    local v39, v40 = v37:Validate(true)
    if not v39 then
        error(v40)
    end
    return v37:Run()
end

function v2.RunHooks(v41, v42, v43, ...) -- line 109 | captures: v1, RunService
    if not v41.Registry.Hooks[v42] then
        local v44 = ("Invalid hook name: %q"):format(v42)
        error(v44, 2)
    end
    if v42 == "BeforeRun" then
        if #v41.Registry.Hooks[v42] == 0 and v43.Group ~= "DefaultUtil" and v43.Group ~= "UserAlias" and v43:HasImplementation() then
            if RunService:IsStudio() then
                if v1 == false then
                    local v45 = if RunService:IsServer() then "<Server>" else "<Client>"
                    v43:Reply(v45 .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26))
                    v1 = true
                end
            else
                return "Command blocked for security as no BeforeRun hook is configured."
            end
        end
    else
        for v46, v47 in ipairs(v41.Registry.Hooks[v42]) do
            local v48 = v47.callback(v43, ...)
            if v48 ~= nil then
                return (tostring(v48))
            end
        end
    end
end

function v2.PushHistory(v49, v50) -- line 138 | captures: RunService, TeleportService, Util
    local v51 = RunService:IsClient()
    assert(v51, "PushHistory may only be used from the client.")
    local v52 = v49:GetHistory()
    if Util.TrimString(v50) ~= "" and v50 ~= v52[#v52] then
        v52[#v52 + 1] = v50
        TeleportService:SetTeleportSetting("CmdrCommandHistory", v52)
    end
end

function v2.GetHistory(v53) -- line 148 | captures: RunService, TeleportService
    local v54 = RunService:IsClient()
    assert(v54, "GetHistory may only be used from the client.")
    return TeleportService:GetTeleportSetting("CmdrCommandHistory") or {}
end

return function(v55) -- line 158 | captures: v2
    v2.Cmdr = v55
    v2.Registry = v55.Registry
    return v2
end
