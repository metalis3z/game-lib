-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local map = require(script.Parent.map)
    it("should return a new table", function() -- line 4 | captures: map
        local v1 = { 1, 2, 3 }
        expect(map(v1, function() -- line 7
        end)).never.to.equal(v1)
    end)
    it("should call the callback for each element", function() -- line 10 | captures: map
        local v2 = { 5, 6, 7 }
        local v3 = {}
        map(v2, function(v4, v5) -- line 13 | captures: v3
            v3[v5] = v4
            return v4
        end)
        for v6, v7 in pairs(v2) do
            expect(v3[v6]).to.equal(v7)
        end
        for v8, v9 in pairs(v3) do
            expect(v9).to.equal(v2[v8])
        end
    end)
    it("should copy list", function() -- line 27 | captures: map
        local v10 = { 1, 2, 3 }
        local v11 = map(v10, function(v12) -- line 29
            return v12
        end)
        for v13, v14 in pairs(v10) do
            expect(v11[v13]).to.equal(v14)
        end
        for v15, v16 in pairs(v11) do
            expect(v16).to.equal(v10[v15])
        end
    end)
    it("should sets the new values to the result of the given callback", function() -- line 42 | captures: map
        local v17 = { 5, 6, 7 }
        local v18 = map(v17, function(v19) -- line 44
            return v19 * 2
        end)
        expect(#v18).to.equal(#v17)
        local v20 = #v17
        for v21 = 1, v20 do
            expect(v18[v21]).to.equal(v17[v21] * 2)
        end
    end)
    it("should work with an empty list", function() -- line 54 | captures: map
        local v22 = {}
        local v23 = map(v22, function() -- line 56
        end)
        expect(v23).to.be.a("table")
        expect(v23).never.to.equal(v22)
    end)
end
