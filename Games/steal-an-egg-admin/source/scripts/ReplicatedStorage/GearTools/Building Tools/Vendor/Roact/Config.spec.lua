-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Config = require(script.Parent.Config)
    it("should accept valid configuration", function() -- line 4 | captures: Config
        local v1 = Config.new()
        local v2 = v1.get()
        expect(v2.elementTracing).to.equal(false)
        v1.set({ elementTracing = true })
        expect(v2.elementTracing).to.equal(true)
    end)
    it("should reject invalid configuration keys", function() -- line 17 | captures: Config
        local v3 = Config.new()
        local v4, v5 = pcall(function() -- line 22 | captures: v3
            v3.set({ garblegoop = true })
        end)
        expect(v4).to.equal(false)
        expect(v5:find("garblegoop")).to.be.ok()
    end)
    it("should reject invalid configuration values", function() -- line 34 | captures: Config
        local v6 = Config.new()
        local v7, v8 = pcall(function() -- line 40 | captures: v6
            v6.set({ elementTracing = "Hello there!" })
        end)
        expect(v7).to.equal(false)
        expect(v8:find("elementTracing")).to.be.ok()
        expect(v8:find("Hello there!")).to.be.ok()
    end)
end
