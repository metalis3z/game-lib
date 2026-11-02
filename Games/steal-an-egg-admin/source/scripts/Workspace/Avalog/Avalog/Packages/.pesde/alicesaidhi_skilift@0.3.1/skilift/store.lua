-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = require("./actions")
require("./types")
local v2 = require("./view")
local v3 = require("./session")
local v4 = require("./flags")

local function add_action(v5, v6, v7) -- line 10 | captures: v1
    local v8, v9
    if v7 then
        v8 = v6
        v9 = v7
    else
        v9 = v6
    end
    if v8 then
        v1.register_transaction_action(v5, v9, v8)
    else
        v1.register_action(v5, v9)
    end
    return v9
end

local function get_store(v10) -- line 16 | captures: v1, v2, v3, v4
    local v11 = {
        _options = v10,
        _allowed_actions = {},
        _transaction_actions = {},
        _transaction_names = {},
        _store = v4.datastoreservice:GetDataStore(v10.name, v10.scope)
    }
    v11.action = v1.register_action
    v11.transaction = v1.register_transaction_action
    v11.load = v3.load_session
    v11.view = v2.view_key
    return v11
end

return get_store
