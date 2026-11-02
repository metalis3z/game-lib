-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createSpy = require(script.Parent.createSpy)
    describe("createSpy", function() -- line 4 | captures: createSpy
        it("should create spies", function() -- line 5 | captures: createSpy
            local v1 = createSpy(function() -- line 6
            end)
            expect(v1).to.be.ok()
        end)
        it("should throw if spies are indexed by an invalid key", function() -- line 11 | captures: createSpy
            local v2 = createSpy(function() -- line 12
            end)
            expect(function() -- line 14 | captures: v2
                return v2.test
            end).to.throw()
        end)
    end)
    describe("value", function() -- line 20 | captures: createSpy
        it("should increment callCount when called", function() -- line 21 | captures: createSpy
            local v3 = createSpy(function() -- line 22
            end)
            v3.value()
            expect(v3.callCount).to.equal(1)
        end)
        it("should store all values passed", function() -- line 28 | captures: createSpy
            local v4 = createSpy(function() -- line 29
            end)
            v4.value(1, true, "3")
            expect(v4.valuesLength).to.equal(3)
            expect(v4.values[1]).to.equal(1)
            expect(v4.values[2]).to.equal(true)
            expect(v4.values[3]).to.equal("3")
        end)
        it("should return the value of the inner function", function() -- line 38 | captures: createSpy
            local v5 = createSpy(function() -- line 39
                return true
            end)
            expect(v5.value()).to.equal(true)
        end)
    end)
    describe("assertCalledWith", function() -- line 47 | captures: createSpy
        it("should throw if the number of values differs", function() -- line 48 | captures: createSpy
            local v6 = createSpy(function() -- line 49
            end)
            v6.value(1, 2)
            expect(function() -- line 52 | captures: v6
                v6:assertCalledWith(1)
            end).to.throw()
        end)
        it("should throw if any value differs", function() -- line 57 | captures: createSpy
            local v7 = createSpy(function() -- line 58
            end)
            v7.value(1, 2)
            expect(function() -- line 61 | captures: v7
                v7:assertCalledWith(1, 3)
            end).to.throw()
            expect(function() -- line 65 | captures: v7
                v7:assertCalledWith(2, 3)
            end).to.throw()
        end)
    end)
    describe("captureValues", function() -- line 71 | captures: createSpy
        it("should throw if the number of values differs", function() -- line 72 | captures: createSpy
            local v8 = createSpy(function() -- line 73
            end)
            v8.value(1, 2)
            expect(function() -- line 76 | captures: v8
                v8:captureValues("a")
            end).to.throw()
        end)
        it("should capture all values in a table", function() -- line 81 | captures: createSpy
            local v9 = createSpy(function() -- line 82
            end)
            v9.value(1, 2)
            local b = v9:captureValues("a", "b")
            expect(b.a).to.equal(1)
            expect(b.b).to.equal(2)
        end)
    end)
end
