-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Portal = require(script.Parent.Portal)
    local Component = require(script.Parent.Component)
    local ElementKind = require(script.Parent.ElementKind)
    describe("of", function() -- line 7 | captures: ElementKind
        it("should return nil for non-table values", function() -- line 8 | captures: ElementKind
            expect(ElementKind.of(nil)).to.equal(nil)
            expect(ElementKind.of(5)).to.equal(nil)
            expect(ElementKind.of(newproxy(true))).to.equal(nil)
        end)
        it("should return nil for table values without an ElementKind key", function() -- line 14 | captures: ElementKind
            expect(ElementKind.of({})).to.equal(nil)
        end)
        it("should return the ElementKind from a table", function() -- line 18 | captures: ElementKind
            local v1 = { [ElementKind] = ElementKind.Stateful }
            expect(ElementKind.of(v1)).to.equal(ElementKind.Stateful)
        end)
    end)
    describe("fromComponent", function() -- line 27 | captures: Portal, Component, ElementKind
        it("should handle host components", function() -- line 28 | captures: ElementKind
            expect(ElementKind.fromComponent("foo")).to.equal(ElementKind.Host)
        end)
        it("should handle function components", function() -- line 32 | captures: ElementKind
            local function foo() -- line 33
            end

            expect(ElementKind.fromComponent(foo)).to.equal(ElementKind.Function)
        end)
        it("should handle stateful components", function() -- line 39 | captures: Component, ElementKind
            local Foo = Component:extend("Foo")
            expect(ElementKind.fromComponent(Foo)).to.equal(ElementKind.Stateful)
        end)
        it("should handle portals", function() -- line 45 | captures: Portal, ElementKind
            expect(ElementKind.fromComponent(Portal)).to.equal(ElementKind.Portal)
        end)
        it("should return nil for invalid inputs", function() -- line 49 | captures: ElementKind
            expect(ElementKind.fromComponent(5)).to.equal(nil)
            expect(ElementKind.fromComponent(newproxy(true))).to.equal(nil)
        end)
    end)
end
