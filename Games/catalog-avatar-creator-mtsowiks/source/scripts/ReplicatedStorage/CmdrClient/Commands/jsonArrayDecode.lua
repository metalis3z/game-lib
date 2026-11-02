-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "json-array-decode",
    Description = "Decodes a JSON Array into a comma-separated list",
    Group = "Administrator",
    Aliases = {},
    Args = { {
            Type = "json",
            Name = "JSON",
            Description = "The JSON array."
        } },

    ClientRun = function(p1, p2) -- Line: 14, Name: ClientRun
        local v3 = type(p2) ~= "table" and { p2 } or p2;

        return table.concat(v3, ",");
    end
};