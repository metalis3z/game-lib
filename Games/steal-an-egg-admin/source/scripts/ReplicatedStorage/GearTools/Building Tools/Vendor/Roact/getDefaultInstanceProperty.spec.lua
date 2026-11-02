-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local getDefaultInstanceProperty = require(script.Parent.getDefaultInstanceProperty)
    it("should get default name string values", function() -- line 4 | captures: getDefaultInstanceProperty
        local v1, Name = getDefaultInstanceProperty("StringValue", "Name")
        expect(Name).to.equal("Value")
    end)
    it("should get default empty string values", function() -- line 10 | captures: getDefaultInstanceProperty
        local v2, Value = getDefaultInstanceProperty("StringValue", "Value")
        expect(Value).to.equal("")
    end)
    it("should get default number values", function() -- line 16 | captures: getDefaultInstanceProperty
        local v3, Value = getDefaultInstanceProperty("IntValue", "Value")
        expect(Value).to.equal(0)
    end)
    it("should get nil default values", function() -- line 22 | captures: getDefaultInstanceProperty
        local v4, Value = getDefaultInstanceProperty("ObjectValue", "Value")
        expect(Value).to.equal(nil)
    end)
    it("should get bool default values", function() -- line 28 | captures: getDefaultInstanceProperty
        local v5, Value = getDefaultInstanceProperty("BoolValue", "Value")
        expect(Value).to.equal(false)
    end)
end
