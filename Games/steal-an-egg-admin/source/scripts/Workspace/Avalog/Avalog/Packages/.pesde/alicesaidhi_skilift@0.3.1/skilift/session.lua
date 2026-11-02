-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require("./types")
local v1 = require("./budget")
local v2 = require("./retry")
local v3 = require("./log")
local v4 = require("./actions")
local v5 = require("./flags")
local v6 = require("./task")
local v7 = require("./checktransaction")
local v8 = require("./util")
local v9 = require("./throw")
local profilebegin = debug.profilebegin or function() -- line 14
end
local profileend = debug.profileend or function() -- line 15
end

local function v10() -- line 17
end

local function merge(v11, v12) -- line 29
    local v13 = table.create(#v11 + #v12)
    table.move(v11, 1, #v11, 1, v13)
    table.move(v12, 1, #v12, #v11 + 1, v13)
    return v13
end

local function migrate(v14, v15) -- line 36 | captures: v3, v9
    local migrations = v14._.options.migrations
    if #migrations == #v15.migrations_performed then
        return false
    end
    v3((("%*: Performing Migration"):format(v14.name)))
    for v16, v17 in migrations do
        if not table.find(v15.migrations_performed, v17.step) then
            v3((("%*: Migration Step %*"):format(v14.name, v17.step)))
            local v18 = v17.migrate(v15.data)
            if v18 == nil then
                v9("migration_does_not_return", v17.step)
            end
            v15.data = v18
            local migrations_performed = v15.migrations_performed
            local step = v17.step
            table.insert(migrations_performed, step)
        end
    end
    return true
end

local function perform_transaction(v19, v20, v21) -- line 54 | captures: v4, v8, v9
    local v22 = v4.obtain_transaction_action(v19, v21.fn)
    local values = v21.values
    local v23 = v22(v8.clone(v20.data), unpack(values))
    if v23 == nil then
        v9("cannot_cancel_action", v21.fn)
    end
    v20.data = v23
end

local function create_migrations_table(v24) -- line 63
    local v25 = {}
    for v26, v27 in v24._.options.migrations do
        local step = v27.step
        table.insert(v25, step)
    end
    return v25
end

local function check_transaction(v28, v29, v30) -- line 71 | captures: v3
    for v31, v32 in v30.pending_transactions do
        for v33, v34 in v32.success do
            if not v28._transaction_names[v34.fn] then
                v29._.why_bad = ("Transaction could not be processed: Unable to recognize the action \"%*\""):format(v34.fn)
                v3(v29._.why_bad)
                return false
            end
        end
    end
    return true
end

local function check_migrations(v35, v36) -- line 83 | captures: v3
    local v37 = {}
    for v38, v39 in v35._.options.migrations do
        local step = v39.step
        table.insert(v37, step)
    end
    for v40, v41 in v36.migrations_performed do
        if not table.find(v37, v41) then
            v35._.why_bad = ("Migration could not be completed: Unable to apply \"%*\""):format(v41)
            v3(v35._.why_bad)
            return false
        end
    end
    return true
end

local function run_updated(v42) -- line 94 | captures: v5, v8
    local data = v42._.cached.data
    local updated = v42._.updated
    if not v5.strict then
        data = v8.deep_freeze(v8.clone(data))
    end
    return updated(data)
end

local function update(v43, v44, v45, v46, v47) -- line 102 | captures: v3, v4, v7, v8, v9, migrate, check_transaction, check_migrations
    local store = v43._.store
    local v48 = v46 == nil
    local v49
    if v46 == nil then
        v49 = {
            pending_transactions = {}
        }
        local v50 = {}
        for v51, v52 in v43._.options.migrations do
            local step = v52.step
            table.insert(v50, step)
        end
        v49.migrations_performed = v50
        v49.data = v43._.options.default_data()
    else
        v49 = v46
    end
    v3((("Applying %* changes to %*"):format(#v44, v43.name)))
    if check_migrations(v43, v49) and check_transaction(store, v43, v49) then
        local v53 = false
        for v54, v55 in v49.pending_transactions do
            local v56 = v7.is_transaction_complete(v54)
            v3((("%*: Pending Transaction Status %*: %*"):format(v43.name, v54, v56)))
            if v56 == "completed" then
                for v57, v58 in v55.success do
                    local v59 = v4.obtain_transaction_action(store, v58.fn)
                    local values = v58.values
                    local v60 = v59(v8.clone(v49.data), unpack(values))
                    if v60 == nil then
                        v9("cannot_cancel_action", v58.fn)
                    end
                    v49.data = v60
                end
                v49.pending_transactions[v54] = nil
                v53 = true
            elseif v56 == "failed" then
                for v61, v62 in v55.failure do
                    local v63 = v4.obtain_transaction_action(store, v62.fn)
                    local values = v62.values
                    local v64 = v63(v8.clone(v49.data), unpack(values))
                    if v64 == nil then
                        v9("cannot_cancel_action", v62.fn)
                    end
                    v49.data = v64
                end
                v49.pending_transactions[v54] = nil
                v53 = true
            elseif v56 ~= "unknown" then
                error("unhandled case")
            end
        end
        if migrate(v43, v49) then
            v53 = true
        end
        for v65, v66 in v45 do
            v3((("Added transaction %* to %*"):format(v65, v43.name)))
            v49.pending_transactions[v65] = v66
            v53 = true
        end
        for v67, v68 in v44 do
            local v69 = v68[1]
            local sl, sl_2 = debug.info(v68[1], "sl")
            v3(("Applying action %*:%* with"):format(sl, sl_2), unpack(v68, 2))
            local v70 = v69(v49.data, unpack(v68, 2))
            if v70 ~= nil then
                v49.data = v70
                v53 = true
            end
        end
        if v53 ~= false or v48 then
            v3((("Returning updated data for %*"):format(v43.name)))
            return v49, v43._.user_ids
        end
        v3((("No data has updated for %*. Cancelling update."):format(v43.name)))
    else
        v43._.finished = "done"
    end
    return nil
end

local function pull_auto(v71, v72) -- line 179 | captures: v1, v3, v5, v8, merge, update
    v1.delay_until_meets_budget("update", 5)
    local v73 = {}
    local datastore = v71._.datastore
    local key = v71.key
    v71._.next_save_opportunity = (1/0)
    v3("saving", v71.name)
    local v74, v75 = pcall(function() -- line 189 | captures: v73, v71, v72, datastore, key, v3, merge, update
        v3("attempting auto-save")
        local v76
        datastore:UpdateAsync(key, function(v77, v78) -- line 192 | captures: v76, v73, v71, v72, v3, merge, update
            v73 = merge(v73, v71._.changes)
            v71._.changes = {}
            v3("retrieved", v77)
            local v79 = update(v71, v73, v72, v77, v78)
            if v79 == nil then
                v76 = v77
            else
                v76 = v79
            end
            local v80 = if v79 == nil then "cancelled update as no change has been made" else "saved new data"
            v3(v80)
            return v79
        end)
        v3("FINISHED SAVE")
        return v76
    end)
    v71._.next_save_opportunity = v71._.pull_delay
    if not v74 then
        v71._.changes = merge(v73, v71._.changes)
        error((("Failed to pull. This issue is not because of %*"):format(v75)))
    end
    v71._.first_request_succeeded = true
    for v81, v82 in v71._.waiting_for_saved do
        v82()
    end
    table.clear(v71._.waiting_for_saved)
    if v75 == nil then
        v71._.why_bad = "missing data"
    end
    if v71._.why_bad then
        error((("Failed to pull as the server has encountered some error: %*"):format(v71._.why_bad)))
    end
    for v83, v84 in v71._.changes do
        local v85 = v84[1]
        local sl, sl_2 = debug.info(v84[1], "sl")
        v3(("Applying action %*:%* with"):format(sl, sl_2), unpack(v84, 2))
        local v86 = v85(v75.data, unpack(v84, 2))
        if v86 ~= nil then
            v75.data = v86
        end
    end
    v3("value is", v75)
    v71._.cached = v75
    v3(("%* calling updated -"):format(v71.name), debug.info(v71._.updated, "sl"))
    local data = v71._.cached.data
    local updated = v71._.updated
    if not v5.strict then
        data = v8.deep_freeze(v8.clone(data))
    end
    updated(data)
end

local function force_pull(v87) -- line 245 | captures: v1, v2, v3, v5, v8, merge, update
    v3("forcing save")
    local v88 = {}
    local datastore = v87._.datastore
    local key = v87.key
    v87._.next_save_opportunity = (1/0)
    local v89 = v2.regular_retry(function() -- line 252 | captures: v88, v87, datastore, key, v1, v3, merge, update
        v3("waiting until budget is met")
        v1.delay_until_meets_budget("update", 5)
        local v90
        v3("performing save")
        datastore:UpdateAsync(key, function(v91, v92) -- line 257 | captures: v90, v88, v87, v3, merge, update
            v88 = merge(v88, v87._.changes)
            v87._.changes = {}
            v3("retrieved", v91)
            local v93 = update(v87, v88, {}, v91, v92)
            if v93 == nil then
                v90 = v91
            else
                v90 = v93
            end
            local v94 = if v93 == nil then "cancelled update as no change has been made" else "saved new data"
            v3(v94)
            return v93
        end)
        v3("finished")
        return v90
    end, 1)
    v87._.first_request_succeeded = true
    for v95, v96 in v87._.waiting_for_saved do
        v96()
    end
    table.clear(v87._.waiting_for_saved)
    v87._.next_save_opportunity = v87._.pull_delay
    local _ = v87._
    if v89 == nil then
        _.cached = v87._.cached
    else
        _.cached = v89
    end
    for v97, v98 in v87._.changes do
        local v99 = v98[1]
        local sl, sl_2 = debug.info(v98[1], "sl")
        v3(("Applying action %*:%* with"):format(sl, sl_2), unpack(v98, 2))
        local v100 = v99(v89.data, unpack(v98, 2))
        if v100 ~= nil then
            v89.data = v100
        end
    end
    v3(("%* calling updated on force"):format(v87.name), debug.info(v87._.updated, "sl"))
    local data = v87._.cached.data
    local updated = v87._.updated
    if not v5.strict then
        data = v8.deep_freeze(v8.clone(data))
    end
    updated(data)
end

local function thread(v101) -- line 294 | captures: v3, v6, pull_auto
    while true do
        if v101._.next_save_opportunity > 0 then
            local v102 = v6.wait()
            local _ = v101._
            _.next_save_opportunity -= v102
            continue
        end
        v3("triggering auto-save for", v101.name)
        local v103, v104 = pcall(pull_auto, v101, {})
        if not v103 then
            warn("autosave error:", v104)
        end
        if v101._.why_bad then
            break
        end
    end
end

local function patch_transaction(v105, v106, ...) -- line 309 | captures: v3, v4, v5, v8, v9, profilebegin, profileend
    local store = v105._.store
    if v5.strict then
        local v107 = select("#", ...)
        for v108 = 1, v107 do
            local v109, v110 = pcall(v8.check_json_valid, select(v108, ...))
            if v109 == false then
                v9("strict_pass_not_json_into_action", (tostring(v110)))
            end
        end
        profilebegin("strict mode")
        local data = v105._.cached.data
        local v111 = v106(v8.clone(data), ...)
        local v112 = v106(v8.clone(data), ...)
        if not (v111 == nil and v112 == nil) then
            local v113, v114 = pcall(v8.check_json_valid, v111)
            if v113 == false then
                v9("strict_not_json_from_action", debug.info(v106, "s"), (tostring(v114)))
            end
            local v115, v116 = v8.delta_eq(v111, v112)
            if not v115 then
                v9("strict_impure_action", debug.info(v106, "sl"), v116)
            end
            profileend()
            if v105._.options.schema and not v105._.options.schema(v111) then
                v9("schema_validation_error", v105.name, debug.info(v106, "n"))
            end
        else
            return false
        end
    else
        local v117 = v106(v8.clone(v105._.cached.data), ...)
        if v117 == nil then
            return false
        end
        if v105._.options.schema and not v105._.options.schema(v117) then
            v9("schema_validation_error", v105.name, debug.info(v106, "n"))
        end
    end
    local processing_transaction = v5.processing_transaction
    local v118 = processing_transaction.sessions[v105] or
    {
        success = {},
        failure = {}
    }
    local v119 = v4.create_transaction_record(store, v106, ...)
    if processing_transaction.state == "failure" then
        v3((("Adding transaction action on failure \"%*\" for %*"):format(v119.fn, v105.name)))
        local failure = v118.failure
        table.insert(failure, v119)
    elseif processing_transaction.state == "success" then
        v3((("Adding transaction action on success \"%*\" for %*"):format(v119.fn, v105.name)))
        local success = v118.success
        table.insert(success, v119)
    end
    processing_transaction.sessions[v105] = v118
    return true
end

local function patch_regular(v120, v121, ...) -- line 373 | captures: v3, v4, v5, v8, v9, profilebegin, profileend
    local function v122(v123, ...)
        table.insert(v123, ...)
    end

    local function v124(v125, ...)
        table.insert(v125, ...)
    end

    local sl, sl_2 = debug.info(v121, "sl")
    v3((("Performing %*:%* for %*"):format(sl, sl_2, v120.name)))
    if v5.strict then
        profilebegin("strict mode")
        local data = v120._.cached.data
        local v126 = v121(v8.clone(data), ...)
        local v127 = v121(v8.clone(data), ...)
        if not (v126 == nil and v127 == nil) then
            local v128, v129 = pcall(v8.check_json_valid, v126)
            if v128 == false then
                v9("strict_not_json_from_action", debug.info(v121, "s"), (tostring(v129)))
            end
            local v130, v131 = v8.delta_eq(v126, v127)
            if not v130 then
                v9("strict_impure_action", debug.info(v121, "sl"), v131)
            end
            profileend()
            if v120._.options.schema and not v120._.options.schema(v126) then
                v9("schema_validation_error", v120.name, debug.info(v121, "n"))
            end
            v122(v120._.changes, v4.create_record(v121, ...))
            v120._.cached.data = v126
            local data = v120._.cached.data
            local updated = v120._.updated
            if not v5.strict then
                data = v8.deep_freeze(v8.clone(data))
            end
            updated(data)
        else
            return false
        end
    else
        local v132 = v121(v120._.cached.data, ...)
        if v132 == nil then
            return false
        end
        if v120._.options.schema and not v120._.options.schema(v132) then
            v9("schema_validation_error", v120.name, debug.info(v121, "n"))
        end
        v124(v120._.changes, v4.create_record(v121, ...))
        v120._.cached.data = v132
        local data = v120._.cached.data
        local updated = v120._.updated
        if not v5.strict then
            data = v8.deep_freeze(v8.clone(data))
        end
        updated(data)
    end
    return true
end

local function commit_transaction_early(v133, v134, ...) -- line 424 | captures: v3, v5, v8, v9, profilebegin, profileend
    local sl, sl_2 = debug.info(v134, "sl")
    v3((("Performing %*:%* for %*"):format(sl, sl_2, v133.name)))
    if v5.strict then
        profilebegin("strict mode")
        local data = v133._.cached.data
        local v135 = v134(v8.clone(data), ...)
        local v136 = v134(v8.clone(data), ...)
        if v135 == nil or v136 == nil then
            v9("cannot_cancel_action", debug.info(v134, "n"))
        end
        local v137, v138 = pcall(v8.check_json_valid, v135)
        if v137 == false then
            v9("strict_not_json_from_action", debug.info(v134, "s"), (tostring(v138)))
        end
        local v139, v140 = v8.delta_eq(v135, v136)
        if not v139 then
            v9("strict_impure_action", debug.info(v134, "sl"), v140)
        end
        profileend()
        if v133._.options.schema and not v133._.options.schema(v135) then
            v9("schema_validation_error", v133.name, debug.info(v134, "n"))
        end
        v133._.cached.data = v135
        local data_2 = v133._.cached.data
        local updated = v133._.updated
        if not v5.strict then
            data_2 = v8.deep_freeze(v8.clone(data_2))
        end
        updated(data_2)
    else
        local v141 = v134(v133._.cached.data, ...)
        if v133._.options.schema and not v133._.options.schema(v141) then
            v9("schema_validation_error", v133.name, debug.info(v134, "n"))
        end
        v133._.cached.data = v141
    end
end

local function patch(v142, v143, ...) -- line 469 | captures: v4, v5, v9, patch_transaction, patch_regular
    if v142._.finished then
        v9("session_already_stopped")
    end
    v4.ASSERT_ACTION(v142._.store, v143)
    if v5.processing_transaction then
        return patch_transaction(v142, v143, ...)
    end
    return patch_regular(v142, v143, ...)
end

local function updated(v144, v145) -- line 480 | captures: v3, v5, v8, v9
    if v144._.finished then
        v9("session_already_stopped")
    end
    v144._.updated = v145
    v3(("%* calling updated register"):format(v144.name), debug.info(v145, "sl"))
    local data = v144._.cached.data
    local updated = v144._.updated
    if not v5.strict then
        data = v8.deep_freeze(v8.clone(data))
    end
    updated(data)
end

local function stop(v146) -- line 488 | captures: v6, v10, force_pull
    if v146._.finished ~= false then
        return
    end
    v146._.finished = "saving"
    v146._.updated = v10
    v6.cancel(v146._.thread)
    v6.spawn(function() -- line 493 | captures: v146, force_pull
        force_pull(v146)
        v146._.finished = "done"
    end)
end

local function await(v147) -- line 499 | captures: v6
    if v147._.finished == "done" then
        return
    end
    local v148 = false
    local waiting_for_saved = v147._.waiting_for_saved

    local function v149() -- line 503 | captures: v148
        v148 = true
    end

    table.insert(waiting_for_saved, v149)
    while not v148 do
        v6.wait()
    end
end

local function bad(v150) -- line 509
    return v150._.why_bad
end

local function add_userid(v151, v152) -- line 513 | captures: v9
    if v151._.finished then
        v9("session_already_stopped")
    end
    local user_ids = v151._.user_ids
    table.insert(user_ids, v152)
end

local function loaded(v153) -- line 518
    return v153._.first_request_succeeded
end

return {
    load_session = function(v154, v155) -- load_session | line 522 | captures: v6, v10, thread, patch, updated, stop, await, bad, add_userid, loaded
        local v156 = {
            _ = {
                next_save_opportunity = 0,
                first_request_succeeded = false,
                finished = false,
                store = v154,
                datastore = v154._store,
                options = v154._options,
                changes = {},
                pending_transactions = {},
                waiting_for_saved = {},
                updated = v10,
                user_ids = {},
                pull_delay = v154._options.pull_delay or 15,
                cached = {
                    pending_transactions = {},
                    migrations_performed = {},
                    data = v154._options.default_data()
                }
            },
            name = ("%*:%*"):format(v154._store.Name, v155),
            key = v155
        }
        v156.patch = patch
        v156.updated = updated
        v156.stop = stop
        v156.userid = add_userid
        v156.loaded = loaded
        v156.bad = bad
        v156.await = await
        v156._.thread = v6.spawn(thread, v156)
        return v156
    end,
    pull_auto = pull_auto,
    force_pull = force_pull,
    perform_transaction = perform_transaction,
    commit_transaction_early = commit_transaction_early
}
