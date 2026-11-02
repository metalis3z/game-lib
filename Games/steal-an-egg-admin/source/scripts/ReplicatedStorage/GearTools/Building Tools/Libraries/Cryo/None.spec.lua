-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local None = require(script.Parent.None)
    it("should be a userdata", function() -- line 4 | captures: None
        expect(None).to.be.a("userdata")
    end)
    it("should have a nice string name", function() -- line 8 | captures: None
        local v1 = tostring(None)
        expect(v1:find("^userdata: ")).never.to.be.ok()
        expect(v1:find("None")).to.be.ok()
    end)
end
