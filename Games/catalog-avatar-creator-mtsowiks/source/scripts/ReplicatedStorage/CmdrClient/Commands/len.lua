-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "len",
    Description = "Returns the length of a comma-separated list",
    Group = "Administrator",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "CSV",
            Description = "The comma-separated list"
        } },

    Run = function(p1, p2) -- Line: 14, Name: Run
        return #p2:split(",");
    end
};