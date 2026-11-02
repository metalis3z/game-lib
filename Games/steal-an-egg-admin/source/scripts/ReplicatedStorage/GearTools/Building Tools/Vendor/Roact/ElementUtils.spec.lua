-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local ElementUtils = require(script.Parent.ElementUtils)
    local createElement = require(script.Parent.createElement)
    local createFragment = require(script.Parent.createFragment)
    local Type = require(script.Parent.Type)
    describe("iterateElements", function() -- line 7 | captures: ElementUtils, createElement, Type
        it("should iterate once for a single child", function() -- line 8 | captures: ElementUtils, createElement
            local TextLabel = createElement("TextLabel")
            local v1 = ElementUtils.iterateElements(TextLabel)
            local v2, v3 = v1()
            expect(v2).to.equal(ElementUtils.UseParentKey)
            expect(v3).to.equal(TextLabel)
            local v4 = v1()
            expect(v4).to.equal(nil)
        end)
        it("should iterate over tables", function() -- line 20 | captures: ElementUtils, createElement, Type
            local v5 = {
                a = createElement("TextLabel"),
                b = createElement("TextLabel")
            }
            local v6 = {}
            local v7 = 0
            for v8, v9 in ElementUtils.iterateElements(v5) do
                expect((typeof(v8))).to.equal("string")
                expect(Type.of(v9)).to.equal(Type.Element)
                v6[v9] = v8
                v7 += 1
            end
            expect(v7).to.equal(2)
            expect(v6[v5.a]).to.equal("a")
            expect(v6[v5.b]).to.equal("b")
        end)
        it("should return a zero-element iterator for booleans", function() -- line 41 | captures: ElementUtils
            local v10 = ElementUtils.iterateElements(false)
            expect(v10()).to.equal(nil)
        end)
        it("should return a zero-element iterator for nil", function() -- line 46 | captures: ElementUtils
            local v11 = ElementUtils.iterateElements(nil)
            expect(v11()).to.equal(nil)
        end)
        it("should throw if given an illegal value", function() -- line 51 | captures: ElementUtils
            expect(function() -- line 52 | captures: ElementUtils
                ElementUtils.iterateElements(1)
            end).to.throw()
        end)
    end)
    describe("getElementByKey", function() -- line 58 | captures: ElementUtils, createElement, createFragment
        it("should return nil for booleans", function() -- line 59 | captures: ElementUtils
            expect(ElementUtils.getElementByKey(true, "test")).to.equal(nil)
        end)
        it("should return nil for nil", function() -- line 63 | captures: ElementUtils
            expect(ElementUtils.getElementByKey(nil, "test")).to.equal(nil)
        end)
        describe("single elements", function() -- line 67 | captures: ElementUtils, createElement
            local TextLabel = createElement("TextLabel")
            it("should return the element if the key is UseParentKey", function() -- line 70 | captures: TextLabel, ElementUtils
                expect(ElementUtils.getElementByKey(TextLabel, ElementUtils.UseParentKey)).to.equal(TextLabel)
            end)
            it("should return nil if the key is not UseParentKey", function() -- line 74 | captures: TextLabel, ElementUtils
                expect(ElementUtils.getElementByKey(TextLabel, "test")).to.equal(nil)
            end)
        end)
        it("should return the corresponding element from a table", function() -- line 79 | captures: ElementUtils, createElement
            local v12 = {
                a = createElement("TextLabel"),
                b = createElement("TextLabel")
            }
            expect(ElementUtils.getElementByKey(v12, "a")).to.equal(v12.a)
            expect(ElementUtils.getElementByKey(v12, "b")).to.equal(v12.b)
        end)
        it("should return nil if the key does not exist", function() -- line 89 | captures: ElementUtils, createFragment
            local v13 = createFragment({})
            expect(ElementUtils.getElementByKey(v13, "a")).to.equal(nil)
        end)
    end)
end
