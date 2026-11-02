-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require("./types")
local v1 = require("./store")
local v2 = require("./transaction")
local v3 = require("./checktransaction")
local v4 = require("./flags")
local v5 = {
    store = v1,
    transaction = v2.create_transaction,
    flush = v3.flush_transactions
}

function v5.strict(v6) -- line 18 | captures: v4
    if v6 ~= nil then
        v4.strict = v6
    end
    return v4.strict
end

function v5.mock(v7) -- line 26 | captures: v4
    v4.datastoreservice = v7
end

return v5
