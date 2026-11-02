-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local filterMap = require(script.Parent.filterMap)
    it("should return a new table", function() -- line 4 | captures: filterMap
        local v1 = { 1, 2, 3 }

        local function callback() -- line 6
            return 1
        end

        local v2 = filterMap(v1, callback)
        expect(v2).never.to.equal(v1)
    end)
    it("should call the callback for each element", function() -- line 14 | captures: filterMap
        local v3 = { "foo1", "foo2", "foo3" }
        local v4 = {}

        local function callback(v5, v6) -- line 21 | captures: v4
            v4[v6] = v5
            return v5
        end

        filterMap(v3, callback)
        for v7, v8 in pairs(v3) do
            expect(v4[v7]).to.equal(v8)
        end
        for v9, v10 in pairs(v4) do
            expect(v10).to.equal(v3[v9])
        end
    end)
    it("should correctly use the filter callback", function() -- line 36 | captures: filterMap
        local v11 = { 1, 2, 3, 4, 5 }

        local function doubleOddOnly(v12) -- line 38
            if v12 % 2 == 0 then
                return nil
            end
            return v12 * 2
        end

        local v13 = filterMap(v11, doubleOddOnly)
        expect(#v13).to.equal(3)
        expect(v13[1]).to.equal(2)
        expect(v13[2]).to.equal(6)
        expect(v13[3]).to.equal(10)
    end)
    it("should copy the list correctly", function() -- line 53 | captures: filterMap
        local v14 = { 1, 2, 3 }

        local function copyCallback(v15) -- line 55
            return v15
        end

        local v16 = filterMap(v14, copyCallback)
        expect(v16).never.to.equal(v14)
        for v17, v18 in pairs(v14) do
            expect(v16[v17]).to.equal(v18)
        end
        for v19, v20 in pairs(v16) do
            expect(v20).to.equal(v14[v19])
        end
    end)
    it("should work with an empty table", function() -- line 71 | captures: filterMap
        local v21 = false

        local function callback() -- line 73 | captures: v21
            v21 = true
            return true
        end

        local v22 = filterMap({}, callback)
        expect(#v22).to.equal(0)
        expect(v21).to.equal(false)
    end)
    it("should remove all elements from a list when callback return always nil", function() -- line 83 | captures: filterMap
        local v23 = { 6, 2, 8, 6, 7 }

        local function removeAll() -- line 85
            return nil
        end

        local v24 = filterMap(v23, removeAll)
        expect(#v24).to.equal(0)
    end)
end
