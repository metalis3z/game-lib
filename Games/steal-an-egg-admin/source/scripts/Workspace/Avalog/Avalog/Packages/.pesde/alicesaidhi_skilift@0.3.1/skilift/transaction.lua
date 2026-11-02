-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require("./flags")
local v1 = require("./guid")
local v2 = require("./flags")
require("./types")
local v3 = require("./session")
local v4 = require("./budget")
local v5 = require("./log")
local v6 = require("./task")
local v7 = require("./actions")
local v8 = require("./checktransaction")
return {
    create_transaction = function(v9, v10) -- create_transaction | line 18 | captures: v1, v2, v3, v4, v5, v6, v7, v8
        local global = v2.datastoreservice:GetDataStore("_$SKILIFT_TRANSACTION", "global")
        local v11 = v1()
        v5((("STARTING TRANSACTION ID %*"):format(v11)))
        local v12 = {
            state = "success",
            uuid = v11,
            sessions = {}
        }
        v5("GETTING ACTIONS FOR SUCCESS")
        v12.state = "success"
        v2.processing_transaction = v12
        local v13 = coroutine.create(v9)
        local v14, v15 = coroutine.resume(v13)
        v2.processing_transaction = false
        if not v14 then
            error(v15)
        end
        v5("GETTING ACTIONS FOR FAILURE")
        if v10 then
            v12.state = "failure"
            v2.processing_transaction = v12
            local v16 = coroutine.create(v10)
            local v17, v18 = coroutine.resume(v16)
            v2.processing_transaction = false
            if not v17 then
                error(v18)
            end
        end
        local v19 = 0
        for v20 in v12.sessions do
            v19 += 1
        end
        if v19 == 0 then
            return true
        end
        v5((("%*: WAITING FOR %* UPDATE BUDGET FOR %* SESSIONS, CURRENT: %*"):format(v11, v19 + 6, v19, (v4.get_budget("update")))))
        v4.delay_until_meets_budget("update", v19 + 6)
        local v21 = 0
        local v22 = 0
        for v23, v24 in v12.sessions do
            v5((("%*: Pulling %*"):format(v11, v23._name)))
            local spawn = v6.spawn
            local v25 = v23
            local v26 = v24
            spawn(function() -- line 66 | captures: v21, v22, v11, v25, v26, v3, v5
                local v27 = pcall(v3.pull_auto, v25, { [v11] = v26 })
                local v28 = if v27 then "SUCCESS" else "FAIL"
                v5((("%*: STATUS %*"):format(v11, v28)))
                if v27 == false then
                    v22 += 1
                end
                if v27 == true then
                    v21 += 1
                end
            end)
        end
        while v21 < v19 and v22 == 0 do
            v6.wait()
        end
        v5((("%*: TOTAL %*, SUCCESS %*, FAIL %*"):format(v11, v19, v21, v22)))
        if v21 == v19 then
            local v29 = pcall(function() -- line 83 | captures: global, v11, v4
                v4.delay_until_meets_budget("set", 1)
                global:SetAsync(v11, "finished")
            end)
            local v30 = if v29 then "SUCCESS" else "FAIL"
            v5((("%*: WRITTEN TO KEY STATUS %*"):format(v11, v30)))
            v8.set_transaction_status(v11, v29)
            for v31, v32 in v12.sessions do
                v5((("%*: Pulling %*"):format(v11, v31._name)))
                local v33 = if v29 == true then v32.success else v32.failure
                for v34, v35 in v33 do
                    local v36 = v7.obtain_transaction_action(v31._.store, v35.fn)
                    local commit_transaction_early = v3.commit_transaction_early
                    local values = v35.values
                    commit_transaction_early(v31, v36, unpack(values))
                end
            end
            return v29
        end
        v8.set_transaction_status(v11, false)
        for v37, v38 in v12.sessions do
            v5((("%*: Pulling %*"):format(v11, v37._name)))
            for v39, v40 in v38.failure do
                local v41 = v7.obtain_transaction_action(v37._.store, v40.fn)
                local commit_transaction_early = v3.commit_transaction_early
                local values = v40.values
                commit_transaction_early(v37, v41, unpack(values))
            end
        end
        return false
    end
}
