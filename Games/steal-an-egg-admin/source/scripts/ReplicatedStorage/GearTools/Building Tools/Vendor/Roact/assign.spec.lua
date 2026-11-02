-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local None = require(script.Parent.None)
    local assign = require(script.Parent.assign)
    it("should accept zero additional tables", function() -- line 6 | captures: assign
        local v1 = {}
        local v2 = assign(v1)
        expect(v1).to.equal(v2)
    end)
    it("should merge multiple tables onto the given target table", function() -- line 13 | captures: assign
        local v3 = {
            a = 5,
            b = 6
        }
        local v4 = {
            b = 7,
            c = 8
        }
        local v5 = { b = 8 }
        assign(v3, v4, v5)
        expect(v3.a).to.equal(5)
        expect(v3.b).to.equal(v5.b)
        expect(v3.c).to.equal(v4.c)
    end)
    it("should remove keys if specified as None", function() -- line 35 | captures: None, assign
        local v6 = {
            foo = 2,
            bar = 3
        }
        local v7 = { foo = None }
        assign(v6, v7)
        expect(v6.foo).to.equal(nil)
        expect(v6.bar).to.equal(3)
    end)
    it("should re-add keys if specified after None", function() -- line 51 | captures: None, assign
        local v8 = { foo = 2 }
        local v9 = { foo = None }
        local v10 = { foo = 3 }
        assign(v8, v9, v10)
        expect(v8.foo).to.equal(v10.foo)
    end)
end
