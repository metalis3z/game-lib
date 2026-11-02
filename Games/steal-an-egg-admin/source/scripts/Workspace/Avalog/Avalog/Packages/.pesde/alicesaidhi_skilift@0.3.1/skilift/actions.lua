-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require("./types")
local v1 = require("./flags")
local v2 = require("./throw")

return {
    ASSERT_ACTION = function(v3, v4) -- ASSERT_ACTION | line 8 | captures: v1, v2
        local _transaction_actions = v3._transaction_actions
        local _allowed_actions = v3._allowed_actions
        if v1.processing_transaction and not _transaction_actions[v4] and _allowed_actions[v4] then
            v2("transaction_invalid_action", debug.info(v4, "sl"))
        elseif not v1.processing_transaction or _transaction_actions[v4] then
            if not v1.processing_transaction and _transaction_actions[v4] and not _allowed_actions[v4] then
                v2("action_attempt_transaction", debug.info(v4, "sl"))
            elseif not v1.processing_transaction and not _allowed_actions[v4] then
                v2("action_invalid_function", debug.info(v4, "sl"))
            end
        else
            v2("transaction_invalid_function", debug.info(v4, "sl"))
        end
    end,
    register_action = function(v5, v6) -- register_action | line 24
        v5._allowed_actions[v6] = true
        return v6
    end,
    register_transaction_action = function(v7, v8, v9) -- register_transaction_action | line 31
        local _transaction_actions = v7._transaction_actions
        local _transaction_names = v7._transaction_names
        local _allowed_actions = v7._allowed_actions
        _transaction_actions[v9] = v8
        _transaction_names[v8] = v9
        _allowed_actions[v9] = true
        return v9
    end,
    create_record = function(v10, ...) -- create_record | line 42
        return {
            v10,
            ...
        }
    end,
    create_transaction_record = function(v11, v12, ...) -- create_transaction_record | line 46
        return {
            fn = v11._transaction_actions[v12],
            values = { ... }
        }
    end,
    obtain_transaction_action = function(v13, v14) -- obtain_transaction_action | line 51 | captures: v2
        local v15 = v13._transaction_names[v14]
        if not v15 then
            v2("unknown_transaction_action", v14)
        end
        return v15
    end
}
