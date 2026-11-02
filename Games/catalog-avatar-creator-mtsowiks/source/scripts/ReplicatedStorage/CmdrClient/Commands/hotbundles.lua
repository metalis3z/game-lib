-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "hotbundles",
    Description = "Shows the most frequently looked up asset IDs for bundle pricing.",
    Group = "Administrator",
    Aliases = { "hotitems" },
    Args = { {
            Type = "number",
            Name = "Count",
            Description = "Number of top items to show.",
            Optional = true
        } }
};