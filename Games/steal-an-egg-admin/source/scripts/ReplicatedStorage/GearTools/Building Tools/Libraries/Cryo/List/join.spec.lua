-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local join = require(script.Parent.join)
    local None = require(script.Parent.Parent.None)
    it("should return a new table", function() -- line 5 | captures: join
        local v1 = {}
        expect(join(v1)).never.to.equal(v1)
    end)
    it("should remove elements equal to None", function() -- line 11 | captures: join, None
        local v2 = { "foo-a" }
        local v3 = { None, "foo-b" }
        local v4 = join(v2, v3)
        expect(v4[1]).to.equal("foo-a")
        expect(v4[2]).to.equal("foo-b")
        expect(v4[3]).to.equal(nil)
    end)
    it("should accept arbitrary numbers of tables", function() -- line 28 | captures: join
        local v5 = { 1 }
        local v6 = { 2 }
        local v7 = { 3 }
        local v8 = join(v5, v6, v7)
        expect(#v8).to.equal(3)
        expect(v8[1]).to.equal(1)
        expect(v8[2]).to.equal(2)
        expect(v8[3]).to.equal(3)
    end)
    it("should accept zero tables", function() -- line 41 | captures: join
        expect(join()).to.be.a("table")
    end)
end
