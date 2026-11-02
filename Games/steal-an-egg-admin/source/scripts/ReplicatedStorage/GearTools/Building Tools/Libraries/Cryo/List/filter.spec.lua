-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local filter = require(script.Parent.filter)
    it("should call the callback for each element", function() -- line 4 | captures: filter
        local v1 = { "foo1", "foo2", "foo3" }
        local v2 = {}

        local function copyCallback(v3, v4) -- line 11 | captures: v2
            v2[v4] = v3
            return true
        end

        filter(v1, copyCallback)
        for v5, v6 in pairs(v1) do
            expect(v2[v5]).to.equal(v6)
        end
        for v7, v8 in pairs(v2) do
            expect(v8).to.equal(v1[v7])
        end
    end)
    it("should correctly use the filter callback", function() -- line 26 | captures: filter
        local v9 = { 1, 2, 3, 4, 5 }

        local function evenOnly(v10) -- line 28
            return v10 % 2 == 0
        end

        local v11 = filter(v9, evenOnly)
        expect(#v11).to.equal(2)
        expect(v11[1]).to.equal(2)
        expect(v11[2]).to.equal(4)
    end)
    it("should copy the list correctly", function() -- line 38 | captures: filter
        local v12 = { 1, 2, 3 }

        local function keepAll() -- line 40
            return true
        end

        local v13 = filter(v12, keepAll)
        expect(v13).never.to.equal(v12)
        for v14, v15 in pairs(v12) do
            expect(v13[v14]).to.equal(v15)
        end
        for v16, v17 in pairs(v13) do
            expect(v17).to.equal(v12[v16])
        end
    end)
    it("should work with an empty table", function() -- line 56 | captures: filter
        local v18 = false

        local function callback() -- line 58 | captures: v18
            v18 = true
            return true
        end

        local v19 = filter({}, callback)
        expect(#v19).to.equal(0)
        expect(v18).to.equal(false)
    end)
    it("should remove all element from a list when callback return always false", function() -- line 68 | captures: filter
        local v20 = { 6, 2, 8, 6, 7 }

        local function removeAll() -- line 70
            return false
        end

        local v21 = filter(v20, removeAll)
        expect(#v21).to.equal(0)
    end)
end
