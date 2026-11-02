-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local assertDeepEqual = require(script.Parent.assertDeepEqual)

local function createSpy(v1) -- line 11 | captures: assertDeepEqual
    local v2 = {
        callCount = 0,
        valuesLength = 0,
        values = {}
    }

    function v2.value(...) -- line 18 | captures: v1, v2
        v2.callCount += 1
        v2.values = { ... }
        v2.valuesLength = select("#", ...)
        if v1 == nil then
            return
        end
        return v1(...)
    end

    function v2.assertCalledWith(v3, ...) -- line 28 | captures: v2
        local v4 = select("#", ...)
        if v2.valuesLength ~= v4 then
            error(("Expected %d arguments, but was called with %d arguments"):format(v2.valuesLength, v4), 2)
        end
        for v5 = 1, v4 do
            local v6 = select(v5, ...)
            local v7 = v2.values[v5] == v6
            assert(v7, "value differs")
        end
    end

    function v2.assertCalledWithDeepEqual(v8, ...) -- line 45 | captures: v2, assertDeepEqual
        local v9 = select("#", ...)
        if v2.valuesLength ~= v9 then
            error(("Expected %d arguments, but was called with %d arguments"):format(v2.valuesLength, v9), 2)
        end
        for v10 = 1, v9 do
            local v11 = select(v10, ...)
            assertDeepEqual(v2.values[v10], v11)
        end
    end

    function v2.captureValues(v12, ...) -- line 62 | captures: v2
        local v13 = select("#", ...)
        local v14 = {}
        local v15 = v2.valuesLength == v13
        assert(v15, "length of expected values differs from stored values")
        for v16 = 1, v13 do
            v14[select(v16, ...)] = v2.values[v16]
        end
        return v14
    end

    local v17 = {
        __index = function(v18, v19) -- __index | line 77
            error(("%q is not a valid member of spy"):format(v19))
        end
    }
    setmetatable(v2, v17)
    return v2
end

return createSpy
