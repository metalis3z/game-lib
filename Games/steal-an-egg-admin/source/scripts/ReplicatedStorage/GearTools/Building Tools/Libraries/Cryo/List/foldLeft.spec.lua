-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local foldLeft = require(script.Parent.foldLeft)
    it("should call the callback", function() -- line 4 | captures: foldLeft
        local v1 = { 1, 2, 3 }
        local v2 = 0
        foldLeft(v1, function() -- line 8 | captures: v2
            v2 += 1
        end, 0)
        expect(v2).to.equal(3)
    end)
    it("should not call the callback when the list is empty", function() -- line 15 | captures: foldLeft
        local v3 = false
        foldLeft({}, function() -- line 18 | captures: v3
            v3 = true
        end, 0)
        expect(v3).to.equal(false)
    end)
    it("should call the callback for each element", function() -- line 25 | captures: foldLeft
        local v4 = { 4, 5, 6 }
        local v5 = {}
        foldLeft(v4, function(v6, v7, v8) -- line 29 | captures: v5
            v5[v8] = v7
            return v6
        end, 0)
        expect(#v5).to.equal(#v4)
        for v9, v10 in pairs(v4) do
            expect(v10).to.equal(v5[v9])
        end
    end)
    it("should pass the same modified initial value to the callback", function() -- line 41 | captures: foldLeft
        local v11 = { 5, 4, 3 }
        local v12 = {}
        foldLeft(v11, function(v13) -- line 45 | captures: v12
            expect(v13).to.equal(v12)
            return v13
        end, v12)
    end)
    it("should call the callback in the correct order", function() -- line 51 | captures: foldLeft
        local v14 = { 5, 4, 3 }
        local v15 = 1
        foldLeft(v14, function(v16, v17) -- line 55 | captures: v15, v14
            expect(v17).to.equal(v14[v15])
            v15 += 1
            return v16
        end, 0)
    end)
end
