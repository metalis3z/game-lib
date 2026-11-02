-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local GlobalConfig = require(script.Parent.GlobalConfig)
    it("should have the correct methods", function() -- line 4 | captures: GlobalConfig
        expect(GlobalConfig).to.be.ok()
        expect(GlobalConfig.set).to.be.ok()
        expect(GlobalConfig.get).to.be.ok()
    end)
end
