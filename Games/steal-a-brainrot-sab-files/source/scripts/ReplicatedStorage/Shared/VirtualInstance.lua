



local v_u_12 = {
    ["__index"] = function(p1, p2)
        local v3 = p1.__internals
        if v3.lastSet[p2] == nil then
            return v3.instance[p2]
        else
            return v3.lastSet[p2]
        end
    end,
    ["__newindex"] = function(p4, p5, p6)
        local v7 = p6 ~= nil
        assert(v7, "cannot set vinst property to nil")
        local v_u_8 = p4.__internals
        if v_u_8.lastSet[p5] ~= p6 then
            v_u_8.bufferedChanges[p5] = p6
            v_u_8.lastSet[p5] = p6
            if not v_u_8.hasBuffered then
                v_u_8.hasBuffered = true
                task.defer(function()
                    local v9 = v_u_8.instance
                    if v_u_8.hasBuffered then
                        v_u_8.hasBuffered = false
                        for v10, v11 in v_u_8.bufferedChanges do
                            v9[v10] = v11
                        end
                        table.clear(v_u_8.bufferedChanges)
                    end
                end)
            end
        end
    end
}
return {
    ["wrap"] = function(p13)
        local v14 = {
            ["__internals"] = {
                ["instance"] = p13,
                ["lastSet"] = {},
                ["bufferedChanges"] = {},
                ["hasBuffered"] = false
            }
        }
        local v15 = v_u_12
        return setmetatable(v14, v15)
    end
}