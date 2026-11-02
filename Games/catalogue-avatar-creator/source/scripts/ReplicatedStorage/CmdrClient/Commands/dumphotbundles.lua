-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "dumphotbundles",
    Description = "Fetches top tracked bundle lookups and prints hardcodeable cache entries.",
    Group = "Administrator",
    Aliases = { "dumpbundles" },
    Args = { {
            Type = "number",
            Name = "Count",
            Description = "Number of top items to fetch (default 30).",
            Optional = true
        } }
};