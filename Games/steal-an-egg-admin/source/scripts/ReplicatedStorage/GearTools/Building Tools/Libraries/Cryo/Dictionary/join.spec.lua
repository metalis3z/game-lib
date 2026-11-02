-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local join = require(script.Parent.join)
    local None = require(script.Parent.Parent.None)
    it("should return a new table", function() -- line 5 | captures: join
        local v1 = {}
        expect(join(v1)).never.to.equal(v1)
    end)
    it("should merge tables, overwriting previous values", function() -- line 11 | captures: join
        local v2 = {
            foo = "foo-a",
            bar = "bar-a"
        }
        local v3 = {
            foo = "foo-b",
            baz = "baz-b"
        }
        local v4 = join(v2, v3)
        expect(v4.foo).to.equal(v3.foo)
        expect(v4.bar).to.equal(v2.bar)
        expect(v4.baz).to.equal(v3.baz)
    end)
    it("should remove values set to None", function() -- line 29 | captures: join, None
        local v5 = { foo = "foo-a" }
        local v6 = { foo = None }
        local v7 = join(v5, v6)
        expect(v7.foo).to.equal(nil)
    end)
    it("should not mutate passed in tables", function() -- line 43 | captures: join
        local v8 = 0
        local v9 = 0
        local v10 = {}
        local v11 = { foo = "foo-b" }
        local v12 = {
            __newindex = function() -- __newindex | line 53 | captures: v8
                v8 += 1
            end
        }
        setmetatable(v10, v12)
        local v13 = {
            __newindex = function() -- __newindex | line 59 | captures: v9
                v9 += 1
            end
        }
        setmetatable(v11, v13)
        join(v10, v11)
        expect(v8).to.equal(0)
        expect(v9).to.equal(0)
        expect(v11.foo).to.equal("foo-b")
    end)
    it("should accept arbitrary numbers of tables", function() -- line 71 | captures: join
        local v14 = { foo = "foo-a" }
        local v15 = { bar = "bar-b" }
        local v16 = { baz = "baz-c" }
        local v17 = join(v14, v15, v16)
        expect(v17.foo).to.equal(v14.foo)
        expect(v17.bar).to.equal(v15.bar)
        expect(v17.baz).to.equal(v16.baz)
    end)
    it("should accept zero tables", function() -- line 91 | captures: join
        expect(join()).to.be.a("table")
    end)
end
