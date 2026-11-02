-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "plus",
    Description = "Toggle Roblox Plus mock state and runtime render dials.",
    Group = "Administrator",
    Aliases = { "robloxplus" },
    Args = { {
            Type = "string",
            Name = "action",
            Description = "on | off | tier | variant | itemvariant | totalvariant | color | upsell | flag | status (prefix-matched)"
        }, {
            Type = "string",
            Name = "value",
            Description = "Value for the action (e.g. 10, 20, chipSuffix, #FF00FF, flag name). Optional for on/off/status.",
            Optional = true
        }, {
            Type = "string",
            Name = "value2",
            Description = "Only used by `flag` action: on|off to set the named FeatureFlag.",
            Optional = true
        } }
};