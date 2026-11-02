-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "version",
    Description = "Shows the current version of Cmdr",
    Group = "Administrator",
    Args = {},

    Run = function() -- Line: 9, Name: Run
        return ("Cmdr Version %s"):format("v1.12.0");
    end
};