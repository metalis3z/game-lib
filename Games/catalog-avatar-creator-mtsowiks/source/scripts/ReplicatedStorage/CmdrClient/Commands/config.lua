-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "config",
    Description = "Set a local testing value for a Roblox Experience Config key. Testing changes last the lifetime of the current server and do not propagate to other servers.",
    Group = "Administrator",
    Aliases = { "cfg" },
    Args = { {
            Type = "string",
            Name = "key",
            Description = "Config key (e.g. plus_upsell_banner_enabled)."
        }, {
            Type = "string",
            Name = "value",
            Description = "Value to set. Parsed as bool/number/string (e.g. true, false, 42, some_string)."
        } }
};