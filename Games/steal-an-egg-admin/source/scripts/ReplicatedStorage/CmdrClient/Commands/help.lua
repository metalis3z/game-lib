-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Name = "help",
    Description = "Displays a list of all commands, or inspects one command.",
    Group = "Help"
}
local v2 = {}

v2[1] = {
    Type = "command",
    Name = "Command",
    Description = "The command to view information on",
    Optional = true
}
v1.Args = v2

function v1.ClientRun(v3, v4) -- line 11
    if v4 then
        local v5 = v3.Cmdr.Registry:GetCommand(v4)
        v3:Reply(("Command: %*"):format(v5.Name), Color3.fromRGB(230, 126, 34))
        if v5.Aliases and #v5.Aliases > 0 then
            v3:Reply(("Aliases: %*"):format((table.concat(v5.Aliases, ", "))), Color3.fromRGB(230, 230, 230))
        end
        v3:Reply(v5.Description, Color3.fromRGB(230, 230, 230))
        for v6, v7 in ipairs(v5.Args) do
            local v8 = if v7.Optional == true then "?" else "";
            (nil):Reply((("#%* %*%*: %* - %*"):format(v6, v7.Name, v8, v7.Type, v7.Description)))
        end
    else
        v3:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n")
        v3:Reply("Tips\n----\n\226\128\162 Utilize the Tab key to automatically complete commands\n\226\128\162 Easily select and copy command output\n")
        local v9 = v3.Cmdr.Registry:GetCommands()
        table.sort(v9, function(v10, v11) -- line 18
            if v10.Group and v11.Group then
                return v10.Group < v11.Group
            end
            return v10.Group
        end)
        local Group
        for v12, v13 in ipairs(v9) do
            v13.Group = v13.Group or "No Group"
            if Group ~= v13.Group then
                v3:Reply((("\n%*\n%*"):format(v13.Group, (string.rep("-", #v13.Group)))))
                Group = v13.Group
            end
            local v14
            if v13.Description then
                v14 = ("%* - %*"):format(v13.Name, v13.Description)
            else
                v14 = v13.Name
            end
            v3:Reply(v14)
        end
    end
    return ""
end

return v1
