-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = require("./flags")
require("./types")
local v2 = require("./retry")
local v3 = require("./task")
local v4 = {}
local v5 = {}

local function set_transaction_status(v6, v7, v8) -- line 19 | captures: v4, v5
    v4[v6] = v7
    local v9 = {
        id = v6,
        lifetime = os.clock() + 5400
    }
    table.insert(v5, v9)
end

local function request_for_transaction(v10) -- line 24 | captures: v1, v2, v4, v5
    local global = v1.datastoreservice:GetDataStore("_$SKILIFT_TRANSACTION", "global")
    local v11 = not not v2.exponential_backoff(function() -- line 27 | captures: v10, global
            return global:GetAsync(v10)
        end)
    v4[v10] = v11
    local v12 = {
        id = v10,
        lifetime = os.clock() + 5400
    }
    table.insert(v5, v12)
end

local function is_transaction_complete(v13) -- line 34 | captures: v3, v4, request_for_transaction
    local v14 = v4[v13]
    if v14 == true then
        return "completed"
    end
    if v14 == false then
        return "failed"
    end
    v3.spawn(request_for_transaction, v13)
    if v4[v13] then
        return "completed"
    end
    return "unknown"
end

return {
    request_for_transaction = request_for_transaction,
    is_transaction_complete = is_transaction_complete,
    set_transaction_status = set_transaction_status,
    flush_transactions = function() -- flush_transactions | line 47 | captures: v5
        while true do
            if v5[1] and v5[1].lifetime < os.clock() then
                table.remove(v5, 1)
                continue
            end
            if #v5 > 9000 then
                table.remove(v5, 1)
                continue
            end
            break
        end
    end
}
