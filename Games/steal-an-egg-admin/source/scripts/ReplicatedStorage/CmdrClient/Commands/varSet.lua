-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "var=",
    Description = "Sets a stored value.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "storedKey",
            Name = "Key",
            Description = "The key to set, saved in your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved."
        },
        {
            Type = "string",
            Name = "Value",
            Description = "Value or values to set.",
            Default = ""
        }
    },
    ClientRun = function(v1, v2) -- ClientRun | line 15
        v1:GetStore("vars_used")[v2] = true
    end
}
