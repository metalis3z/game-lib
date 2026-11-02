-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "alias",
    Description = "Creates a new, single command out of a command and given arguments.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "string",
            Name = "Alias name",
            Description = "The key or input type you'd like to bind the command to."
        },
        {
            Type = "string",
            Name = "Command string",
            Description = "The command text you want to run. Separate multiple commands with \"&&\". Accept arguments with $1, $2, $3, etc."
        }
    },
    ClientRun = function(v1, v2, v3) -- ClientRun | line 15
        local v4 = v1.Cmdr.Util.MakeAliasCommand(v2, v3)
        v1.Cmdr.Registry:RegisterCommandObject(v4, true)
        return ("Created alias %q"):format(v2)
    end
}
