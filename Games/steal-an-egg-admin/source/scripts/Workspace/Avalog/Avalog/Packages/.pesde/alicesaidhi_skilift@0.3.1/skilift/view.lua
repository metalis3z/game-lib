-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require("./types")
local v1 = require("./retry")
local v2 = require("./budget")
return {
    view_key = function(v3, v4) -- view_key | line 9 | captures: v1, v2
        local v5 = {}
        local _store = v3._store

        function v5.latest(v6) -- line 13 | captures: v4, _store, v1, v2
            return v1.exponential_backoff(function() -- line 14 | captures: v4, _store, v2
                    v2.delay_until_meets_budget("get", 1)
                    return _store:GetAsync(v4) or { data = nil }
                end).data
        end

        function v5.version(v7, v8) -- line 22 | captures: v4, _store, v1, v2
            return v1.exponential_backoff(function() -- line 23 | captures: v8, v4, _store, v2
                    v2.delay_until_meets_budget("get_version", 1)
                    return _store:GetVersionAsync(v4, v8) or { data = nil }
                end).data
        end

        function v5.timestamp(v9, v10) -- line 31 | captures: v4, _store, v1, v2
            return v1.exponential_backoff(function() -- line 32 | captures: v10, v4, _store, v2
                    v2.delay_until_meets_budget("get_version", 1)
                    return _store:GetVersionAtTimeAsync(v4, v10) or { data = nil }
                end).data
        end

        return v5
    end
}
