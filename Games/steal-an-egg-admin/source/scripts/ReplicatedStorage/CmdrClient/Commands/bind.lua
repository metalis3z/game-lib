-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local UserInputService = game:GetService("UserInputService")
local v1 = {
    Name = "bind",
    Description = "Binds a command string to a key or mouse input.",
    Group = "DefaultUtil",
    Aliases = {}
}
local v2 = {}
local v3 = {
    Type = "string",
    Name = "Arguments",
    Description = "The arguments for the command",
    Default = ""
}

v2[1] = {
    Type = "userInput ! bindableResource @ player",
    Name = "Input",
    Description = "The key or input type you'd like to bind the command to."
}
v2[2] = {
    Type = "command",
    Name = "Command",
    Description = "The command you want to run on this input"
}
v2[3] = v3
v1.Args = v2

function v1.ClientRun(v4, v5, v6, v7) -- line 14 | captures: UserInputService
    local CMDR_Binds = v4:GetStore("CMDR_Binds")
    local v8 = v6 .. " " .. v7
    if CMDR_Binds[v5] then
        CMDR_Binds[v5]:Disconnect()
    end
    local Name = v4:GetArgument(1).Type.Name
    if Name == "userInput" then
        local InputBegan = UserInputService.InputBegan
        CMDR_Binds[v5] = InputBegan:Connect(function(v9, v10) -- line 22 | captures: v4, v5, v8
            if not v10 and (v9.UserInputType == v5 or v9.KeyCode == v5) then
                v4:Reply(v4.Dispatcher:EvaluateAndRun(v4.Cmdr.Util.RunEmbeddedCommands(v4.Dispatcher, v8)))
            end
        end)
    else
        if Name == "bindableResource" then
            return "Unimplemented..."
        end
        if Name == "player" then
            local Chatted = v5.Chatted
            CMDR_Binds[v5] = Chatted:Connect(function(v11) -- line 38 | captures: v4, v5, v8
                local v12 = v4.Cmdr.Util.RunEmbeddedCommands(v4.Dispatcher, v4.Cmdr.Util.SubstituteArgs(v8, { v11 }))
                local v13 = ("%s $ %s : %s"):format(v5.Name, v12, v4.Dispatcher:EvaluateAndRun(v12))
                v4:Reply(v13, Color3.fromRGB(244, 92, 66))
            end)
        end
    end
    return "Bound command to input."
end

return v1
