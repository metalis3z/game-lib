-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local findWhere = require(script.Parent.findWhere)
    it("should return the correct index", function() -- line 4 | captures: findWhere
        local v1 = { 1, 5, 10, 7 }

        local function v2(v3) -- line 6
            return v3 % 2 == 0
        end

        local function v4(v5) -- line 10
            return v5 % 2 == 1
        end

        expect(findWhere(v1, v2)).to.equal(3)
        expect(findWhere(v1, v4)).to.equal(1)
    end)
    it("should work with an empty table", function() -- line 18 | captures: findWhere
        local function v6() -- line 19
            return true
        end

        expect(findWhere({}, v6)).to.equal(nil)
    end)
    it("should return nil when the when no value satisfies the predicate", function() -- line 25 | captures: findWhere
        local v7 = { 1, 2, 3 }

        local function v8(v9) -- line 27
            return v9 == 4
        end

        expect(findWhere(v7, v8)).to.equal(nil)
    end)
    it("should return the index of the first value for which the predicate is true", function() -- line 34 | captures: findWhere
        local v10 = { 1, 1, 1, 2, 2 }

        local function v11(v12) -- line 37
            return v12 == 2
        end

        expect(findWhere(v10, v11)).to.equal(4)
    end)
    it("should allow access to table index in the predicate function", function() -- line 44 | captures: findWhere
        local v13 = { 5, 4, 3, 2, 1 }

        local function v14(v15, v16) -- line 47
            return v16 == 4
        end

        expect(findWhere(v13, v14)).to.equal(4)
    end)
    it("should allow access to both value and index in the predicate function", function() -- line 54 | captures: findWhere
        local v17 = { 1, 1, 2, 2, 1 }

        local function v18(v19, v20) -- line 57
            return v19 + v20 == 5
        end

        expect(findWhere(v17, v18)).to.equal(3)
    end)
end
