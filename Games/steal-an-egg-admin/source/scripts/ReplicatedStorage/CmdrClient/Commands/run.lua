-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "run",
    Description = "Runs a given command string (replacing embedded commands).",
    Group = "DefaultUtil",
    Aliases = { ">" },
    AutoExec = { "alias \"discard|Run a command and discard the output.\" replace ${run $1} .* \\\"\\\"" },
    Args = {
        {
            Type = "string",
            Name = "Command",
            Description = "The command string to run"
        }
    },
    Run = function(v1, v2) -- Run | line 15
        return v1.Cmdr.Util.RunCommandString(v1.Dispatcher, v2)
    end
}
