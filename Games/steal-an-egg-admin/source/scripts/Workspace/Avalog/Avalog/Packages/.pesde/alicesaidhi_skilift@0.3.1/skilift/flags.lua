-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require("./types")

local function inline_test() -- line 5
    return debug.info(1, "n")
end

local v1 = {
    processing_transaction = false,
    disable_new_actions = false,
    print = false,
    strict = debug.info(1, "n") == "inline_test"
}

if game then
    v1.datastoreservice = game:GetService("DataStoreService")
else
    v1.datastoreservice = nil
end
return v1
